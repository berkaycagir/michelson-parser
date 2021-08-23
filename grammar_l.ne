@builtin "whitespace.ne"
@lexer lexer

main -> script {% id %}
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

script -> parameter _ storage _ code {% scriptToJson %}

parameter -> %parameter (_ %annot):* _ type _ semicolons {% singleArgKeywordToJson %}

storage -> %storage (_ %annot):* _ type _ semicolons {% singleArgKeywordToJson %}

code -> %code _ subInstruction _ semicolons _ {% function (d) { return d[2]; } %}
      | %code _ "{};" {% function (d) { return "code {}"; } %}

#parameterValue -> %parameter _ typeData _ semicolons {% singleArgKeywordToJson %}

#storageValue -> %storage _ typeData _ semicolons {% singleArgKeywordToJson %}

type -> %comparableType {% keywordToJson %}
      | %constantType {% keywordToJson %}
      | %singleArgType _ type {% singleArgKeywordToJson %}
      | %lparen _ %singleArgType _ type _ %rparen {% singleArgKeywordWithParenToJson %}
      | %lparen _ %singleArgType _ %lparen _ type _ %rparen _ %rparen {% singleArgKeywordWithParenToJson %}
      | %doubleArgType _ type _ type {% doubleArgKeywordToJson %}
      | %lparen _ %doubleArgType _ type _ type _ %rparen {% doubleArgKeywordWithParenToJson %}
      | %lparen _ %comparableType (_ %annot):+ _ %rparen {% comparableTypeToJson %}
      | %lparen _ %constantType (_ %annot):+ _ %rparen {% comparableTypeToJson %}
      | %lparen _ %singleArgType (_ %annot):+ _ type %rparen {% singleArgTypeKeywordWithParenToJson %}
      | %comparableType (_ %annot):+ {% keywordToJson %}
      | %constantType (_ %annot):+ {% keywordToJson %}
      | %lparen _ %doubleArgType (_ %annot):+ _ type _ type %rparen {% doubleArgTypeKeywordWithParenToJson %}

#typeData -> %singleArgType _ typeData {% singleArgKeywordToJson %}
#          | %lparen _ %singleArgType _ typeData _ %rparen {% singleArgKeywordWithParenToJson %}
#          | %doubleArgType _ typeData _ typeData {% doubleArgKeywordToJson %}
#          | %lparen _ %doubleArgType _ typeData _ typeData _ %rparen {% doubleArgKeywordWithParenToJson %}
#          | subTypeData {% id %}
#          | subTypeElt {% id %}
#          | %number {% intToJson %}
#          | %string {% stringToJson %}
#          | %lbrace _ %rbrace {% function(d) { return []; } %}

data -> %constantData {% keywordToJson %}
      | %singleArgData _ data {% singleArgKeywordToJson %}
      | %lparen _ %singleArgData _ data _ %rparen {% singleArgKeywordWithParenToJson %}
      | %doubleArgData _ data _ data {% doubleArgKeywordToJson %}
      | %lparen _ %doubleArgData _ data _ data _ %rparen {% doubleArgKeywordWithParenToJson %}
      | subData  {% id %}
      | subElt {% id %}
      | %number {% intToJson %}
      | %string {% stringToJson %}

#subTypeData -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
#             | "{" _ (data ";":? _):+ "}" {% instructionSetToJsonSemi %}
#             | "(" _ (data ";":? _):+ ")" {% instructionSetToJsonSemi %}

#subTypeElt -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
#            | "{" _ (typeElt ";":? _):+ "}" {% instructionSetToJsonSemi %}
#            | "(" _ (typeElt ";":? _):+ ")" {% instructionSetToJsonSemi %}
#            | "{" _ (typeElt _ ";":? _):+ "}" {% instructionSetToJsonSemi %}
#            | "(" _ (typeElt _ ";":? _):+ ")" {% instructionSetToJsonSemi %}

#typeElt -> %elt _ typeData _ typeData {% doubleArgKeywordToJson %}

subInstruction -> %lbrace _ %rbrace {% function(d) { return ""; } %}
                | %lbrace _ instruction _ %rbrace {% function(d) { return d[2]; } %}
                | %lbrace _ (instruction _ %semicolon _):+ instruction _ %rbrace {% instructionSetToJsonNoSemi %}
                | %lbrace _ (instruction _ %semicolon _):+ %rbrace {% instructionSetToJsonSemi %}

