
#Car Sales


type([inventa, kia, toyota]).
city([pecs, budapest, gyor, szeged]).
sales(pecs, kia, 20180502, sally, 500000).
sales(budapest, toyota, 20180502, sally, 500000).
sales(pecs, toyota, 20180502, sally, 500000).
sales(gyor, inventa, 20180502, sally, 100000).


:-dynamic sales/5.

displayMenu :- writeln("**********************************\n--------- FIREBIRD -----------\n**********************************\n").

selectCity(City) :- city(X), writeln(X), writeln("Select city"), read(City).

buying(City, Type, Date, Customer, Price) :- type(Types), writeln(Types), writeln("Select Type of Car:"), read(Type), writeln("Enter Date(YYYYMMDD)"), read(Date), writeln("Enter your name: "), read(Customer), writeln("Enter price:"), read(Price), assert(sales(City, Type, Date, Customer, Price)).

start :- displayMenu, selectCity(City), buying(City, Type, Date, Customer, Price).


%STATISTICS

% Returns total revenue of sales by type of car
typeSales(Type, S) :- bagof(Price, City^Date^Customer^sales(City, Type, Date, Customer, Price), SL), sum(SL, S).

% Returns type of car sold according to number of cars sold
numberSales(Type, N) :- bagof(Price, City^Date^Customer^Price^sales(City, Type, Date, Customer, Price), SL), length(SL, N), assert(typeQuatity(Type, N)).

% Returns decreasing list of
sortbytype(Output) :- findall([X,Y],typeQuatity(X,Y),List),
sort(2, @>, List, OrderedList),
Output = OrderedList.

mostSales(City, S) :- bagof(Price, Type^Date^Customer^sales(City, Type
                                                           , Date, Customer, Price), SL), sum(SL, S), writeln(S).



% Returns type, sales by year
byYear(Year, S, Type) :- bagof(Price, City^Date^Customer^(sales(City, Type, Date, Customer, Price), Year is Date // 10000), SL), sum(SL, S), assert(typeRevenue(Type, S)).

% Returns decreasing list of
sortbytypeyear(Output) :- findall([X,Y],typeRevenue(X,Y),List),
sort(2, @>, List, OrderedList),
Output = OrderedList.

% Returns total revenue of sales by city
citySalesRevenue(City, S) :- bagof(Price, Type^Date^Customer^sales(City, Type, Date, Customer, Price), SL), sum(SL, S).

% Returns number of cars sold
citySalesNumber(City, N) :- bagof(Price, Type^Date^Customer^sales(City, Type, Date, Customer, Price), SL), length(SL, N).

citySalesByYear(Year, S, City) :- bagof(Price, Type^Date^Customer^(sales(City, Type, Date, Customer, Price), Year is Date // 10000), SL), sum(SL, S), assert(cityRevenue(City, S)).

sortbycityyear(Output) :- findall([X,Y],cityRevenue(X,Y),List),
sort(2, @>, List, OrderedList),
Output = OrderedList.

sum([], 0).
sum([H|T], S) :- sum(T, S1), S is S1 + H.


