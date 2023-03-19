import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;
public class Execute extends HelloBaseVisitor<String> {

  

   @Override public String visitGreetings(HelloParser.GreetingsContext ctx) {
      System.out.print("Olá" + ctx.name()+"\n");
      return null;
   }

   @Override public String visitBye(HelloParser.ByeContext ctx) {
      System.out.print("Bye" + ctx.name()+"\n");
      return null;
   }

   

   
}