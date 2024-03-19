import "package:flutter/material.dart";
import "package:landlord_portal/components/home_screen/key_facts.dart";
import "package:landlord_portal/components/shared/custom_app_bar.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/personal_manager.dart";
import "package:landlord_portal/components/statements/payout_card.dart";
import "package:landlord_portal/components/statements/statement_card.dart";
import "package:landlord_portal/config/colors.dart";

class StatementSreen extends StatelessWidget {
  const StatementSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Statements",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardContainer(
              cardHeader: "Statements",
              trailing: true,
              trailingWidgetBackground: kPrimaryColor,
              trailingWidgetText: "2024",
              hasBtn: true,
              buttonText: "See All Transaction",
              child: Column(
                children: [
                  StatementCard(),
                  BorderLine(),
                  StatementCard(),
                ],
              ),
            ),
            CardContainer(
              cardHeader: 'Key Facts',
              customHeight: 316,
              child: KeyFacts(),
            ),
            PersonalManager(),
            CardContainer(
                hasBtn: true,
                buttonText: "See All Transaction",
                cardHeader: "Payout History",
                child: Column(
                  children: [
                    SizedBox(
                      height: 11,
                    ),
                    PayoutCard(),
                    PayoutCard(),
                    PayoutCard(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
