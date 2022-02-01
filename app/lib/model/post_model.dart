class Post {
  int? id;
  String? title;
  String? code;
  String? content;
  String? date;
  Category? category;
  bool? like;
  int? totallike;
  List<Comment>? comment;

  Post(
      {this.id,
      this.title,
      this.code,
      this.content,
      this.date,
      this.category,
      this.like,
      this.totallike,
      this.comment});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    content = json['content'];
    date = json['date'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    like = json['like'];
    totallike = json['totallike'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['content'] = content;
    data['date'] = date;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['like'] = like;
    data['totallike'] = totallike;
    if (comment != null) {
      data['comment'] = comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class Comment {
  int? id;
  String? title;
  String? time;
  User? user;
  int? post;
  List<Reply>? reply;

  Comment({this.id, this.title, this.time, this.user, this.post, this.reply});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    post = json['post'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['post'] = post;
    if (reply != null) {
      data['reply'] = reply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;

  User({this.id, this.username, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}

class Reply {
  int? id;
  String? title;
  String? time;
  User? user;
  int? comment;

  Reply({this.id, this.title, this.time, this.user, this.comment});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['comment'] = comment;
    return data;
  }
}
