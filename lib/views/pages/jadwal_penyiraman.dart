import 'package:flutter/material.dart';
import 'package:orchitech/controllers/jadwal_controller.dart';
import '../../widget/appbar.dart';


class JadwalPenyiraman extends StatefulWidget {
  const JadwalPenyiraman({super.key, required this.idJalur});
  final int idJalur;
  static const routeName = '/jadwalpenyiraman';

  @override
  State<JadwalPenyiraman> createState() => _JadwalPenyiramanState();
}

class _JadwalPenyiramanState extends State<JadwalPenyiraman> {
  final _jadwalController = JadwalController();
  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  final List<String> selectedDays = [];
  TimeOfDay? selectedTime;
  bool _dataLoaded = false;

  Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    TransitionBuilder? builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    RouteSettings? routeSettings,
    EntryModeChangeCallback? onEntryModeChanged,
    Offset? anchorPoint,
    Orientation? orientation,
    Icon? switchToInputEntryModeIcon,
    Icon? switchToTimerEntryModeIcon,
  }) async {
    assert(debugCheckHasMaterialLocalizations(context));

    final Widget dialog = TimePickerDialog(
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      errorInvalidText: errorInvalidText,
      hourLabelText: hourLabelText,
      minuteLabelText: minuteLabelText,
      orientation: orientation,
      onEntryModeChanged: onEntryModeChanged,
      switchToInputEntryModeIcon: switchToInputEntryModeIcon,
      switchToTimerEntryModeIcon: switchToTimerEntryModeIcon,
    );
    return showDialog<TimeOfDay>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _jadwalController.showJadwal(widget.idJalur),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        if (!_dataLoaded) {
          selectedDays.addAll(data!.hari);
          selectedTime = data.waktu;
          _dataLoaded = true;
        }

        return Scaffold(
          appBar: WidgetAppBar(
            colorAnimated: ColorAnimated(
              background: Color(0xFF1C7C56),
              color: Colors.white,
            ),
            title: 'Jadwal Penyiraman ${widget.idJalur}',
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(
                      'Pilih Hari',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 0,
                  runSpacing: 1,
                  children:
                      days.map((day) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width / 2 -
                                40, // supaya dua kolom
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    selectedDays.contains(day)
                                        ? const Color.fromARGB(
                                          255,
                                          227,
                                          253,
                                          243,
                                        )
                                        : Colors.white,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedDays.contains(day)) {
                                    selectedDays.remove(day);
                                  } else {
                                    selectedDays.add(day);
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 20),
                                  Icon(
                                    selectedDays.contains(day)
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    size: 20,
                                    color:
                                        selectedDays.contains(day)
                                            ? Colors.blue
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    day,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xFF1C7C56),
                                onPrimary: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            selectedTime ??= data!.waktu;
                            selectedTime = value;
                          });
                        }
                      });
                    },
                    contentPadding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                    title: Text(
                      'Atur Waktu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Atur waktu penyiraman',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.timer_rounded),
                        Text(
                          selectedTime?.format(context) ?? "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(3, 68, 45, 1),
                        minimumSize: Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        if (selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Silahkan pilih waktu')),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('APAKAH ANDA YAKIN ?'),
                                ),
                                content: Text(
                                  'Apakah Anda yakin ingin menyimpan jadwal penyiraman ini?',
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Batal'),
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // Tutup dialog
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(
                                        3,
                                        68,
                                        45,
                                        1,
                                      ),
                                    ),
                                    child: Text(
                                      'Ya, Simpan',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      // Tutup dialog terlebih dahulu
                                      Navigator.of(context).pop();
                                      // Jalankan update
                                      try {
                                        _jadwalController.ubahJadwal(
                                          widget.idJalur,
                                          selectedDays,
                                          selectedTime!,
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Jadwal penyiraman berhasil disimpan',
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Color.fromRGBO(
                                              3,
                                              68,
                                              45,
                                              1,
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Gagal menyimpan jadwal penyiraman $e',
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Color.fromRGBO(
                                              3,
                                              68,
                                              45,
                                              1,
                                            ),
                                          ),
                                        );
                                      }
                                      // Tampilkan snackbar
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
