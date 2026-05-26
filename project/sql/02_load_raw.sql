--CREATE RAW TABLES

CREATE TABLE lmp_raw (
    interval_start TEXT,
    interval_end TEXT,
    settlement_location TEXT,
    pnode TEXT,
    lmp TEXT,
    mcc TEXT,
    mlc TEXT,
    mec TEXT
);

CREATE TABLE fuel_on_margin_raw (
    interval TEXT,
    gmt_interval_end TEXT,
    fuel_on_margin TEXT
);

CREATE TABLE resource_uplift_raw (
    reference_date TEXT,
    settlement_location_resource_mp TEXT,
    da_make_whole_payment TEXT,
    ruc_make_whole_payment TEXT,
    real_time_out_of_merit TEXT,
    real_time_regulation_adjustment TEXT,
    real_time_reserve_sharing_group TEXT,
    reg_up_mileage_mwp TEXT,
    reg_down_mileage_mwp TEXT,
    total_uplift TEXT
);

CREATE TABLE zonal_uplift_raw (
    operating_day TEXT,
    settlement_area TEXT,
    da_make_whole_payment TEXT,
    ruc_make_whole_payment TEXT,
    real_time_out_of_merit TEXT,
    real_time_regulation_adjustment TEXT,
    real_time_reserve_sharing_group TEXT,
    reg_up_mileage_mwp TEXT,
    reg_down_mileage_mwp TEXT,
    total_uplift TEXT
);

--LOAD DATA

\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502220100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502230100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502240100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502250100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502260100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502270100.csv' CSV HEADER;
\copy lmp_raw FROM 'raw/lmp/DA-LMP-SL-202502280100.csv' CSV HEADER;

\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502220100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502230100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502240100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502250100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502260100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502270100.csv' CSV HEADER;
\copy fuel_on_margin_raw FROM 'raw/load/DA-FUEL-ON-MARGIN-202502280100.csv' CSV HEADER;

\copy resource_uplift_raw FROM 'raw/resource_uplift/RESOURCE_UPLIFT_06012025.csv' CSV HEADER;
\copy zonal_uplift_raw FROM 'raw/zonal_uplift/ZONAL_UPLIFT_03152025.csv' CSV HEADER;