@builtin "whitespace.ne"
@builtin "number.ne"

main -> parameter __ storage __ code _

parameter -> "parameter" __ type:? (type __):* ";"

storage -> "storage" __ type:? (type __):* ";"

code -> "code" __ "{" _ ([a-zA-Z_]:+ _ [a-zA-Z_]:*):? ([a-zA-Z_]:+ _ [a-zA-Z_]:* ";" __):* ([a-zA-Z_]:+ _ [a-zA-Z_]:*):? _ "}" ";"

type -> "address"
      | "big_map" __ type __ type
      | "bls12_381_fr"
      | "bls12_381_g1"
      | "bls12_381_g2"
      | "bool"
      | "bytes"
      | "chain_id"
      | "contract" __ type
      | "int"
      | "key"
      | "key_hash"
      | "lambda"
      | "list" __ type
      | "map" __ type __ type
      | "mutez"
      | "nat"
      | "never"
      | "operation"
      | "option" __ type
      | "or" __ type __ type
      | "pair" __ type __ type
      | "sapling_state" __ type
      | "sapling_transaction" __ type
      | "set" __ type
      | "signature"
      | "string"
      | "ticket" __ type
      | "timestamp"
      | "unit"

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
             | "CONTRACT" __ type
             | "CREATE_CONTRACT" __ "{" _ "parameter" __ type _ ";" _ "storage" __ type _ ";" _ "code" __ instruction _ "}"
             | "DIG" __ int
             | "DIP" __ instruction
             | "DIP" __ int __ instruction
             | "DROP" __ int
             | "DUG" __ int
             | "DUP"
             | "DUP" __ int
             | "EDIV"
             | "EMPTY_BIG_MAP" __ type __ type
             | "EMPTY_MAP" __ type __ type
             | "EMPTY_SET" __ type
             | "EQ"
             | "EXEC"
             | "FAILWITH"
             | "GE"
             | "GET"
             | "GET" __ int
             | "GET_AND_UPDATE"
             | "GT"
             | "HASH_KEY"
             | "IF" __ instruction __ instruction
             | "IF_CONS" __ instruction __ instruction
             | "IF_LEFT" __ instruction __ instruction
             | "IF_NONE" __ instruction __ instruction
             | "IMPLICIT_ACCOUNT"
             | "INT"
             | "ISNAT"
             | "ITER" __ instruction
             | "JOIN_TICKETS"
             | "KECCAK"
             | "LAMBDA" __ type __ type __ instruction
             | "LE"
             | "LEFT" __ type
             | "LEVEL"
             | "LOOP" __ instruction
             | "LOOP_LEFT" __ instruction
             | "LSL"
             | "LSR"
             | "LT"
             | "MAP" __ instruction
             | "MEM"
             | "MUL"
             | "NEG"
             | "NEQ"
             | "NEVER"
             | "NIL" __ type
             | "NONE" __ type
             | "NOT"
             | "NOW"
             | "OR"
             | "PACK"
             | "PAIR"
             | "PAIR" __ int
             | "PAIRING_CHECK"
             | "PUSH" __ type __ [a-zA-Z_]:+
             | "READ_TICKET"
             | "RIGHT" __ type
             | "SAPLING_EMPTY_STATE" __ type
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
             | "UNPACK" __ type
             | "UNPAIR"
             | "UNPAIR" __ int
             | "UPDATE"
             | "UPDATE" __ int
             | "VOTING_POWER"
             | "XOR"
             | "{}"
