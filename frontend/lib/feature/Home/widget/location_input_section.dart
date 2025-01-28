import 'package:flutter/material.dart';

class LocationInputSection extends StatelessWidget {
  final VoidCallback? onLocationTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onNotificationTap;
  final Color backgroundColor;
  final TextStyle? locationTextStyle;
  final TextStyle? inputTextStyle;

  const LocationInputSection({
    super.key,
    this.onLocationTap,
    this.onFilterTap,
    this.onNotificationTap,
    this.backgroundColor = const Color(0xFF007BFF), // Blue background
    this.locationTextStyle,
    this.inputTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.05),
          bottomRight: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenWidth * 0.05),
          // Top row: Location & Notification Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Location',
                    style: locationTextStyle ??
                        TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: screenWidth * 0.05,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Chennai, India',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.05),

          // Search Bar & Filter Icon
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onLocationTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.035,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: screenWidth * 0.05,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          'Enter Your Location',
                          style: inputTextStyle ??
                              TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    size: screenWidth * 0.06,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02),
        ],
      ),
    );
  }
}
