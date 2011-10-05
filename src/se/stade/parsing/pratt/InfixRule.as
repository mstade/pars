package se.stade.parsing.pratt
{
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;

    public interface InfixRule
    {
        function evaluate(preceding:Expression, current:Token, following:TokenStream, parser:Parser, precedence:uint):Expression;
    }
}
