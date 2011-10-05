package se.stade.parsing
{
    import se.stade.babbla.formatting.format;

    internal class ExpectationErrorBuilder
    {
        public function ExpectationErrorBuilder(message:String)
        {
            expected = message;
        }
        
        private var expected:String;
        
        public function got(token:Token):ParseError
        {
            var message:String = format("Expected {something}, got {token}.",
                {
                    something:  expected,
                    token:    token || "nothing"
                });
            
            return new ParseError(token ? token.position : SourcePosition.At(0, 0), message);
        }
    }
}
