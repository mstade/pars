package se.stade.parsing
{
    public final class InvalidExpression implements Expression
    {
        public function InvalidExpression(token:Token)
        {
            this.token = token;
        }
        
        private var token:Token;
        
        public function equals(other:Expression):Boolean
        {
            return this == other || String(other) == token.value;
        }
        
        public function toString():String
        {
            return "Invalid expression: " + token.value;
        }
    }
}