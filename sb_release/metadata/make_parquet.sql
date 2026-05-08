SELECT
  ROW_ID :: Int64 AS ROW_ID,  -- Cast to Int64 to ensure numerical sorting
  FID,
  SEX,
  nullIf(EVENT_AGE, 'NA') :: Nullable(Float64) AS EVENT_AGE,
  EVENT_DATETIME :: DateTime64(3, 'UTC') AS EVENT_DATETIME,
  nullIf(OMOP_CONCEPT_ID, 'NA') :: Nullable(String) AS OMOP_CONCEPT_ID,
  TEST_ID,
  TEST_ID_IS_NATIONAL :: Bool AS TEST_ID_IS_NATIONAL,
  TEST_NAME_SOURCE,
  nullIf(MEASUREMENT_VALUE_SOURCE, 'NA') :: Nullable(Float64) AS MEASUREMENT_VALUE_SOURCE,
  nullIf(MEASUREMENT_UNIT_SOURCE, 'NA') :: Nullable(String) AS MEASUREMENT_UNIT_SOURCE,
  nullIf(MEASUREMENT_STATUS, 'NA') :: Nullable(String) AS MEASUREMENT_STATUS,
  nullIf(REFERENCE_VALUE_TEXT, 'NA') :: Nullable(String) AS REFERENCE_VALUE_TEXT,
  nullIf(CODING_SYSTEM_ORG, 'NA') :: Nullable(String) AS CODING_SYSTEM_ORG,
  nullIf(CODING_SYSTEM_OID, 'NA') :: Nullable(String) AS CODING_SYSTEM_OID,
  nullIf(SERVICE_PROVIDER_ID, 'NA') :: Nullable(String) AS SERVICE_PROVIDER_ID

FROM file({filePathCleanTxtGz:String}, TSVWithNames)

-- Make the output deterministic by using ORDER BY on all columns
ORDER BY (ROW_ID)

FORMAT Parquet
SETTINGS
    input_format_tsv_use_best_effort_in_schema_inference = 0,
    output_format_parquet_compression_method = 'zstd',
    output_format_parquet_string_as_string = 1
