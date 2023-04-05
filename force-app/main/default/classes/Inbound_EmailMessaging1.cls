public class Inbound_EmailMessaging1 implements Messaging.InboundEmailHandler{
	
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
       
        try{
            System.debug('yes we received a mail ');
            System.debug('FromAddress >> '+email.fromAddress);
            System.debug('subject >> '+email.subject);
            System.debug('body >> '+email.plainTextBody);
            String fromAddress = email.fromAddress;
            String subject = email.subject;
            String body = email.plainTextBody;
            Contact contact =  new Contact(LastName = 'Tarun', email = fromAddress);
           	contact.Amount__c = 2000;
            insert contact;
            Contact con = [SELECT ID FROM Contact WHERE LastName = 'Tarun'][0];
            
            Case c1 = new Case();
            c1.Subject = subject;
            c1.Priority = 'Normal';
            c1.Status = 'New';
            c1.Origin = 'Email';
            c1.Description = body;
            c1.ContactId = con.Id;
            insert c1;
            
            result.success = true;
        }
        catch(Exception e) {
            result.success = false;
            System.debug('error camed '+e.getMessage());
        }
        return result;
    }
}