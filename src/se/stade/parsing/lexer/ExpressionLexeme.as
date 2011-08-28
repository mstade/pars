package se.stade.parsing.lexer
{
    import se.stade.parsing.SourcePosition;
    import se.stade.parsing.Token;

	public class ExpressionLexeme implements Lexeme
	{
        public static const CaseSensitive:uint = 1;
        public static const IgnoreWhitespace:uint = 2;
        
		public function ExpressionLexeme(type:String, pattern:String, options:uint = 3)
		{
            this.type = type;
            
            var rxOptions:String = "g";

            rxOptions += options & IgnoreWhitespace ? "x" : "";
            rxOptions += options & CaseSensitive ? "i" : "";
			
            expression = new RegExp(pattern, rxOptions);
		}
		
        protected var type:String;
		protected var expression:RegExp;
        
        public function evaluate(input:String, position:SourcePosition):Token
        {
            expression.lastIndex = position.column;
            
            var match:Object = expression.exec(input);
            
            if (match && match.index == position.column)
            {
                return new Token(position, type, match[0]);
            }
            
            return null;
        }
	}
}