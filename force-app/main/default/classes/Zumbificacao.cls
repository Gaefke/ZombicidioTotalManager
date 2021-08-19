public class Zumbificacao 
{
	@InvocableMethod (label = 'Transforma Zumbi')
    public static void zumbificar(List<id>ids)
    {
        System.debug(ids);
        List<Criatura__c> criList = [SELECT id, bunker__r.name, bunker__c, (SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE id in : ids];
        List<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        for(Criatura__c cr : criList){
            String TipoZumbi = '';
            integer rand = Math.mod(Integer.valueof(Math.random()*1000000),100);
            if(rand < 50)
            {
                tipoZumbi = 'Lerdo';
            }
            else if (rand < 80)
            {
                tipoZumbi = 'Corredor';
            }
            else if (rand <= 99)
            {
                tipoZumbi = 'Balofo';
            }
            else
            {
                tipoZumbi = 'Monstruoso';
            }
            cr.tipoZumbi__c = tipoZumbi;
            if(cr.RecursosCriatura__r != null)
            	rcDeleteList.addAll(cr.RecursosCriatura__r);
        }
		update criList;
        delete rcDeleteList;
    }
}