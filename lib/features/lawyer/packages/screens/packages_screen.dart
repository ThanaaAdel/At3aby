import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/packages/cubit/state.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../../../core/widgets/custom_appbar_title_and_back.dart';
import '../cubit/cubit.dart';
import 'widget/package_item_widget.dart';
import 'package:lottie/lottie.dart';
class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    context.read<PackagesCubit>().getAdOfferPackages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          var cubit = context.read<PackagesCubit>();

          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarTitleAndbackButton(
                    title: 'packages'.tr(),
                    isLawyer: widget.args.indexPageClientOrLawyer == 1,
                  ),
                  5.h.verticalSpace,
                  Flexible(
                    child: (state is LoadingGetPackagesState &&
                        cubit.mainAdOfferPackagesModel == null)
                        ? Center(child: CustomLoadingIndicator())
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.mainAdOfferPackagesModel?.data?.length,
                      itemBuilder: (context, index) {
                        var item = cubit.mainAdOfferPackagesModel?.data?[index];
                        return packageItemWidget(
                          item: item,
                          onTap: () async {
                            bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('confirm'.tr()),
                                content: Text('are_you_sure_you_want_to_choose_this_package'.tr()),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text('cancel'.tr()),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: Text('confirm'.tr()),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              cubit.addAdOfferPackageToLawyer(
                                packageId: cubit.mainAdOfferPackagesModel?.data?[index].id.toString() ?? "",
                              );
                            }
                          },

                        );
                      },
                    ),
                  ),
                ],
              ),
              // Show loading overlay when package is being added
              if (state is LoadingAddAdOfferPackageToLawyerState)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child:Center(
                      child: Lottie.asset(
                        'assets/icons/Animation - 1744329876055.json',
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

}
