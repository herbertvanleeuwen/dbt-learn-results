select 
    order_id,
    {%- for method in ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] %}
    sum(case when payment_method = '{{ method }}' then amount else 0 end) as {{ method }}_amount
    {%- if not loop.last %},{%endif%}
    {%- endfor %}

 from {{ ref('stg_stripe__payments') }}
 group by 1