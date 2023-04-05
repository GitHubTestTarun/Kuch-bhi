public with sharing class HeaderLessQuickActionController {
    
    @AuraEnabled
    public static void createContact(String accountId) {
        try {
            Account account = [SELECT Id, Name FROM Account WHERE Id=: accountId];
            Contact contact = new Contact(FirstName = account.Name, LastName = 'HeaderLessAction', accountId = account.Id, Amount__c = 2333);
            insert contact;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Contact> fetchContatcs(String accountId){
        try {
            System.debug('hello'+[SELECT Id, Name FROM Contact WHERE AccountId =: accountId]);
            return [SELECT Id, Name FROM Contact WHERE AccountId =: accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}