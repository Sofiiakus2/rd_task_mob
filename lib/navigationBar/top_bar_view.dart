import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 10),
            child: SizedBox(
              width: 50,
              child: FloatingActionButton(
                heroTag: 'menu_button',
                backgroundColor: AppColors.white,
                splashColor: AppColors.grey,
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: () {
                },
                tooltip: 'Floating Action Button',
                child: const Icon(Icons.menu,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 10),
                child: SizedBox(
                  width: 50,
                  child: FloatingActionButton(
                    heroTag: 'bell_button',
                    backgroundColor: AppColors.white,
                    splashColor: AppColors.grey,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/registration');
                    },
                    tooltip: 'Floating Action Button',
                    child: const Icon(CupertinoIcons.bell_fill,
                      color: AppColors.black,),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 10),
                child: SizedBox(
                  width: 50,
                  child: FloatingActionButton(
                    heroTag: 'profile_button',
                    backgroundColor: AppColors.white,
                    splashColor: AppColors.grey,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    tooltip: 'Floating Action Button',
                    child: const Icon(Icons.person,
                      color: AppColors.black,),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
