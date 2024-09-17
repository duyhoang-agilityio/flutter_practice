import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_advance/core/gen/assets.gen.dart';
import 'package:practice_advance/features/home/presentation/bloc/home_bloc.dart';
import 'package:practice_advance/features/home/presentation/domain/usecases/home_usecase.dart';
import 'package:practice_advance/global.dart';
import 'package:practice_advance/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(locator<HomeUsecases>())..add(GetProductEvent(1)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Example Page')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Center(
                  child: Column(
                children: [
                  Text(
                    'Example: ${state.homeEntity.title} ${Global.environment == 'dev' ? 'dev' : 'prod'}',
                    style: TextStyle(fontSize: 16.w),
                  ),
                  Text(AppLocalizations.of(context)?.helloWorld ?? ''),
                  Text(
                    'Example: ${state.homeEntity.title}',
                    style: TextStyle(fontSize: 16.h),
                  ),
                  Text(
                    'Example: ${state.homeEntity.title}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SvgPicture.asset(
                    Assets.values.first,
                    width: 120,
                    height: 120,
                  ),
                ],
              ));
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Text('No data available');
          },
        ),
      ),
    );
  }
}
