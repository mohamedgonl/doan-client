import 'package:http/http.dart';
import 'package:lichviet_flutter_base/core/utils/alice/alice.dart';

extension AliceHttpExtensions on Future<Response> {
  /// Intercept http request with alice. This extension method provides additional
  /// helpful method to intercept https' response.
  Future<Response> interceptWithAlice(Alice alice, {dynamic body}) async {
    final Response response = await this;
    alice.onHttpResponse(response, body: body);
    return response;
  }
}
