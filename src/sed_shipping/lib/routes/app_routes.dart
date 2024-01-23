import 'package:flutter/material.dart';
import 'package:renan_s_application8/presentation/delivery_id_screen/delivery_id_screen.dart';
import 'package:renan_s_application8/presentation/mockup_entrega_screen/mockup_entrega_screen.dart';
import 'package:renan_s_application8/presentation/mockup_modal_digite_o_c_digo_one_screen/mockup_modal_digite_o_c_digo_one_screen.dart';
import 'package:renan_s_application8/presentation/mockup_modal_digite_o_c_digo_screen/mockup_modal_digite_o_c_digo_screen.dart';
import 'package:renan_s_application8/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String mockupEntregaScreen = '/mockup_entrega_screen';

  static const String deliveryIDScreen = '/delivery_id_screen';

  static const String mockupModalDigiteOCDigoOneScreen =
      '/mockup_modal_digite_o_c_digo_one_screen';

  static const String mockupModalDigiteOCDigoScreen =
      '/mockup_modal_digite_o_c_digo_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    deliveryIDScreen: (context) => DeliveryIDScreen(),
    mockupEntregaScreen: (context) => MockupEntregaScreen(),
    mockupModalDigiteOCDigoOneScreen: (context) =>
        MockupModalDigiteOCDigoOneScreen(),
    mockupModalDigiteOCDigoScreen: (context) => MockupModalDigiteOCDigoScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
