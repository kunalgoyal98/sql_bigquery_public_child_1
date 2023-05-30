{% macro combine_multi_tables(table_1, table_2, table_3, table_4, table_5, col_table_1) %}
select * from {{table_1}} 
    where {{col_table_1}} != (select count(*) from {{table_2}} ) + 
        (select count(*) from {{table_3}} ) + 
            (select count(*) from {{table_4}} ) + 
                (select count(*) from {{table_5}} ) + 500000
{% endmacro %}

 