import 'package:flutter/material.dart';
import 'package:lafia/utils/colors.dart';  
// Ensure this points to your AppColors file  

class CustomButton extends StatelessWidget {  
  final Function()? onTap;  
  final String text;  

  const CustomButton({  
    super.key,  
    required this.onTap,  
    required this.text,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTap: onTap,  
      child: Container(  
        height: 56,  
        width: double.infinity,  
        padding: const EdgeInsets.all(15),  
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),  
        decoration: BoxDecoration(  
          color: AppColors.secondary, // Change this to use the color from your class  
          borderRadius: BorderRadius.circular(30),  
        ),  
        child: Center(  
          child: Text(  
            text,  
            style: const TextStyle(  
              fontWeight: FontWeight.bold,  
              color: Colors.white, // This can remain if white text is preferred  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}