instructions -> %baseInstruction {% id %}
              | %macroCADR {% id %}
              | %macroDIP {% id %}
              | %macroDUP {% id %}
              | %macroSETCADR {% id %}
              | %macroASSERTlist {% id %}

instruction -> instructions {% keywordToJson %}
             | instructions (_ %annot):+ _ {% keywordToJson %}
#instruction -> instructions (_ %annot):* _ {% keywordToJson %}
             | instructions _ subInstruction {% singleArgInstrKeywordToJson %}
             | instructions (_ %annot):+ _ subInstruction {% singleArgTypeKeywordToJson %}
             | instructions _ type {% singleArgKeywordToJson %}
             | instructions (_ %annot):+ _ type {% singleArgTypeKeywordToJson %}
             | instructions _ data {% singleArgKeywordToJson %}
             | instructions (_ %annot):+ _ data {% singleArgTypeKeywordToJson %}
             | instructions _ type _ type _ subInstruction {% tripleArgKeyWordToJson %}
             | instructions (_ %annot):+ _ type _ type _ subInstruction {% tripleArgTypeKeyWordToJson %}
             | instructions _ subInstruction _ subInstruction {% doubleArgInstrKeywordToJson %}
             | instructions (_ %annot):+ _ subInstruction _ subInstruction {% doubleArgTypeKeywordToJson %}
             | instructions _ type _ type {% doubleArgKeywordToJson %}
             | instructions (_ %annot):+ _ type _ type {% doubleArgTypeKeywordToJson %}
             | "PUSH" _ type _ data {% doubleArgKeywordToJson %}
             | "PUSH" _ type _ %lbrace %rbrace {% pushToJson %}
             | "PUSH" (_ %annot):+ _ type _ data {% pushWithAnnotsToJson %}
             | "DIP" _ %number _ subInstruction {% dipnToJson %}
             | "DUP" _ %number _ subInstruction {% dipnToJson %}
             | "DIG" _ %number {% dignToJson %}
             | "DUG" _ %number {% dignToJson %}
             | "DROP" _ %number {% dropnToJson %}
             | "DROP" {% keywordToJson %}
             | %lbrace _ %rbrace {% function(d) { return ""; } %}
             | "CREATE_CONTRACT" _ %lbrace _ parameter _ storage _ code _ %rbrace {% subContractToJson %}
             | "EMPTY_MAP" _ type _ type {% doubleArgKeywordToJson %}
             | "EMPTY_MAP" _ %lparen _ type _ %rparen _ type {% doubleArgParenKeywordToJson %}

subData -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
         | "{" _ (data ";":? _):+ "}" {% instructionSetToJsonSemi %}
         | "(" _ (data ";":? _):+ ")" {% instructionSetToJsonSemi %}
         | "{" _ (data _ ";":? _):+ "}" {% instructionSetToJsonSemi %}
         | "(" _ (data _ ";":? _):+ ")" {% instructionSetToJsonSemi %}

subElt -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}
        | "{" _ (elt ";":? _):+ "}" {% instructionSetToJsonSemi %}
        | "(" _ (elt ";":? _):+ ")" {% instructionSetToJsonSemi %}

elt -> %elt _ data _ data {% doubleArgKeywordToJson %}

# _ -> [\s]:*

semicolons -> [;]:?


