abstract class Failure {
  final String message;
  Failure(this.message);
}

class InAppPurchaseFaliure extends Failure {
  InAppPurchaseFaliure(super.message);
}
