import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/gendernew_model.dart';
import 'package:sufismart/model/infodetailuser_model.dart';
import 'package:sufismart/model/job_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ProfileViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  TextEditingController namaTextController = TextEditingController();
  TextEditingController tanggalLahirTextController = TextEditingController();
  TextEditingController noTelpTextController = TextEditingController();
  TextEditingController noKtpTextController = TextEditingController();
  TextEditingController noKontrak1TextController = TextEditingController();
  TextEditingController noKontrak2TextController = TextEditingController();
  TextEditingController noKontrak3TextController = TextEditingController();

  DateTime? selectedDateFrom = DateTime.now();
  DateTime? picked;
  Duration? timertest;
  final format = DateFormat("yyyy-MM-dd");

  Future<List<JobModel>?> jobs = JobModel.getListJob();
  Future<List<GenderNewModel>?> genders = GenderNewModel.getListGender();

  void showDate() async {
    picked = await showDatePicker(
        context: System.data.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 200, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDateFrom) {
      selectedDateFrom = picked!;
      tanggalLahirTextController.text = format.format(selectedDateFrom!);
      ModeUtil.debugPrint("tgllahir $tanggallahir");
      commit();
    }
  }

  GenderNewModel? _gender;
  GenderNewModel? get gender => _gender;
  set gender(GenderNewModel? type) {
    _gender = type;
    commit();
  }

  JobModel? _job;
  JobModel? get job => _job;
  set job(JobModel? type) {
    _job = type;
    commit();
  }

  String? _fullname;
  String? get fullname => _fullname;
  set fullname(String? value) {
    _fullname = value;
    commit();
  }

  String? _tanggallahir;
  String? get tanggallahir => _tanggallahir;
  set tanggallahir(String? value) {
    _tanggallahir = value;
    commit();
  }

  String? _telp;
  String? get telp => _telp;
  set telp(String? value) {
    _telp = value;
    commit();
  }

  String? _nokon1;
  String? get nokon1 => _nokon1;
  set nokon1(String? value) {
    _nokon1 = value;
    commit();
  }

  String? _nokon2;
  String? get nokon2 => _nokon2;
  set nokon2(String? value) {
    _nokon2 = value;
    commit();
  }

  String? _nokon3;
  String? get nokon3 => _nokon3;
  set nokon3(String? value) {
    _nokon3 = value;
    commit();
  }

  String? _noKtp;
  String? get noktp => _noKtp;
  set noktp(String? value) {
    _noKtp = value;
    commit();
  }

  void getDetailInfoUser({
    required String userid,
  }) {
    loadingController.startLoading();
    InfoDetailuserModel.getDetailUser(userid: userid).then((value) {
      loadingController.stopLoading(
          isError: false,
          message: "Successfuly",
          duration: const Duration(seconds: 3),
          onCloseCallBack: () {
            namaTextController.text = value?.nama ?? "";
            tanggalLahirTextController.text = value?.tanggallahir ?? "";
            noTelpTextController.text = value?.telp ?? "";
            noKtpTextController.text = value?.nik ?? "";
            noKontrak1TextController.text = value?.nokon1 ?? "";
            noKontrak2TextController.text = value?.nokon2 ?? "";
            noKontrak3TextController.text = value?.nokon3 ?? "";
            GenderNewModel.readGender(value?.gender ?? "").then((value) {
              gender = value;
            });
            JobModel.readJob(value?.pekerjaan ?? "").then((value) {
              job = value;
            });

            // noKontrak1TextController.text = value?.nokon1 ?? "";
            // noKontrak2TextController.text = value?.nokon2  ?? "";
            // noKontrak3TextController.text = value?.nokon3 ?? "";
            commit();
          });
    });
  }

  void sendUpdateProfil({
    ValueChanged<CustomerNewModel>? onUpdateSuccefuly,
  }) {
    loadingController.startLoading();
    ModeUtil.debugPrint("${System.data.global.customerNewModel!.userid}");
    InfoDetailuserModel.updateDetailInfoUser(
        infoDetailuserModel: InfoDetailuserModel(
      userid: System.data.global.customerNewModel!.userid,
      tanggallahir: tanggalLahirTextController.text,
      telp: noTelpTextController.text,
      nokon1: noKontrak1TextController.text,
      nokon2: noKontrak2TextController.text,
      nokon3: noKontrak3TextController.text,
      nik: noKtpTextController.text,
      pekerjaan: job?.value,
      gender: gender?.value,
      nama: namaTextController.text,
    )).then((value) {
      if (value != null) {
        if (value.status == "1") {
          loadingController.stopLoading(
            isError: true,
            message: value.msg,
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {},
          );
        } else if (value.status == "0") {
          loadingController.stopLoading(
            isError: false,
            message: value.msg,
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {
              // if (onUpdateSuccefuly != null) {
              //   onUpdateSuccefuly(value);
              // }
            },
          );
        }
      }
    }).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}
