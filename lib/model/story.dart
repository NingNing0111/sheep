
// 故事
class Story {
  Story(this.id,this.title,this.content,this.category,this.image,this.created);
  // id
  late int id;
  // 标题
  late String title;
  // 内容
  late String content;
  // 图片地址
  late String image;
  // 类别
  late String category;
  // 创建时间
  late DateTime created;

  @override
  String toString() {
    return 'Story{id: $id, title: $title, content: $content, image: $image, category: $category, created: $created}';
  }
}