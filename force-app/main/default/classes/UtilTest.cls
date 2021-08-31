@isTest
public class UtilTest 
{
    private  String ZombieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();
    private  String HumanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();

	@isTest static void GetRandomItemTest()
    {
        //preparação do cenário
        List<criatura__c> creatureList= new List<criatura__c>();
        creatureList.add(new Criatura__c(name = 'Criatura1'));
        
        //teste
        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRandomItem(creatureList);
        test.stopTest();
        
        //validação do resultado
        System.assertEquals(cri, creatureList.get(0));
    }
    
}