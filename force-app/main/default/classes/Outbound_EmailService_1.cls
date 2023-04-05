public class Outbound_EmailService_1 {

    public static void invoke() {
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        
        String[] bcc = new String[]{'tarun.s@metadologie.com'};
        String[] toadd = new String[]{'javasfdc@gmail.com', 'tarunsharma06120@gmail.com'};
        String[] cc = new String[]{'tarun.s@metadologie.com'};
        msg.setToAddresses(toadd);
        msg.setBccAddresses(bcc);
        msg.setCcAddresses(cc);
        msg.setSubject('Outbound email service TEst 1');
        msg.setSenderDisplayName('TArun Sharma send this outbound mail');
        msg.setInReplyTo('rahul@metadologie.com');
        msg.setPlainTextBody('hello this is the body of outbound email test ');
        
        //now we will set all the message to cc bcc
        Messaging.Email[] emails = new Messaging.Email[]{msg};
        Messaging.sendEmail(emails);
        
    }
}