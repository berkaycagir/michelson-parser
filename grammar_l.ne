@lexer lexer
@builtin "whitespace.ne"

main -> instruction {% id %}
      | data {% id %}
      | type {% id %}
      | parameter {% id %}
      | storage {% id %}
      | code {% id %}
      | script {% id %}
      | parameterValue {% id %}
      | storageValue {% id %}
      | typeData {% id %}

script -> parameter _ storage _ code {% scriptToJson %}

parameterValue -> %parameter _ typeData _ semicolons {% singleArgKeywordToJson %}

storageValue -> %storage _ typeData _ semicolons {% singleArgKeywordToJson %}

parameter -> %parameter _ type _ semicolons {% singleArgKeywordToJson %}

storage -> %storage _ type _ semicolons {% singleArgKeywordToJson %}

code -> %code _ subInstruction _ semicolons _ {% function (d) { return d[2]; } %}
      | %code _ "{};" {% function (d) { return "code {}"; } %}

type -> %comparableType {% keywordToJson %}
       | %constantType {% keywordToJson %}
       | %singleArgType _ type {% singleArgKeywordToJson %}
       | %lparen _ %singleArgType _ type _ %rparen {% singleArgKeywordWithParenToJson %}
       | %lparen _ %singleArgType _ %lparen _ type _ %rparen _ %rparen {% singleArgKeywordWithParenToJson %}
       | %doubleArgType _ type _ type {% doubleArgKeywordToJson %}
       | %lparen _ %doubleArgType _ type _ type _ %rparen {% doubleArgKeywordWithParenToJson %}

typeData -> %singleArgType _ typeData {% singleArgKeywordToJson %}
          | %lparen _ %singleArgType _ typeData _ %rparen {% singleArgKeywordWithParenToJson %}
          | %doubleArgType _ typeData _ typeData {% doubleArgKeywordToJson %}
          | %lparen _ %doubleArgType _ typeData _ typeData _ %rparen {% doubleArgKeywordWithParenToJson %}
          | subTypeData {% id %}
          | subTypeElt {% id %}
          | %number {% intToJson %}
          | %string {% stringToJson %}
          | %lbrace _ %rbrace {% function(d) { return []; } %}

data -> %constantData {% keywordToJson %}
      | %singleArgData _ data {% singleArgKeywordToJson %}
      | %lparen _ %singleArgData _ data _ %rparen {% singleArgKeywordWithParenToJson %}
      | %doubleArgData _ data _ data {% doubleArgKeywordToJson %}
      | %lparen _ %doubleArgData _ data _ data _ %rparen {% doubleArgKeywordWithParenToJson %}
      | subData  {% id %}
      | subElt {% id %}
      | %number {% intToJson %}
      | %string {% stringToJson %}

subTypeData -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}

subTypeElt -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}

typeElt -> %elt _ typeData _ typeData {% doubleArgKeywordToJson %}

subInstruction -> %lbrace _ %rbrace {% function(d) { return ""; } %}
                | %lbrace _ instruction _ %rbrace {% function(d) { return d[2]; } %}

instructions -> %baseInstruction
              | %macroCADR
              | %macroDIP
              | %macroDUP
              | %macroSETCADR
              | %macroASSERTlist

instruction -> instructions {% keywordToJson %}
             | instructions _ subInstruction {% singleArgInstrKeywordToJson %}
             | instructions _ type {% singleArgKeywordToJson %}
             | instructions _ data {% singleArgKeywordToJson %}
             | instructions _ type _ type _ subInstruction {% tripleArgKeyWordToJson %}
             | instructions _ subInstruction _ subInstruction {% doubleArgInstrKeywordToJson %}
             | instructions _ type _ type {% doubleArgKeywordToJson %}
             | "PUSH" _ type _ data {% doubleArgKeywordToJson %}
             | "PUSH" _ type _ %lbrace %rbrace {% pushToJson %}
             | "DROP" {% keywordToJson %}
             | %lbrace _ %rbrace {% function(d) { return ""; } %}
             | "CREATE_CONTRACT" _ %lbrace _ parameter _ storage _ code _ %rbrace {% subContractToJson %}
             | "EMPTY_MAP" _ type _ type {% doubleArgKeywordToJson %}
             | "EMPTY_MAP" _ %lparen _ type _ %rparen _ type {% doubleArgParenKeywordToJson %}

subData -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}

subElt -> %lbrace _ %rbrace {% function(d) { return "[]"; } %}

elt -> %elt _ data _ data {% doubleArgKeywordToJson %}

semicolons -> %semicolon {% id %}


@{%
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
%}
