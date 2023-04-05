public class Inbound_EmailMessagingWithAttachments implements Messaging.InboundEmailHandler{
    
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
     
        try{
            
            Messaging.InboundEmail.binaryAttachment[]  files = email.binaryAttachments;
            
            Case c1 = new Case();
			c1.Subject = email.subject;
			c1.Priority = 'Normal';
			c1.Description = email.plainTextBody;      
            c1.Status = 'New';
            c1.Origin = 'Email';
            insert c1;
            
           	List<Attachment> attachments = new List<Attachment>();
            for(Messaging.InboundEmail.binaryAttachment b:files) {
                Attachment a = new Attachment();
                a.ParentId = c1.Id;
                a.Body = b.body;
                a.Name = b.fileName;
                attachments.add(a);
            }
            insert attachments;
            result.success = true;
            Integer i =1;
            for(Attachment attachment :attachments) {
                System.debug('Attachment '+i+'  is '+attachment);
                i++;
            }
        }
        catch(Exception e) {
            System.debug('error occurred '+e.getMessage());
            result.success = false;
        }
        return result;
    }
}