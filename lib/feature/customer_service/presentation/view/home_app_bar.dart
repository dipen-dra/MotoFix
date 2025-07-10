// lib/feature/home/presentation/widgets/home_app_bar.dart
import 'package:flutter/material.dart';
import 'package:motofix_app/core/common/app_colors.dart'; // Adjust path

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello, Dipendra', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                SizedBox(height: 4),
                Text('Ready for a smooth ride?', style: TextStyle(fontSize: 16, color: AppColors.textWhite70)),
              ],
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: const NetworkImage('https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg'),
            backgroundColor: AppColors.accentBlue.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}