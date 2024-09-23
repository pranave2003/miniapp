import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CosmeticWork extends StatefulWidget {
  const CosmeticWork({super.key});

  @override
  State<CosmeticWork> createState() => _CosmeticWorkState();
}

class _CosmeticWorkState extends State<CosmeticWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Screenshot 2024-08-17 114408.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 100, top: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.grey.shade100,
                              size: 20,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.twitter,
                                color: Colors.grey.shade100,size: 20,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.facebook,
                                color: Colors.grey.shade100,size: 20,)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100, top: 50),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10), // Hint text color
                          hintText: "Search",

                          suffixIcon: Icon(Icons.search,
                              color: Colors.white), // Icon color
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0), // Reduce vertical padding
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Optional: Set border color to white
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Optional: Set border color to white
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Optional: Set border color to white when focused
                          ),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            height: 1.0), // Typing text color and line height
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "HOME",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "REVIEWS",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "BRANDS",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "TUTORIALS",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "FEATURES",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "SHOP",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "FUNCTIONALITY",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 900, top: 300),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FIND MORE ABOUT",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w200,
                                fontSize: 40)),
                      ),
                      Text(
                        "MAKE UP PRODUCTS",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        color: Color(0xFF86727F),
                        child: Center(
                          child: Text(
                            "MAKE A RESERVATION",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15)),
                          ),
                        ), // Corrected hex color code
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
