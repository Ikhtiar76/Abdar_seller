import 'package:abdar_seller/Controllers/home_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/home_screen/home_screen.dart';
import 'package:abdar_seller/views/orders_screen/orders_screen.dart';
import 'package:abdar_seller/views/products_screen/products_screen.dart';
import 'package:abdar_seller/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomNavBar = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.grey.shade500, weight: 25),
          label: dashBoard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, color: Colors.grey.shade500, width: 25),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, color: Colors.grey.shade500, width: 25),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings,
              color: Colors.grey.shade500, width: 25),
          label: settings),
    ];

    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen()
    ];

    return Scaffold(
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(
           onTap: (index){
             controller.navIndex.value = index;
           },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: greenColor,
          unselectedItemColor: Colors.grey.shade500,
          items: bottomNavBar,
          backgroundColor: nabBarClr,
           currentIndex: controller.navIndex.value,
        ),
      ),
      body: Obx(()=> Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
