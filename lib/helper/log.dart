
class Log {

  static const functionNamePosition = 6;
  static const functionPosition = 2;

  static void log(String str) {
    var functionName = Log.functionNameAt(functionPosition);
    print(functionName + '[' + DateTime.now().toIso8601String() + '] : ' + str.trim());
  }
  static String functionNameAt(int order) {
    var currentStack = StackTrace.current.toString();
    var arrayStack = currentStack.split('\n');
    List<String> arrayDetail;
    String functionName;

    if (arrayStack.length > order){
      arrayDetail = arrayStack[order].split(' ');
      if (arrayDetail.length > functionNamePosition) {
        functionName = arrayDetail[functionNamePosition];
      }
    }
    return functionName;
  }
  static void apiLogRequest(
      String request,
      String headers,
      {String method = 'POST',
      String queryParams,
      String body = ''}
      ){
    var functionName = Log.functionNameAt(2);
    String str = '\n' + functionName + ' ►►►'
        + '\n' + DateTime.now().toIso8601String()
        + '\n' + '☀️☀️☀️☀️☀️REQUEST'
        + '\n' + '($method) $request'
        + '\n' + 'Headers: ' + headers
        + '\n' + 'QueryParams: ' + queryParams
        + '\n' + 'Body: ' + body
        + '\n' + '-----------------------------------------------------------------------------------------------\n';

    printLongString(str);
  }
  static void apiLogResponse(
      String request,
      String response,
      String code,
      {String method = 'POST',
        String body = ''}
      ){
    var functionName = Log.functionNameAt(2);
    String str = '\n' + functionName + ' ►►►'
        + '\n' + DateTime.now().toIso8601String()
        + '\n' + '💥💥💥💥💥RESPONSE'
        + '\n' + 'Return $code: ($method) $request'
        + '\n' + response.trim()
        + '\n' + '-----------------------------------------------------------------------------------------------\n';

    printLongString(str);
  }

  static void printLongString(Object object) {
    int defaultPrintLength = 1020; //currently dart and flutter not supporting printing logs more than 1020 character.
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}