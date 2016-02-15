public with sharing class IHU_AdvancedMultiPicklist_Controller {
    // COMPONENT ATTRIBUTES 
    public String fieldParam { get; set; }
    public String sourceFieldsParam { get; set; }
    public String keyFieldParam { get; set; }
    public String modeParam { get; set; }
    public String objectNameParam { get; set; }
    public sObject sObjectParam { get; set; }
    
    // ACTION ATTRIBUTES
    public String valueToDelete {get; set;}
    
    //PUBLIC
    public List<String> columns {get; set;}
    public List<Map<String,String>> values {get; set;}
    public sObject sObjectParam2 {get; set;}
    public Map<String,String> mLabelFields {get; set;} //Label fiels
    public Map<String,List<SelectOption>> mFieldOptions {get; set;}
    public Map<String,String> mFieldValue {get; set;}
    
    public boolean showAddAndPicklist {get; set;}
    
    private Map<String,Schema.SObjectField> mfields;
    
    public void getInit() {
    	mFieldValue = new Map<String,String>();
    	//Get columns
    	if (sourceFieldsParam!=null){
    		columns = sourceFieldsParam.split(',');
    	}
    	
    	//Save fields to SOQL in Set to no repeat
    	Set<String> sFieldsSQL = new Set<String>();
    	sFieldsSQL.add('Id');
    	sFieldsSQL.add(fieldParam);
    	sFieldsSQL.add(keyFieldParam);
    	for(String auxStr:columns){
    		sFieldsSQL.add(auxStr);
    		mFieldValue.put(auxStr,'');
    	}
    	
    	//Generate fields SOQL to query	
    	String strFieldsSQL	= '';
    	for(String auxStr:sFieldsSQL)
    		strFieldsSQL += auxStr + ',';
    	if(strFieldsSQL.length()>0)
    		strFieldsSQL = strFieldsSQL.substring(0,strFieldsSQL.length()-1);
    	
    	//Get Describo of sObject and its fields
    	SObjectType objectType = Schema.getGlobalDescribe().get(objectNameParam);
    	mfields = objectType.getDescribe().fields.getMap();
    	
    	//Instance Maps variables
    	mFieldOptions = new Map<String,List<SelectOption>>();
    	mLabelFields = new Map<String,String>();
    	
    	//Query sObject
    	String strSQL = 'SELECT ' + strFieldsSQL + ' FROM ' + objectNameParam + ' WHERE Id = \'' + sObjectParam.Id + '\' LIMIT 1';
    	sObjectParam2 = Database.query(strSQL);
    	
    	getValues();
    }
    
    public void getValues(){
    	Set<String> valuesKey = new Set<String>(); 
    	values = new List<Map<String,String>>();
    	
    	//Get value of field to update
    	String valueField = (String)sObjectParam2.get(fieldParam);
    	
    	// Set variables to contains list values in field and keyValues
    	if(valueField!=null && valueField!=''){
    		List<String> aux_values= valueField.split(';');
    		
    		for(String val: aux_Values){
    			if(val!=null && val!=''){
	    			List<String> lstVals = val.split('-');
	    			Map<String,String> auxMap = new Map<String,String>();
	    			Integer i = 0;   
	    			for(String nameColumn:columns){
	    				if( keyFieldParam == nameColumn )
	    					valuesKey.add(lstVals[i]);
	    				auxMap.put(nameColumn,lstVals[i]);
	    				System.debug('Insert ' + nameColumn + ' : ' + valueField);
	    				i++;
	    			}
	    			values.add(auxMap);
    			}
    		}
    	}
    	
    	//Set List of picklist availables
    	for(String nameColumn:columns){
    		Schema.DescribeFieldResult tmpDescribeField = mfields.get(nameColumn).getDescribe();
    		mLabelFields.put(nameColumn,tmpDescribeField.Label);
    		List<SelectOption> options = new List<SelectOption>();
    		system.debug(valuesKey);
    		for( Schema.PicklistEntry f : tmpDescribeField.getPicklistValues()){
    			system.debug(f.getValue());	
    			if(!valuesKey.contains(f.getValue()))
    				options.add(new SelectOption(f.getLabel(), f.getValue()));
    		}
    		if(options.size()<1){
    			options.add(new SelectOption('Nothing', 'Nothing'));
    			if( keyFieldParam == nameColumn )
    				showAddAndPicklist = false;
    		}else{
    			if( keyFieldParam == nameColumn )
    				showAddAndPicklist = true;
    		}
    		mFieldOptions.put(nameColumn, options);
    	}
    }
    
    public void add(){
    	String newValue='';
    	String oldValue = (String)sObjectParam2.get(fieldParam);
    	for(String nameColumn:columns){
    		newValue += mFieldValue.get(nameColumn) + '-';
    	}
    	if(newValue.length()>0)
    		newValue = newValue.substring(0,newValue.length()-1);
    	
    	if(oldValue!=null && oldValue!='')	
    		sObjectParam2.put(fieldParam,oldValue +';'+newValue);
    	else
    		sObjectParam2.put(fieldParam,newValue);
    	try {
			update sObjectParam2;
			getValues(); 
		}catch(Exception e) {
			System.debug(e);
			ApexPages.addMessages(e);
			sObjectParam2.put(fieldParam,oldValue); 
		}
    	
    }
    
    public void deleteValue(){
    	String newValue = '';
    	
    	if(valueToDelete.length()>0)
    		valueToDelete = valueToDelete.substring(0,valueToDelete.length() - 1);
    	String oldvalue = (String)sObjectParam2.get(fieldParam);
    	
    	List <String> oldValues = oldvalue.split(';');
    	for(String auxValue: oldValues)
    		if(auxValue != valueToDelete)
    			newValue += auxValue + ';';
    	
    	if(newValue.EndsWith(';'))
    		newValue = newValue.substring(0,newValue.length() - 1);
    	
    	sObjectParam2.put(fieldParam,newValue);
    	try {
			update sObjectParam2;
			getValues(); 
		}catch(Exception e) {
			System.debug(e);
			ApexPages.addMessages(e);
			sObjectParam2.put(fieldParam,oldValue); 
    	}
    }
}