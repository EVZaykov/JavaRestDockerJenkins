package utils;

import static utils.RunContext.RUN_CONTEXT;

public class CheckVariable {

    public static Object checkVariable(Object fullString) {
        String argumentToString = fullString.toString();
        if (argumentToString.contains("${")) {
            int startVar = argumentToString.indexOf("${");
            int endVar = argumentToString.indexOf("}");
            char[] ch = new char[200];
            argumentToString.getChars(startVar + 2, endVar, ch, 0);
            String chLikeString = String.valueOf(ch);
            return argumentToString.substring(0, startVar) + RUN_CONTEXT.get(chLikeString.trim(), Object.class) + argumentToString.substring(endVar + 1);
        }
        return fullString;
    }
}
