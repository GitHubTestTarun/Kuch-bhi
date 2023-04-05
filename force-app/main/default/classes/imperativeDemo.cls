public  class imperativeDemo {
    
    @AuraEnabled
    
    public static List<FootBall__c> getFootBalls() {

        
        return [SELECT Id, Name, Quantity__c FROM FootBall__c];
    }

}