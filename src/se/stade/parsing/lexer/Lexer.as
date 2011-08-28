package se.stade.parsing.lexer
{
    import se.stade.parsing.TokenStream;

	public interface Lexer
	{
		function scan(source:String, line:uint = 1):TokenStream
	}
}