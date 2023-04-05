public with sharing class TestDataFactory {

    public static Account insertAccount(String name, Boolean isInsert) {

        Account account = new Account(Name = name);

        if(isInsert) {
            insert account;
        }
        return account;
    }

    public static Account insertAccount(String name) {

        Account account = new Account(Name = name);
        insert account;
        return account;
    }

    public static Contact insertContact(String firstName, String lastName, Id accountId, Integer amount, Boolean isInsert) {

        Contact contact = new Contact(FirstName = firstName, LastName = lastName, accountId = accountId, Amount__c = amount);

        if(isInsert) {
            insert contact;
        }
        return contact;
    }
    
    public static Contact insertContact(String firstName, String lastName, Id accountId, Integer amount) {

        Contact contact = new Contact(FirstName = firstName, LastName = lastName, accountId = accountId, Amount__c = amount);
        insert contact;
        return contact;
    }

}