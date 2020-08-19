class Crypto {
  String name; // name of the currency (ex: Bitcoin)
  String diminutive; // diminutive of the currency (ex: BTC)
  double price; // price of the currency
  String change;
  double changeValue;
  String logoUrl;

  Crypto(
      {this.name,
      this.diminutive,
      this.price,
      this.change,
      this.changeValue,
      this.logoUrl});
}
