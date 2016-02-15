/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class IHU_AdvancedMultiPicklist_Test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Account newAccount = new Account();
        newAccount.Name = 'Name';
        newAccount.AccountSource = '';
        newAccount.Description = '11111;22222;33333';
        insert newAccount;
        
        IHU_AdvancedMultiPicklist_Controller ctlr = new IHU_AdvancedMultiPicklist_Controller();
        	
        ctlr.fieldParam = 'Description';
        ctlr.sourceFieldsParam = 'AccountSource';
        ctlr.keyFieldParam = 'AccountSource';
        ctlr.modeParam = 'write';
        ctlr.objectNameParam = 'Account';
        ctlr.sObjectParam = newAccount;
        
        ctlr.getInit();
        
        //Delete first Value
        newAccount.Description = '11111;22222;33333';
        ctlr.sObjectParam2 = newAccount;
        ctlr.valueToDelete = '11111';
        ctlr.deleteValue();
        
        //Delete last Value
        newAccount.Description = '11111;22222;33333';
        ctlr.sObjectParam2 = newAccount;
        ctlr.valueToDelete = '33333';
        ctlr.deleteValue();
        
        newAccount.Description = '';
        ctlr.sObjectParam2 = newAccount;
        ctlr.add();
        
        
        Schema.DescribeFieldResult fieldResult = Account.active__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		
		String values ='';
		
  		for (Schema.PicklistEntry a : ple ) {
      		values += a.getValue() + ';';
      	}
      	
      	newAccount.Description = values;
        ctlr.sObjectParam2 = newAccount;
        
        ctlr.add();

    }
}