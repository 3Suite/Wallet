import 'package:mobile_app/network/http-client/http-client.dart';
import 'package:mobile_app/network/http-client/ihttp-client.dart';

class HttpClientFactory {
  static const String schema = "https";

  static const String domain = "15.206.150.203";
  static const String wssDomain = domain;
  static const String confirmDomain = domain;

  static const String path = "api";

  static IHttpClient getHttpClient([
    String customDomain = HttpClientFactory.domain,
  ]) {
    return HttpClient(domain: domain, schema: schema, path: path);
  }
}
