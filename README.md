## CSVToSQL

A simplistic script to quickly scaffold postgres compliant SQL from a csv file

The `.csv` file should be in the format `entity_type,entity_name,data_type,data_limits,is_foreign_key,foreign_tuple,foreign_field,extras`

     
    0 - entity_type
    1 - entity_name
    2 - data_type
    3 - data_limits
    4 - is_foreign_key
    5 - foreign_tuple
    6 - foreign_field
    7 - extras
    
***Runs on [`Node.js`](https://nodejs.org)***