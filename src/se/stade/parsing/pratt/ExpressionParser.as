package se.stade.parsing.pratt
{
	import se.stade.parsing.Expression;
	import se.stade.parsing.Language;
	import se.stade.parsing.ParseError;
	import se.stade.parsing.Token;
	import se.stade.parsing.TokenStream;
	import se.stade.parsing.lexer.Lexer;

    public class ExpressionParser implements Parser
    {
        public function ExpressionParser(grammar:Grammar)
        {
            this.grammar = grammar;
        }
        
        protected var grammar:Grammar;
        
        public function interpret(stream:TokenStream, precedence:uint):Expression
        {
            var prefix:PrefixRule = grammar.prefixFor(stream.consume());
            
            if (prefix)
                var left:Expression = prefix.evaluate(stream.current, stream, this, precedence);
            else
                throw ParseError.expected("known token").got(stream.current);
            
            while (precedence < grammar.precedenceOf(stream.peek))
            {
                var next:Token = stream.consume();
                var infix:InfixRule = grammar.infixFor(next);
                
                precedence = grammar.precedenceOf(next);
                return infix.evaluate(left, stream.current, stream, this, precedence);
            }
            
            return left;
        }
    }
}