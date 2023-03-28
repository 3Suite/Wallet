#!/usr/bin/env python3

import re
import os
import fileinput
import sys
import subprocess
from shutil import copyfile


def findFiles(baseDir, exten):
    filesList = []
    for dirpath, d, files in os.walk(baseDir):
        for name in files:
            if name.lower().endswith(exten):
                filesList.append(os.path.join(dirpath, name))
    return filesList


def replaceLines(files, oldValue, newLine):
    for line in fileinput.input(files, inplace=1):
        if oldValue in line:
            line = newLine


def copyFile(path_from, path_to):
    copyfile(path_from, path_to)


def convertApp(appFilesPath, domain, appId, iOSProvName, appName):
    baseDirectory = "./lib"
    extension = ".dart"

    # Replace logo

    from_logo1x = appFilesPath + "/logo.png"
    from_logo2x = appFilesPath + "/logo@2x.png"
    from_logo3x = appFilesPath + "/logo@3x.png"
    to_logo1x = "images/logo.png"
    to_logo2x = "images/2.0x/logo.png"
    to_logo3x = "images/3.0x/logo.png"

    copyFile(from_logo1x, to_logo1x)
    copyFile(from_logo2x, to_logo2x)
    copyFile(from_logo3x, to_logo3x)

    allFiles = findFiles(baseDirectory, extension)

    # Replace domain in file with domain

    fileWithDomain = "http-client-fabric.dart"

    newDomain = "static const String domain = \"" + domain + "\";\n"
    lineWithDomain = "static const String domain"

    for file in allFiles:
        fileName = file.split("/")[-1]
        if fileName == fileWithDomain:
            replaceLines(file, lineWithDomain, newDomain)
            break

    # Replace android app id

    lineWithId = "applicationId \""
    newId = lineWithId + appId + "\"\n"

    extension = ".gradle"
    baseDirectory = "./android"

    files = findFiles(baseDirectory, extension)
    for file in files:
        replaceLines(file, lineWithId, newId)

    # Replace iOS app id

    lineWithId = "PRODUCT_BUNDLE_IDENTIFIER = "
    newId = "PRODUCT_BUNDLE_IDENTIFIER = " + appId + ";\n"

    extension = ".pbxproj"
    baseDirectory = "./ios"

    files = findFiles(baseDirectory, extension)
    for file in files:
        replaceLines(file, lineWithId, newId)

    # Replace provisions name (iOS only)

    lineWithProv = "PROVISIONING_PROFILE_SPECIFIER = "
    newProv = "PROVISIONING_PROFILE_SPECIFIER = \"" + iOSProvName + "\";\n"

    files = findFiles(baseDirectory, extension)
    for file in files:
        replaceLines(file, lineWithProv, newProv)

    # Replace bundle display name (iOS only)

    lineWithAppName = "<key>CFBundleDisplayName</key><string>"
    newAppName = "<key>CFBundleDisplayName</key><string>" + appName + "</string>\n"

    extension = ".plist"
    baseDirectory = "./ios"

    files = findFiles(baseDirectory, extension)
    for file in files:
        replaceLines(file, lineWithAppName, newAppName)

    # Replace icons: iOS

    iOSCurrentAppIcons = "./ios/Runner/Assets.xcassets"
    newiOSIcons = "./" + appFilesPath + "/Assets.xcassets"

    bashCommand = "rm -rf " + iOSCurrentAppIcons
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print(output)
    print(error)

    bashCommand = "cp -R " + newiOSIcons + " " + iOSCurrentAppIcons
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print(output)
    print(error)

    # Replace icons: Android

    newAndroidIcons = "./" + appFilesPath + "/android/mipmap-*"
    androidCurrentAppIcons = "./android/app/src/main/res"

    bashCommand = "rm -rf " + androidCurrentAppIcons + "/mipmap-*"
    print("Excuting " + bashCommand)
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    if len(output) > 0:
        print(output)
    if error != None:
        print(error)
        exit(1)
    print("Old android icons removed")

    bashCommand = "cp -R " + newAndroidIcons + " " + androidCurrentAppIcons
    print("Excuting " + bashCommand)
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    if len(output) > 0:
        print(output)
    if error != None:
        print(error)
        exit(1)
    print("New android icons copied")
