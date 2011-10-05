package se.stade.parsing
{
    import se.stade.babbla.formatting.format;

    public class ParseError extends Error
    {
        public static function expected(message:String):ExpectationErrorBuilder
        {
            return new ExpectationErrorBuilder(message);
        }
        public static function UnexpectedToken(token:Token, expected:String):ParseError
        {
            var message:String = format("Expected {message}; got {token}",
                {
                    message:  expected,
                    token:    token
                });
            
            return new ParseError(token.position, message);
        }
        
        public function ParseError(position:SourcePosition, message:String)
        {
            message = format("[ln: {row}, c: {column}] {message}",
            {
                row:     position.row,
                column:  position.column,
                message: message
            });
            
            super(message);
        }
    }
}
