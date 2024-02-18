@echo off
SET PGPASSWORD=postgres
psql -U postgres -d postgres -f "C:\Users\user\Documents\Store Procedure\sp_sales.sql"
