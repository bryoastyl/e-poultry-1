import 'dart:developer';

import 'package:epoultry/data/queries.dart';
import 'package:epoultry/graphql/graphql_config.dart';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/dashboard/farm_dashboard_page.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

import 'controllers/farm_controller.dart';
import 'controllers/user_controller.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('appData');
  final box = Hive.box('appData');
  runApp(Epoultry());
}

class Epoultry extends StatefulWidget {
  Epoultry({
    Key? key,
  }) : super(key: key);

  @override
  State<Epoultry> createState() => _EpoultryState();
}

class _EpoultryState extends State<Epoultry> {
  GraphQLConfiguration graphQLConfig = GraphQLConfiguration();

  HttpLink authentication = HttpLink(
    "https://cbsmartfarm.herokuapp.com/api/graphql/auth",
  );

  HttpLink authorised =
      HttpLink("https://cbsmartfarm.herokuapp.com/api/graphql");

  final box = Hive.box('appData');

  late AuthLink authLink = AuthLink(
    getToken: () async {
      return 'Bearer ${box.get("token")}';
    },
  );

  late Link link = authLink.concat(authorised);

  Link getLink() {
    return Link.split((request) {
      return request.operation.operationName == 'RequestLoginOtp' ||
          request.operation.operationName == "VerifyOtp" ||
          request.operation.operationName == "RegisterUser";
    }, authentication, link);
  }

  ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        defaultPolicies: DefaultPolicies(
          // make watched mutations behave like watched queries.
          watchMutation: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.none,
            cacheReread: CacheRereadPolicy.mergeOptimistic,
          ),
          watchQuery: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.none,
            cacheReread: CacheRereadPolicy.mergeOptimistic,
          ),
        ),
        cache: GraphQLCache(),
        link: getLink(),
      ),
    );
    return client;
  }

  final queries = EpoultryQueries();

  @override
  Widget build(BuildContext context) {
    final token = box.get("token");
    final FarmsController controller =
        Get.put(FarmsController(), permanent: true);
    final UserController userController =
        Get.put(UserController(), permanent: true);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return QueriesDocumentProvider(
          queries: queries,
          child: GraphQLProvider(
            client: initializeClient(),
            child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Epoultry',
                theme: CustomTheme.lightTheme,
                localizationsDelegates: const [
                  FormBuilderLocalizations.delegate,
                ],
                home: token.toString().isNotEmpty && token != null
                    ? FarmDashboardPage()
                    : LandingPage()),
          ),
        );
      },
    );
  }
}
