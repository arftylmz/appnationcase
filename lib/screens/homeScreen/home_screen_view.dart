import 'package:appnationcase/data/repositories/request.dart';
import 'package:appnationcase/product/utils/screensize.dart';
import 'package:appnationcase/screens/homeScreen/search_bar_view.dart';
import 'package:appnationcase/screens/settingScreen/setting_screen_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  final List<String> dogBreedsList;
  final List<String> dogBreedsListPhoto;

  const HomeScreenView(
      {Key? key, required this.dogBreedsList, required this.dogBreedsListPhoto})
      : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  bool detay = false;
  bool random = false;
  String pickedDogName = "";
  String pickedDogPhoto = "";
  String randomImage = "";
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Dog Generate",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.dogBreedsList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    pickedDogName = widget.dogBreedsList[index];
                    pickedDogPhoto = widget.dogBreedsListPhoto[index];
                    detay = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.dogBreedsListPhoto[index],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 163.0,
                          height: 163.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      bottom: 8, // Alt kenara olan uzaklık
                      left: 30, // Sol kenara olan uzaklık
                      child: Text(
                        capitalizeFirstLetter(widget.dogBreedsList[index]),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Column(
          children: [
            const Spacer(),
            Builder(
              builder: (BuildContext scaffoldContext) {
                return ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: scaffoldContext,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.5,
                          minChildSize: 0.2,
                          maxChildSize: 0.95,
                          expand: false,
                          builder: (context, scrollController) {
                            return SearchBarBottomSheet(
                              scrollController: scrollController,
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: const Color(0x28000000),
                    elevation: 16,
                  ),
                  child: const SizedBox(
                    width: 400,
                    height: 64,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Search',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0x993C3C43),
                              fontSize: 16,
                              fontFamily: 'Galano Grotesque',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: 0.16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300, // Çerçeve rengi
                  width: 3.0, // Çerçeve kalınlığı
                ),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.elliptical(
                        30, 100) // Yukarı doğru çıkarken köşe yarıçapı
                    ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.elliptical(
                        26, 100) // Yukarı doğru çıkarken köşe yarıçapı
                    ),
                child: Container(
                  height: 110,
                  width: displayWidth(context),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem('Home', Icons.home, true),
                      _buildDivider(),
                      Builder(
              builder: (BuildContext scaffoldContext) {
                return ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: scaffoldContext,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.95,
                          //minChildSize: 0.2,
                          maxChildSize: 0.95,
                          expand: false,
                          builder: (context, scrollController) {
                            return SettingBarSheet(
                              scrollController: scrollController,
                            );
                          },
                        );
                      },
                    );
                    
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: const Color(0x28000000),
                    elevation: 16,
                  ), child: _buildNavItem('Settings', Icons.settings, false),
                  );}
                  )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        detay
            ? Stack(children: [
                _popup(context),
                random ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 256,
                        height: 256,
                        decoration: ShapeDecoration(
                          image:  DecorationImage(
                            image: NetworkImage(
                               randomImage),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            random = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 32,
                            height: 32,
                            color: Colors.white,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'X',
                                style: TextStyle(
                                    fontSize: 24,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ) : const SizedBox(),
              ])
            : const SizedBox()
      ],
    );
  }

  SizedBox _popup(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 343,
                  height: displayHeight(context) * 0.73,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 343,
                        child: Container(
                          width: 343,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(pickedDogPhoto),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        capitalizeFirstLetter(pickedDogName),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xFF0054D3),
                          fontSize: 20,
                          fontFamily: 'Galano Grotesque',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.20,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      const Text(
                        'Breed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Galano Grotesque',
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: 0.16,
                        ),
                      ),
                      const Text(
                        'Sub Breed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xFF0054D3),
                          fontSize: 20,
                          fontFamily: 'Galano Grotesque',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.20,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      const Text(
                        'Sub Breed 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Galano Grotesque',
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: 0.16,
                        ),
                      ),
                      const Text(
                        'Sub Breed 2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Galano Grotesque',
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: 0.16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()async {
                          await DogBreedRepository().getBreedRandom(pickedDogName).then((value) {
                            setState(() {
                              randomImage = value;
                              random = true;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // İstediğiniz kırpma miktarını ayarlayabilirsiniz
                          ),
                          fixedSize: const Size(256,
                              56), // İstediğiniz genişlik ve yüksekliği burada belirleyebilirsiniz
                        ),
                        child: const Text(
                          "Generate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Galano Grotesque',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.09,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 155,
            right: 50,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  detay = false;
                  random = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.8),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Boş string ise doğrudan geri döndür
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  Widget _buildNavItem(String label, IconData icon, bool picked) {
    return Column(
      children: [
        Icon(
          icon,
          color: picked ? const Color.fromARGB(255, 6, 78, 137) : Colors.black,
          size: 32,
        ),
        Text(
          label,
          style: TextStyle(
            decoration: TextDecoration.none,
            color:
                picked ? const Color.fromARGB(255, 6, 78, 137) : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 2,
      height: 30,
      color: const Color(0xFFD1D1D6),
    );
  }
}
