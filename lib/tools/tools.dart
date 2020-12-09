String getRegion(String timeZone) {
  switch (timeZone) {
    case 'Europe/Kiev':
      return 'Kiev';
    default:
      return 'Unknown region';
  }
}

String addSign(double value, [String sign = '']) {
  assert(sign != null);

  if (value == null) {
    return '';
  }

  return '${value?.toString()}$sign';
}
