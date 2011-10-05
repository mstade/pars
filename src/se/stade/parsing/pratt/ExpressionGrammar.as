package se.stade.parsing.pratt
{
    import flash.utils.Dictionary;
    
    import se.stade.parsing.Token;

    public class ExpressionGrammar implements Grammar
    {
        private var infixRules:Dictionary = new Dictionary;
        private var infixPriority:Dictionary = new Dictionary;
        
        public function infixFor(token:Token):InfixRule
        {
            return token ? infixRules[token.type] : null;
        }
        
        public function setInfixFor(type:String, rule:InfixRule, priority:uint):void
        {
            infixRules[type] = rule;
            infixPriority[type] = priority;
        }
        
        public function precedenceOf(token:Token):uint
        {
            if (token && token.type in infixPriority)
                return infixPriority[token.type];
            
            return 0;
        }
                                      
        private var prefixParsers:Dictionary = new Dictionary;
        public function prefixFor(token:Token):PrefixRule
        {
            return token ? prefixParsers[token.type] : null;
        }
        
        public function setPrefixFor(type:String, parser:PrefixRule):void
        {
            prefixParsers[type] = parser;
        }
    }
}
