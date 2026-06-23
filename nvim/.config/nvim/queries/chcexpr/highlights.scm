; === Functions ===
(function_call name: (identifier) @function.call)

; === Column references ===
(column_reference table: (identifier) @module)
(column_reference "." @punctuation.delimiter)
(column_reference "`" @punctuation.special)
(column_reference column: (column_name) @property)

; === Lambda ===
(lambda_expression "->" @operator)
(lambda_expression params: (identifier) @variable.parameter)
(parameter_list (identifier) @variable.parameter)

; === Literals ===
(number) @number
(string) @string
(boolean) @boolean
(null) @constant.builtin

; === Word operators ===
["OR" "AND" "NOT" "IN" "GLOBAL" "LIKE" "ILIKE" "IS"] @keyword.operator

; === Symbol operators ===
["=" "==" "!=" "<>" "<" ">" "<=" ">="] @operator
["+" "-" "*" "/" "%"] @operator

; === Punctuation ===
["(" ")"] @punctuation.bracket
[","] @punctuation.delimiter

; === Fallback: unmatched identifiers ===
(identifier) @variable

; === Syntax errors ===
(ERROR) @error
