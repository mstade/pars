package se.stade.parsing
{
    public class LinearTokenStream implements TokenStream
    {
        public function LinearTokenStream(tokens:Vector.<Token>)
        {
            this.tokens = tokens ? tokens.slice() : new Vector.<Token>;
        }
        
        private var currentIndex:int = -1;
        private var tokens:Vector.<Token>;
        
        public function get current():Token
        {
            if (currentIndex >= 0 && currentIndex < tokens.length)
                return tokens[currentIndex];
            
            return null;
        }
        
        public function get type():String
        {
            return current ? current.type : null;
        }

        public function get value():String
        {
            return current ? current.value : null;
        }
        
        public function get peek():Token
        {
            return look(1);
        }
        
        public function look(distance:uint):Token
        {
            distance = (distance == 0) ? 1 : distance; 
            var peekIndex:int = currentIndex + distance;
            return peekIndex < tokens.length ? tokens[peekIndex] : null; 
        }
        
        public function nextTypeIs(type:String, ... types):Boolean
        {
            types = [type].concat(types);
            
            for each (type in types)
            {
                var next:Token = look(1);
                
                if (next && next.type == type)
                    return true;
            }
            
            return false;
        }
        
        public function ignore(type:String, ... types):TokenStream
        {
            types = [type].concat(types);
            
            while (nextTypeIs.apply(this, types))
            {
                consume();
            }
            
            return this;
        }

        public function consume():Token
        {
            currentIndex = currentIndex < tokens.length ? currentIndex + 1 : tokens.length;
            
            if (!current)
                throw ParseError.expected("some token").got(current);
            
            return current;
        }
        
        public function accept(type:String, ... types):Token
        {
            types = [type].concat(types);
            return nextTypeIs.apply(this, types) ? consume() : null;
        }
        
        public function acceptAnythingBut(type:String, ... types):Token
        {
            types = [type].concat(types);
            return nextTypeIs.apply(this, types) ? null : consume();
        }
        
        public function expect(type:String, ... types):Token
        {
            types = [type].concat(types);
            var token:Token = accept.apply(this, types);
            
            if (token)
                return token;
            else
                throw ParseError.expected(types.join("|")).got(peek);
        }
        
        public function expectAnythingBut(type:String, ... types):Token
        {
            types = [type].concat(types);
            var token:Token = acceptAnythingBut.apply(this, types);
            
            if (token)
                return token;
            else
                throw ParseError.expected("anything but: " + types.join("|")).got(peek); 
        }
    }
}