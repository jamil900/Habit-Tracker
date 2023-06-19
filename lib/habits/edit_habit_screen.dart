import 'package:flutter/material.dart';
import 'package:Habits/constants.dart';
import 'package:Habits/habits/habits_manager.dart';
import 'package:Habits/model/habit_data.dart';
import 'package:Habits/navigation/routes.dart';
import 'package:Habits/widgets/text_container.dart';
import 'package:provider/provider.dart';

class EditHabitScreen extends StatefulWidget {
  static MaterialPage page(HabitData? data) {
    return MaterialPage(
      name: (data != null) ? Routes.editHabitPath : Routes.createHabitPath,
      key: (data != null)
          ? ValueKey(Routes.editHabitPath)
          : ValueKey(Routes.createHabitPath),
      child: EditHabitScreen(habitData: data),
    );
  }

  const EditHabitScreen({Key? key, required this.habitData}) : super(key: key);

  final HabitData? habitData;

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController cue = TextEditingController();
  TextEditingController routine = TextEditingController();
  TextEditingController reward = TextEditingController();
  TextEditingController sanction = TextEditingController();
  TextEditingController accountant = TextEditingController();
  TimeOfDay notTime = const TimeOfDay(hour: 12, minute: 0);
  bool twoDayRule = false;
  bool showReward = false;
  bool advanced = false;
  bool notification = false;
  bool showSanction = false;

