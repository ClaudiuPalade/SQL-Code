--- Create new table for housing data

Create Table HousingInMadrid(
Id integer,
Street_name varchar(255),
Street_number varchar(255),
District varchar(255),
Sq_mt_built int,
Sq_mt_useful int,
N_rooms float,
N_bathrooms int,
N_floors int,
Price int, 
Has_parking_included varchar(255),
Built_year varchar(255)
);

/* Remove duplicate rows. First create a new table with only unique rows, then delete all the rows in 
the original table, copy the unique rows in it and lastly delete the temporary, new, table. */

Select Distinct * 
Into HousingInMadrid_uniques
From HousingInMadrid;

Select * 
From HousingInMadrid_uniques;

Delete
From HousingInMadrid;

Insert Into HousingInMadrid
Select * 
From HousingInMadrid_uniques;

Drop Table HousingInMadrid_uniques;

--- Add new column with the year (better format and data type) in which the property was built.

Select Built_year, Cast(Built_year as Date), Extract(Year from Cast(Built_year as Date)) As Year_Built
From HousingInMadrid;

Alter Table HousingInMadrid
Add Year_built Int;

Update HousingInMadrid
Set Year_built = Extract(Year from Cast(Built_year as Date));

/* Standardize column "Has_parking_included" content, only to have 2 valid options, 'YES' or 'NO'.
The other cells that had 'Y' or 'N' have been updated.
                            */
Select Has_parking_included, Count(Has_Parking_Included)
From HousingInMadrid
Group By Has_Parking_Included;

Update HousingInMadrid 
Set Has_Parking_Included = 'YES'
Where Has_Parking_Included = 'Y';

Update HousingInMadrid 
Set Has_Parking_Included = 'NO'
Where Has_Parking_Included = 'N';

--- Change data type in the N_rooms columns, as the values used are integers not floating points.

Alter Table HousingInMadrid
Alter Column N_rooms Type int;

/* Add new column with full address 
(info from 2 already existing columns, street name and street number) */

Select street_name, street_number, concat(street_name,', ',street_number) as Address
From HousingInMadrid;

Alter Table HousingInMadrid
Add Address Varchar(255);

Update HousingInMadrid
Set Address = concat(street_name,', ',street_number);

--- Extract correct district name and put it in a new column

SELECT split_part(District, '- ', 2)
From HousingInMadrid;

Alter Table HousingInMadrid
Add Column Correct_District_Name Varchar(255);

Update HousingInMadrid
Set Correct_District_Name = split_part(District, '- ', 2);

--- Remove columns that are no longer needed

Alter Table HousingInMadrid
Drop Column District, Built_Year;


