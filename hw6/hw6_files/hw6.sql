CREATE FUNCTION hw6() RETURNS real AS $$
DECLARE
BEGIN
	new1 = hw6_1();
	new2 = hw6_2();
	new3 = hw6_3();
END ;
$$ LANGUAGE plpgsql;

select sales_tax(100, 'NY');

select hw6();