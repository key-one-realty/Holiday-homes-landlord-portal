import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
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
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 10.0.r),
            child: Row(
              children: [
                badges.Badge(
                  showBadge: badge.isNotEmpty,
                  badgeContent: Text(
                    badge,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  position:
                      badges.BadgePosition.topStart(top: -8.r, start: -8.r),
                  child: Container(
                    width: 78.r,
                    height: 78.r,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ),
                ),
                18.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 12.r,
                          height: 12.r,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: kRedAccent,
                            size: 12.r,
                          ),
                        ),
                        4.horizontalSpace,
                        Text(
                          location,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Text(
                      listingName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    6.verticalSpace,
                    Container(
                      // width: 44,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                      decoration: ShapeDecoration(
                        color: const Color(0x192A85FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            unitNumber,
                            style: TextStyle(
                              color: const Color(0xFF2180FF),
                              fontSize: 11.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.11.r,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.r,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFE9ECF2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.r)),
            ),
          )
        ],
      ),
    );
  }
}
