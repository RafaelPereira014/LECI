public class Interpreter extends SuffixCalculatorBaseVisitor<Double> {

   @Override public Double visitProgram(SuffixCalculatorParser.ProgramContext ctx) {
      Double res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Double visitStat(SuffixCalculatorParser.StatContext ctx) {
      if(ctx.expr() != null){
         double res = visit(ctx.expr());
         System.out.println(res);
      }
      return null;
      //return res;
   }

   
}
