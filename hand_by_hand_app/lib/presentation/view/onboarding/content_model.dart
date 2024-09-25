class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
    image: "images/wellcome.svg",
    title: "ยินดีต้อนรับ",
    description:
        "ยินดีต้อนรับสู่ Hand by Hand!\nแอปพลิเคชันที่ช่วยให้คุณสามารถแลกเปลี่ยนสิ่งของ\nที่ยังใช้งานได้กับผู้คนในชุมชนของคุณ มาร่วมกัน\nสร้างสังคมแห่งการแบ่งปันไปด้วยกัน!",
  ),
  UnboardingContent(
    image: "images/find_item.svg",
    title: "ค้นหาสิ่งของ",
    description:
        "ค้นหาสิ่งของที่คุณต้องการแลกเปลี่ยนได้ง่ายๆ\nเพียงแค่เลือกหมวดหมู่ที่คุณสนใจ\nหรือใช้ฟังก์ชันการค้นหาของเรา\nเพื่อหาสิ่งที่ต้องการอย่างรวดเร็วและสะดวก",
  ),
  UnboardingContent(
    image: "images/exchange.svg",
    title: "แลกเปลี่ยน",
    description:
        "เมื่อคุณเจอสิ่งของที่ต้องการแล้ว\nสามารถติดต่อเจ้าของเพื่อเสนอการแลกเปลี่ยน\n มาร่วมกันเชื่อมต่อและสร้างมิตรภาพใหม่ๆ\nพร้อมกับได้สิ่งที่คุณต้องการโดยไม่ต้องเสียเงิน!",
  ),
];
