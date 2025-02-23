import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/image_with_error_handling.dart';
import 'package:povedi_me_app/widgets/working_hours_place.dart';

class ShoppingPlacesScreen extends ConsumerStatefulWidget {
  const ShoppingPlacesScreen({
    super.key,
    required this.place,
    this.isFiltered = false,
  });

  final ShoppingPlace place;
  final bool isFiltered;

  @override
  ConsumerState<ShoppingPlacesScreen> createState() =>
      _ShoppingPlacesScreenState();
}

class _ShoppingPlacesScreenState extends ConsumerState<ShoppingPlacesScreen> {
  String? workingHours;
  bool? openNow;
  bool isLoadingWorkingHours = true;

  final ScrollController _scrollController = ScrollController();

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
    return widget.isFiltered
        ? Scaffold(appBar: AppBar(), body: _buildCard(context))
        : _buildCard(context);
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: widget.isFiltered
              ? const BorderRadius.all(Radius.circular(20.0))
              : BorderRadius.zero),
      elevation: 10,
      child: _buildLayout(),
    );
  }

  Widget _buildLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        double imageWidth = 160;
        double textWidth = availableWidth - imageWidth - 5;

        return widget.isFiltered
            ? Column(
                children: [
                  _buildImage(double.infinity, 180, false),
                  _buildTextContent(double.infinity),
                ],
              )
            : Row(
                children: [
                  _buildImage(imageWidth, 160, true),
                  _buildTextContent(textWidth, height: 155),
                ],
              );
      },
    );
  }

  Widget _buildImage(double width, double height, bool isCard) {
    return ImageWithErrorHandling(
      imageUrl: widget.place.imageUrl.first,
      width: width,
      height: height,
      fit: BoxFit.cover,
      isCard: isCard,
    );
  }

  Widget _buildTextContent(double width, {double? height}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Scrollbar(
        trackVisibility: true,
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place.title,
                maxLines: 2,
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subcategoryCardPlaceHeadline(context),
              ),
              Text(
                widget.place.address,
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subcategoryDesc(context),
              ),
              WorkingHoursPlace(
                workingHours:
                    workingHours ?? "Nema dostupnih podataka o radnom vremenu.",
                openNow: openNow ?? false,
                isLoadingWorkingHours: isLoadingWorkingHours,
                isShop: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
