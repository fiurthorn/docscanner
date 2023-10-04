import 'package:document_scanner/core/reactive/bloc.dart';
import 'package:document_scanner/scanner/presentation/screens/base.dart';
import 'package:document_scanner/scanner/presentation/screens/base/right_menu.dart';
import 'package:document_scanner/scanner/presentation/screens/base/top_nav.dart';
import 'package:flutter/material.dart';

abstract class TemplateBaseScreenState<T extends StatefulWidget, F extends ReactiveBloc>
    extends ReactiveBlocBaseScreenState<T, F> {
  TemplateBaseScreenState({
    super.onSubmitting,
    super.onFailure,
    super.onSuccess,
    super.onUpdateState,
    bool extendBodyBehindAppBar = false,
    FloatingActionButtonLocation floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked,
  });

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => FullTopNavBar(title: title(context), refresh: update);

  @override
  Widget? buildEndDrawer(BuildContext context) => RightMenu(refresh: update);
}
