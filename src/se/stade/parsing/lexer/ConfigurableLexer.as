package se.stade.parsing.lexer
{
	import flash.utils.Dictionary;
	
	import se.stade.babbla.formatting.format;
	import se.stade.parsing.LinearTokenStream;
	import se.stade.parsing.SourcePosition;
	import se.stade.parsing.Token;
	import se.stade.parsing.TokenStream;

	public class ConfigurableLexer implements Lexer
	{
        private var lexemeTable:Dictionary;
        
        public function setLexeme(type:String, lexeme:Lexeme):void
        {
            lexemeTable ||= new Dictionary;
            lexemeTable[type] = lexeme;
        }
        
        public function removeLexeme(type:String):void
        {
            delete lexemeTable[type];
            
            /* The following snippet of magic will return if
             * the dictionary is non-empty. Otherwise we clean
             * up. While the memory overhead of keeping the
             * dictionary around is likely small, it matters
             * to scan() since it'll shortcut if there's no
             * dictionary created. Unicorns cry in heaven for
             * this Adobe, thanks.
             */
            for each (var lexeme:Lexeme in lexemeTable)
            {
                
                return;
            }
            
            lexemeTable = null;
        }
        
        public function scan(source:String, line:uint=1):TokenStream
        {
			if (!lexemeTable)
			{
				return new LinearTokenStream(new <Token>
                [
                    Token.From(source, SourcePosition.At(0, 0))
                ]);
			}
            
			var column:int = 0;
			var tokens:Vector.<Token> = new <Token>[];
            
            var text:String = "";
			
			while (column < source.length)
			{
                var position:SourcePosition = SourcePosition.At(column, line);
                var nextToken:Token = Token.From(source.charAt(column), position);
                
				for each (var lexeme:Lexeme in lexemeTable)
				{
					var suggestedToken:Token = lexeme.evaluate(source, position);
                    
                    if (suggestedToken)
                    {
                        if (nextToken.type == Token.Text)
                            nextToken = suggestedToken;
                        else if (suggestedToken.value.length > nextToken.value.length)
                            nextToken = suggestedToken;
                    }
				}
                
                if (nextToken.type == Token.Text)
                {
                    text += nextToken.value;
                }
                else
                {
                    if (text.length)
                        tokens.push(Token.From(text, SourcePosition.At(position.column - text.length, line)));
                    
                    tokens.push(nextToken);
                    text = "";
                }
                
                column += nextToken.value.length;
			}
			
			return new LinearTokenStream(tokens);
		}
	}
}