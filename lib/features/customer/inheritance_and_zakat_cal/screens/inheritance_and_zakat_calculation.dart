import 'package:ataaby/core/exports.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/appbar_with_image.dart';
import '../../../lawyer/profile_lawyer/Screen/widgets/profile_widget.dart';
import '../cubit/inheritance_and_zakat_calculator_cubit.dart';
import '../cubit/inheritance_and_zakat_calculator_customer_state.dart';

class InheritanceAndZakatCalculatorScreen extends StatelessWidget {
  const InheritanceAndZakatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceAndZakatCalculatorCubit,
        InheritanceAndZakatCalculatorState>(
      builder: (context, state) {
        var cubit = context.read<InheritanceAndZakatCalculatorCubit>();
        return Scaffold(
            body: Column(
          children: [
            AppbarContainImage(
              isLawyer: false,
              titleCenter: "inheritance_and_zakat_calculator_customer".tr(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cubit.myListItems.length,
                itemBuilder: (context, index) => ProfileWidget(
                  title: cubit.myListItems[index].title,
                  onTap: () {
                    //! 1 ==>> Zakat
                    //! 2 ==>> Inheritance
                    if (cubit.myListItems[index].id == 1) {
                      Navigator.pushNamed(context, Routes.calZakatScreen,
                          arguments: cubit.myListItems[index].title);
                    } else {
                      successGetBar(cubit.myListItems[index].title);
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                  },
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
