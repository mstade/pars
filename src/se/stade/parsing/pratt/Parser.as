package se.stade.parsing.pratt
{
	import se.stade.parsing.Expression;
	import se.stade.parsing.TokenStream;

    public interface Parser
    {
        function interpret(stream:TokenStream, precedence:uint):Expression;
    }
}