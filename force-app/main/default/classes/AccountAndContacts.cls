public with sharing class AccountAndContacts {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accountId) {

            return [SELECT ID, Name FROM Contact WHERE AccountId =: accountId];
    }
}