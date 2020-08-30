class Crypto {
  String name; // name of the currency (ex: Bitcoin)
  String diminutive; // diminutive of the currency (ex: BTC)
  String price; // price of the currency
  String change;
  String changeValue;
  String logoUrl;

  Crypto(
      {this.name,
      this.diminutive,
      this.price,
      this.change,
      this.changeValue,
      this.logoUrl});
}
