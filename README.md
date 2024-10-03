# SQL-php_replace_to_json
SQL function for Postgre.


Input structure is:

'a:2:{i:0;a:5:{s:6:"poradi";i:1;s:3:"ais";s:5:"0.374";s:4:"issn";s:9:"1008-682X";s:7:"kvartil";s:2:"Q2";s:5:"decil";s:1:"1";}i:1;a:5:{s:6:"poradi";i:2;s:3:"ais";s:5:"0.355";s:4:"issn";s:9:"0303-4569";s:7:"kvartil";s:2:"Q4";s:5:"decil";s:0:"";}}'

Output structure is:

{
"0": {"ais": "0.374", "issn": "1008-682X", "decil": "1", "poradi": 1, "kvartil": "Q2"}, 
"1": {"ais": "0.355", "issn": "0303-4569", "decil": "", "poradi": 2, "kvartil": "Q4"}
}

{
"PHP_arr": [{"ais": "0.374", "issn": "1008-682X", "decil": "", "poradi": 1, "kvartil": "Q2"}, 
             {"ais": "0.355", "issn": "0303-4569", "decil": "", "poradi": 2, "kvartil": "Q4"}],
"PHP_len": 2
 }

Note:
- Function is easy.
- Function is without syntax validation of PHP structure. It is only ease replacing typical PHP patterns to JSON patterns + finalized correction of completed result.
- Function is my first function in SQL for Postgre. Please a respect with amateur.
