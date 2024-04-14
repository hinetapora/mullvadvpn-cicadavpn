export enum RoutePath {
  launch = '/',
  login = '/login',
  tooManyDevices = '/login/too-many-devices',
  deviceRevoked = '/login/device-revoked',
  main = '/main',
  redeemVoucher = '/main/voucher/redeem',
  voucherSuccess = '/main/voucher/success/:newExpiry/:secondsAdded',
  expired = '/main/expired',
  timeAdded = '/main/time-added',
  setupFinished = '/main/setup-finished',
  settings = '/settings',
  selectLanguage = '/settings/language',
  account = '/account',
  userInterfaceSettings = '/settings/interface',
  vpnSettings = '/settings/vpn',
  wireguardSettings = '/settings/advanced/wireguard',
  openVpnSettings = '/settings/advanced/openvpn',
  splitTunneling = '/settings/split-tunneling',
  support = '/settings/support',
  problemReport = '/settings/support/problem-report',
  debug = '/settings/debug',
  selectLocation = '/select-location',
  filter = '/select-location/filter',
}