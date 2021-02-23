class WorkOrderModel {
  String id;
  String title;
  String description;
  String status;
  String image;
  String requesterId;
  String workerId;
  String start;
  String end;
  String estimate;
  String warranty;
  String paymentMethod;
  String workerConfidence;
  String cost;

  WorkOrderModel(
      this.id,
      this.title,
      this.description,
      this.status,
      this.image,
      this.requesterId,
      this.workerId,
      this.start,
      this.end,
      this.estimate,
      this.warranty,
      this.paymentMethod,
      this.workerConfidence,
      this.cost);
}

List<WorkOrderModel> workOrders = workOrdersData
    .map((item) => WorkOrderModel(
          item['id'],
          item['title'],
          item['description'],
          item['status'],
          item['image'],
          item['requesterId'],
          item['workerId'],
          item['start'],
          item['end'],
          item['estimate'],
          item['warranty'],
          item['paymentMethod'],
          item['workerConfidence'],
          item['cost'],
        ))
    .toList();

var workOrdersData = [
  {
    "id": "712300-ZV",
    "title": "Restauración de Zapatos de vestir",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "Aguardando Colecta",
    "image": "assets/images/leather_shoes_small.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "En Progreso",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Alta",
    "cost": "7000",
  },
  {
    "id": "712300-ZV",
    "title": "Ajuste de camisas",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "En Progreso",
    "image": "assets/images/shirts_small.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "En Progreso",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Media",
    "cost": "4900",
  },
  {
    "id": "712300-ZV",
    "title": "Costuras Polera",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "En Progreso",
    "image": "assets/images/tshirt_small.jpg",
    "requesterId": "admin",
    "workerId": "María Moñitos - Costurera",
    "start": "07/02/2020",
    "end": "En Progreso",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Alta",
    "cost": "2100",
  },
  {
    "id": "712300-ZV",
    "title": "Reparación radio",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "Recibido",
    "image": "assets/images/radio_small.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "21/02/2020",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Baja",
    "cost": "14000",
  },
  {
    "id": "712300-ZV",
    "title": "Reparar pantalla celular",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "Recibido",
    "image": "assets/images/login_bg_small_compressed.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "21/02/2020",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Baja",
    "cost": "20000",
  },
  {
    "id": "712300-ZV",
    "title": "Teñir ropas",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "Recibido",
    "image": "assets/images/silk_small.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "21/02/2020",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Media",
    "cost": "7000",
  },
  {
    "id": "712300-ZV",
    "title": "Reciclado variado",
    "description":
        "Sustituir suela y reducir detalles en la superficie. Finalizar con humectación del cuero y pulimiento",
    "status": "Recibido",
    "image": "assets/images/reels_small.jpg",
    "requesterId": "admin",
    "workerId": "José Alcántara -  Zapatero",
    "start": "07/02/2020",
    "end": "21/02/2020",
    "estimate": "7 días",
    "warranty": "3 meses",
    "paymentMethod": "Tarjeta de crédito",
    "workerConfidence": "Alta",
    "cost": "2800",
  },
];
