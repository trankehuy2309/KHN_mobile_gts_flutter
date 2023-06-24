import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

const primaryColor = Color.fromRGBO(0, 197, 105, 1);

class ValidatorApp {
  static double fheaderHeight = 230;
}

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Object? errorText]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      errorText: errorText?.toString(),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration textPassDecoration(
      [String lableText = "", String hintText = "", bool? _passwordVisible]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      suffixIcon: IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          _passwordVisible! ? Icons.visibility : Icons.visibility_off,
          // color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () {
          _passwordVisible = !_passwordVisible!;
        },
      ),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    // ignore: deprecated_member_use
    Color c2 = Theme.of(context).accentColor;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class Constants {
  static const String bugBuckBunnyVideoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String forBiggerBlazesUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  static const String fileTestVideoUrl = "testvideo.mp4";
  static const String fileTestVideoEncryptUrl = "testvideo_encrypt.mp4";
  static const String networkTestVideoEncryptUrl =
      "https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4";
  static const String fileExampleSubtitlesUrl = "example_subtitles.srt";
  static const String hlsTestStreamUrl =
      "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";
  static const String hlsPlaylistUrl =
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
  static const Map<String, String> exampleResolutionsUrls = {
    "LOW":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "MEDIUM":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4",
    "LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4",
    "EXTRA_LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
  };
  static const String phantomVideoUrl =
      "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8";
  static const String elephantDreamVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  static const String forBiggerJoyridesVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
  static const String verticalVideoUrl =
      "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4";
  static String logo = "logo.png";
  static String placeholderUrl =
      "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg";
  static String elephantDreamStreamUrl =
      "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";
  static String tokenEncodedHlsUrl =
      "https://amssamples.streaming.mediaservices.windows.net/830584f8-f0c8-4e41-968b-6538b9380aa5/TearsOfSteelTeaser.ism/manifest(format=m3u8-aapl)";
  static String tokenEncodedHlsToken =
      "Bearer=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cm46bWljcm9zb2Z0OmF6dXJlOm1lZGlhc2VydmljZXM6Y29udGVudGtleWlkZW50aWZpZXIiOiI5ZGRhMGJjYy01NmZiLTQxNDMtOWQzMi0zYWI5Y2M2ZWE4MGIiLCJpc3MiOiJodHRwOi8vdGVzdGFjcy5jb20vIiwiYXVkIjoidXJuOnRlc3QiLCJleHAiOjE3MTA4MDczODl9.lJXm5hmkp5ArRIAHqVJGefW2bcTzd91iZphoKDwa6w8";
  static String widevineVideoUrl =
      "https://storage.googleapis.com/wvmedia/cenc/h264/tears/tears_sd.mpd";
  static String widevineLicenseUrl =
      "https://proxy.uat.widevine.com/proxy?provider=widevine_test";
  static String fairplayHlsUrl =
      "https://fps.ezdrm.com/demo/hls/BigBuckBunny_320x180.m3u8";
  static String fairplayCertificateUrl =
      "https://github.com/koldo92/betterplayer/raw/fairplay_ezdrm/example/assets/eleisure.cer";
  static String fairplayLicenseUrl = "https://fps.ezdrm.com/api/licenses/";
  static String catImageUrl =
      "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg";
  static String dashStreamUrl =
      "https://bitmovin-a.akamaihd.net/content/sintel/sintel.mpd";
  static String segmentedSubtitlesHlsUrl =
      "https://eng-demo.cablecast.tv/segmented-captions/vod.m3u8";
}
