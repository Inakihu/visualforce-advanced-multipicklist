<a href="https://githubsfdeploy.herokuapp.com?owner=inakihu&repo=visualforce-advanced-multipicklist">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

[[Usage](#usage-examples) | [Know Issues/Todos](#known-issuestodos) | [Third Party Code](#third-party-code) | [Licence](#visualforce-tablegrid-license)

Advanced Multipicklist is a free, open-source Force.com library, that provides users and developers a other form to see and work with multipicklist fields. 
This component can be used as an advanced, highly configurable (by developer and user) replacement of <apex:selectOption> and fields into Standard Page Layouts.

> ![Examples One Field.](https://github.com/Inakihu/visualforce-advanced-multipicklist/blob/master/resources/Only_One_Field.png)
> ![Examples One Field two Source Picklist Fields.](https://github.com/Inakihu/visualforce-advanced-multipicklist/blob/master/resources/Only_One_Field.png)

## Features: ##

## Usage Examples ##

Please see `components/IHU_advancedMultiPicklist.component` for a detailed description of all attributes. The following examples should give 
you enough information to get started.

### Advanced Embedded into Standard Page Layouts

        <apex:page standardController="Contact">
    		<c:IHU_advancedMultiPicklist objectName="Contact"
        		sObject="{!contact}"
        		sourceFields="Aficiones__c"
        		keyField="Aficiones__c" 
        		field="Aficiones__c" 
        		mode="write"/>
		</apex:page>

	RESULT:
	> ![Result One Field.](https://github.com/Inakihu/visualforce-advanced-multipicklist/blob/master/resources/Only_One_Field_result.png)

		<apex:page standardController="Contact">
    		<c:IHU_advancedMultiPicklist objectName="Contact"
        		sObject="{!contact}"
        		sourceFields="aux_Language__c,aux_Level__c"
        		keyField="aux_Language__c" 
        		field="Languages__c" 
        		mode="write"/>
		</apex:page>

	RESULT
	> ![Results Two Fields.](https://github.com/Inakihu/visualforce-advanced-multipicklist/blob/master/resources/One_Field_Two_Picklist_Result.png)

## Known Issues/Todos ##

---Under construction---

## Visualforce Advanced Picklist License ##

Copyright (c) 2016, Iñaki Hernando Urcullu - https://github.com/Inakihu. 
Web-site: ihdourcullu.com or yxelp.com
All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

