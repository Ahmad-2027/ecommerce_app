import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String? text;
  final String? imgUrl;
  final VoidCallback? onPressed;
  final bool isLoading;
  SocialMediaButton({
    super.key,
    this.text,
    this.imgUrl,
    this.onPressed,
    this.isLoading = false,
  }) {
    assert((imgUrl != null && text != null) || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(
                  child: const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgUrl!,
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 16),
                    Text(text!),
                  ],
                ),
        ),
      ),
    );
  }
}
