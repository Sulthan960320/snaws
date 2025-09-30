{{ config(materialized='table') }}

with tb as
(
    select 
    s_suppkey as skey,
    concat (s_name,'+',s_address) as protofile,
    try_cast(s_phone as int) as phone,
    case
    when s_nationkey = 5 then 'yes'
    when s_nationkey <= 10 then 'no'
    end s_nationkey from {{source('datafeed_mydata','SUPPLIERS')}}
)
select * from tb