  Future<void> setNotificationTime(context) async {
    TimeOfDay? selectedTime;
    TimeOfDay initialTime = notTime;
    selectedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (selectedTime != null) {
      setState(() {
        notTime = selectedTime!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.habitData != null) {
      title.text = widget.habitData!.title;
      cue.text = widget.habitData!.cue;
      routine.text = widget.habitData!.routine;
      reward.text = widget.habitData!.reward;
      twoDayRule = widget.habitData!.twoDayRule;
      showReward = widget.habitData!.showReward;
      advanced = widget.habitData!.advanced;
      notification = widget.habitData!.notification;
      notTime = widget.habitData!.notTime;
      sanction.text = widget.habitData!.sanction;
      showSanction = widget.habitData!.showSanction;
      accountant.text = widget.habitData!.accountant;
    }
  }

  @override
  void dispose() {
    title.dispose();
    cue.dispose();
    routine.dispose();
    reward.dispose();
    sanction.dispose();
    accountant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.habitData != null) ? 'Ubah Habit' : 'Buat Habit',
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          if (widget.habitData != null)
            IconButton(
              icon: const Icon(
                Icons.delete,
                semanticLabel: 'Delete',
              ),
              color: HaboColors.red,
              tooltip: 'Delete',
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.habitData != null) {
                  Provider.of<HabitsManager>(context, listen: false)
                      .deleteHabit(widget.habitData!.id!);
                }
              },
            ),
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            if (title.text.isNotEmpty) {
              if (widget.habitData != null) {
                Provider.of<HabitsManager>(context, listen: false).editHabit(
                  HabitData(
                    id: widget.habitData!.id,
                    title: title.text.toString(),
                    twoDayRule: twoDayRule,
                    cue: cue.text.toString(),
                    routine: routine.text.toString(),
                    reward: reward.text.toString(),
                    showReward: showReward,
                    advanced: advanced,
                    notification: notification,
                    notTime: notTime,
                    position: widget.habitData!.position,
                    events: widget.habitData!.events,
                    sanction: sanction.text.toString(),
                    showSanction: showSanction,
                    accountant: accountant.text.toString(),
                  ),
                );
              } else {
                Provider.of<HabitsManager>(context, listen: false).addHabit(
                  title.text.toString(),
                  twoDayRule,
                  cue.text.toString(),
                  routine.text.toString(),
                  reward.text.toString(),
                  showReward,
                  advanced,
                  notification,
                  notTime,
                  sanction.text.toString(),
                  showSanction,
                  accountant.text.toString(),
                );
              }
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: const Text("Judul Habit tidak boleh kosong."),
                ),
              );
            }
          },
          backgroundColor: HaboColors.primary,
          child: const Icon(
            Icons.check,
            semanticLabel: 'Save',
            color: Colors.white,
            size: 35.0,
          ),
        );
      }),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                TextContainer(
                  title: title,
                  hint: 'Nama Habit',
                  label: 'Habit',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                //   child: Row(
                //     children: <Widget>[
                //       Checkbox(
                //         onChanged: (bool? value) {
                //           setState(() {
                //             twoDayRule = value!;
                //           });
                //         },
                //         value: twoDayRule,
                //       ),
                //       const Text("Use Two day rule"),
                //       const Padding(
                //         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //         child: Tooltip(
                //           message:
                //               "With two day rule, you can miss one day and do not lose a streak if the next day is successful.",
                //           child: Icon(
                //             Icons.info,
                //             color: Colors.grey,
                //             size: 20,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ExpansionTile(
                  title: const Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      "Fitur Lanjutan",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  initiallyExpanded: advanced,
                  onExpansionChanged: (bool value) {
                    advanced = value;
                  },
                  children: <Widget>[
                    Divider(
                      thickness: 0.5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Center(
                        child: Text(
                          "Bagian ini membantu Anda mendefinisikan kebiasaan Anda dengan lebih baik. Anda harus mendefinisikan pemicu (cue), rutinitas (routine), dan hadiah (reward) untuk setiap kebiasaan.",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const ValueKey("Info Button"),
                      icon: const Icon(
                        Icons.info,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Info"),
                              content:
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text("Cue: Pemicu adalah sinyal atau peristiwa yang memicu dimulainya kebiasaan. Misalnya, setiap kali saya melihat ponsel saya terletak di meja, itu menjadi pemicu untuk memeriksa pesan atau media sosial."),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                        const Text("Routine: Rutinitas adalah tindakan atau langkah-langkah yang dilakukan ketika kebiasaan tersebut dipicu. Misalnya, setelah melihat ponsel di meja, saya mulai membuka aplikasi pesan atau media sosial dan memeriksanya selama beberapa menit."),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                        const Text("Reward: Hadiah adalah sesuatu yang Anda rasakan sebagai hasil dari menjalankan kebiasaan tersebut. Misalnya, setelah memeriksa pesan atau media sosial, saya merasa terhubung dengan teman-teman dan mendapatkan pembaruan terbaru dari mereka, yang memberi saya perasaan kepuasan sosial."),
                                      ],
                                    ),
                                  ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Tutup"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Menutup dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextContainer(
                      title: cue,
                      hint: 'At 7:00AM',
                      label: 'Cue',
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      title: const Text("Notifikasi"),
                      trailing: Switch(
                          value: notification,
                          onChanged: (value) {
                            notification = value;
                            setState(() {});
                          }),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      enabled: notification,
                      title: const Text("Waktu notifikasi"),
                      trailing: InkWell(
                        onTap: () {
                          if (notification) {
                            setNotificationTime(context);
                          }
                        },
                        child: Text(
                          "${notTime.hour.toString().padLeft(2, '0')}:${notTime.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              color: (notification)
                                  ? null
                                  : Theme.of(context).disabledColor),
                        ),
                      ),
                    ),
                    TextContainer(
                      title: routine,
                      hint: 'Contoh: Tidak Merokok',
                      label: 'Routine',
                    ),
                    TextContainer(
                      title: reward,
                      hint: 'Tambah sehat',
                      label: 'Reward',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool? value) {
                              setState(() {
                                showReward = value!;
                              });
                            },
                            value: showReward,
                          ),
                          const Text("Tampilkan reward"),
                          // const Padding(
                          //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          //   child: Tooltip(
                          //     message:
                          //         "The remainder of the reward after a successful routine.",
                          //     child: Icon(
                          //       Icons.info,
                          //       semanticLabel: 'Tooltip',
                          //       color: Colors.grey,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        "Habit contract",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          "Habit contract, atau kontrak kebiasaan, adalah sebuah perjanjian tertulis yang digunakan untuk membantu seseorang mengembangkan atau mengubah kebiasaan tertentu. Dalam kontrak ini, individu menetapkan kebiasaan yang ingin mereka tingkatkan atau ubah, serta menetapkan tujuan yang ingin dicapai dalam periode waktu tertentu. Untuk mendorong kepatuhan, habit contract juga mencakup sanksi yang jelas jika individu melewatkan atau melanggar kebiasaan tersebut. Sanksi ini bisa berupa denda finansial atau konsekuensi negatif lainnya yang dirancang untuk memberikan motivasi bagi individu agar tetap mematuhi kebiasaan yang ditetapkan.",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextContainer(
                      title: sanction,
                      hint: 'Contoh: Sedekah 10k',
                      label: 'Sanction',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool? value) {
                              setState(() {
                                showSanction = value!;
                              });
                            },
                            value: showSanction,
                          ),
                          const Text("Tampilkan Sanksi"),
                          // const Padding(
                          //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          //   child: Tooltip(
                          //     message:
                          //         "The remainder of the sanction after a unsuccessful routine.",
                          //     child: Icon(
                          //       Icons.info,
                          //       semanticLabel: 'Tooltip',
                          //       color: Colors.grey,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    TextContainer(
                      title: accountant,
                      hint: 'Malaikat Izrail',
                      label: 'Saksi',
                    ),
                    const SizedBox(
                      height: 110,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
