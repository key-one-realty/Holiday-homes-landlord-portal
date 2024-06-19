import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
// import "package:landlord_portal/components/home_screen/key_facts.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/custom_app_bar.dart";
import "package:landlord_portal/components/shared/personal_manager.dart";
// import "package:landlord_portal/components/statements/payout_card.dart";
import "package:landlord_portal/components/statements/statement_card.dart";
import "package:landlord_portal/config/colors.dart";
import "package:landlord_portal/features/authentication/view_model/auth_provider.dart";
import "package:landlord_portal/features/statements/model/statement_model.dart";
import "package:landlord_portal/features/statements/view_model/statement_view_model.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class StatementSreen extends StatefulWidget {
  const StatementSreen({super.key});

  @override
  State<StatementSreen> createState() => _StatementSreenState();
}

class _StatementSreenState extends State<StatementSreen> {
  Future<int> getuserId() async {
    int userId = context.read<AuthPovider>().userId;

    if (userId == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId')!;
    }

    if (mounted) {
      context.read<StatementProvider>().getStatements(userId);
    }

    return userId;
  }

  @override
  void initState() {
    super.initState();
    // call the get user statements API
    getuserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Statements",
      ),
      body: SingleChildScrollView(
        child: Consumer<StatementProvider>(
          builder: (context, value, child) => Column(
            children: [
              CardContainer(
                  isLoading: value.isLoading,
                  isEmpty: value.statements.isEmpty,
                  cardHeader: "Statements",
                  trailing: false,
                  trailingWidgetBackground: kPrimaryColor,
                  trailingWidgetText: "2024",
                  hasBtn: false,
                  buttonText: "See All Transaction",
                  child: SizedBox(
                    height: 300.0.r,
                    child: ListView.builder(
                      itemCount: value.statements.length,
                      itemBuilder: (context, index) {
                        Statement statement = value.statements[index];
                        return StatementCard(
                          statementMonth: statement.monthString,
                          statementPDFLink: statement.link,
                          statementRange: statement.statementRange,
                        );
                      },
                    ),
                  )

                  // Column(
                  //   children: [
                  //     StatementCard(),
                  //     // BorderLine(),
                  //     StatementCard(),
                  //   ],
                  // ),
                  ),
              // CardContainer(
              //   cardHeader: 'Key Facts',
              //   customHeight: 325,
              //   child: KeyFacts(),
              // ),
              const PersonalManager(),
              // CardContainer(
              //     hasBtn: true,
              //     buttonText: "See All Transaction",
              //     cardHeader: "Payout History",
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 11,
              //         ),
              //         PayoutCard(),
              //         PayoutCard(),
              //         PayoutCard(),
              //       ],
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
