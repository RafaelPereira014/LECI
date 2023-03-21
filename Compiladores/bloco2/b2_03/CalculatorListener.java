// Generated from Calculator.g4 by ANTLR 4.12.0
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CalculatorParser}.
 */
public interface CalculatorListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CalculatorParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(CalculatorParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalculatorParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(CalculatorParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link CalculatorParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(CalculatorParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalculatorParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(CalculatorParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ExprLabel}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExprLabel(CalculatorParser.ExprLabelContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ExprLabel}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExprLabel(CalculatorParser.ExprLabelContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ExprSumSub}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExprSumSub(CalculatorParser.ExprSumSubContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ExprSumSub}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExprSumSub(CalculatorParser.ExprSumSubContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ExprInteger}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExprInteger(CalculatorParser.ExprIntegerContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ExprInteger}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExprInteger(CalculatorParser.ExprIntegerContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ExprMultDivMod}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ExprMultDivMod}
	 * labeled alternative in {@link CalculatorParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx);
}