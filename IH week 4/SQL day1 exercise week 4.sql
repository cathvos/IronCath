use bank;

# we want a table with: count of clients(from clients), count of transactions (from trans), count of amount(from trans)
# , date(from trans) and status(from loans)

drop view trans_status_as_date;

create view trans_status_as_date AS
select d.account_id, d.client_id, trans_id, t.amount, l.status, 
convert(t.date, date) as date
from trans t
join loan l using (account_id)
join disp d using (account_id)
where d.type = 'OWNER';

select status, date, sum(amount), count(trans_id), 
count(distinct client_id)
from trans_status_as_date
group by status, date;







