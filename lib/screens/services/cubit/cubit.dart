import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/aggrieved_place.dart';
import 'package:najran/models/belonging.dart';
import 'package:najran/models/center.dart';
import 'package:najran/models/city.dart';
import 'package:najran/models/compensation_reason.dart';
import 'package:najran/models/country.dart';
import 'package:najran/models/department.dart';
import 'package:najran/models/relative.dart';
import 'package:najran/models/request_type.dart';
import 'package:najran/services/auth_service.dart';

part 'state.dart';

class CityCubit extends Cubit<CityState> {
  final OdooApiService odooApiService;

  final List<CityModel> _cities = [];
  final List<RelativeModel> _relatives = [];
  final List<CountryModel> _countries = [];
  final List<CenterModel> _centers = [];
  final List<RequestType> _requestTypes = [];
  final List<DepartmentModel> _departments = [];
  final List<BelongingModel> _belogings = [];
  final List<CompensationReason> _compensations = [];
  final List<AggrievedPlace> _aggrivedPlaces = [];

  final int _page = 1;
  final int _pageSize = 10;
  TextEditingController searchController = TextEditingController();

  CityModel? selectedCity;
  RelativeModel? selectedRelative;
  CountryModel? selectedCountry;
  CenterModel? selectedCenter;
  RequestType? selectedRequestType;
  DepartmentModel? selectedDepartment;
  CompensationReason? selectedCompensation;
  AggrievedPlace? selectedAggrivedPlace;
  List<BelongingModel>? selectedBelongings = [];

  final FocusNode cityFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode centerFocusNode = FocusNode();
  final FocusNode requestTypeFocusNode = FocusNode();
  final FocusNode departmentFocusNode = FocusNode();
  final FocusNode belgongingFocusNode = FocusNode();
  final FocusNode compensationFocusNode = FocusNode();
  final FocusNode aggrivedPlaceFocusNode = FocusNode();
  final LayerLink layerLink = LayerLink();

  CityCubit({required this.odooApiService}) : super(CityInitial());

  List<CityModel> get cities => _cities;
  List<RelativeModel> get relatives => _relatives;
  List<CountryModel> get countries => _countries;
  List<CenterModel> get centers => _centers;
  List<RequestType> get requestTypes => _requestTypes;
  List<DepartmentModel> get departments => _departments;
  List<BelongingModel> get belogings => _belogings;
  List<CompensationReason> get compensations => _compensations;
  List<AggrievedPlace> get aggrivedPlaces => _aggrivedPlaces;

  void init() {
    searchController.addListener(_updateFrom);
    fetchRelative();
    fetchRequestType();
    fetchDepatments();
    fetchBelogings();
    fetchCompensation();
    fetchAggrivePlaces();
  }

  void _updateFrom() {
    if (searchController.text.isEmpty) {
      selectedCity = null;
      emit(CityLoaded());
    }
  }

  void selectCity(CityModel? city) {
    selectedCity = city;
    cityFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectCountry(CountryModel? country) {
    selectedCountry = country;
    countryFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectCenter(CenterModel? center) {
    selectedCenter = center;
    centerFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectRelative(RelativeModel relative) {
    selectedRelative = relative;
    emit(CityLoaded());
  }

  void selectRequestType(RequestType? requestType) {
    selectedRequestType = requestType;
    requestTypeFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectDepartment(DepartmentModel? department) {
    selectedDepartment = department;
    departmentFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectCompensation(CompensationReason? compensation) {
    selectedCompensation = compensation;
    compensationFocusNode.unfocus();
    emit(CityLoaded());
  }

  void selectAggrievedPlace(AggrievedPlace? aggrivedPlace) {
    selectedAggrivedPlace = aggrivedPlace;
    aggrivedPlaceFocusNode.unfocus();
    emit(CityLoaded());
  }

  void toggleBelonging(BelongingModel belonging, bool selected) {
    if (selected) {
      selectedBelongings?.add(belonging);
    } else {
      selectedBelongings?.removeWhere((b) => b.id == belonging.id);
    }
    emit(CityLoaded());
  }

  void updateSelectedBelongings(List<BelongingModel> list) {
    selectedBelongings = list;
    emit(CityLoaded());
  }

  Future<void> fetchBelogings() async {
    emit(CityLoading());
    try {
      _belogings.clear();
      final response = await odooApiService.getModelData(
        model: '/get/appointment.belonging',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => BelongingModel.fromJson(json))
          .toList();

      _belogings.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchCompensation() async {
    emit(CityLoading());
    try {
      _compensations.clear();
      final response = await odooApiService.getModelData(
        model: '/get/compensation.reason',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => CompensationReason.fromJson(json))
          .toList();

      _compensations.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchAggrivePlaces() async {
    emit(CityLoading());
    try {
      _aggrivedPlaces.clear();
      final response = await odooApiService.getModelData(
        model: '/get/aggrieved.place',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => AggrievedPlace.fromJson(json))
          .toList();

      _aggrivedPlaces.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchDepatments() async {
    emit(CityLoading());
    try {
      _departments.clear();
      final response = await odooApiService.getModelData(
        model: '/get/hr.department',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => DepartmentModel.fromJson(json))
          .toList();

      _departments.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchCities(String cityName) async {
    if (state is CityLoading) return;
    emit(CityLoading());
    try {
      _cities.clear();
      final response = await odooApiService.getModelData(
        model: '/api/search/res.country.state',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
        name: cityName,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => CityModel.fromJson(json))
          .toList();

      _cities.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchCenters(String centerName) async {
    if (state is CityLoading) return;
    emit(CityLoading());
    try {
      _centers.clear();
      final response = await odooApiService.getModelData(
        model: '/api/search/affiliate.center',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
        name: centerName,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => CenterModel.fromJson(json))
          .toList();

      _centers.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchCountry(String countryName) async {
    if (state is CityLoading) return;
    emit(CityLoading());
    try {
      _countries.clear();
      final response = await odooApiService.getModelData(
        model: '/api/search/res.country',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
        name: countryName,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => CountryModel.fromJson(json))
          .toList();

      _countries.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchRelative() async {
    if (state is CityLoading) return;
    emit(CityLoading());
    try {
      _relatives.clear();
      final response = await odooApiService.getModelData(
        model: '/get/dead.relative.relation',
        query: '{id,name}',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => RelativeModel.fromJson(json))
          .toList();

      _relatives.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }

  Future<void> fetchRequestType() async {
    emit(CityLoading());
    try {
      _requestTypes.clear();
      final response = await odooApiService.getModelData(
        model: '/get/request.type',
        query: '{id,name}',
        page: _page,
        pageSize: 20,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => RequestType.fromJson(json))
          .toList();

      _requestTypes.addAll(newItems);
      if (!isClosed) {
        emit(CityLoaded());
      }
    } catch (e) {
      if (!isClosed) {
        emit(CityError(message: e.toString()));
      }
    }
  }
}
