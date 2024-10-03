-- DROP FUNCTION public.php_replace_to_json(text);

CREATE OR REPLACE FUNCTION public.php_replace_to_json(input_str text)
 RETURNS text
 LANGUAGE plpgsql
 IMMUTABLE PARALLEL SAFE COST 10
AS $function$

DECLARE
 len_array TEXT;
 rest_array TEXT;
 temp_array TEXT[];

BEGIN
	-- split to two blocks = prefix length attributes and rest.
	temp_array := regexp_match(input_str, '^a:(\d+):\{(.*)\}$');
	len_array := temp_array[1];

	-- Debuging
	-- RAISE NOTICE 'php_replace_to_json: *** START temp1=% temp2=% input_str=%', temp_array[1],temp_array[2], input_str; 
/*

Input = 'a:2:{i:0;a:5:{s:6:"poradi";i:1;s:3:"ais";s:5:"0.374";s:4:"issn";s:9:"1008-682X";s:7:"kvartil";s:2:"Q2";s:5:"decil";s:0:"";}i:1;a:5:{s:6:"poradi";i:2;s:3:"ais";s:5:"0.355";s:4:"issn";s:9:"0303-4569";s:7:"kvartil";s:2:"Q4";s:5:"decil";s:0:"";}}'
Step 1: erase begin sentence "a:2:{"
Step 2: convert s:6:"poradi";i:1 to JSON Key-Value format => {"poradi":1;"ais":"0.374";"issn":"1008-682X";"kvartil":"Q2";"decil":""}
Step 3: change end sentence ";}" to "}"
Result = i:0;a:5:{"poradi":1;"ais":"0.374";"issn":"1008-682X";"kvartil":"Q2";"decil":""}i:1;a:5:{"poradi":2;"ais":"0.355";"issn":"0303-4569";"kvartil":"Q4";"decil":""}

*/
	
   	temp_array := regexp_split_to_array(regexp_replace(regexp_replace(temp_array[2],'[isdb]:[\d:]*:?([^;]+);[isdb]:[\d:]*:?([^;]+);','\1:\2,','g'),',}','}','g'),'i:\d+;a:\d+:');

/*
Step 4: split string to array by pattern 'i:\d+;a:\d+:'
Step 5: erase first array member => is null/empty
Step 6: create JSON array structure => [item, item, item] 
Step 7: create final JSON structure => OUTPUT Format:
{
    "PHP_len": 2,
    "PHP_arr": [
        {
            "ais": "0.374",
            "issn": "1008-682X",
            "decil": "",
            "poradi": 1,
            "kvartil": "Q2"
        },
        {
            "ais": "0.355",
            "issn": "0303-4569",
            "decil": "",
            "poradi": 2,
            "kvartil": "Q4"
        }
    ]
}

*/

	-- Debuging
	-- RAISE NOTICE 'php_replace_to_json: *** END result=%', rest_array; 

    return format('{ "PHP_len": %s, "PHP_arr": [%s]}', len_array, array_to_string(array_remove(temp_array, ''), ','));

END;
$function$
;
