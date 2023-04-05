public with sharing class GraphQLQueryGenerator {
    public static void createRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://apiv2-staging.construyo.de/graphql');
        //?query{authToken(email:"julius.diedenhofen+salesforce@construyo.de",password:"test1234")}');
        request.setMethod('POST');
        
        request.setHeader('Content-Type', 'application/json');
        String body = '{"query": "query { authToken( email: "julius.diedenhofen+salesforce@construyo.de", password: "test1234" )}"}';
        //'query{authToken(email:"julius.diedenhofen+salesforce@construyo.de",password:"test1234")}';
        //{"query": "query { authToken( email: "julius.diedenhofen+salesforce@construyo.de", password: "test1234" )}"}';
        request.setBody(JSON.serialize(body));
        request.setTimeout(120000);
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        response = http.send(request);
        System.debug('Response >> '+response.getBody());
        
    }
}