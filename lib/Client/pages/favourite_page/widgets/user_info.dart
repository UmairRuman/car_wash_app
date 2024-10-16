import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePageUserLocation extends StatelessWidget {
  final String location;
  const FavouritePageUserLocation({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            flex: 15,
            child: Icon(
              Icons.location_on_sharp,
              color: Colors.red,
            )),
        Expanded(
            flex: 85,
            child: AutoSizeText(
              location,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}

class FavouritePageProfilePic extends StatelessWidget {
  final String profilePic;
  const FavouritePageProfilePic({super.key, required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: profilePic == ""
                  ? AssetImage(emptyImage)
                  : NetworkImage(profilePic),
              fit: BoxFit.cover)),
    );
  }
}

class FavouritePageUserInfo extends ConsumerWidget {
  const FavouritePageUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(userAdditionStateProvider);
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 40,
            child: FavouritePageUserLocation(
              location: (state as AddittionLoadedState).user.userLocation,
            )),
        const Spacer(
          flex: 40,
        ),
        Expanded(
            flex: 10,
            child: FavouritePageProfilePic(
              profilePic: state.user.profilePicUrl,
            )),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class FavouriteCategoryPic extends StatelessWidget {
  final String favouriteCategoryimagePath;
  final bool isAssetImage;
  const FavouriteCategoryPic(
      {super.key,
      required this.favouriteCategoryimagePath,
      required this.isAssetImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: favouriteCategoryimagePath == ""
                  ? AssetImage(emptyImage)
                  : favouriteCategoryimagePath[0] == "a"
                      ? AssetImage(favouriteCategoryimagePath) as ImageProvider
                      : CachedNetworkImageProvider(favouriteCategoryimagePath),
              fit: BoxFit.cover),
          color: const Color.fromARGB(255, 239, 233, 233),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: favouriteCategoryimagePath == ""
          ? Image.asset(emptyImage)
          : favouriteCategoryimagePath[0] == "a"
              ? null // The image is already being han  dled by DecorationImage
              : CachedNetworkImage(
                  imageUrl: favouriteCategoryimagePath,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
    );
  }
}
