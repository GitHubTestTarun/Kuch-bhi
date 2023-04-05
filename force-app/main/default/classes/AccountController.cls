public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {

         return [SELECT Id, Name, AnnualRevenue, type, Industry FROM Account ORDER BY Name ASC];
         //throw new AuraHandledException('Forced error');

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts1(Integer fro, Integer to, Integer lim) {

         return [SELECT Id, Name, type, Industry FROM Account ORDER BY Name ASC];
         //throw new AuraHandledException('Forced error');

    }

    @AuraEnabled
    public static List<Account> getAccountData(String accName) {
        accName = '%' + accName + '%';
        List<Account> accounts = new List<Account>([SELECT ID, Name, Industry FROM Account WHERE Name LIKE:accName OR Industry LIKE: accName]);
        if(!accounts.isEmpty()) {
            return accounts;
        }
        return null;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getOffsetAccounts(Integer offSetBy) {
        List<Account> accounts = new List<Account>();
        accounts = [SELECT Id, Name, Industry FROM Account ORDER By Name ASC LIMIT 100 OFFSET : offSetBy];
        System.debug('acounts >> '+accounts);
        if(!accounts.isEmpty()) {
            return accounts;
        }
        return null;
    }
    
    @AuraEnabled
    public static string updateAccoutns(Object data) {
        List<Account> accountsForUpdate = (List<Account>) JSON.deserialize(
            JSON.serialize(data),
            List<Account>.class
       );
       try {
           update accountsForUpdate;
           return 'Success: ACCOUNTS updated successfully';
       }
       catch (Exception e) {
           return 'The following exception has occurred: ' + e.getMessage();
       }
    }

    @AuraEnabled(cacheable=true)
    public static string createNotesAndAttachments(String objectName, List<Id> files){
     
        System.debug('objectName created is '+ objectName);
        System.debug('ids camed is '+files);
        // Attachment a = new Attachment();
        // a.ParentId = account.Id;
        // a.Body = attachments.body;
        // a.Name = attachments.fileName;
        // System.debug('a is '+a);
        // insert a;
       return 'suucesssssss';
    }
}