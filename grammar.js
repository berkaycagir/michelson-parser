// Generated automatically by nearley, version 2.20.1
// http://github.com/Hardmath123/nearley
(function () {
function id(x) { return x[0]; }
var grammar = {
    Lexer: undefined,
    ParserRules: [
    {"name": "_$ebnf$1", "symbols": []},
    {"name": "_$ebnf$1", "symbols": ["_$ebnf$1", "wschar"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "_", "symbols": ["_$ebnf$1"], "postprocess": function(d) {return null;}},
    {"name": "__$ebnf$1", "symbols": ["wschar"]},
    {"name": "__$ebnf$1", "symbols": ["__$ebnf$1", "wschar"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "__", "symbols": ["__$ebnf$1"], "postprocess": function(d) {return null;}},
    {"name": "wschar", "symbols": [/[ \t\n\v\f]/], "postprocess": id},
    {"name": "main", "symbols": ["parameter", "__", "storage", "__", "code", "_"]},
    {"name": "parameter$string$1", "symbols": [{"literal":"p"}, {"literal":"a"}, {"literal":"r"}, {"literal":"a"}, {"literal":"m"}, {"literal":"e"}, {"literal":"t"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "parameter$ebnf$1", "symbols": ["type"], "postprocess": id},
    {"name": "parameter$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "parameter$ebnf$2", "symbols": []},
    {"name": "parameter$ebnf$2$subexpression$1", "symbols": ["type", "__"]},
    {"name": "parameter$ebnf$2", "symbols": ["parameter$ebnf$2", "parameter$ebnf$2$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "parameter", "symbols": ["parameter$string$1", "__", "parameter$ebnf$1", "parameter$ebnf$2", {"literal":";"}]},
    {"name": "storage$string$1", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"o"}, {"literal":"r"}, {"literal":"a"}, {"literal":"g"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "storage$ebnf$1", "symbols": ["type"], "postprocess": id},
    {"name": "storage$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "storage$ebnf$2", "symbols": []},
    {"name": "storage$ebnf$2$subexpression$1", "symbols": ["type", "__"]},
    {"name": "storage$ebnf$2", "symbols": ["storage$ebnf$2", "storage$ebnf$2$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "storage", "symbols": ["storage$string$1", "__", "storage$ebnf$1", "storage$ebnf$2", {"literal":";"}]},
    {"name": "code$string$1", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"d"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "code$ebnf$1$subexpression$1$ebnf$1", "symbols": [/[a-zA-Z]/]},
    {"name": "code$ebnf$1$subexpression$1$ebnf$1", "symbols": ["code$ebnf$1$subexpression$1$ebnf$1", /[a-zA-Z]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$1$subexpression$1$ebnf$2", "symbols": []},
    {"name": "code$ebnf$1$subexpression$1$ebnf$2", "symbols": ["code$ebnf$1$subexpression$1$ebnf$2", "type"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$1$subexpression$1", "symbols": ["code$ebnf$1$subexpression$1$ebnf$1", "code$ebnf$1$subexpression$1$ebnf$2"]},
    {"name": "code$ebnf$1", "symbols": ["code$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "code$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "code$ebnf$2", "symbols": []},
    {"name": "code$ebnf$2$subexpression$1$ebnf$1", "symbols": [/[a-zA-Z]/]},
    {"name": "code$ebnf$2$subexpression$1$ebnf$1", "symbols": ["code$ebnf$2$subexpression$1$ebnf$1", /[a-zA-Z]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$2$subexpression$1$ebnf$2", "symbols": []},
    {"name": "code$ebnf$2$subexpression$1$ebnf$2", "symbols": ["code$ebnf$2$subexpression$1$ebnf$2", "type"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$2$subexpression$1", "symbols": ["code$ebnf$2$subexpression$1$ebnf$1", "code$ebnf$2$subexpression$1$ebnf$2", {"literal":";"}, "__"]},
    {"name": "code$ebnf$2", "symbols": ["code$ebnf$2", "code$ebnf$2$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$3$subexpression$1$ebnf$1", "symbols": [/[a-zA-Z]/]},
    {"name": "code$ebnf$3$subexpression$1$ebnf$1", "symbols": ["code$ebnf$3$subexpression$1$ebnf$1", /[a-zA-Z]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$3$subexpression$1$ebnf$2", "symbols": []},
    {"name": "code$ebnf$3$subexpression$1$ebnf$2", "symbols": ["code$ebnf$3$subexpression$1$ebnf$2", "type"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "code$ebnf$3$subexpression$1", "symbols": ["code$ebnf$3$subexpression$1$ebnf$1", "code$ebnf$3$subexpression$1$ebnf$2"]},
    {"name": "code$ebnf$3", "symbols": ["code$ebnf$3$subexpression$1"], "postprocess": id},
    {"name": "code$ebnf$3", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "code", "symbols": ["code$string$1", "__", {"literal":"{"}, "_", "code$ebnf$1", "code$ebnf$2", "code$ebnf$3", "_", {"literal":"}"}, {"literal":";"}]},
    {"name": "type$string$1", "symbols": [{"literal":"a"}, {"literal":"d"}, {"literal":"d"}, {"literal":"r"}, {"literal":"e"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$1"]},
    {"name": "type$string$2", "symbols": [{"literal":"b"}, {"literal":"i"}, {"literal":"g"}, {"literal":"_"}, {"literal":"m"}, {"literal":"a"}, {"literal":"p"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$2", "__", "type", "__", "type"]},
    {"name": "type$string$3", "symbols": [{"literal":"b"}, {"literal":"l"}, {"literal":"s"}, {"literal":"1"}, {"literal":"2"}, {"literal":"_"}, {"literal":"3"}, {"literal":"8"}, {"literal":"1"}, {"literal":"_"}, {"literal":"f"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$3"]},
    {"name": "type$string$4", "symbols": [{"literal":"b"}, {"literal":"l"}, {"literal":"s"}, {"literal":"1"}, {"literal":"2"}, {"literal":"_"}, {"literal":"3"}, {"literal":"8"}, {"literal":"1"}, {"literal":"_"}, {"literal":"g"}, {"literal":"1"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$4"]},
    {"name": "type$string$5", "symbols": [{"literal":"b"}, {"literal":"l"}, {"literal":"s"}, {"literal":"1"}, {"literal":"2"}, {"literal":"_"}, {"literal":"3"}, {"literal":"8"}, {"literal":"1"}, {"literal":"_"}, {"literal":"g"}, {"literal":"2"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$5"]},
    {"name": "type$string$6", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$6"]},
    {"name": "type$string$7", "symbols": [{"literal":"b"}, {"literal":"y"}, {"literal":"t"}, {"literal":"e"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$7"]},
    {"name": "type$string$8", "symbols": [{"literal":"c"}, {"literal":"h"}, {"literal":"a"}, {"literal":"i"}, {"literal":"n"}, {"literal":"_"}, {"literal":"i"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$8"]},
    {"name": "type$string$9", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"t"}, {"literal":"r"}, {"literal":"a"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$9", "__", "type"]},
    {"name": "type$string$10", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$10"]},
    {"name": "type$string$11", "symbols": [{"literal":"k"}, {"literal":"e"}, {"literal":"y"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$11"]},
    {"name": "type$string$12", "symbols": [{"literal":"k"}, {"literal":"e"}, {"literal":"y"}, {"literal":"_"}, {"literal":"h"}, {"literal":"a"}, {"literal":"s"}, {"literal":"h"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$12"]},
    {"name": "type$string$13", "symbols": [{"literal":"l"}, {"literal":"a"}, {"literal":"m"}, {"literal":"b"}, {"literal":"d"}, {"literal":"a"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$13"]},
    {"name": "type$string$14", "symbols": [{"literal":"l"}, {"literal":"i"}, {"literal":"s"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$14", "__", "type"]},
    {"name": "type$string$15", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"p"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$15", "__", "type", "__", "type"]},
    {"name": "type$string$16", "symbols": [{"literal":"m"}, {"literal":"u"}, {"literal":"t"}, {"literal":"e"}, {"literal":"z"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$16"]},
    {"name": "type$string$17", "symbols": [{"literal":"n"}, {"literal":"a"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$17"]},
    {"name": "type$string$18", "symbols": [{"literal":"n"}, {"literal":"e"}, {"literal":"v"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$18"]},
    {"name": "type$string$19", "symbols": [{"literal":"o"}, {"literal":"p"}, {"literal":"e"}, {"literal":"r"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$19"]},
    {"name": "type$string$20", "symbols": [{"literal":"o"}, {"literal":"p"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$20", "__", "type"]},
    {"name": "type$string$21", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$21", "__", "type", "__", "type"]},
    {"name": "type$string$22", "symbols": [{"literal":"p"}, {"literal":"a"}, {"literal":"i"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$22", "__", "type", "__", "type"]},
    {"name": "type$string$23", "symbols": [{"literal":"s"}, {"literal":"a"}, {"literal":"p"}, {"literal":"l"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}, {"literal":"_"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$23", "__", "type"]},
    {"name": "type$string$24", "symbols": [{"literal":"s"}, {"literal":"a"}, {"literal":"p"}, {"literal":"l"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}, {"literal":"_"}, {"literal":"t"}, {"literal":"r"}, {"literal":"a"}, {"literal":"n"}, {"literal":"s"}, {"literal":"a"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$24", "__", "type"]},
    {"name": "type$string$25", "symbols": [{"literal":"s"}, {"literal":"e"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$25", "__", "type"]},
    {"name": "type$string$26", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"g"}, {"literal":"n"}, {"literal":"a"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$26"]},
    {"name": "type$string$27", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$27"]},
    {"name": "type$string$28", "symbols": [{"literal":"t"}, {"literal":"i"}, {"literal":"c"}, {"literal":"k"}, {"literal":"e"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$28", "__", "type"]},
    {"name": "type$string$29", "symbols": [{"literal":"t"}, {"literal":"i"}, {"literal":"m"}, {"literal":"e"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"m"}, {"literal":"p"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$29"]},
    {"name": "type$string$30", "symbols": [{"literal":"u"}, {"literal":"n"}, {"literal":"i"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "type", "symbols": ["type$string$30"]}
]
  , ParserStart: "main"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
