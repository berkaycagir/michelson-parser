// Generated automatically by nearley, version 2.20.1
// http://github.com/Hardmath123/nearley
(function () {
function id(x) { return x[0]; }

const moo = require("moo");

const macroCADRconst = /C[AD]+R/;
const macroSETCADRconst = /SET_C[AD]+R/;
const macroDIPconst = /DII+P/;
const macroDUPconst = /DUU+P/;
const DIPmatcher = new RegExp(macroDIPconst);
const DUPmatcher = new RegExp(macroDUPconst);
const macroASSERTlistConst = ['ASSERT', 'ASSERT_EQ', 'ASSERT_NEQ', 'ASSERT_GT', 'ASSERT_LT', 'ASSERT_GE', 'ASSERT_LE', 'ASSERT_NONE', 'ASSERT_SOME', 'ASSERT_LEFT', 'ASSERT_RIGHT', 'ASSERT_CMPEQ', 'ASSERT_CMPNEQ', 'ASSERT_CMPGT', 'ASSERT_CMPLT', 'ASSERT_CMPGE', 'ASSERT_CMPLE'];
const macroIFCMPlist = ['IFCMPEQ', 'IFCMPNEQ', 'IFCMPLT', 'IFCMPGT', 'IFCMPLE', 'IFCMPGE'];
const macroCMPlist = ['CMPEQ', 'CMPNEQ', 'CMPLT', 'CMPGT', 'CMPLE', 'CMPGE'];
const macroIFlist = ['IFEQ', 'IFNEQ', 'IFLT', 'IFGT', 'IFLE', 'IFGE'];
const lexer = moo.compile({
    annot: /[\@\%\:][a-z_A-Z0-9]+/,
    lparen: '(',
    rparen: ')',
    lbrace: '{',
    rbrace: '}',
    ws: /[ \t]+/,
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

function scriptToJson(d) {
  return `[ ${d[0]}, ${d[2]}, { "prim": "code", "args": [ [ ${d[4]} ] ] } ]`;
};

function singleArgKeywordToJson(d) {
  return `{ "prim": "${d[0]}", "args": [ ${d[2]} ] }`;
};

function keywordToJson(d) {
    const word = d[0].toString();
    if (d.length == 1) {
        if (checkKeyword(word)) {
            return [expandKeyword(word, null)];
        }
        else {
            return `{ "prim": "${d[0]}" }`;
        }
    }
    else {
        const annot = d[1].map(x => `"${x[1]}"`);
        if (checkKeyword(word)) {
            return [expandKeyword(word, annot)];
        }
        else {
            return `{ "prim": "${d[0]}", "annots": [${annot}] }`;
        }
    }
};

function singleArgKeywordWithParenToJson(d) {
  return `{ "prim": "${d[2]}", "args": [ ${d[(4 + ((d.length === 7) ? 0 : 2))]} ] }`;
};

function doubleArgKeywordToJson(d) {
  return `{ "prim": "${d[0]}", "args": [ ${d[2]}, ${d[4]} ] }`;
};

function doubleArgKeywordWithParenToJson(d) {
  return `{ "prim": "${d[2]}", "args": [ ${d[4]}, ${d[6]} ] }`;
};

function intToJson(d) {
  return `{ "int": "${parseInt(d[0])}" }`;
};

function stringToJson(d) {
  return `{ "string": ${d[0]} }`;
};

function singleArgInstrKeywordToJson(d) {
    const word = `${d[0].toString()}`;
    if (check_dip(word)) {
        return expandDIP(word, d[2]);
    }
    else {
        return `{ "prim": "${d[0]}", "args": [ [ ${d[2]} ] ] }`;
    }
};

function tripleArgKeyWordToJson(d) {
  return `{ "prim": "${d[0]}", "args": [ ${d[2]}, ${d[4]}, [${d[6]}] ] }`;
};

function doubleArgInstrKeywordToJson(d) {
    const word = `${d[0].toString()}`;
    if (check_if(word)) {
        return expandIF(word, d[2], d[4]);
    }
    else {
        return `{ "prim": "${d[0]}", "args": [ [${d[2]}], [${d[4]}] ] }`;
    }
};

function pushToJson(d) {
  return `{ "prim": "${d[0]}", "args": [${d[2]}, []] }`;
};

function subContractToJson(d) {
  return `{ "prim":"CREATE_CONTRACT", "args": [ [ ${d[4]}, ${d[6]}, {"prim": "code" , "args":[ [ ${d[8]} ] ] } ] ] }`;
};

function doubleArgParenKeywordToJson(d) {
  return `{ "prim": "${d[0]}", "args": [ ${d[4]}, ${d[8]} ] }`;
};

function checkKeyword(word) {
    if (check_assert(word) || check_compare(word) || check_dip(word) || check_dup(word) ||
        check_fail(word) || check_if(word) || checkC_R(word) || check_other(word) ||
        checkSetCadr(word)) {
        return true;
    }
};

function check_assert(assert) {
  return macroASSERTlistConst.includes(assert);
};

function check_compare(cmp) {
  return macroCMPlist.includes(cmp);
};

function check_dip(dip) {
  return DIPmatcher.test(dip);
};

function check_dup(dup) {
  return DUPmatcher.test(dup);
};

function check_fail(fail) {
  return fail === "FAIL";
};

function check_if(ifStatement) {
  return (macroIFCMPlist.includes(ifStatement) || macroIFlist.includes(ifStatement) || ifStatement === 'IF_SOME');
  // TODO: IF_SOME
};

function checkC_R(c_r) {
  var pattern = new RegExp('^C(A|D)(A|D)+R$'); // TODO
  return pattern.test(c_r);
};

function check_other(word) {
  return (word == "UNPAIR" || word == "UNPAPAIR");
  // TODO: dynamic matching
  //UNPAIR and annotations follows a nonstandard format described in docs, and is dependent on the number of
  //annotations given to the command, right now we're hard coding to fix the multisig contract swiftly, but a
  //more general solution is required in the longterm.
};

function checkSetCadr(s) {
  return macroSETCADRconst.test(s);
};

function expandKeyword(word, annot) {
    if (checkC_R(word)) {
        return expandC_R(word, annot);
    }
    if (check_assert(word)) {
        return expand_assert(word, annot);
    }
    if (check_compare(word)) {
        return expand_cmp(word, annot);
    }
    if (check_dip(word)) {
        return expandDIP(word, annot);
    }
    if (check_dup(word)) {
        return expand_dup(word, annot);
    }
    if (check_fail(word)) {
        return expand_fail(word, annot);
    }
    if (check_if(word)) {
        return expandIF(word, annot);
    }
    if (check_other(word)) {
        return expand_other(word, annot);
    }
    if (checkSetCadr(word)) {
        return expandSetCadr(word, annot);
    }
};

function expand_other(word, annot) {
    if (word == 'UNPAIR') {
        if (annot == null) {
            return '[ [ { "prim": "DUP" }, { "prim": "CAR" }, { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ] ]';
        }
        else if (annot.length == 1) {
            return `[ [ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot}] }, { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ]  } ] ]`;
        }
        else if (annot.length == 2) {
            return `[ [ { "prim": "DUP" }, { "prim": "CAR", "annots": [${annot[0]}] }, { "prim": "DIP", "args": [ [ { "prim": "CDR", "annots": [${annot[1]}] } ] ]  } ] ]`;
        }
        else {
            return '';
        }
    }
    if (word == 'UNPAPAIR') {
        if (annot == null) {
            return `[ [ { "prim": "DUP" },
                            { "prim": "CAR" },
                            { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ],
                            {"prim":"DIP","args":[[[{"prim":"DUP"},{"prim":"CAR"},{"prim":"DIP","args":[[{"prim":"CDR"}]]}]]]}]`;
        }
        else {
            return `[ [ { "prim": "DUP" },
                            { "prim": "CAR" },
                            { "prim": "DIP", "args": [ [ { "prim": "CDR" } ] ] } ],
                            {"prim":"DIP","args":[[[{"prim":"DUP"},{"prim":"CAR"},{"prim":"DIP","args":[[{"prim":"CDR"}]],"annots": [${annot}]}]]]}]`;
        }
    }
};
var grammar = {
    Lexer: lexer,
    ParserRules: [
    {"name": "_$ebnf$1", "symbols": []},
    {"name": "_$ebnf$1", "symbols": ["_$ebnf$1", "wschar"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "_", "symbols": ["_$ebnf$1"], "postprocess": function(d) {return null;}},
    {"name": "__$ebnf$1", "symbols": ["wschar"]},
    {"name": "__$ebnf$1", "symbols": ["__$ebnf$1", "wschar"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "__", "symbols": ["__$ebnf$1"], "postprocess": function(d) {return null;}},
    {"name": "wschar", "symbols": [/[ \t\n\v\f]/], "postprocess": id},
    {"name": "main", "symbols": ["instruction"], "postprocess": id},
    {"name": "main", "symbols": ["data"], "postprocess": id},
    {"name": "main", "symbols": ["type"], "postprocess": id},
    {"name": "main", "symbols": ["parameter"], "postprocess": id},
    {"name": "main", "symbols": ["storage"], "postprocess": id},
    {"name": "main", "symbols": ["code"], "postprocess": id},
    {"name": "main", "symbols": ["script"], "postprocess": id},
    {"name": "main", "symbols": ["parameterValue"], "postprocess": id},
    {"name": "main", "symbols": ["storageValue"], "postprocess": id},
    {"name": "main", "symbols": ["typeData"], "postprocess": id},
    {"name": "script", "symbols": ["parameter", "_", "storage", "_", "code"], "postprocess": scriptToJson},
    {"name": "parameterValue", "symbols": [(lexer.has("parameter") ? {type: "parameter"} : parameter), "_", "typeData", "_", "semicolons"], "postprocess": singleArgKeywordToJson},
    {"name": "storageValue", "symbols": [(lexer.has("storage") ? {type: "storage"} : storage), "_", "typeData", "_", "semicolons"], "postprocess": singleArgKeywordToJson},
    {"name": "parameter", "symbols": [(lexer.has("parameter") ? {type: "parameter"} : parameter), "_", "type", "_", "semicolons"], "postprocess": singleArgKeywordToJson},
    {"name": "storage", "symbols": [(lexer.has("storage") ? {type: "storage"} : storage), "_", "type", "_", "semicolons"], "postprocess": singleArgKeywordToJson},
    {"name": "code", "symbols": [(lexer.has("code") ? {type: "code"} : code), "_", "subInstruction", "_", "semicolons", "_"], "postprocess": function (d) { return d[2]; }},
    {"name": "code", "symbols": [(lexer.has("code") ? {type: "code"} : code), "_", {"literal":"{};"}], "postprocess": function (d) { return "code {}"; }},
    {"name": "type", "symbols": [(lexer.has("comparableType") ? {type: "comparableType"} : comparableType)], "postprocess": keywordToJson},
    {"name": "type", "symbols": [(lexer.has("constantType") ? {type: "constantType"} : constantType)], "postprocess": keywordToJson},
    {"name": "type", "symbols": [(lexer.has("singleArgType") ? {type: "singleArgType"} : singleArgType), "_", "type"], "postprocess": singleArgKeywordToJson},
    {"name": "type", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("singleArgType") ? {type: "singleArgType"} : singleArgType), "_", "type", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": singleArgKeywordWithParenToJson},
    {"name": "type", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("singleArgType") ? {type: "singleArgType"} : singleArgType), "_", (lexer.has("lparen") ? {type: "lparen"} : lparen), "_", "type", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen), "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": singleArgKeywordWithParenToJson},
    {"name": "type", "symbols": [(lexer.has("doubleArgType") ? {type: "doubleArgType"} : doubleArgType), "_", "type", "_", "type"], "postprocess": doubleArgKeywordToJson},
    {"name": "type", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("doubleArgType") ? {type: "doubleArgType"} : doubleArgType), "_", "type", "_", "type", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": doubleArgKeywordWithParenToJson},
    {"name": "typeData", "symbols": [(lexer.has("singleArgType") ? {type: "singleArgType"} : singleArgType), "_", "typeData"], "postprocess": singleArgKeywordToJson},
    {"name": "typeData", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("singleArgType") ? {type: "singleArgType"} : singleArgType), "_", "typeData", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": singleArgKeywordWithParenToJson},
    {"name": "typeData", "symbols": [(lexer.has("doubleArgType") ? {type: "doubleArgType"} : doubleArgType), "_", "typeData", "_", "typeData"], "postprocess": doubleArgKeywordToJson},
    {"name": "typeData", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("doubleArgType") ? {type: "doubleArgType"} : doubleArgType), "_", "typeData", "_", "typeData", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": doubleArgKeywordWithParenToJson},
    {"name": "typeData", "symbols": ["subTypeData"], "postprocess": id},
    {"name": "typeData", "symbols": ["subTypeElt"], "postprocess": id},
    {"name": "typeData", "symbols": [(lexer.has("number") ? {type: "number"} : number)], "postprocess": intToJson},
    {"name": "typeData", "symbols": [(lexer.has("string") ? {type: "string"} : string)], "postprocess": stringToJson},
    {"name": "typeData", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return []; }},
    {"name": "data", "symbols": [(lexer.has("constantData") ? {type: "constantData"} : constantData)], "postprocess": keywordToJson},
    {"name": "data", "symbols": [(lexer.has("singleArgData") ? {type: "singleArgData"} : singleArgData), "_", "data"], "postprocess": singleArgKeywordToJson},
    {"name": "data", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("singleArgData") ? {type: "singleArgData"} : singleArgData), "_", "data", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": singleArgKeywordWithParenToJson},
    {"name": "data", "symbols": [(lexer.has("doubleArgData") ? {type: "doubleArgData"} : doubleArgData), "_", "data", "_", "data"], "postprocess": doubleArgKeywordToJson},
    {"name": "data", "symbols": [(lexer.has("lparen") ? {type: "lparen"} : lparen), "_", (lexer.has("doubleArgData") ? {type: "doubleArgData"} : doubleArgData), "_", "data", "_", "data", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen)], "postprocess": doubleArgKeywordWithParenToJson},
    {"name": "data", "symbols": ["subData"], "postprocess": id},
    {"name": "data", "symbols": ["subElt"], "postprocess": id},
    {"name": "data", "symbols": [(lexer.has("number") ? {type: "number"} : number)], "postprocess": intToJson},
    {"name": "data", "symbols": [(lexer.has("string") ? {type: "string"} : string)], "postprocess": stringToJson},
    {"name": "subTypeData", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return "[]"; }},
    {"name": "subTypeElt", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return "[]"; }},
    {"name": "typeElt", "symbols": [(lexer.has("elt") ? {type: "elt"} : elt), "_", "typeData", "_", "typeData"], "postprocess": doubleArgKeywordToJson},
    {"name": "subInstruction", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return ""; }},
    {"name": "subInstruction", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", "instruction", "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return d[2]; }},
    {"name": "instructions", "symbols": [(lexer.has("baseInstruction") ? {type: "baseInstruction"} : baseInstruction)]},
    {"name": "instructions", "symbols": [(lexer.has("macroCADR") ? {type: "macroCADR"} : macroCADR)]},
    {"name": "instructions", "symbols": [(lexer.has("macroDIP") ? {type: "macroDIP"} : macroDIP)]},
    {"name": "instructions", "symbols": [(lexer.has("macroDUP") ? {type: "macroDUP"} : macroDUP)]},
    {"name": "instructions", "symbols": [(lexer.has("macroSETCADR") ? {type: "macroSETCADR"} : macroSETCADR)]},
    {"name": "instructions", "symbols": [(lexer.has("macroASSERTlist") ? {type: "macroASSERTlist"} : macroASSERTlist)]},
    {"name": "instruction", "symbols": ["instructions"], "postprocess": keywordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "subInstruction"], "postprocess": singleArgInstrKeywordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "type"], "postprocess": singleArgKeywordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "data"], "postprocess": singleArgKeywordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "type", "_", "type", "_", "subInstruction"], "postprocess": tripleArgKeyWordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "subInstruction", "_", "subInstruction"], "postprocess": doubleArgInstrKeywordToJson},
    {"name": "instruction", "symbols": ["instructions", "_", "type", "_", "type"], "postprocess": doubleArgKeywordToJson},
    {"name": "instruction", "symbols": [{"literal":"PUSH"}, "_", "type", "_", "data"], "postprocess": doubleArgKeywordToJson},
    {"name": "instruction", "symbols": [{"literal":"PUSH"}, "_", "type", "_", (lexer.has("lbrace") ? {type: "lbrace"} : lbrace), (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": pushToJson},
    {"name": "instruction", "symbols": [{"literal":"DROP"}], "postprocess": keywordToJson},
    {"name": "instruction", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return ""; }},
    {"name": "instruction", "symbols": [{"literal":"CREATE_CONTRACT"}, "_", (lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", "parameter", "_", "storage", "_", "code", "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": subContractToJson},
    {"name": "instruction", "symbols": [{"literal":"EMPTY_MAP"}, "_", "type", "_", "type"], "postprocess": doubleArgKeywordToJson},
    {"name": "instruction", "symbols": [{"literal":"EMPTY_MAP"}, "_", (lexer.has("lparen") ? {type: "lparen"} : lparen), "_", "type", "_", (lexer.has("rparen") ? {type: "rparen"} : rparen), "_", "type"], "postprocess": doubleArgParenKeywordToJson},
    {"name": "subData", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return "[]"; }},
    {"name": "subElt", "symbols": [(lexer.has("lbrace") ? {type: "lbrace"} : lbrace), "_", (lexer.has("rbrace") ? {type: "rbrace"} : rbrace)], "postprocess": function(d) { return "[]"; }},
    {"name": "elt", "symbols": [(lexer.has("elt") ? {type: "elt"} : elt), "_", "data", "_", "data"], "postprocess": doubleArgKeywordToJson},
    {"name": "semicolons", "symbols": [(lexer.has("semicolon") ? {type: "semicolon"} : semicolon)], "postprocess": id}
]
  , ParserStart: "main"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
