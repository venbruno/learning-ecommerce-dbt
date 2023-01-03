/*
    That's a custom logic to generate the schema name in production.
    In prod, a model's schema name should match the custom schema rather than being concatenated to the target schema.
    Docs here: https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-custom-schemas#an-alternative-pattern-for-generating-schema-names.
*/

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set node_tags = [] -%}

    {% for tag_name in node.tags -%}
        {%- if tag_name in ['staging', 'logic', 'marts'] -%}

            {%- do node_tags.append(tag_name) -%}

        {%- endif -%}
    {%- endfor %}

    {%- if target.name == 'prod' and 'staging' in node_tags -%}
        {{ var('staging_schema') }}

    {%- elif target.name == 'prod' and 'logic' in node_tags -%}
        {{ var('logic_schema') }}

    {%- elif target.name == 'prod' and 'marts' in node_tags -%}
        {{ var('marts_schema') }}

    {%- else -%}
        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}