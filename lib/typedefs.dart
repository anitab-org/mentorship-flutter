import 'package:chopper/chopper.dart';

/// Generic type definition representing API method
typedef ApiFunction<T> = Future<Response<T>> Function();