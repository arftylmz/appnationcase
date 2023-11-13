
import 'package:flutter/material.dart';

class SearchBarBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const SearchBarBottomSheet({super.key,required this.scrollController});

  @override
  State<SearchBarBottomSheet> createState() => _SearchBarBottomSheetState();
}

class _SearchBarBottomSheetState extends State<SearchBarBottomSheet> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:const  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFE5E5EA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:const  Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    suffixIconColor: Colors.white,
                    border: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            // Your other content here
          ],
        ),
      ),
    );
  }
}
