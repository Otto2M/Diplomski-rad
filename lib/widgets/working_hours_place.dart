import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

class WorkingHoursPlace extends StatelessWidget {
  const WorkingHoursPlace({
    super.key,
    required this.workingHours,
    required this.openNow,
    required this.isLoadingWorkingHours,
    required this.isShop,
    this.isMap = false,
  });

  final String workingHours;
  final bool openNow;
  final bool isLoadingWorkingHours;
  final bool isShop;
  final bool isMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMap ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Radno vrijeme:",
          style: isShop
              ? AppTextStyles.subcategoryDesc(context)
              : AppTextStyles.description(context),
        ),
        const SizedBox(height: 10),
        if (isLoadingWorkingHours)
          const CircularProgressIndicator()
        else ...[
          Text(
            workingHours,
            style: isShop
                ? AppTextStyles.subcategoryDesc(context)
                : AppTextStyles.description(context),
            textAlign: isMap ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 10),
          isShop
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(
                    openNow == true
                        ? "Trenutno otvoreno"
                        : "Trenutno zatvoreno",
                    style: AppTextStyles.description(context).copyWith(
                      color: openNow == true ? Colors.green : Colors.red,
                    ),
                  ),
                )
              : Text(
                  openNow == true ? "Trenutno otvoreno" : "Trenutno zatvoreno",
                  style: AppTextStyles.description(context).copyWith(
                    color: openNow == true ? Colors.green : Colors.red,
                  ),
                ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }
}
