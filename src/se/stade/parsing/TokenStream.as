package se.stade.parsing
{
    public interface TokenStream
    {
        function get peek():Token;
        function get type():String;
        function get value():String;
        function get current():Token;
        
        function look(distance:uint):Token;
        function nextTypeIs(type:String, ... types):Boolean;
        
        function consume():Token;
        function ignore(type:String, ... types):TokenStream;
        
        function accept(type:String, ... types):Token;
        function acceptAnythingBut(type:String, ... types):Token;
        
        function expect(type:String, ... types):Token;
        function expectAnythingBut(type:String, ... types):Token;
    }
}
