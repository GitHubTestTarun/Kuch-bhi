@isTest
private class AnimalFarmTest {
	
    @isTest
    static void testAnimals() {
        Test.setMock(HttpCalloutMock.class, new AnimalFarmCalloutMock());
        
        HttpResponse response = AnimalFarm.animals();
        String fakeBody = response.getBody();
        System.debug('response camed is >> '+response.getBody());
    }
}