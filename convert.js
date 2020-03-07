let fs = require(`fs`);
let path = require(`path`);

function fieldFormatter(rowData) {

    if (rowData[1] != undefined) {

        rowData[5] = rowData[5] != undefined? rowData[5].trim().split(/\s/ig)[0] : rowData[5];
        rowData[6] = rowData[6] != undefined? rowData[6].trim().replace(/\s/ig,"_").toLowerCase(): rowData[6];

        let foreign_key_associations = (rowData[4] != undefined && rowData[5] != undefined && rowData[6] != undefined) ? `\treferences ${rowData[5]}(${rowData[6]})` : ``;
        let field_extras = (rowData[7] != undefined) ? `\t${rowData[7]}` : ``;
        let type_limit_info = rowData[3] != undefined ? `(${rowData[3]})` : ``;
        let type_info = rowData[2] != undefined ? `\t${rowData[2]}` : ``;

        return `\n\t${rowData[1].toLowerCase().trim().replace(/\s/ig,"_")}${type_info}${type_limit_info}${foreign_key_associations}${field_extras},`;

    } else {
        return ``;
    }

}

function tableViewFormatter(rowData) {

    rowData[0] = rowData[0].trim().split(/\s/ig)[0];
    rowData[1] = rowData[1].trim().replace(/\s/ig,"_").toLowerCase();

    let primary_key = (rowData[0] == "table") ? `\n\t${rowData[1].replace(/s$/i,'').replace(/ie$/ig,'y')}_id\tbigserial\tPRIMARY KEY\tNOT NULL,` : ``;
    return `\nCREATE ${rowData[0]} ${rowData[1]} (${primary_key}`;
}

function convert(filePath,fileDestination=`Output.sql`) {

    //@ open the file (expects one in the order {entity_type,entity_name,data_type,data_limits,is_foreign_key,foreign_tuple,foreign_field,extras})
    /*
        0 - entity_type
        1 - entity_name
        2 - data_type
        3 - data_limits
        4 - is_foreign_key
        5 - foreign_tuple
        6 - foreign_field
        7 - extras
    */
    let SQLQuery =
        fs.readFileSync(`${path.join(__dirname,filePath)}`, 'utf8')
        //@ Remove spaces
        .trim()
        //@ Split per new line 
        .split('\n')
        //@ Split per explicit comma
        .map(a => a.split(/,(?=(?:[^"]*"[^"]*")*[^"]*$)/))
        //@ Enforce bare minimums (( [entity_type{0}] || [entity_name{1}&&data_type{2}] ) && ( entity_type{0} != "table" || entity_type{0} != "field" || entity_type{0} != "view" ) 
        /*
            - csv_row_data[0] 
            the entity type is defined

            OR

            - (csv_row_data[0] || (csv_row_data[1] && csv_row_data[2] ) || csv_row_data[7] )
                either ( the entity_type is defined ) 
                     OR 
                ( the entity_name AND data_type is defined )
                     OR
                ( entity extras are defined )

            AND 

            - (csv_row_data[0] != "table" || csv_row_data[0] != "field" || csv_row_data[0] != "view")
            the entity_type is not a field descriptor
             
        */
        .filter(csv_row_data => (csv_row_data[0] != "entity_type" && (csv_row_data[0] || (csv_row_data[1] && csv_row_data[2]) && (csv_row_data[0] != "table" || csv_row_data[0] != "field" || csv_row_data[0] != "view"))))
        //@ Convert the row into an sql string
        .reduce(function(cumulative_value, current_value, index) {

            // console.log(`\n_____________\n`)
            // console.dir(current_value);
            // console.log(`\n_____________\n`)

            //@ Convert empty string values to nulls
            current_value = current_value.map(d => d != '' ? d.trim() : undefined);

            let row_builder = "";

            //@ ensure that the entity_type field is in lowercase (where defined/provided)
            current_value[0] = current_value[0] ? current_value[0].toLowerCase() : current_value[0];

            //@ convert the words 'tuple' and 'collection' to table
            current_value[0] = (current_value[0] == "tuple" || current_value[0] == "collection") ? "table" : current_value[0];


            switch (current_value[0]) {

                case "table":
                case "view":
                    row_builder = `${row_builder}${tableViewFormatter(current_value)}`;
                    break;

                case "endtable":
                case "notable":
                case "endview":
                case "noview":
                case "end":
                    row_builder += `\n);\n`                    
                    break;

                case "field":
                default:
                    row_builder = `${row_builder}${fieldFormatter(current_value)}`;
                    break;
            }

            return  row_builder == `\n);\n` ? `${cumulative_value.trim().replace(/\,$/ig,'')}${row_builder}` : `${cumulative_value}${row_builder}`;

        }, ``);

    fs.writeFileSync(fileDestination, SQLQuery);

    console.log(`\nDone!\n`);
    // console.dir(SQLQuery);

}


convert(`schema.csv`);