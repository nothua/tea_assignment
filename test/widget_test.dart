import 'dart:io';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:tea_assignment/features/onboarding/screens/landing_screen.dart';
import 'package:tea_assignment/main.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MyHttpClient();
  }
}

class _MyHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return _MyHttpClientRequest();
  }
}

class _MyHttpClientRequest implements HttpClientRequest {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

  @override
  Future<HttpClientResponse> close() async {
    return _MyHttpClientResponse();
  }

  @override
  HttpHeaders get headers => _MyHttpHeaders();
}

class _MyHttpClientResponse implements HttpClientResponse {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

  @override
  int get statusCode => 200;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream.value(List<int>.from([0])).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

class _MyHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _MyHttpOverrides();
  });

  testWidgets('Landing screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    expect(find.byType(LandingScreen), findsOneWidget);

    expect(find.text('Get Started'), findsOneWidget);

    expect(find.textContaining('Turn everyday noise'), findsOneWidget);
  });
}
