package se.stade.parsing
{
	public final class Token
	{
        public static const Text:String = "text";
        public static const EOF:Token = Token.OfType("eof", SourcePosition.At(0, 0));
        
        public static function From(value:String, position:SourcePosition):Token
        {
            return new Token(position, Text, value);
        }
        
        public static function OfType(type:String, position:SourcePosition):Token
        {
            return new Token(position, type);
        }
        
		public function Token(position:SourcePosition, type:String, value:String = "")
		{
			_value = value || "";
            _type = type;
            _position = position;
		}
        
        private var _type:String;
        public function get type():String
        {
            return _type;
        }
        
        private var _position:SourcePosition;
        public function get position():SourcePosition
        {
            return _position;
        }
		
		protected var _value:String;
		public function get value():String
		{
			return _value;
		}
        
		public function toString():String
		{
			return type + "[" + value + "]";
		}
	}
}