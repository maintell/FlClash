// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "accessControl": MessageLookupByLibrary.simpleMessage("访问控制"),
        "accessControlAllowDesc":
            MessageLookupByLibrary.simpleMessage("只允许选中应用进入VPN"),
        "accessControlDesc": MessageLookupByLibrary.simpleMessage("配置应用访问代理"),
        "accessControlNotAllowDesc":
            MessageLookupByLibrary.simpleMessage("选中应用将会被排除在VPN之外"),
        "account": MessageLookupByLibrary.simpleMessage("账号"),
        "accountTip": MessageLookupByLibrary.simpleMessage("账号不能为空"),
        "action": MessageLookupByLibrary.simpleMessage("操作"),
        "action_mode": MessageLookupByLibrary.simpleMessage("切换模式"),
        "action_proxy": MessageLookupByLibrary.simpleMessage("系统代理"),
        "action_start": MessageLookupByLibrary.simpleMessage("启动/停止"),
        "action_tun": MessageLookupByLibrary.simpleMessage("虚拟网卡"),
        "action_view": MessageLookupByLibrary.simpleMessage("显示/隐藏"),
        "add": MessageLookupByLibrary.simpleMessage("添加"),
        "address": MessageLookupByLibrary.simpleMessage("地址"),
        "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAV服务器地址"),
        "addressTip": MessageLookupByLibrary.simpleMessage("请输入有效的WebDAV地址"),
        "adminAutoLaunch": MessageLookupByLibrary.simpleMessage("管理员自启动"),
        "adminAutoLaunchDesc":
            MessageLookupByLibrary.simpleMessage("使用管理员模式开机自启动"),
        "ago": MessageLookupByLibrary.simpleMessage("前"),
        "agree": MessageLookupByLibrary.simpleMessage("同意"),
        "allApps": MessageLookupByLibrary.simpleMessage("所有应用"),
        "allowBypass": MessageLookupByLibrary.simpleMessage("允许应用绕过VPN"),
        "allowBypassDesc":
            MessageLookupByLibrary.simpleMessage("开启后部分应用可绕过VPN"),
        "allowLan": MessageLookupByLibrary.simpleMessage("局域网代理"),
        "allowLanDesc": MessageLookupByLibrary.simpleMessage("允许通过局域网访问代理"),
        "app": MessageLookupByLibrary.simpleMessage("应用"),
        "appAccessControl": MessageLookupByLibrary.simpleMessage("应用访问控制"),
        "appDesc": MessageLookupByLibrary.simpleMessage("处理应用相关设置"),
        "application": MessageLookupByLibrary.simpleMessage("应用程序"),
        "applicationDesc": MessageLookupByLibrary.simpleMessage("修改应用程序相关设置"),
        "auto": MessageLookupByLibrary.simpleMessage("自动"),
        "autoCheckUpdate": MessageLookupByLibrary.simpleMessage("自动检查更新"),
        "autoCheckUpdateDesc":
            MessageLookupByLibrary.simpleMessage("应用启动时自动检查更新"),
        "autoCloseConnections": MessageLookupByLibrary.simpleMessage("自动关闭连接"),
        "autoCloseConnectionsDesc":
            MessageLookupByLibrary.simpleMessage("切换节点后自动关闭连接"),
        "autoLaunch": MessageLookupByLibrary.simpleMessage("自启动"),
        "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("跟随系统自启动"),
        "autoRun": MessageLookupByLibrary.simpleMessage("自动运行"),
        "autoRunDesc": MessageLookupByLibrary.simpleMessage("应用打开时自动运行"),
        "autoUpdate": MessageLookupByLibrary.simpleMessage("自动更新"),
        "autoUpdateInterval":
            MessageLookupByLibrary.simpleMessage("自动更新间隔（分钟）"),
        "backup": MessageLookupByLibrary.simpleMessage("备份"),
        "backupAndRecovery": MessageLookupByLibrary.simpleMessage("备份与恢复"),
        "backupAndRecoveryDesc":
            MessageLookupByLibrary.simpleMessage("通过WebDAV或者文件同步数据"),
        "backupSuccess": MessageLookupByLibrary.simpleMessage("备份成功"),
        "bind": MessageLookupByLibrary.simpleMessage("绑定"),
        "blacklistMode": MessageLookupByLibrary.simpleMessage("黑名单模式"),
        "bypassDomain": MessageLookupByLibrary.simpleMessage("排除域名"),
        "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("仅在系统代理启用时生效"),
        "cancelFilterSystemApp":
            MessageLookupByLibrary.simpleMessage("取消过滤系统应用"),
        "cancelSelectAll": MessageLookupByLibrary.simpleMessage("取消全选"),
        "checkError": MessageLookupByLibrary.simpleMessage("检测失败"),
        "checkUpdate": MessageLookupByLibrary.simpleMessage("检查更新"),
        "checkUpdateError": MessageLookupByLibrary.simpleMessage("当前应用已经是最新版了"),
        "checking": MessageLookupByLibrary.simpleMessage("检测中..."),
        "clipboardExport": MessageLookupByLibrary.simpleMessage("导出剪贴板"),
        "clipboardImport": MessageLookupByLibrary.simpleMessage("剪贴板导入"),
        "columns": MessageLookupByLibrary.simpleMessage("列数"),
        "compatible": MessageLookupByLibrary.simpleMessage("兼容模式"),
        "compatibleDesc":
            MessageLookupByLibrary.simpleMessage("开启将失去部分应用能力，获得全量的Clash的支持"),
        "confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "connections": MessageLookupByLibrary.simpleMessage("连接"),
        "connectionsDesc": MessageLookupByLibrary.simpleMessage("查看当前连接数据"),
        "connectivity": MessageLookupByLibrary.simpleMessage("连通性："),
        "copy": MessageLookupByLibrary.simpleMessage("复制"),
        "core": MessageLookupByLibrary.simpleMessage("内核"),
        "coreInfo": MessageLookupByLibrary.simpleMessage("内核信息"),
        "country": MessageLookupByLibrary.simpleMessage("区域"),
        "create": MessageLookupByLibrary.simpleMessage("创建"),
        "cut": MessageLookupByLibrary.simpleMessage("剪切"),
        "dark": MessageLookupByLibrary.simpleMessage("深色"),
        "dashboard": MessageLookupByLibrary.simpleMessage("仪表盘"),
        "days": MessageLookupByLibrary.simpleMessage("天"),
        "defaultNameserver": MessageLookupByLibrary.simpleMessage("默认域名服务器"),
        "defaultNameserverDesc":
            MessageLookupByLibrary.simpleMessage("用于解析DNS服务器"),
        "defaultSort": MessageLookupByLibrary.simpleMessage("按默认排序"),
        "defaultText": MessageLookupByLibrary.simpleMessage("默认"),
        "delay": MessageLookupByLibrary.simpleMessage("延迟"),
        "delaySort": MessageLookupByLibrary.simpleMessage("按延迟排序"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteProfileTip": MessageLookupByLibrary.simpleMessage("确定要删除当前配置吗?"),
        "desc": MessageLookupByLibrary.simpleMessage(
            "基于ClashMeta的多平台代理客户端，简单易用，开源无广告。"),
        "direct": MessageLookupByLibrary.simpleMessage("直连"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("免责声明"),
        "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
            "本软件仅供学习交流、科研等非商业性质的用途，严禁将本软件用于商业目的。如有任何商业行为，均与本软件无关。"),
        "discoverNewVersion": MessageLookupByLibrary.simpleMessage("发现新版本"),
        "discovery": MessageLookupByLibrary.simpleMessage("发现新版本"),
        "dnsDesc": MessageLookupByLibrary.simpleMessage("更新DNS相关设置"),
        "dnsMode": MessageLookupByLibrary.simpleMessage("DNS模式"),
        "doYouWantToPass": MessageLookupByLibrary.simpleMessage("是否要通过"),
        "domain": MessageLookupByLibrary.simpleMessage("域名"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "en": MessageLookupByLibrary.simpleMessage("英语"),
        "entries": MessageLookupByLibrary.simpleMessage("个条目"),
        "exclude": MessageLookupByLibrary.simpleMessage("从最近任务中隐藏"),
        "excludeDesc":
            MessageLookupByLibrary.simpleMessage("应用在后台时,从最近任务中隐藏应用"),
        "exit": MessageLookupByLibrary.simpleMessage("退出"),
        "expand": MessageLookupByLibrary.simpleMessage("标准"),
        "expirationTime": MessageLookupByLibrary.simpleMessage("到期时间"),
        "exportLogs": MessageLookupByLibrary.simpleMessage("导出日志"),
        "exportSuccess": MessageLookupByLibrary.simpleMessage("导出成功"),
        "externalController": MessageLookupByLibrary.simpleMessage("外部控制器"),
        "externalControllerDesc":
            MessageLookupByLibrary.simpleMessage("开启后将可以通过9090端口控制Clash内核"),
        "externalLink": MessageLookupByLibrary.simpleMessage("外部链接"),
        "externalResources": MessageLookupByLibrary.simpleMessage("外部资源"),
        "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeip过滤"),
        "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip范围"),
        "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
        "fallbackDesc": MessageLookupByLibrary.simpleMessage("一般情况下使用境外DNS"),
        "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback过滤"),
        "file": MessageLookupByLibrary.simpleMessage("文件"),
        "fileDesc": MessageLookupByLibrary.simpleMessage("直接上传配置文件"),
        "filterSystemApp": MessageLookupByLibrary.simpleMessage("过滤系统应用"),
        "findProcessMode": MessageLookupByLibrary.simpleMessage("查找进程"),
        "findProcessModeDesc":
            MessageLookupByLibrary.simpleMessage("开启后存在闪退风险"),
        "fontFamily": MessageLookupByLibrary.simpleMessage("字体"),
        "fourColumns": MessageLookupByLibrary.simpleMessage("四列"),
        "general": MessageLookupByLibrary.simpleMessage("基础"),
        "generalDesc": MessageLookupByLibrary.simpleMessage("覆写基础设置"),
        "geoData": MessageLookupByLibrary.simpleMessage("地理数据"),
        "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo低内存模式"),
        "geodataLoaderDesc":
            MessageLookupByLibrary.simpleMessage("开启将使用Geo低内存加载器"),
        "geoipCode": MessageLookupByLibrary.simpleMessage("Geoip代码"),
        "global": MessageLookupByLibrary.simpleMessage("全局"),
        "go": MessageLookupByLibrary.simpleMessage("前往"),
        "goDownload": MessageLookupByLibrary.simpleMessage("前往下载"),
        "hostsDesc": MessageLookupByLibrary.simpleMessage("追加Hosts"),
        "hotkeyConflict": MessageLookupByLibrary.simpleMessage("快捷键冲突"),
        "hotkeyManagement": MessageLookupByLibrary.simpleMessage("快捷键管理"),
        "hotkeyManagementDesc":
            MessageLookupByLibrary.simpleMessage("使用键盘控制应用程序"),
        "hours": MessageLookupByLibrary.simpleMessage("小时"),
        "icon": MessageLookupByLibrary.simpleMessage("图片"),
        "iconConfiguration": MessageLookupByLibrary.simpleMessage("图片配置"),
        "iconStyle": MessageLookupByLibrary.simpleMessage("图标样式"),
        "importFromURL": MessageLookupByLibrary.simpleMessage("从URL导入"),
        "infiniteTime": MessageLookupByLibrary.simpleMessage("长期有效"),
        "init": MessageLookupByLibrary.simpleMessage("初始化"),
        "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("请输入正确的快捷键"),
        "intelligentSelected": MessageLookupByLibrary.simpleMessage("智能选择"),
        "intranetIP": MessageLookupByLibrary.simpleMessage("内网 IP"),
        "ipcidr": MessageLookupByLibrary.simpleMessage("IP/掩码"),
        "ipv6Desc": MessageLookupByLibrary.simpleMessage("开启后将可以接收IPv6流量"),
        "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("允许IPv6入站"),
        "just": MessageLookupByLibrary.simpleMessage("刚刚"),
        "keepAliveIntervalDesc":
            MessageLookupByLibrary.simpleMessage("TCP保持活动间隔"),
        "key": MessageLookupByLibrary.simpleMessage("键"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "layout": MessageLookupByLibrary.simpleMessage("布局"),
        "light": MessageLookupByLibrary.simpleMessage("浅色"),
        "list": MessageLookupByLibrary.simpleMessage("列表"),
        "local": MessageLookupByLibrary.simpleMessage("本地"),
        "localBackupDesc": MessageLookupByLibrary.simpleMessage("备份数据到本地"),
        "localRecoveryDesc": MessageLookupByLibrary.simpleMessage("通过文件恢复数据"),
        "logLevel": MessageLookupByLibrary.simpleMessage("日志等级"),
        "logcat": MessageLookupByLibrary.simpleMessage("日志捕获"),
        "logcatDesc": MessageLookupByLibrary.simpleMessage("禁用将会隐藏日志入口"),
        "logs": MessageLookupByLibrary.simpleMessage("日志"),
        "logsDesc": MessageLookupByLibrary.simpleMessage("日志捕获记录"),
        "loopback": MessageLookupByLibrary.simpleMessage("回环解锁工具"),
        "loopbackDesc": MessageLookupByLibrary.simpleMessage("用于UWP回环解锁"),
        "loose": MessageLookupByLibrary.simpleMessage("宽松"),
        "min": MessageLookupByLibrary.simpleMessage("最小"),
        "minimizeOnExit": MessageLookupByLibrary.simpleMessage("退出时最小化"),
        "minimizeOnExitDesc":
            MessageLookupByLibrary.simpleMessage("修改系统默认退出事件"),
        "minutes": MessageLookupByLibrary.simpleMessage("分钟"),
        "mode": MessageLookupByLibrary.simpleMessage("模式"),
        "months": MessageLookupByLibrary.simpleMessage("月"),
        "more": MessageLookupByLibrary.simpleMessage("更多"),
        "name": MessageLookupByLibrary.simpleMessage("名称"),
        "nameSort": MessageLookupByLibrary.simpleMessage("按名称排序"),
        "nameserver": MessageLookupByLibrary.simpleMessage("域名服务器"),
        "nameserverDesc": MessageLookupByLibrary.simpleMessage("用于解析域名"),
        "nameserverPolicy": MessageLookupByLibrary.simpleMessage("域名服务器策略"),
        "nameserverPolicyDesc":
            MessageLookupByLibrary.simpleMessage("指定对应域名服务器策略"),
        "network": MessageLookupByLibrary.simpleMessage("网络"),
        "networkDesc": MessageLookupByLibrary.simpleMessage("修改网络相关设置"),
        "networkDetection": MessageLookupByLibrary.simpleMessage("网络检测"),
        "networkSpeed": MessageLookupByLibrary.simpleMessage("网络速度"),
        "noData": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "noHotKey": MessageLookupByLibrary.simpleMessage("暂无快捷键"),
        "noIcon": MessageLookupByLibrary.simpleMessage("无图标"),
        "noInfo": MessageLookupByLibrary.simpleMessage("暂无信息"),
        "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("暂无更多信息"),
        "noNetwork": MessageLookupByLibrary.simpleMessage("无网络"),
        "noProxy": MessageLookupByLibrary.simpleMessage("暂无代理"),
        "noProxyDesc":
            MessageLookupByLibrary.simpleMessage("请创建配置文件或者添加有效配置文件"),
        "notEmpty": MessageLookupByLibrary.simpleMessage("不能为空"),
        "notSelectedTip": MessageLookupByLibrary.simpleMessage("当前代理组无法选中"),
        "nullConnectionsDesc": MessageLookupByLibrary.simpleMessage("暂无连接"),
        "nullCoreInfoDesc": MessageLookupByLibrary.simpleMessage("无法获取内核信息"),
        "nullLogsDesc": MessageLookupByLibrary.simpleMessage("暂无日志"),
        "nullProfileDesc":
            MessageLookupByLibrary.simpleMessage("没有配置文件,请先添加配置文件"),
        "nullRequestsDesc": MessageLookupByLibrary.simpleMessage("暂无请求"),
        "oneColumn": MessageLookupByLibrary.simpleMessage("一列"),
        "onlyIcon": MessageLookupByLibrary.simpleMessage("仅图标"),
        "onlyOtherApps": MessageLookupByLibrary.simpleMessage("仅第三方应用"),
        "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("仅统计代理"),
        "onlyStatisticsProxyDesc":
            MessageLookupByLibrary.simpleMessage("开启后，将只统计代理流量"),
        "options": MessageLookupByLibrary.simpleMessage("选项"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "otherContributors": MessageLookupByLibrary.simpleMessage("其他贡献者"),
        "outboundMode": MessageLookupByLibrary.simpleMessage("出站模式"),
        "override": MessageLookupByLibrary.simpleMessage("覆写"),
        "overrideDesc": MessageLookupByLibrary.simpleMessage("覆写代理相关配置"),
        "overrideDns": MessageLookupByLibrary.simpleMessage("覆写DNS"),
        "overrideDnsDesc":
            MessageLookupByLibrary.simpleMessage("开启后将覆盖配置中的DNS选项"),
        "password": MessageLookupByLibrary.simpleMessage("密码"),
        "passwordTip": MessageLookupByLibrary.simpleMessage("密码不能为空"),
        "paste": MessageLookupByLibrary.simpleMessage("粘贴"),
        "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage("请绑定WebDAV"),
        "pleaseUploadFile": MessageLookupByLibrary.simpleMessage("请上传文件"),
        "pleaseUploadValidQrcode":
            MessageLookupByLibrary.simpleMessage("请上传有效的二维码"),
        "port": MessageLookupByLibrary.simpleMessage("端口"),
        "preferH3Desc": MessageLookupByLibrary.simpleMessage("优先使用DOH的http/3"),
        "pressKeyboard": MessageLookupByLibrary.simpleMessage("请按下按键"),
        "preview": MessageLookupByLibrary.simpleMessage("预览"),
        "profile": MessageLookupByLibrary.simpleMessage("配置"),
        "profileAutoUpdateIntervalInvalidValidationDesc":
            MessageLookupByLibrary.simpleMessage("请输入有效间隔时间格式"),
        "profileAutoUpdateIntervalNullValidationDesc":
            MessageLookupByLibrary.simpleMessage("请输入自动更新间隔时间"),
        "profileNameNullValidationDesc":
            MessageLookupByLibrary.simpleMessage("请输入配置名称"),
        "profileParseErrorDesc":
            MessageLookupByLibrary.simpleMessage("配置文件解析错误"),
        "profileUrlInvalidValidationDesc":
            MessageLookupByLibrary.simpleMessage("请输入有效配置URL"),
        "profileUrlNullValidationDesc":
            MessageLookupByLibrary.simpleMessage("请输入配置URL"),
        "profiles": MessageLookupByLibrary.simpleMessage("配置"),
        "profilesSort": MessageLookupByLibrary.simpleMessage("配置排序"),
        "project": MessageLookupByLibrary.simpleMessage("项目"),
        "providers": MessageLookupByLibrary.simpleMessage("提供者"),
        "proxies": MessageLookupByLibrary.simpleMessage("代理"),
        "proxiesSetting": MessageLookupByLibrary.simpleMessage("代理设置"),
        "proxyGroup": MessageLookupByLibrary.simpleMessage("代理组"),
        "proxyNameserver": MessageLookupByLibrary.simpleMessage("代理域名服务器"),
        "proxyNameserverDesc":
            MessageLookupByLibrary.simpleMessage("用于解析代理节点的域名"),
        "proxyPort": MessageLookupByLibrary.simpleMessage("代理端口"),
        "proxyPortDesc": MessageLookupByLibrary.simpleMessage("设置Clash监听端口"),
        "proxyProviders": MessageLookupByLibrary.simpleMessage("代理提供者"),
        "prueBlackMode": MessageLookupByLibrary.simpleMessage("纯黑模式"),
        "qrcode": MessageLookupByLibrary.simpleMessage("二维码"),
        "qrcodeDesc": MessageLookupByLibrary.simpleMessage("扫描二维码获取配置文件"),
        "recovery": MessageLookupByLibrary.simpleMessage("恢复"),
        "recoveryAll": MessageLookupByLibrary.simpleMessage("恢复所有数据"),
        "recoveryProfiles": MessageLookupByLibrary.simpleMessage("仅恢复配置文件"),
        "recoverySuccess": MessageLookupByLibrary.simpleMessage("恢复成功"),
        "regExp": MessageLookupByLibrary.simpleMessage("正则"),
        "remote": MessageLookupByLibrary.simpleMessage("远程"),
        "remoteBackupDesc": MessageLookupByLibrary.simpleMessage("备份数据到WebDAV"),
        "remoteRecoveryDesc":
            MessageLookupByLibrary.simpleMessage("通过WebDAV恢复数据"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "requests": MessageLookupByLibrary.simpleMessage("请求"),
        "requestsDesc": MessageLookupByLibrary.simpleMessage("查看最近请求记录"),
        "reset": MessageLookupByLibrary.simpleMessage("重置"),
        "resetTip": MessageLookupByLibrary.simpleMessage("确定要重置吗?"),
        "resources": MessageLookupByLibrary.simpleMessage("资源"),
        "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部资源相关信息"),
        "respectRules": MessageLookupByLibrary.simpleMessage("遵守规则"),
        "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
            "DNS连接跟随rules,需配置proxy-server-nameserver"),
        "rule": MessageLookupByLibrary.simpleMessage("规则"),
        "ruleProviders": MessageLookupByLibrary.simpleMessage("规则提供者"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "seconds": MessageLookupByLibrary.simpleMessage("秒"),
        "selectAll": MessageLookupByLibrary.simpleMessage("全选"),
        "selected": MessageLookupByLibrary.simpleMessage("已选择"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "show": MessageLookupByLibrary.simpleMessage("显示"),
        "shrink": MessageLookupByLibrary.simpleMessage("紧凑"),
        "silentLaunch": MessageLookupByLibrary.simpleMessage("静默启动"),
        "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("后台启动"),
        "size": MessageLookupByLibrary.simpleMessage("尺寸"),
        "sort": MessageLookupByLibrary.simpleMessage("排序"),
        "source": MessageLookupByLibrary.simpleMessage("来源"),
        "stackMode": MessageLookupByLibrary.simpleMessage("栈模式"),
        "standard": MessageLookupByLibrary.simpleMessage("标准"),
        "start": MessageLookupByLibrary.simpleMessage("启动"),
        "startVpn": MessageLookupByLibrary.simpleMessage("正在启动VPN..."),
        "status": MessageLookupByLibrary.simpleMessage("状态"),
        "statusDesc": MessageLookupByLibrary.simpleMessage("关闭后将使用系统DNS"),
        "stop": MessageLookupByLibrary.simpleMessage("暂停"),
        "stopVpn": MessageLookupByLibrary.simpleMessage("正在停止VPN..."),
        "style": MessageLookupByLibrary.simpleMessage("风格"),
        "submit": MessageLookupByLibrary.simpleMessage("提交"),
        "sync": MessageLookupByLibrary.simpleMessage("同步"),
        "system": MessageLookupByLibrary.simpleMessage("系统"),
        "systemFont": MessageLookupByLibrary.simpleMessage("系统字体"),
        "systemProxy": MessageLookupByLibrary.simpleMessage("系统代理"),
        "systemProxyDesc": MessageLookupByLibrary.simpleMessage("设置系统代理"),
        "tab": MessageLookupByLibrary.simpleMessage("标签页"),
        "tabAnimation": MessageLookupByLibrary.simpleMessage("选项卡动画"),
        "tabAnimationDesc":
            MessageLookupByLibrary.simpleMessage("开启后，主页选项卡将添加切换动画"),
        "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP并发"),
        "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("开启后允许TCP并发"),
        "testUrl": MessageLookupByLibrary.simpleMessage("测速链接"),
        "theme": MessageLookupByLibrary.simpleMessage("主题"),
        "themeColor": MessageLookupByLibrary.simpleMessage("主题色彩"),
        "themeDesc": MessageLookupByLibrary.simpleMessage("设置深色模式，调整色彩"),
        "themeMode": MessageLookupByLibrary.simpleMessage("主题模式"),
        "threeColumns": MessageLookupByLibrary.simpleMessage("三列"),
        "tight": MessageLookupByLibrary.simpleMessage("紧凑"),
        "time": MessageLookupByLibrary.simpleMessage("时间"),
        "tip": MessageLookupByLibrary.simpleMessage("提示"),
        "toggle": MessageLookupByLibrary.simpleMessage("切换"),
        "tools": MessageLookupByLibrary.simpleMessage("工具"),
        "trafficUsage": MessageLookupByLibrary.simpleMessage("流量统计"),
        "tun": MessageLookupByLibrary.simpleMessage("虚拟网卡"),
        "tunDesc": MessageLookupByLibrary.simpleMessage("仅在管理员模式生效"),
        "twoColumns": MessageLookupByLibrary.simpleMessage("两列"),
        "unableToUpdateCurrentProfileDesc":
            MessageLookupByLibrary.simpleMessage("无法更新当前配置文件"),
        "unifiedDelay": MessageLookupByLibrary.simpleMessage("统一延迟"),
        "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage("去除握手等额外延迟"),
        "unknown": MessageLookupByLibrary.simpleMessage("未知"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "upload": MessageLookupByLibrary.simpleMessage("上传"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlDesc": MessageLookupByLibrary.simpleMessage("通过URL获取配置文件"),
        "useHosts": MessageLookupByLibrary.simpleMessage("使用Hosts"),
        "useSystemHosts": MessageLookupByLibrary.simpleMessage("使用系统Hosts"),
        "value": MessageLookupByLibrary.simpleMessage("值"),
        "view": MessageLookupByLibrary.simpleMessage("查看"),
        "vpnDesc": MessageLookupByLibrary.simpleMessage("修改VPN相关设置"),
        "vpnEnableDesc":
            MessageLookupByLibrary.simpleMessage("通过VpnService自动路由系统所有流量"),
        "vpnSystemProxyDesc":
            MessageLookupByLibrary.simpleMessage("为VpnService附加HTTP代理"),
        "vpnTip": MessageLookupByLibrary.simpleMessage("重启VPN后改变生效"),
        "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV配置"),
        "whitelistMode": MessageLookupByLibrary.simpleMessage("白名单模式"),
        "years": MessageLookupByLibrary.simpleMessage("年"),
        "zh_CN": MessageLookupByLibrary.simpleMessage("中文简体")
      };
}
