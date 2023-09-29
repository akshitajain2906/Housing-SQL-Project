select *
from NashvilleHousing

-- standardizing date format
select saledateconverted, convert(date, saledate)
from NashvilleHousing

alter table nashvillehousing
add SaleDateConverted date;

update NashvilleHousing
set SaleDateConverted = convert(date, saledate)

-- populate null property address data
select *
from NashvilleHousing
-- where propertyaddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a 
set PropertyAddress = ISNULL( a.propertyaddress, b.propertyaddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-- breaking address column down by address, city, state
select propertyaddress
from NashvilleHousing

select SUBSTRING(propertyaddress, 1, charindex(',',propertyaddress)-1) as Address,
SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1,len(propertyaddress)) as City
from NashvilleHousing

alter table nashvillehousing
add PropertyAddressSplit nvarchar(255);

update NashvilleHousing
set PropertyAddressSplit = SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress)-1)

alter table nashvillehousing
add PropertyCitySplit nvarchar(255);

update NashvilleHousing
set PropertyCitySplit = SUBSTRING(propertyaddress,charindex(',', propertyaddress)+1,len(propertyaddress))

select *
from NashvilleHousing

select owneraddress
from NashvilleHousing

select PARSENAME(replace(owneraddress, ',', '.'),3),
PARSENAME(replace(owneraddress, ',', '.'),2),
PARSENAME(replace(owneraddress, ',', '.'),1)
from NashvilleHousing

alter table nashvillehousing
add OwnerAddressSplit nvarchar(255);

update NashvilleHousing
set OwnerAddressSplit = PARSENAME(replace(owneraddress,',','.'),3)

alter table nashvillehousing
add OwnerCitySplit nvarchar(255);

update NashvilleHousing
set OwnerCitySplit = PARSENAME(replace(owneraddress,',','.'),2)

alter table nashvillehousing
add OwnerStateSplit nvarchar(255);

update NashvilleHousing
set OwnerStateSplit = PARSENAME(replace(owneraddress,',','.'),1)

-- changing Y and N to Yes and No in SoldAsVacant
select distinct (soldasvacant), count(soldasvacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select soldasvacant, 
case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant end
	 from NashvilleHousing

update NashvilleHousing
set SoldAsVacant=case when soldasvacant = 'Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
	 else soldasvacant end


-- removing duplicates
  
 with rownumCTE as (
 select *, ROW_NUMBER() over
 (partition by parcelID, propertyaddress,Saleprice, saledate,legalreference order by uniqueID) row_num
 from NashvilleHousing
 --order by ParcelID
 )
 
 delete
 from rownumCTE
 where row_num > 1

 -- delete unused columns
 alter table nashvillehousing
 drop column owneraddress, taxdistrict, propertyaddress

 alter table nashvillehousing
 drop column saledate

 select *
 from NashvilleHousing
 
 
