import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/society/cubit/cubit.dart';
import 'package:ataaby/features/society/cubit/state.dart';
import 'package:ataaby/features/society/screen/widget/post_cart.dart';
import 'package:ataaby/features/society/screen/widget/post_details.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import '../../../core/widgets/custom_appbar_title_and_back.dart';
import 'widget/add_post_widget.dart';

class SocietyMainScreen extends StatefulWidget {
  SocietyMainScreen({required this.isLawyer, super.key});
  bool isLawyer;

  @override
  State<SocietyMainScreen> createState() => _SocietyMainScreenState();
}

class _SocietyMainScreenState extends State<SocietyMainScreen> {
  @override
  initState() {
    super.initState();
    context.read<SocietyCubit>().getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocietyCubit, SocietyState>(
      builder: (context, state) {
        var cubit = context.read<SocietyCubit>();
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                CustomAppBarTitleAndbackButton(
                    title: widget.isLawyer ? 'blog'.tr() : 'society'.tr(),
                    isLawyer: widget.isLawyer ? true : false),
                Flexible(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // if (widget.isLawyer)
                      AddPostCard(cubit: cubit),

                      if (widget.isLawyer) 30.h.verticalSpace,
                      (state is LoadingGetPostsData)
                          ? Center(
                              child: CustomLoadingIndicator(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.postsModel?.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PostDetailsScreen(
                                            postsModelData:
                                                cubit.postsModel!.data![index],
                                            idPost: cubit.postsModel
                                                    ?.data?[index].id ??
                                                0,
                                            cubit: cubit,
                                            isLawyer: widget.isLawyer,
                                          ),
                                        ),
                                      );
                                    },
                                    child: PostCard(
                                      cubit: cubit,
                                      postsModelData:
                                          cubit.postsModel!.data![index],
                                    ));
                              },
                            ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