@{%
const moo = require("moo");

const macroCADRconst = /C[AD]+R/;
const macroSETCADRconst = /SET_C[AD]+R/;
const macroDIPconst = /DII+P/;
const macroDUPconst = /DUU+P/;
const DIPmatcher = new RegExp(macroDIPconst);
const DUPmatcher = new RegExp(macroDUPconst);
const macroASSERTlistConst = ['ASSERT', 'ASSERT_EQ', 'ASSERT_NEQ', 'ASSERT_GT',
                              'ASSERT_LT', 'ASSERT_GE', 'ASSERT_LE', 'ASSERT_NONE',
                              'ASSERT_SOME', 'ASSERT_LEFT', 'ASSERT_RIGHT', 'ASSERT_CMPEQ',
                              'ASSERT_CMPNEQ', 'ASSERT_CMPGT', 'ASSERT_CMPLT', 'ASSERT_CMPGE',
                              'ASSERT_CMPLE'];
const macroIFCMPlist = ['IFCMPEQ', 'IFCMPNEQ', 'IFCMPLT', 'IFCMPGT', 'IFCMPLE', 'IFCMPGE'];
const macroCMPlist = ['CMPEQ', 'CMPNEQ', 'CMPLT', 'CMPGT', 'CMPLE', 'CMPGE'];
const macroIFlist = ['IFEQ', 'IFNEQ', 'IFLT', 'IFGT', 'IFLE', 'IFGE'];
const lexer = moo.compile({
    annot: /[\@\%\:][a-z_A-Z0-9]+/,
    comment: /#.*/,
    lparen: '(',
    rparen: ')',
    lbrace: '{',
    rbrace: '}',
    ws: {match: /[ \s]+/, lineBreaks: true},
    semicolon: ";",
    number: /-?[0-9]+/,
    parameter: ['parameter', 'Parameter'],
    storage: ['Storage', 'storage'],
    code: ['Code', 'code'],
    comparableType: ['int', 'nat', 'string', 'bytes', 'mutez', 'bool', 'key_hash', 'timestamp', 'chain_id'],
    constantType: ['key', 'unit', 'signature', 'operation', 'address'],
    singleArgType: ['option', 'list', 'set', 'contract'],
    doubleArgType: ['pair', 'or', 'lambda', 'map', 'big_map'],
    baseInstruction: ['ABS', 'ADD', 'ADDRESS', 'AMOUNT', 'AND', 'BALANCE', 'BLAKE2B', 'CAR', 'CAST', 'CDR', 'CHECK_SIGNATURE',
        'COMPARE', 'CONCAT', 'CONS', 'CONTRACT', /*'CREATE_CONTRACT',*/ 'DIP', /*'DROP',*/ 'DUP', 'EDIV',
        'EMPTY_SET', 'EQ', 'EXEC', 'FAIL', 'FAILWITH', 'GE', 'GET', 'GT', 'HASH_KEY', 'IF', 'IF_CONS', 'IF_LEFT', 'IF_NONE',
        'IF_RIGHT', 'IMPLICIT_ACCOUNT', 'INT', 'ISNAT', 'ITER', 'LAMBDA', 'LE', 'LEFT', 'LOOP', 'LOOP_LEFT', 'LSL', 'LSR', 'LT',
        'MAP', 'MEM', 'MUL', 'NEG', 'NEQ', 'NIL', 'NONE', 'NOT', 'NOW', 'OR', 'PACK', 'PAIR', /*'PUSH',*/ 'REDUCE', 'RENAME', 'RIGHT', 'SELF',
        'SENDER', 'SET_DELEGATE', 'SHA256', 'SHA512', 'SIZE', 'SLICE', 'SOME', 'SOURCE', 'STEPS_TO_QUOTA', 'SUB', 'SWAP',
        'TRANSFER_TOKENS', 'UNIT', 'UNPACK', 'UPDATE', 'XOR',
        'UNPAIR', 'UNPAPAIR',
        'IF_SOME',
        'IFCMPEQ', 'IFCMPNEQ', 'IFCMPLT', 'IFCMPGT', 'IFCMPLE', 'IFCMPGE', 'CMPEQ', 'CMPNEQ', 'CMPLT', 'CMPGT', 'CMPLE',
        'CMPGE', 'IFEQ', 'NEQ', 'IFLT', 'IFGT', 'IFLE', 'IFGE',
        /*'DIG',*/ /*'DUG',*/ 'EMPTY_BIG_MAP', 'APPLY', 'CHAIN_ID'
    ],
    macroCADR: macroCADRconst,
    macroDIP: macroDIPconst,
    macroDUP: macroDUPconst,
    macroSETCADR: macroSETCADRconst,
    macroASSERTlist: macroASSERTlistConst,
    constantData: ['Unit', 'True', 'False', 'None', 'instruction'],
    singleArgData: ['Left', 'Right', 'Some'],
    doubleArgData: ['Pair'],
    elt: "Elt",
    word: /[a-zA-Z_0-9]+/,
    string: /"(?:\\["\\]|[^\n"\\])*"/
});
const checkC_R = c_r => {
    var pattern = new RegExp('^C(A|D)(A|D)+R$'); // TODO
    return pattern.test(c_r);
};
const expandC_R = (word, annot, d) => {
    var expandedC_R = word.slice(1, -1).split('').map(c => (c === 'A' ? '{ "prim": "CAR" }' : '{ "prim": "CDR" }'));
    if (annot != null) {
        const lastChar = word.slice(-2, -1);
        if (lastChar === 'A') {
            expandedC_R[expandedC_R.length - 1] = `{ "prim": "CAR", "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
        }
        else if (lastChar === 'D') {
            expandedC_R[expandedC_R.length - 1] = `{ "prim": "CDR", "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
        }
    }
    return `[ ${expandedC_R.join(', ')}, { "line": "${findLine(d)}" } ]`;
};
const check_compare = cmp => macroCMPlist.includes(cmp);
const expand_cmp = (cmp, annot, d) => {
    var op = cmp.substring(3);
    var binary_op = keywordToJson([`${op}`]);
    var compare = keywordToJson(['COMPARE']);
    if (annot != null) {
        binary_op = `{ "prim": "${op}", "annots": [${annot}], "line": "${findLine(d)}" }`;
    }
    return `[ ${compare}, ${binary_op}, { "line": "${findLine(d)}" } ]`;
};
const check_dup = dup => DUPmatcher.test(dup);
const expand_dup = (dup, annot, d) => {
    let t = '';
    if (DUPmatcher.test(dup)) {
        const c = dup.length - 3;
        for (let i = 0; i < c; i++) {
            t += '[ { "prim": "DIP", "args": [ ';
        }
        if (annot == null) {
            t += `[ { "prim": "DUP" }, { "line": "${findLine(d)}" } ]`;
        }
        else {
            t += `[ { "prim": "DUP", "annots": [${annot}] }, { "line": "${findLine(d)}" } ]`;
        }
        for (let i = 0; i < c; i++) {
            t += ` ] }, { "prim": "SWAP" }, { "line": "${findLine(d)}" } ]`;
        }
        return t;
    }
    throw new Error('');
};
const check_assert = assert => macroASSERTlistConst.includes(assert);
const expand_assert = (assert, annot, d) => {
    const annotation = !!annot ? `, "annots": [ ${annot} ]` : '';
    switch (assert) {
        case 'ASSERT':
            return `[ { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPEQ':
            return `[ [ { "prim": "COMPARE"}, { "prim": "EQ" } ], {"prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPGE':
            return `[ [ { "prim":"COMPARE" }, { "prim": "GE" } ], { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPGT':
            return `[ [ { "prim": "COMPARE" }, { "prim": "GT" } ], { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPLE':
            return `[ [ { "prim": "COMPARE" }, { "prim": "LE" } ], { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPLT':
            return `[ [ { "prim": "COMPARE" }, { "prim": "LT" } ], { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_CMPNEQ':
            return `[ [ { "prim": "COMPARE" }, { "prim": "NEQ" } ], { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_EQ':
            return `[ { "prim": "EQ" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ], { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_GE':
            return `[ { "prim": "GE" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim":"FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_GT':
            return `[ { "prim": "GT" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_LE':
            return `[ { "prim": "LE" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_LT':
            return `[ { "prim": "LT" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        case 'ASSERT_NEQ':
            return `[ { "prim": "NEQ" }, { "prim": "IF", "args": [ [], [ [ { "prim": "UNIT" }, { "prim": "FAILWITH" ${annotation} } ] ] ] }, { "line": "${findLine(d)}" } ]`;
        default:
            return '';
    }
};
const check_fail = fail => fail === "FAIL";
const expand_fail = (fail, annot, d) => {
    if (annot == null) {
        return `[ { "prim": "UNIT" }, { "prim": "FAILWITH" }, { "line": "${findLine(d)}" } ]`;
    }
    else {
        return `[ { "prim": "UNIT" }, { "prim": "FAILWITH", "annots": [${annot}] }, { "line": "${findLine(d)}" } ]`;
    }
};
const check_if = ifStatement => (macroIFCMPlist.includes(ifStatement) || macroIFlist.includes(ifStatement) || ifStatement === 'IF_SOME'); // TODO: IF_SOME
const expandIF = (ifInstr, ifTrue, ifFalse, annot, d) => {
    const annotation = !!annot ? `, "annots": [ ${annot} ] ` : ' ';
    switch (ifInstr) {
        case 'IFCMPEQ':
            return `[ { "prim": "COMPARE" }, { "prim": "EQ" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFCMPGE':
            return `[ { "prim": "COMPARE" }, { "prim": "GE" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFCMPGT':
            return `[ { "prim": "COMPARE" }, { "prim": "GT" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFCMPLE':
            return `[ { "prim": "COMPARE" }, { "prim": "LE" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFCMPLT':
            return `[ { "prim": "COMPARE" }, { "prim": "LT" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFCMPNEQ':
            return `[ { "prim": "COMPARE" }, { "prim": "NEQ" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFEQ':
            return `[ { "prim":"EQ" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFGE':
            return `[ { "prim": "GE" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFGT':
            return `[ { "prim": "GT" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFLE':
            return `[ { "prim": "LE" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFLT':
            return `[ { "prim": "LT" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IFNEQ':
            return `[ { "prim": "NEQ" }, { "prim": "IF", "args": [ [ ${ifTrue} ], [ ${ifFalse} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        case 'IF_SOME':
            return `[ { "prim": "IF_NONE", "args": [ [ ${ifFalse} ], [ ${ifTrue} ] ]${annotation}}, { "line": "${findLine(d)}" } ]`;
        default:
            return '';
    }
};
const check_dip = dip => DIPmatcher.test(dip);
const expandDIP = (dip, instruction, annot, d) => {
    let t = '';
    if (check_dip(dip)) {
        const c = dip.length - 2;
        for (let i = 0; i < c; i++) {
            t += '[ { "prim": "DIP", "args": [ ';
        }
        t = `${t} [ ${instruction} ] ]`;
        if (annot != null && !!annot) {
            t = `${t}, "annots": [ ${annot} ]`;
        }
        t += ' }]';
        for (let i = 0; i < c - 1; i++) {
            t += ` ] }, { "line": "${findLine(d)}" } ]`;
        }
        return t;
    }
    throw new Error(`Unexpected parameter for DIP processing: ${dip}`);
};
const check_other = word => (word == "UNPAIR" || word == "UNPAPAIR"); // TODO: dynamic matching
//UNPAIR and annotations follows a nonstandard format described in docs, and is dependent on the number of
//annotations given to the command, right now we're hard coding to fix the multisig contract swiftly, but a
//more general solution is required in the longterm.
const expand_other = (word, annot, d) => {
    if (word == 'UNPAIR') {
        if (annot == null) {
            // return '[ [ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ] ]';
            return `[ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ {"prim": "CDR" } ] }, { "line": "${findLine(d)}" } ]`;
        }
        else if (annot.length == 1) {
            // return `[ [ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot}] }, { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ]  } ] ]`;
            return `[ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot}] }, { "prim": "DIP", "args": [ { "prim": "CDR" } ] }, { "line": "${findLine(d)}" } ]`;
        }
        else if (annot.length == 2) {
            // return `[ [ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot[0]}] }, { "prim": "DIP", "args": [ [ { "prim": "CDR", "annots": [${annot[1]}] } ] ]  } ] ]`;
            return `[ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot[0]}] }, { "prim": "DIP", "args": [ { "prim": "CDR", "annots": [${annot[1]}] } ] }, { "line": "${findLine(d)}" } ]`;
        }
        else {
            return '';
        }
    }
    if (word == 'UNPAPAIR') {
        if (annot == null) {
            // return `[ [ { "prim": "DUP" },
            //                { "prim": "CAR" },
            //                { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ],
            //                {"prim":"DIP","args":[[[{"prim":"DUP"},{"prim":"CAR"},{"prim":"DIP","args":[[{"prim":"CDR"}]]}]]]}]`;
            return `[ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ { "prim": "CDR" } ] }, { "prim": "DIP", "args": [ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ { "prim": "CDR" } ] } ] }, { "line": "${findLine(d)}" } ]`;
        }
        else {
            // return `[ [ { "prim": "DUP" },
            //                { "prim": "CAR" },
            //                { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ],
            //                {"prim":"DIP","args":[[[{"prim":"DUP"},{"prim":"CAR"},{"prim":"DIP","args":[[{"prim":"CDR"}]],"annots": [${annot}]}]]]}]`;
            return `[ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ { "prim": "CDR" } ] }, { "prim": "DIP", "args": [ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ { "prim": "CDR" } ], "annots": [ ${annot} ] } ] }, { "line": "${findLine(d)}" } ]`;
        }
    }
};
const checkSetCadr = s => macroSETCADRconst.test(s);
const expandSetCadr = (word, annot, d) => nestSetCadr(word.slice(5, -1), d);
const nestSetCadr = (r, d) => {
    if (r.length === 0) {
        return '';
    }
    const c = r.charAt(0);
    if (r.length === 1) {
        if (c === 'A') {
            return `[ { "prim": "CDR", "annots": [ "@%%" ] }, { "prim": "SWAP" }, { "prim": "PAIR", "annots": [ "%", "%@" ] }, { "line": "${findLine(d)}" } ]`;
        }
        else if (c === 'D') {
            return `[ { "prim": "CAR", "annots": [ "@%%" ] }, { "prim": "PAIR", "annots": [ "%@", "%" ] }, { "line": "${findLine(d)}" } ]`;
        }
    }
    if (c === 'A') {
        return `[ { "prim": "DUP" }, { "prim": "DIP", "args": [ [ { "prim": "CAR", "annots": [ "@%%" ] }, ${nestSetCadr(r.slice(1), d)} ] ] }, { "prim": "CDR", "annots": [ "@%%" ] }, { "prim": "SWAP" }, { "prim": "PAIR", "annots": [ "%@", "%@" ] }, { "line": "${findLine(d)}" } ]`;
    }
    else if (c === 'D') {
        return `[ { "prim": "DUP" }, { "prim": "DIP", "args": [ [ { "prim": "CDR", "annots": [ "@%%" ] }, ${nestSetCadr(r.slice(1), d)} ] ] }, { "prim": "CAR", "annots": [ "@%%" ] }, { "prim": "PAIR", "annots": [ "%@", "%@" ] }, { "line": "${findLine(d)}" } ]`;
    }
};
const checkKeyword = word => {
    if (check_assert(word)) {
        return true;
    }
    if (check_compare(word)) {
        return true;
    }
    if (check_dip(word)) {
        return true;
    }
    if (check_dup(word)) {
        return true;
    }
    if (check_fail(word)) {
        return true;
    }
    if (check_if(word)) {
        return true;
    }
    if (checkC_R(word)) {
        return true;
    }
    if (check_other(word)) {
        return true;
    }
    if (checkSetCadr(word)) {
        return true;
    }
};
const expandKeyword = (word, annot, d) => {
    if (checkC_R(word)) {
        return expandC_R(word, annot, d);
    }
    if (check_assert(word)) {
        return expand_assert(word, annot, d);
    }
    if (check_compare(word)) {
        return expand_cmp(word, annot, d);
    }
    if (check_dip(word)) {
        return expandDIP(word, null, annot, d);
    }
    if (check_dup(word)) {
        return expand_dup(word, annot, d);
    }
    if (check_fail(word)) {
        return expand_fail(word, annot, d);
    }
    if (check_if(word)) {
        return expandIF(word, "", "", annot, d);
    }
    if (check_other(word)) {
        return expand_other(word, annot, d);
    }
    if (checkSetCadr(word)) {
        return expandSetCadr(word, annot, d);
    }
};
/**
 * Given a int, convert it to JSON.
 * Example: "3" -> { "int": "3" }
 */
const intToJson = d => `{ "int": "${parseInt(d[0])}", "line": "${findLine(d)}" }`;
/**
 * Given a string, convert it to JSON.
 * Example: "string" -> "{ "string": "blah" }"
 */
const stringToJson = d => `{ "string": ${d[0]}, "line": "${findLine(d)}" }`;
/**
 * Given a keyword, convert it to JSON.
 * Example: "int" -> "{ "prim" : "int" }"
 * DOESN'T WORK!
 */
const keywordToJson = d => {
    const word = d[0].toString();
    if (d.length == 1) {
        if (checkKeyword(word)) {
            return [expandKeyword(word, null, d)];
        }
        else {
            return `{ "prim": "${d[0]}", "line": "${findLine(d)}" }`;
        }
    } else {
        const annot = d[1].map(x => `"${x[1]}"`);
        if (checkKeyword(word)) {
            return [expandKeyword(word, annot, d)];
        }
        else {
            return `{ "prim": "${d[0]}", "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
        }
    }
};
/**
 * Given a keyword with one argument, convert it to JSON.
 * Example: "option int" -> "{ prim: option, args: [int] }"
 */
const singleArgKeywordToJson = d => {
    if (d.length > 3) {
        if (d[1].length > 0) {
            const annot = d[1].map(x => `"${x[1]}"`);
            return `{ "prim": "${d[0]}", "args": [ ${d[3]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
        } else {
            return `{ "prim": "${d[0]}", "args": [ ${d[3]} ], "line": "${findLine(d)}" }`;
        }
    } else {
        return `{ "prim": "${d[0]}", "args": [ ${d[2]} ], "line": "${findLine(d)}" }`;
    }
};
const comparableTypeToJson = d => {
    const annot = d[3].map(x => `"${x[1]}"`);
    return `{ "prim": "${d[2]}", "annots": [${annot}], "line": "${findLine(d)}" }`;
};
const singleArgTypeKeywordWithParenToJson = d => {
    const annot = d[3].map(x => `"${x[1]}"`);
    return `{ "prim": "${d[2]}", "args": [ ${d[5]} ], "annots": [${annot}], "line": "${findLine(d)}" }`;
};
const singleArgInstrKeywordToJson = d => {
    const word = `${d[0].toString()}`;
    if (check_dip(word)) {
        return expandDIP(word, d[2], null, d);
    }
    else {
        return `{ "prim": "${d[0]}", "args": [ [ ${d[2]} ] ], "line": "${findLine(d)}" }`;
    }
};
const singleArgTypeKeywordToJson = d => {
    const word = `${d[0].toString()}`;
    const annot = d[1].map(x => `"${x[1]}"`);
    if (check_dip(word)) {
        return expandDIP(word, d[2], annot, d);
    }
    else {
        return `{ "prim": "${d[0]}", "args": [ ${d[3]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
    }
};
/**
 * Given a keyword with one argument and parentheses, convert it to JSON.
 * Example: "(option int)" -> "{ prim: option, args: [{prim: int}] }"
 * Also: (option (mutez))
 */
const singleArgKeywordWithParenToJson = d => `{ "prim": "${d[2]}", "args": [ ${d[(4 + ((d.length === 7) ? 0 : 2))]} ], "line": "${findLine(d)}" }`;
/**
 * Given a keyword with two arguments, convert it into JSON.
 * Example: "Pair unit instruction" -> "{ prim: Pair, args: [{prim: unit}, {prim: instruction}] }"
 */
const doubleArgKeywordToJson = d => `{ "prim": "${d[0]}", "args": [ ${d[2]}, ${d[4]} ], "line": "${findLine(d)}" }`;
const doubleArgParenKeywordToJson = d => `{ "prim": "${d[0]}", "args": [ ${d[4]}, ${d[8]} ], "line": "${findLine(d)}" }`;
const doubleArgInstrKeywordToJson = d => {
    const word = `${d[0].toString()}`;
    if (check_if(word)) {
        return expandIF(word, d[2], d[4], null, d);
    }
    else {
        return `{ "prim": "${d[0]}", "args": [ [ ${d[2]} ], [ ${d[4]} ] ], "line": "${findLine(d)}" }`;
    }
};
/**
 * Given a keyword with two arguments and parentheses, convert it into JSON.
 * Example: "(Pair unit instruction)" -> "{ prim: Pair, args: [{prim: unit}, {prim: instruction}] }"
 */
const doubleArgKeywordWithParenToJson = d => `{ "prim": "${d[2]}", "args": [ ${d[4]}, ${d[6]} ], "line": "${findLine(d)}" }`;
/**
 * Given a keyword with three arguments, convert it into JSON.
 * Example: "LAMBDA key unit {DIP;}" -> "{ prim: LAMBDA, args: [{prim: key}, {prim: unit}, {prim: DIP}] }"
 */
const tripleArgKeyWordToJson = d => `{ "prim": "${d[0]}", "args": [ ${d[2]}, ${d[4]}, [ ${d[6]} ] ], "line": "${findLine(d)}" }`;
/**
 * Given a keyword with three arguments and parentheses, convert it into JSON.
 * Example: "(LAMBDA key unit {DIP;})" -> "{ prim: LAMBDA, args: [{prim: key}, {prim: unit}, {prim: DIP}] }"
 */
const tripleArgKeyWordWithParenToJson = d => `{ "prim": "${d[0]}", "args": [ ${d[2]}, ${d[4]}, ${d[6]} ], "line": "${findLine(d)}" }`;
const nestedArrayChecker = x => {
    if (Array.isArray(x) && Array.isArray(x[0])) { // handles double array nesting
        return x[0];
    }
    else {
        return x;
    }
};
/**
 * Given a list of michelson instructions, convert it into JSON.
 * Example: "{CAR; NIL operation; PAIR;}" ->
 * [ '{ prim: CAR }',
 * '{ prim: NIL, args: [{ prim: operation }] }',
 * '{ prim: PAIR }' ]
 */
const instructionSetToJsonNoSemi = d => { return d[2].map(x => x[0]).concat(d[3]).map(x => nestedArrayChecker(x)); };
const instructionSetToJsonSemi = d => { return d[2].map(x => x[0]).map(x => nestedArrayChecker(x)); };
/**
 * parameter, storage, code
 */
//const scriptToJson = d => `[ ${d[0]}, ${d[2]}, { "prim": "code", "args": [ [ ${d[4]} ] ] } ]`;
const scriptToJson = d => `[ ${d[0]}, ${d[2]}, { "prim": "code", "args": [ ${d[4]} ] } ]`;
const doubleArgTypeKeywordToJson = d => {
    const annot = d[1].map(x => `"${x[1]}"`);
    return `{ "prim": "${d[0]}", "args": [ ${d[4]}, ${d[6]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
};
const doubleArgTypeKeywordWithParenToJson = d => {
    const annot = d[3].map(x => `"${x[1]}"`);
    return `{ "prim": "${d[2]}", "args": [ ${d[5]}, ${d[7]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
};
const tripleArgTypeKeyWordToJson = d => {
    const annot = d[1].map(x => `"${x[1]}"`);
    return `{ "prim": "${d[0]}", "args": [ ${d[3]}, ${d[5]}, ${d[7]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
};
const pushToJson = d => {
    return `{ "prim": "${d[0]}", "args": [ ${d[2]}, [] ], "line": "${findLine(d)}" }`;
};
const pushWithAnnotsToJson = d => {
    const annot = d[1].map(x => `"${x[1]}"`);
    return `{ "prim": "PUSH", "args": [ ${d[3]}, ${d[5]} ], "annots": [ ${annot} ], "line": "${findLine(d)}" }`;
};
const dipnToJson = d => (d.length > 4) ? `{ "prim": "${d[0]}", "args": [ { "int": "${d[2]}" }, [ ${d[4]} ] ], "line": "${findLine(d)}" }` : `{ "prim": "${d[0]}", "args": [ ${d[2]} ], "line": "${findLine(d)}" }`;
const dignToJson = d => `{ "prim": "${d[0]}", "args": [ { "int": "${d[2]}" } ], "line": "${findLine(d)}" }`;
const dropnToJson = d => `{ "prim": "${d[0]}", "args": [ { "int": "${d[2]}" } ], "line": "${findLine(d)}" }`;
// const subContractToJson = d => `{ "prim":"CREATE_CONTRACT", "args": [ [ ${d[4]}, ${d[6]}, {"prim": "code" , "args":[ [ ${d[8]} ] ] } ] ] }`;
const subContractToJson = d => `{ "prim":"CREATE_CONTRACT", "args": [ [ ${d[4]}, ${d[6]}, {"prim": "code" , "args":[ ${d[8]} ] } ] ], "line": "${findLine(d)}" }`;
const instructionListToJson = d => {
    const instructionOne = [d[2]];
    const instructionList = d[3].map(x => x[3]);
    return instructionOne.concat(instructionList).map(x => nestedArrayChecker(x));
};

const isIterable = obj => {
  // checks for null and undefined
  if (obj == null) {
    return false;
  }
  return typeof obj[Symbol.iterator] === 'function';
};

const findLine = d => {
  if (!isIterable(d)) {
    return "-1";
  }
  const lineNums = new Set();
  for (const i of d) {
    if (i != null && i.hasOwnProperty('line') && !isNaN(parseInt(i.line))) {
      lineNums.add(i.line);
    }
  }
  if (lineNums.size > 1) {
    var output = "[ ";
    for (const i of lineNums) {
      output = output.concat(i).concat(", ");
    }
    output = output.substring(0, output.length - 2).concat(" ]");
    return output;
  } else if (lineNums.size == 1) {
    return lineNums.values().next().value;
  } else {
    return "-1";
  };
};
%}
