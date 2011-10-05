package se.stade.parsing
{
    public interface Language
    {
        function parse(input:String):Expression;
    }
}
