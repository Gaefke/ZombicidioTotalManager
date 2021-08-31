public class TestHelper {
    public static Criatura__c CriaCriatura(Integer count){
        return new Criatura__c(name = 'Criatura '+count);
    }
}