
class  Chat {
  

  String messageId;
  String sender;
  String message;
  String sendAt;
  bool seen;
  String seenAt;
  Attachment attachment;
 // Patient patientid;
 

 Chat({this.messageId,this.sender,this.message,this.sendAt,this.seen,this.seenAt,this.attachment});
  
}


class Attachment {
  String attachmentId;
  String attachmentType;
  String attachment;
  String attachmentDescription;
 // String messageId;
  Attachment({
    this.attachmentId,this.attachmentType,this.attachment,this.attachmentDescription});
  }