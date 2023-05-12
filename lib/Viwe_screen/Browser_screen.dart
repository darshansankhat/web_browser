import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:web_browser/Provider_screen/Provider_screen.dart';

class Browser_screen extends StatefulWidget {
  const Browser_screen({Key? key}) : super(key: key);

  @override
  State<Browser_screen> createState() => _Browser_screenState();
}

class _Browser_screenState extends State<Browser_screen> {
  Browser_provider? providerF;
  Browser_provider? providerT;

  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
        pullToRefreshController=PullToRefreshController(
      onRefresh: (){
        Provider.of<Browser_provider>(context,listen: false).webViewController!.reload();
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController txtsearch = TextEditingController();

    providerF = Provider.of<Browser_provider>(context, listen: false);
    providerT = Provider.of<Browser_provider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //search
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50,
                child: TextFormField(
                  controller: txtsearch,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(500),
                    ),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/image/d.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        )),
                    suffixIcon: IconButton(
                      onPressed: () {
                        providerT!.a?providerT!.search=txtsearch.text:providerT!.copy=txtsearch.text;
                        providerT!.a?providerT!.webViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse("https://www.google.com/search?q=${providerT!.search}"),
                          ),
                        ):
                        providerT!.webViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse("${providerT!.copy}"),
                          ),
                        );
                      },
                      icon: Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),
            //google
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.google.com/")),
                onLoadStart: (controller, url) {
                  providerT!.webViewController = controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadStop: (controller, url) {
                  providerT!.webViewController = controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {
                  providerT!.webViewController = controller;
                  pullToRefreshController!.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  providerT!.webViewController = controller;
                  pullToRefreshController!.endRefreshing();
                },
                pullToRefreshController: pullToRefreshController,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white10,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    providerT!.webViewController!.goBack();
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
              IconButton(
                  onPressed: () {
                    providerT!.webViewController!.goForward();
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp)),
              IconButton(
                  onPressed: () {
                    providerT!.webViewController!.reload();
                  },
                  icon: Image.asset("assets/image/r1.png",
                      height: 70, width: 70, fit: BoxFit.cover)),
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Link Copid",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      backgroundColor: Colors.white12,
                      behavior: SnackBarBehavior.floating,
                    ));
                    providerT!.copy="https://www.google.com/search?q=${providerT!.search}";
                  },
                  icon: Icon(Icons.copy)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
