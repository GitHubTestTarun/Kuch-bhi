public class JSONExample8 {
    public String accName{set;get;}
    public String phone{set;get;}
   
    public void create() {
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
        jp.writeFieldName('Status');
        try{
            Account a = new Account();
            a.Name = accName;
            a.Phone = phone;
            insert a;
            jp.writeString('Success');
            jp.writeIdField('Id', a.Id);
        }
        catch(Exception e) {
            
        }
        jp.writeEndObject();
    }
        
}