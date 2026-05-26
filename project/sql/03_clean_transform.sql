--FINAL TABLES

CREATE TABLE lmp (
    interval_start TIMESTAMP,
    interval_end TIMESTAMP,
    settlement_location TEXT,
    pnode TEXT,
    lmp NUMERIC(12,4),
    mcc NUMERIC(12,4),
    mlc NUMERIC(12,4),
    mec NUMERIC(12,4),
    PRIMARY KEY (interval_start, settlement_location, pnode)
);

CREATE TABLE fuel_on_margin (
    interval TIMESTAMP PRIMARY KEY,
    gmt_interval_end TIMESTAMP,
    fuel_on_margin TEXT
);
CREATE TABLE resource_uplift (
    reference_month DATE,
    settlement_location TEXT,

    da_make_whole_payment NUMERIC(14,2),
    ruc_make_whole_payment NUMERIC(14,2),
    real_time_out_of_merit NUMERIC(14,2),
    real_time_regulation_adjustment NUMERIC(14,2),
    real_time_reserve_sharing_group NUMERIC(14,2),
    reg_up_mileage_mwp NUMERIC(14,2),
    reg_down_mileage_mwp NUMERIC(14,2),
    total_uplift NUMERIC(14,2),

    PRIMARY KEY (reference_month, settlement_location)
);

CREATE TABLE zonal_uplift (
    operating_day DATE,
    settlement_area TEXT,

    da_make_whole_payment NUMERIC(14,2),
    ruc_make_whole_payment NUMERIC(14,2),
    real_time_out_of_merit NUMERIC(14,2),
    real_time_regulation_adjustment NUMERIC(14,2),
    real_time_reserve_sharing_group NUMERIC(14,2),
    reg_up_mileage_mwp NUMERIC(14,2),
    reg_down_mileage_mwp NUMERIC(14,2),
    total_uplift NUMERIC(14,2),

    PRIMARY KEY (operating_day, settlement_area)
);


--Reset tables before clean load

TRUNCATE lmp, fuel_on_margin, resource_uplift, zonal_uplift;

--Clean load

INSERT INTO lmp (
    interval_start,
    interval_end,
    settlement_location,
    pnode,
    lmp,
    mcc,
    mlc,
    mec
)
SELECT DISTINCT
    interval_start::timestamp,
    interval_end::timestamp,
    settlement_location,
    pnode,
    lmp::numeric,
    mcc::numeric,
    mlc::numeric,
    mec::numeric
FROM lmp_raw
WHERE interval_start IS NOT NULL;


INSERT INTO fuel_on_margin (
    interval,
    gmt_interval_end,
    fuel_on_margin
)
SELECT DISTINCT
    interval::timestamp,
    gmt_interval_end::timestamp,
    fuel_on_margin
FROM fuel_on_margin_raw
WHERE interval IS NOT NULL;

INSERT INTO resource_uplift (
    reference_month,
    settlement_location,

    da_make_whole_payment,
    ruc_make_whole_payment,
    real_time_out_of_merit,
    real_time_regulation_adjustment,
    real_time_reserve_sharing_group,
    reg_up_mileage_mwp,
    reg_down_mileage_mwp,
    total_uplift
)
SELECT DISTINCT
    TO_DATE(reference_date, 'MM/YYYY'),
    settlement_location_resource_mp,
    NULLIF(da_make_whole_payment, '')::numeric,
    NULLIF(ruc_make_whole_payment, '')::numeric,
    NULLIF(real_time_out_of_merit, '')::numeric,
    NULLIF(real_time_regulation_adjustment, '')::numeric,
    NULLIF(real_time_reserve_sharing_group, '')::numeric,
    NULLIF(reg_up_mileage_mwp, '')::numeric,
    NULLIF(reg_down_mileage_mwp, '')::numeric,
    NULLIF(total_uplift, '')::numeric
FROM resource_uplift_raw
WHERE reference_date IS NOT NULL;

INSERT INTO zonal_uplift (
    operating_day,
    settlement_area,
    da_make_whole_payment,
    ruc_make_whole_payment,
    real_time_out_of_merit,
    real_time_regulation_adjustment,
    real_time_reserve_sharing_group,
    reg_up_mileage_mwp,
    reg_down_mileage_mwp,
    total_uplift
)

SELECT DISTINCT
    TO_DATE(operating_day, 'MM/DD/YYYY'),

    settlement_area,

    NULLIF(da_make_whole_payment, '')::numeric,
    NULLIF(ruc_make_whole_payment, '')::numeric,
    NULLIF(real_time_out_of_merit, '')::numeric,
    NULLIF(real_time_regulation_adjustment, '')::numeric,
    NULLIF(real_time_reserve_sharing_group, '')::numeric,
    NULLIF(reg_up_mileage_mwp, '')::numeric,
    NULLIF(reg_down_mileage_mwp, '')::numeric,
    NULLIF(total_uplift, '')::numeric
FROM zonal_uplift_raw
WHERE operating_day IS NOT NULL;

-- check duplicates (should return 0 rows)
/*SELECT settlement_location, interval_start, COUNT(*)
FROM lmp
GROUP BY settlement_location, interval_start
HAVING COUNT(*) > 1;*/

CREATE VIEW lmp_enriched AS
SELECT
    interval_start,
    settlement_location,
    pnode,
    lmp,
    mcc,
    mlc,
    mec,
    (mcc + mlc + mec) AS lmp_check
FROM lmp;
