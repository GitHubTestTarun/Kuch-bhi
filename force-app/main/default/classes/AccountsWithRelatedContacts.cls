public with sharing class AccountsWithRelatedContacts {
    
    @AuraEnabled
    
    public static List<Contact> RelatedContacts(Account ac) {

        return [SELECT Id, Name FROM Contact WHERE AccountId =: ac.Id];
    }
    public static List<Account> getAccounts() {

            return [SELECT ID, Name FROM Account];
    }
}