public class JSONExample7 {
    public String jsonString{set;get;}
    public JSONExample7() {
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
        jp.writeFieldName('Name');
        jp.writeString('Tarun Sharma');
        jp.writeFieldName('Age');
        jp.writeNumber(20);
        jp.writeDateField('DOB', System.today());
        jp.writeEndObject();
        jsonString = jp.getAsString();
    }

}