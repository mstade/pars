package se.stade.parsing.lexer
{
    import se.stade.parsing.SourcePosition;
    import se.stade.parsing.Token;

    public interface Lexeme
    {
        function evaluate(input:String, position:SourcePosition):Token;
    }
}
