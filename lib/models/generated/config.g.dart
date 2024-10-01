// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config()
  ..appSetting =
      AppSetting.realFromJson(json['appSetting'] as Map<String, Object?>?)
  ..profiles = (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..currentProfileId = json['currentProfileId'] as String?
  ..themeMode = $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system
  ..primaryColor = (json['primaryColor'] as num?)?.toInt()
  ..isAccessControl = json['isAccessControl'] as bool? ?? false
  ..accessControl =
      AccessControl.fromJson(json['accessControl'] as Map<String, dynamic>)
  ..dav = json['dav'] == null
      ? null
      : DAV.fromJson(json['dav'] as Map<String, dynamic>)
  ..prueBlack = json['prueBlack'] as bool? ?? false
  ..windowProps =
      WindowProps.fromJson(json['windowProps'] as Map<String, dynamic>?)
  ..vpnProps = VpnProps.fromJson(json['vpnProps'] as Map<String, dynamic>?)
  ..desktopProps =
      DesktopProps.fromJson(json['desktopProps'] as Map<String, dynamic>?)
  ..overrideDns = json['overrideDns'] as bool? ?? false
  ..hotKeyActions = (json['hotKeyActions'] as List<dynamic>?)
          ?.map((e) => HotKeyAction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..proxiesStyle =
      ProxiesStyle.fromJson(json['proxiesStyle'] as Map<String, dynamic>?);

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'appSetting': instance.appSetting,
      'profiles': instance.profiles,
      'currentProfileId': instance.currentProfileId,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'primaryColor': instance.primaryColor,
      'isAccessControl': instance.isAccessControl,
      'accessControl': instance.accessControl,
      'dav': instance.dav,
      'prueBlack': instance.prueBlack,
      'windowProps': instance.windowProps,
      'vpnProps': instance.vpnProps,
      'desktopProps': instance.desktopProps,
      'overrideDns': instance.overrideDns,
      'hotKeyActions': instance.hotKeyActions,
      'proxiesStyle': instance.proxiesStyle,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

_$AppSettingImpl _$$AppSettingImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingImpl(
      locale: json['locale'] as String?,
      onlyProxy: json['onlyProxy'] as bool? ?? false,
      autoLaunch: json['autoLaunch'] as bool? ?? false,
      adminAutoLaunch: json['adminAutoLaunch'] as bool? ?? false,
      silentLaunch: json['silentLaunch'] as bool? ?? false,
      autoRun: json['autoRun'] as bool? ?? false,
      openLogs: json['openLogs'] as bool? ?? false,
      closeConnections: json['closeConnections'] as bool? ?? true,
      testUrl: json['testUrl'] as String? ?? defaultTestUrl,
      isAnimateToPage: json['isAnimateToPage'] as bool? ?? true,
      autoCheckUpdate: json['autoCheckUpdate'] as bool? ?? true,
      showLabel: json['showLabel'] as bool? ?? false,
      disclaimerAccepted: json['disclaimerAccepted'] as bool? ?? false,
      minimizeOnExit: json['minimizeOnExit'] as bool? ?? true,
      hidden: json['hidden'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppSettingImplToJson(_$AppSettingImpl instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'onlyProxy': instance.onlyProxy,
      'autoLaunch': instance.autoLaunch,
      'adminAutoLaunch': instance.adminAutoLaunch,
      'silentLaunch': instance.silentLaunch,
      'autoRun': instance.autoRun,
      'openLogs': instance.openLogs,
      'closeConnections': instance.closeConnections,
      'testUrl': instance.testUrl,
      'isAnimateToPage': instance.isAnimateToPage,
      'autoCheckUpdate': instance.autoCheckUpdate,
      'showLabel': instance.showLabel,
      'disclaimerAccepted': instance.disclaimerAccepted,
      'minimizeOnExit': instance.minimizeOnExit,
      'hidden': instance.hidden,
    };

_$AccessControlImpl _$$AccessControlImplFromJson(Map<String, dynamic> json) =>
    _$AccessControlImpl(
      mode: $enumDecodeNullable(_$AccessControlModeEnumMap, json['mode']) ??
          AccessControlMode.rejectSelected,
      acceptList: (json['acceptList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rejectList: (json['rejectList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sort: $enumDecodeNullable(_$AccessSortTypeEnumMap, json['sort']) ??
          AccessSortType.none,
      isFilterSystemApp: json['isFilterSystemApp'] as bool? ?? true,
    );

Map<String, dynamic> _$$AccessControlImplToJson(_$AccessControlImpl instance) =>
    <String, dynamic>{
      'mode': _$AccessControlModeEnumMap[instance.mode]!,
      'acceptList': instance.acceptList,
      'rejectList': instance.rejectList,
      'sort': _$AccessSortTypeEnumMap[instance.sort]!,
      'isFilterSystemApp': instance.isFilterSystemApp,
    };

const _$AccessControlModeEnumMap = {
  AccessControlMode.acceptSelected: 'acceptSelected',
  AccessControlMode.rejectSelected: 'rejectSelected',
};

const _$AccessSortTypeEnumMap = {
  AccessSortType.none: 'none',
  AccessSortType.name: 'name',
  AccessSortType.time: 'time',
};

_$WindowPropsImpl _$$WindowPropsImplFromJson(Map<String, dynamic> json) =>
    _$WindowPropsImpl(
      width: (json['width'] as num?)?.toDouble() ?? 1000,
      height: (json['height'] as num?)?.toDouble() ?? 600,
      top: (json['top'] as num?)?.toDouble(),
      left: (json['left'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WindowPropsImplToJson(_$WindowPropsImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'top': instance.top,
      'left': instance.left,
    };

_$VpnPropsImpl _$$VpnPropsImplFromJson(Map<String, dynamic> json) =>
    _$VpnPropsImpl(
      systemProxy: json['systemProxy'] as bool? ?? true,
      ipv6: json['ipv6'] as bool? ?? false,
      allowBypass: json['allowBypass'] as bool? ?? true,
    );

Map<String, dynamic> _$$VpnPropsImplToJson(_$VpnPropsImpl instance) =>
    <String, dynamic>{
      'systemProxy': instance.systemProxy,
      'ipv6': instance.ipv6,
      'allowBypass': instance.allowBypass,
    };

_$DesktopPropsImpl _$$DesktopPropsImplFromJson(Map<String, dynamic> json) =>
    _$DesktopPropsImpl(
      systemProxy: json['systemProxy'] as bool? ?? true,
    );

Map<String, dynamic> _$$DesktopPropsImplToJson(_$DesktopPropsImpl instance) =>
    <String, dynamic>{
      'systemProxy': instance.systemProxy,
    };

_$ProxiesStyleImpl _$$ProxiesStyleImplFromJson(Map<String, dynamic> json) =>
    _$ProxiesStyleImpl(
      type: $enumDecodeNullable(_$ProxiesTypeEnumMap, json['type']) ??
          ProxiesType.tab,
      sortType:
          $enumDecodeNullable(_$ProxiesSortTypeEnumMap, json['sortType']) ??
              ProxiesSortType.none,
      layout: $enumDecodeNullable(_$ProxiesLayoutEnumMap, json['layout']) ??
          ProxiesLayout.standard,
      iconStyle:
          $enumDecodeNullable(_$ProxiesIconStyleEnumMap, json['iconStyle']) ??
              ProxiesIconStyle.standard,
      cardType: $enumDecodeNullable(_$ProxyCardTypeEnumMap, json['cardType']) ??
          ProxyCardType.expand,
    );

Map<String, dynamic> _$$ProxiesStyleImplToJson(_$ProxiesStyleImpl instance) =>
    <String, dynamic>{
      'type': _$ProxiesTypeEnumMap[instance.type]!,
      'sortType': _$ProxiesSortTypeEnumMap[instance.sortType]!,
      'layout': _$ProxiesLayoutEnumMap[instance.layout]!,
      'iconStyle': _$ProxiesIconStyleEnumMap[instance.iconStyle]!,
      'cardType': _$ProxyCardTypeEnumMap[instance.cardType]!,
    };

const _$ProxiesTypeEnumMap = {
  ProxiesType.tab: 'tab',
  ProxiesType.list: 'list',
};

const _$ProxiesSortTypeEnumMap = {
  ProxiesSortType.none: 'none',
  ProxiesSortType.delay: 'delay',
  ProxiesSortType.name: 'name',
};

const _$ProxiesLayoutEnumMap = {
  ProxiesLayout.loose: 'loose',
  ProxiesLayout.standard: 'standard',
  ProxiesLayout.tight: 'tight',
};

const _$ProxiesIconStyleEnumMap = {
  ProxiesIconStyle.standard: 'standard',
  ProxiesIconStyle.none: 'none',
  ProxiesIconStyle.icon: 'icon',
};

const _$ProxyCardTypeEnumMap = {
  ProxyCardType.expand: 'expand',
  ProxyCardType.shrink: 'shrink',
  ProxyCardType.min: 'min',
};
