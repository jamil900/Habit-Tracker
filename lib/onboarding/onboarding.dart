import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Habits/constants.dart';
import 'package:Habits/settings/settings_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      titleWidget: const Text(
        'Definisikan Keabiasaanmu',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      image: SvgPicture.asset(
        'assets/images/onboard/1.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Untuk lebih mematuhi kebiasaan Anda, Anda dapat melakukan hal-hal berikut:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1. Cue (Pemicu)',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '2. Routine (Rutinitas)',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '3. Reward (Hadiah)',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      titleWidget: const Text(
        'Catat hari-hari Anda',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      image: SvgPicture.asset(
        'assets/images/onboard/2.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check,
                    color: HaboColors.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Berhasil Dilakukan',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.close,
                    color: HaboColors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'TIdak Dilakukan',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.last_page,
                    color: HaboColors.skip,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Di Skip',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: HaboColors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Komentar',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "Amati kemajuan Anda",
      image: SvgPicture.asset(
        'assets/images/onboard/3.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Anda dapat melacak(track) kemajuan Anda melalui tampilan kalender di setiap kebiasaan atau di halaman statistik.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPagesViewModel,
      done: const Text("Selesai", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        if (Provider.of<SettingsManager>(context, listen: false)
            .getSeenOnboarding) {
          Navigator.pop(context);
        } else {
          Provider.of<SettingsManager>(context, listen: false)
              .setSeenOnboarding = true;
        }
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: const Text("Skip"),
    );
  }
}
