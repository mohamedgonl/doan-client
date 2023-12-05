part of 'error_to_string_mapper.dart';

abstract class ErrorToStringMapperItem {
  ErrorToStringMapperItem(this.key);

  final String key;

  String getDisplay(BuildContext context, dynamic exception) {
    return key.translate(context);
  }

  bool isMatch(BaseException exception);
}

class NoNetworkMapperItem extends ErrorToStringMapperItem {
  NoNetworkMapperItem() : super('error.msg_no_network');

  @override
  bool isMatch(BaseException exception) => exception is NetworkIssueException;
}

class GeneralErrorMapperItem extends ErrorToStringMapperItem {
  GeneralErrorMapperItem() : super('error.msg_general');

  @override
  bool isMatch(BaseException exception) => true;
}

class HttpErrorResponseMapperItem extends ErrorToStringMapperItem {
  HttpErrorResponseMapperItem() : super('error.msg_general');

  @override
  String getDisplay(BuildContext context, dynamic exception) {
    if (exception is ServerException && exception.hasError) {
      final Response<dynamic>? _errorResp = exception.error.response;
      if (_errorResp != null) {
        final String? _errorCode = _errorResp.data['error_code'];
        switch (_errorCode) {
          case '001.001.001':
            return 'error.msg_001_001_001'.translate(context);
          case '001.001.003':
            return 'error.msg_session_expired'.translate(context);
          case '002.001':
            return 'error.msg_002_001'.translate(context);
          default:
            break;
        }
      }
    }
    return key.translate(context);
  }

  @override
  bool isMatch(BaseException exception) => exception is ServerException;
}
