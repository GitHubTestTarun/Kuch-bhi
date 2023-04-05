public class inboundEmailAttacchmentRecord implements Messaging.InboundEmailHandler{

    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
     
        try{
            Messaging.InboundEmail.binaryAttachment[]  files = email.binaryAttachments;
            
           /* Case c1 = new Case();
			c1.Subject = email.subject;
			c1.Priority = 'Normal';
			c1.Description = email.plainTextBody;      
            c1.Status = 'New';
            c1.Origin = 'Email';
            insert c1;*/
            List<String> fieldName = new List<String>();
           	List<Attachment> attachments = new List<Attachment>();
            for(Messaging.InboundEmail.binaryAttachment b:files) {
                Attachment a = new Attachment();
                //a.ParentId = c1.Id;
                a.Body = b.body;
                a.Name = b.fileName;
                String p = EncodingUtil.base64Encode(b.body);
                System.debug(p);
                String data = EncodingUtil.base64Decode(p).toString();
                System.debug(data);
                separator(data);
                attachments.add(a);
            }
           // insert attachments;
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

    public static void separator(String data) {
        
        string nameFile;
        Blob contentFile;
        String[] filelines = new String[]{};
        List<Case> casesToupload;
        filelines = data.split('\n');
        System.debug('after split filelines is '+filelines);

        for(integer i = 0; i<filelines.size(); i++) {
            System.debug('filelines ['+i+'] = '+filelines[i]);
        }
        List<String> objectNames = new List<String>();

        for(String objName : filelines[0].split(',')) {
            if(String.isBlank(objName) || String.isEmpty(objName)) {
            }
            else {
                System.debug('objName'+objName);
                objectNames.add(objName);
            }
            
        }
        System.debug('objectNames   '+objectNames);

        for(String fieldName : objectNames[0].split(',')) {
            System.debug(fieldName);
        }

        List<String> fieldNames = new List<String>();

        for(String fieldName : filelines[1].split(',')) {
            if(String.isBlank(fieldName) || String.isEmpty(fieldName)) {
            }
            else {
                System.debug('fieldName'+fieldName);
                fieldNames.add(fieldName);
            }
        }

        List<String> fieldsData = new List<String>();
        

        for(integer i = 2; i<filelines.size(); i++) {
            List<String> data1 = new List<String>();
            
            filelines[i] = filelines[i].replace(',', ' ');
            System.debug(filelines[i]);
            for(String q1 : filelines[i].split(' ')) {
                data1.add(q1);
            }
            System.debug('data1  '+data1);
            for(String g : data1) {
                System.debug('g  '+g);
            }
            for(Integer p = 0; p <objectNames.size() ; p++) {
                objectNames[p] = objectNames[p].remove(' ');
                objectNames[p] = objectNames[p].replace(',', ' ');
                for(String lp : objectNames[p].split(' ')) {
                    System.debug('lp'+lp);
                    if(lp == 'Case') {
                        Integer r = 0;
                    
                        Case c1 = new Case();
                        c1.Comments = data1[r];
                        r +=1;
                        c1.Subject = data1[r];
                        r += 1;
                        c1.Description = data1[r];
                        insert c1;
                        System.debug('Case created is '+c1);
                    }
                    
                }
            }
        }

        System.debug(filelines[1].split(','));

        objectNames = filelines[0].split(',');
        System.debug(filelines[0].remove(','));
        System.debug('After split objectNames '+objectNames);
    

        /*for(Integer i=1;i<filelines.size();i++)
        {
            String[] inputvalues = new String[]{};
            inputvalues = filelines[i].split(',');
        
            lead a = new lead();
            a.lastName = inputvalues[0];
            a.company = inputvalues[1];       
            a.street = inputvalues[2];       
            a.City = inputvalues[3];
            a.State = inputvalues[4];
            a.PostalCode = inputvalues[5];
            a.Country = inputvalues[6];

            accstoupload.add(a);
        }
        try{
            insert accstoupload;
        }
        catch (Exception e)
        {
            System.debug(e.getMessage());
        }*/
    }
}