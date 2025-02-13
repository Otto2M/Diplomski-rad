import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/working_hours_place.dart';
import 'package:transparent_image/transparent_image.dart';

class ShoppingPlacesScreen extends ConsumerStatefulWidget {
  const ShoppingPlacesScreen({
    super.key,
    required this.place,
  });

  final ShoppingPlace place;

  @override
  ConsumerState<ShoppingPlacesScreen> createState() =>
      _ShoppingPlacesScreenState();
}

class _ShoppingPlacesScreenState extends ConsumerState<ShoppingPlacesScreen> {
  String? workingHours;
  bool? openNow;
  bool isLoadingWorkingHours = true;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() async {
    final String placeName = widget.place.title.trim();

    setState(() {
      isLoadingWorkingHours = true;
    });

    final details = await ref
        .read(placeDetailsServiceProvider)
        .fetchPlaceDetails(placeName: placeName);

    setState(() {
      workingHours = details['workingHours'];
      openNow = details['openNow'];
      isLoadingWorkingHours = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(20),
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 10,
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        double imageWidth = 160;
        double textWidth = availableWidth - imageWidth - 5;

        return Column(
          children: [
            Row(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.place.imageUrl.first),
                  fit: BoxFit.cover,
                  height: 160,
                  width: imageWidth,
                ),
                Container(
                  //color: Colors.amber,
                  width: textWidth,
                  height: 155,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Scrollbar(
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.place.title,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subcategoryCardPlaceHeadline(
                                context),
                          ),
                          Text(
                            widget.place.address,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subcategoryDesc(context),
                          ),
                          Text(
                            'Radno vrijeme:',
                            style: AppTextStyles.subcategoryDesc(context),
                          ),
                          WorkingHoursPlace(
                            workingHours: workingHours ??
                                "Nema dostupnih podataka o radnom vremenu.",
                            openNow: openNow ?? false,
                            isLoadingWorkingHours: isLoadingWorkingHours,
                            isShop: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
