class MessageModel {
  String userId;
  String workerId;
  String workerPicture;
  String workerCategories;
  String message;
  String timeSent;
  String amountUnread;

  MessageModel(this.userId, this.workerId, this.workerPicture,
      this.workerCategories, this.message, this.timeSent, this.amountUnread);
}

List<MessageModel> messages = messagesData
    .map((item) => MessageModel(
          item['userId'],
          item['workerId'],
          item['workerPicture'],
          item['workerCategories'],
          item['message'],
          item['timeSent'],
          item['amountUnread'],
        ))
    .toList();

var messagesData = [
  {
    "userId": "Admin",
    "workerId": "Ana Medina - Taller de Costura",
    "workerPicture": "assets/images/person1.jpg",
    "workerCategories": "Arte & Manualidades, Costura",
    "message":
        "Nihil et vitae earum perspiciatis sed asperiores. Placeat dolor id labore minima doloribus quod aspernatur. Voluptas nulla consequuntur sed.",
    "timeSent": "49m",
    "amountUnread": "2",
  },
  {
    "userId": "Admin",
    "workerId": "José Alcántara -  Zapatero",
    "workerPicture": "assets/images/person2.jpg",
    "workerCategories": "Zapatería",
    "message": "Libero saepe odit alias",
    "timeSent": "1h",
    "amountUnread": "1",
  },
  {
    "userId": "Admin",
    "workerId": "Pedro Alcazar -  Mecánico",
    "workerPicture": "assets/images/person3.jpg",
    "workerCategories": "Mecánica, Construcción",
    "message":
        "Dignissimos autem maiores esse rerum maxime reiciendis. Sit laborum aliquam temporibus ut.",
    "timeSent": "6h",
    "amountUnread": "0",
  },
  {
    "userId": "Admin",
    "workerId": "Adrián Torres",
    "workerPicture": "assets/images/person4.jpg",
    "workerCategories": "Zapatería",
    "message": "Et et ab eum et",
    "timeSent": "1d",
    "amountUnread": "0",
  },
  {
    "userId": "Admin",
    "workerId": "Luisa Villarreal",
    "workerPicture": "assets/images/person1.jpg",
    "workerCategories": "Costura",
    "message":
        "Nihil placeat recusandae officia. Omnis ipsum consequatur consequatur quod nulla officia repudiandae.",
    "timeSent": "2d",
    "amountUnread": "0",
  },
  {
    "userId": "Admin",
    "workerId": "José Alcántara -  Zapatero",
    "workerPicture": "assets/images/person2.jpg",
    "workerCategories": "Mecánica, Construcción",
    "message": "Sint qui perspiciatis aliquam nesciunt eum ut ullam numquam",
    "timeSent": "6d",
    "amountUnread": "0",
  },
  {
    "userId": "Admin",
    "workerId": "Jesús Adrián Romero",
    "workerPicture": "assets/images/person3.jpg",
    "workerCategories": "Carpintería",
    "message": "Ut est eveniet quia",
    "timeSent": "6d",
    "amountUnread": "0",
  },
];
