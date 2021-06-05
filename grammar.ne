@builtin "whitespace.ne"

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
