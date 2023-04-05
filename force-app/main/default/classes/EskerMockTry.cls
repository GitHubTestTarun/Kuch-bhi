@isTest
global class EskerMockTry implements HttpCalloutMock{
	
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        
        
        return response;
    }
    
}