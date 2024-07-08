public with sharing class StaticExample {
    public StaticExample() {}

    public static void helloMe() {
        System.debug('I am a static method');
    }

    public void helloYou() {
        System.debug('I am now static method');
    }
}