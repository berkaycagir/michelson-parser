# Unused definitions:

#main -> instruction {% id %}
#      | data {% id %}
#      | type {% id %}
#      | parameter {% id %}
#      | storage {% id %}
#      | code {% id %}
#      | script {% id %}
#      | parameterValue {% id %}
#      | storageValue {% id %}
#      | typeData {% id %}

#parameterValue -> %parameter _ typeData _ semicolons {% singleArgKeywordToJson %}
#storageValue -> %storage _ typeData _ semicolons {% singleArgKeywordToJson %}
#typeData -> %singleArgType _ typeData {% singleArgKeywordToJson %}
#          | %lparen _ %singleArgType _ typeData _ %rparen {% singleArgKeywordWithParenToJson %}
#          | %doubleArgType _ typeData _ typeData {% doubleArgKeywordToJson %}
#          | %lparen _ %doubleArgType _ typeData _ typeData _ %rparen {% doubleArgKeywordWithParenToJson %}
#          | subTypeData {% id %}
#          | subTypeElt {% id %}
#          | %number {% intToJson %}
#          | %string {% stringToJson %}
#          | %lbrace _ %rbrace {% function(d) { return []; } %}

#subTypeData -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
#             | "{" _ (data ";":? _):+ "}" {% instructionSetToJsonSemi %}
#             | "(" _ (data ";":? _):+ ")" {% instructionSetToJsonSemi %}

#subTypeElt -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
#            | "{" _ (typeElt ";":? _):+ "}" {% instructionSetToJsonSemi %}
#            | "(" _ (typeElt ";":? _):+ ")" {% instructionSetToJsonSemi %}
#            | "{" _ (typeElt _ ";":? _):+ "}" {% instructionSetToJsonSemi %}
#            | "(" _ (typeElt _ ";":? _):+ ")" {% instructionSetToJsonSemi %}

#typeElt -> %elt _ typeData _ typeData {% doubleArgKeywordToJson %}
