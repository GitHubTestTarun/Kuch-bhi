public class AnimalFarm {

    public static HttpResponse animals() {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"great white shark"}');
        
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 201) {
            System.debug(response.getBody());
        }
        else {
            
            System.debug('Error. Status : '+response.getStatusCode());
        }
        return response;
    }
    
}