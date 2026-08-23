class AmortizationScheduleItem {
  final int paymentNumber;
  final DateTime paymentDate;
  final double monthlyPayment;
  final double principalComponent;
  final double interestComponent;
  final double remainingBalance;
  final bool isPaid;

  const AmortizationScheduleItem({
    required this.paymentNumber,
    required this.paymentDate,
    required this.monthlyPayment,
    required this.principalComponent,
    required this.interestComponent,
    required this.remainingBalance,
    this.isPaid = false,
  });
}
