@builtin "whitespace.ne"
@builtin "number.ne"
@builtin "string.ne"

main -> parameter _ storage _ code _ {% function(d) { return JSON.stringify({"parameter": d[0], "storage": d[2], "code": d[4]}) } %}

parameter -> "parameter" __ type _ ";" {% function(d) { return d[2] } %}

storage -> "storage" __ type _ ";" {% function(d) { return d[2] } %}

code -> "code" _ "{" _ ins:* "}" _ ";" {% code %}

ins -> instruction _ ";" _ {% ins %}

#comment -> _ "#" [^\n]:* {% function(d) { return null; } %}

type -> "address" {% function(d) { return 'address' } %}
      | "(" _ "big_map" __ type __ type _ ")" {% function(d) { return [ "big_map", [ [ d[4][0], d[6][0] ] ] ] } %}
      | "bls12_381_fr" {% function(d) { return 'bls12_381_fr' } %}
      | "bls12_381_g1" {% function(d) { return 'bls12_381_g1' } %}
      | "bls12_381_g2" {% function(d) { return 'bls12_381_g2' } %}
      | "bool" {% function(d) { return 'bool' } %}
      | "bytes" {% function(d) { return 'bytes' } %}
      | "chain_id" {% function(d) { return 'chain_id' } %}
      | "contract" __ type {% function(d) { return { 'contract': d[2][0] } } %}
      | "int" {% function(d) { return 'int' } %}
      | "key" {% function(d) { return 'key' } %}
      | "key_hash" {% function(d) { return 'key_hash' } %}
      | "lambda" {% function(d) { return 'lambda' } %}
      | "list" __ type {% function(d) { return [ "list", [ [ d[4][0], d[6][0] ] ] ] } %}
      | "map" __ type __ type {% function(d) { return [ "map", [ [ d[4][0], d[6][0] ] ] ] } %}
      | "mutez" {% function(d) { return 'mutez' } %}
      | "nat" {% function(d) { return 'nat' } %}
      | "never" {% function(d) { return 'never' } %}
      | "operation" {% function(d) { return 'operation' } %}
      | "option" __ type {% function(d) { return { 'option': d[2][0] } } %}
      | "(" _ "or" __ type __ type _ ")" {% function(d) { return [ "or", [ [ d[4][0], d[6][0] ] ] ] } %}
      | "(" _ "pair" __ type __ type _ ")" {% function(d) { return [ "pair", [ [ d[4][0], d[6][0] ] ] ] } %}
      | "sapling_state" __ type {% function(d) { return { 'sapling_state': d[2][0] } } %}
      | "sapling_transaction" __ type {% function(d) { return { 'sapling_transaction': d[2][0] } } %}
      | "set" __ type {% function(d) { return { 'set': d[2][0] } } %}
      | "signature" {% function(d) { return 'signature' } %}
      | "string" {% function(d) { return 'string' } %}
      | "ticket" __ type {% function(d) { return { 'ticket': d[2][0] } } %}
      | "timestamp" {% function(d) { return 'timestamp' } %}
      | "unit" {% function(d) { return 'unit' } %}

instruction -> "ABS"
             | "ADD"
             | "ADDRESS"
             | "AMOUNT"
             | "AND"
             | "APPLY"
             | "BALANCE"
             | "BLAKE2B"
             | "CAR"
             | "CDR"
             | "CHAIN_ID"
             | "CHECK_SIGNATURE"
             | "COMPARE"
             | "CONCAT"
             | "CONS"
             | "CONTRACT" __ type {% single_param %}
             | "CREATE_CONTRACT" __ "{" _ "parameter" __ type _ ";" _ "storage" __ type _ ";" _ "code" __ instruction _ "}"
             | "DIG" __ int {% single_param %}
             | "DIP" _ "{" _ ins "}" {% dip %}
             | "DIP" __ int __ "{" _ ins "}" {% dipi %}
             | "DROP"
             | "DROP" __ int {% single_param %}
             | "DUG" __ int {% single_param %}
             | "DUP"
             | "DUP" __ int {% single_param %}
             | "EDIV"
             | "EMPTY_BIG_MAP" __ type __ type
             | "EMPTY_MAP" __ type __ type
             | "EMPTY_SET" __ type {% single_param %}
             | "EQ"
             | "EXEC"
             | "FAILWITH"
             | "GE"
             | "GET"
             | "GET" __ int {% single_param %}
             | "GET_AND_UPDATE"
             | "GT"
             | "HASH_KEY"
             | "IF" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IF_CONS" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IF_LEFT" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IF_NONE" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IF_SOME" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IFCMPGE" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IFCMPGT" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IFCMPLT" _ "{" _ ins:* _ "}" _ "{" _ ins:* _ "}" {% ifs %}
             | "IMPLICIT_ACCOUNT"
             | "INT"
             | "ISNAT"
             | "ITER" __ instruction {% single_param %}
             | "JOIN_TICKETS"
             | "KECCAK"
             | "LAMBDA" __ type __ type __ instruction
             | "LE"
             | "LEFT" __ type {% single_param %}
             | "LEVEL"
             | "LOOP" __ instruction {% single_param %}
             | "LOOP_LEFT" __ instruction {% single_param %}
             | "LSL"
             | "LSR"
             | "LT"
             | "MAP" __ instruction {% single_param %}
             | "MEM"
             | "MUL"
             | "NEG"
             | "NEQ"
             | "NEVER"
             | "NIL" __ type {% single_param %}
             | "NONE" __ type {% single_param %}
             | "NOT"
             | "NOW"
             | "OR"
             | "PACK"
             | "PAIR"
             | "PAIR" __ int {% single_param %}
             | "PAIRING_CHECK"
             | "PUSH" __ pushh {% single_param %}
             | "READ_TICKET"
             | "RIGHT" __ type {% single_param %}
             | "SAPLING_EMPTY_STATE" __ type {% single_param %}
             | "SAPLING_VERIFY_UPDATE"
             | "SELF"
             | "SELF_ADDRESS"
             | "SENDER"
             | "SET_DELEGATE"
             | "SHA256"
             | "SHA3"
             | "SHA512"
             | "SIZE"
             | "SLICE"
             | "SOME"
             | "SOURCE"
             | "SPLIT_TICKET"
             | "SUB"
             | "SWAP"
             | "TICKET"
             | "TOTAL_VOTING_POWER"
             | "TRANSFER_TOKENS"
             | "UNIT"
             | "UNPACK" __ type {% single_param %}
             | "UNPAIR"
             | "UNPAIR" __ int {% single_param %}
             | "UPDATE"
             | "UPDATE" __ int {% single_param %}
             | "VOTING_POWER"
             | "XOR"
             | "{}"

pushh -> "string" __ dqstring {% function(d) { return [ d[0], d[2] ] } %}
      | "string" __ sqstring {% function(d) { return [ d[0], d[2] ] } %}
      | type __ int {% function(d) { return [ d[0], d[2] ] } %}

@{%
function single_param(d) {
    return [ d[0], d[2] ]
}

function dip(d) {
    return [ d[0], d[4] ]
}

function dipi(d) {
    return [ d[0], d[2], d[6] ]
}

function code(d) {
    var rarr = [];
    for (var i = 0; i < d[4].length; i++) {
        rarr[i] = d[4][i];
    }
    return rarr;
}

function ifs(d) {
    return [d[0], d[4], d[10]];
}

function ins(d) {
    if (d[0].length == 1) {
        return d[0][0];
    } else {
        return d[0];
    }
}

%}
