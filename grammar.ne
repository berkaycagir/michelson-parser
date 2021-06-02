@builtin "whitespace.ne"

main -> parameter "\n":+ storage "\n":+ code "\n":+

parameter -> "parameter " (type " "):+ ";"

storage -> "storage " (type " "):+ ";"

code -> "code " "{" (type " "):+ "}" ";"

type -> "address"
      | "big_map" " " type " " type
      | "bls12_381_fr"
      | "bls12_381_g1"
      | "bls12_381_g2"
      | "bool"
      | "bytes"
      | "chain_id"
      | "contract" " " type
      | "int"
      | "key"
      | "key_hash"
      | "lambda"
      | "list" " " type
      | "map" " " type " " type
      | "mutez"
      | "nat"
      | "never"
      | "operation"
      | "option" " " type
      | "or" " " type " " type
      | "pair" " " type " " type
      | "sapling_state" " " type
      | "sapling_transaction" " " type
      | "set" " " type
      | "signature"
      | "string"
      | "ticket" " " type
      | "timestamp"
      | "unit"
