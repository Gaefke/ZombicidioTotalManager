global class ContagionSchedulable implements Schedulable
{
    
    global void execute(SchedulableContext SC)
    {
        this.contagiar();
    }
    
	private void contagiar ()
    {   
        List<Criatura__c> humanList = [SELECT id, Criatura__c.RecordTypeId, bunker__r.DefesaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c where recordtypeId = '0125e000001EACsAAO'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where recordtypeId <> '0125e000001EACsAAO'];
        for(Criatura__c zb : zombieList)
        {
            if(humanList.size() == 0) break;  
            Criatura__c hmn1 = humanlist.get(Math.mod(Integer.valueof(Math.random()*1000),humanlist.size()));
            Decimal defesa = 0;
            if(hmn1.recordtypeId != '0125e000001EADRAA4')
            {
                if (hmn1.bunker__c != null)
                {
                    defesa += hmn1.bunker__r.DefesaBunker__c;
                }
                if(hmn1.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*10000),100)+1;
            if(DiceRoll > defesa)
            {
                hmn1.recordtypeId = '0125e000001EADRAA4';
            	hmn1.DataZumbificacao__c = Date.today();
            }
            defesa = 0;
            Criatura__c hmn2 = humanlist.get(Math.mod(Integer.valueof(Math.random()*1000),humanlist.size()));
            if(hmn1.recordtypeId != '0125e000001EADRAA4')
            {
                if (hmn1.bunker__c != null)
                {
                    defesa += hmn1.bunker__r.DefesaBunker__c;
                }
                if(hmn1.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            if(DiceRoll > defesa)
            {
                hmn2.recordtypeId = '0125e000001EADRAA4';
                hmn2.DataZumbificacao__c = Date.today();
            }

        }
        update humanList;
    }

}