package se.stade.parsing.lexer
{
    import flash.utils.Dictionary;
    
    import se.stade.babbla.formatting.format;

    public class ExpressionLexemeFactory
    {
        public function ExpressionLexemeFactory(definitions:Object):void
        {
            this.definitions = expand(definitions);
        }
        
        protected var definitions:Object;
        
        protected function expand(value:Object):Object
        {
            value ||= {};
            
            var expandedDefinitions:Dictionary = new Dictionary;
            var definitionsNeedExpansion:Boolean = true;
            
            expansion: while (definitionsNeedExpansion)
            {
                definitionsNeedExpansion = false;
                var nothingWasExpanded:Boolean = true; //Assume this
                
                for (var name:String in value)
                {
                    if (name in expandedDefinitions)
                        continue;
                    
                    definitionsNeedExpansion = true;
                    var definition:String = format(value[name], expandedDefinitions);
                    
                    if (definition.search(/{(?!\d,\d}|\d,}|\d})[^}]+}/gi) == -1)
                    {
                        nothingWasExpanded = false;
                        expandedDefinitions[name] = "(?: " + definition + " )";
                    }
                }
                
                if (nothingWasExpanded)
                    break;
            }
            
            return expandedDefinitions;
        }
        
        public function create(type:String, pattern:String):Lexeme
        {
            pattern = format(pattern, definitions);
            return new ExpressionLexeme(type, pattern);
        }
    }
}
