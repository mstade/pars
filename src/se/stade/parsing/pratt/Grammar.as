package se.stade.parsing.pratt
{
    import se.stade.parsing.Token;

    public interface Grammar
    {
        function precedenceOf(token:Token):uint;
        
        function infixFor(token:Token):InfixRule;

        function prefixFor(token:Token):PrefixRule;
    }
}
