class author
{
  String?name;
  dynamic?image;
  dynamic?url;
  String?popular_book_title;
  dynamic?popular_book_url;
  int?number_published_books;

  author({this.name, this.image, this.url, this.popular_book_title,
      this.popular_book_url, this.number_published_books});
  factory author.fromJson(Map<String, dynamic> json) {
    return author(
      name: json['name'],
      image: json['image'],
      url: json['url'],
      popular_book_title: json['popular_book_title'],
      popular_book_url: json['popular_book_url'],
      number_published_books: json['number_published_books'],
    );
  }
}