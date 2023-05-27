import 'dart:convert';
import 'dart:io';
import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/provider/assist_provider.dart';
import 'package:abc_tech_app/service/assist_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'assist_service_test.mocks.dart';

@GenerateMocks([AssistanceProviderInterface])
void main() {
  late AssistanceProviderInterface providerInterface;
  late AssistanceService assistService;
  setUp(() async {
    providerInterface = MockAssistanceProviderInterface();
    assistService = AssistanceService().init(providerInterface);
    var json = File("${Directory.current.path}/test/resources/assists.json")
        .readAsStringSync();

    when(providerInterface.getAssists()).thenAnswer((_) => Future.sync(
        () => Response(statusCode: HttpStatus.ok, body: jsonDecode(json))));
  });

  test('Teste de listagem de assistências', () async {
    List<Assist> list = await assistService.getAssists();
    expect(list.length, 6);
    expect(list[0].title, "Troca de aparelho");
  });
}
