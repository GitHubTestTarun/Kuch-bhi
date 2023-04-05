public  class wireDemoClassBySalesforceNoob {
    
    @AuraEnabled(cacheable = true)//used to specify that our LWC component can access this apex class also cachable = true is not required if we are using imparitive method but if we use @wire decorator then it is necessary to make cachable = true 

    public static List<FootBall__c> getFootBallList()  {

        List<FootBall__c> FootBallDetails = [SELECT Id, Name FROM FootBall__c];
        return FootBallDetails;
    }
    


}