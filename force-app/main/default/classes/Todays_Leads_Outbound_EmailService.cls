public class Todays_Leads_Outbound_EmailService {
    public void invoke() {
        List<Lead> leads = [SELECT Id, email, FirstName, LastName, Phone FROM Lead WHERE createdDate = today];
        List<String> toadd = new List<String>();
        List<Messaging.Email> emails = new List<Messaging.Email>();
            
        for(Lead l : leads) {
            if(l.Email != '') {
                System.debug('lead to which email is send is '+l);
                toadd.add(l.email);
                
                Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                msg.setToAddresses(toadd);
                msg.setSubject('Lead Acknowledgement');
                String body = 'Dear  Customer , <br/> ';
                body += 'We have rececived your enquiry with following details <br/> ';
                body += '<b> First Name : </b>'+'<i>'+l.FirstName+'</i>';
                body += '<b> Last Name :</b>'+'<i>'+l.LastName+'</i>';
                body += '<b> Phone : </b>'+'<i>'+l.Phone+'</i>';
                body += '<br/>Thanks <br/>  Sales Team';
                msg.setHtmlBody(body);
                emails.add(msg);
            }
            else {
                System.debug('no lead found');
            }
        }
         Messaging.sendEmail(emails);
    }
}