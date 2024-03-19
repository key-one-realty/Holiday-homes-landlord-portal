import "package:flutter/material.dart";
import "package:landlord_portal/config/colors.dart";
import 'package:badges/badges.dart' as badges;

class ListingCard extends StatelessWidget {
  const ListingCard({
    super.key,
    required this.listingName,
    required this.location,
    this.image = "https://via.placeholder.com/78x78",
    required this.unitNumber,
    this.badge = "",
    this.onTap,
  });

  final String listingName;
  final String location;
  final String image;
  final String unitNumber;
  final String badge;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        disabledBackgroundColor: Colors.white,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              badges.Badge(
                showBadge: badge.isNotEmpty,
                badgeContent: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                position: badges.BadgePosition.topStart(top: -8, start: -8),
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: Icon(
                          Icons.location_on_outlined,
                          color: kRedAccent,
                          size: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    listingName,
                    style: const TextStyle(
                      color: kTextColor,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    // width: 44,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0x192A85FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          unitNumber,
                          style: const TextStyle(
                            color: Color(0xFF2180FF),
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.11,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFE9ECF2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
            ),
          )
        ],
      ),
    );
  }
}
