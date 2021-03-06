# knitr::stitch_rmd(script="./manipulation/te-ellis.R", output="./stitched-output/manipulation/te-ellis.md") # dir.create("./stitched-output/manipulation/", recursive=T)
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------
source("./utility/connectivity.R")

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr            , quietly=TRUE)
library(DBI                 , quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        ) # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"       ) # For asserting conditions meet expected patterns/conditions.
requireNamespace("checkmate"    ) # For asserting conditions meet expected patterns/conditions. # remotes::install_github("mllg/checkmate")
# requireNamespace("RODBC"      ) # For communicating with SQL Server over a locally-configured DSN.  Uncomment if you use 'upload-to-db' chunk.
requireNamespace("OuhscMunge"   ) # remotes::install_github(repo="OuhscBbmc/OuhscMunge")

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
config              <- config::get()

sql <- "
	SELECT
    rs.ExtendedID,
    rs.SubjectTag_S1,
    rs.SubjectTag_S2,
    s1.SubjectID             AS SubjectID_S1,
    s2.SubjectID             AS SubjectID_S2,
    rs.RelationshipPath,
    rs.EverSharedHouse,
    rv.R,
    rv.RFull,
    rv.MultipleBirthIfSameSex,
    rv.IsMz,
    rv.LastSurvey_S1,
    rv.LastSurvey_S2,
    rv.RImplicitPass1,
    rv.RImplicit,
    -- rv.RImplicit2004,
    -- rv.RImplicit - rv.RImplicit2004 AS RImplicitDifference,
    rv.RExplicit,
    rv.RExplicitPass1,
    rv.RPass1,
    rv.RExplicitOlderSibVersion,
    rv.RExplicitYoungerSibVersion,
    rv.RImplicitSubject,
    rv.RImplicitMother
  FROM Process.tblRelatedStructure rs
    LEFT JOIN Process.tblRelatedValues rv ON rs.ID = rv.ID
    LEFT JOIN Process.tblSubject s1 ON rs.SubjectTag_S1 = s1.SubjectID
    LEFT JOIN Process.tblSubject s2 ON rs.SubjectTag_S2 = s2.SubjectID
  WHERE rs.SubjectTag_S1 < rs.SubjectTag_S2
  ORDER BY ExtendedID, SubjectTag_S1, SubjectTag_S2
"
sql_archive <- "
  SELECT
    --a.ID
    a.AlgorithmVersion
    ,rs.ExtendedID
    ,a.SubjectTag_S1
    ,a.SubjectTag_S2
    ,s1.SubjectID             AS SubjectID_S1
    ,s2.SubjectID             AS SubjectID_S2
    ,a.MultipleBirthIfSameSex
    ,a.IsMz
    ,a.SameGeneration
    ,a.RosterAssignmentID
    ,a.RRoster
    ,a.LastSurvey_S1
    ,a.LastSurvey_S2
    ,a.RImplicitPass1
    ,a.RImplicit
    ,a.RImplicitSubject
    ,a.RImplicitMother
    ,a.RExplicitOldestSibVersion         AS RExplicitOlderSibVersion
    ,a.RExplicitYoungestSibVersion       AS RExplicitYoungerSibVersion
    ,a.RExplicitPass1
    ,a.RExplicit
    ,a.RPass1
    ,a.R
    ,a.RFull
    ,a.RPeek
  FROM [NlsyLinks97].[Archive].[tblRelatedValuesArchive]  a
    LEFT JOIN Process.tblRelatedStructure rs          ON (a.SubjectTag_S1=rs.SubjectTag_S1 AND a.SubjectTag_S2=rs.SubjectTag_S2)
    LEFT JOIN Process.tblSubject s1                   ON a.SubjectTag_S1 = s1.SubjectID
    LEFT JOIN Process.tblSubject s2                   ON a.SubjectTag_S2 = s2.SubjectID
  ORDER BY a.AlgorithmVersion, rs.ExtendedID, a.SubjectTag_S1, a.SubjectTag_S2
"
sql_description <- "
  SELECT TOP (1)
    AlgorithmVersion
    ,Description
    ,Date
  FROM Archive.tblArchiveDescription
  ORDER BY AlgorithmVersion DESC
"

# ---- load-data ---------------------------------------------------------------
channel            <- open_dsn_channel_odbc(study = "97")
# DBI::dbGetInfo(channel)
ds                <- DBI::dbGetQuery(channel, sql)
ds_archive        <- DBI::dbGetQuery(channel, sql_archive)
ds_description    <- DBI::dbGetQuery(channel, sql_description)
DBI::dbDisconnect(channel, sql, sql_archive, sql_description)

OuhscMunge::verify_data_frame(ds                , 2519    )
OuhscMunge::verify_data_frame(ds_archive        , 2519*3  )
OuhscMunge::verify_data_frame(ds_description    , 1       )

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.
testit::assert("Only one description row should be returned", nrow(ds_description) == 1L)

ds <- ds %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    RExplicit                   = NA_real_,
    RExplicitPass1              = NA_real_,
    RExplicitOlderSibVersion    = NA_real_,
    RExplicitYoungerSibVersion  = NA_real_
  )

ds_archive <- ds_archive %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    RExplicit                   = NA_real_,
    RExplicitPass1              = NA_real_,
    RExplicitOlderSibVersion    = NA_real_,
    RExplicitYoungerSibVersion  = NA_real_
  )

ds_description <- ds_description %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    sample   = "NLSY97",
    Date     = as.character(Date),
    note_1   = "For a complete history of algorithm versions, see `data-public/metadata/tables-97/ArchiveDescription.csv"
  ) %>%
  dplyr::select(
    sample,
    algorithm_version             = AlgorithmVersion,
    description_of_last_change    = Description,
    version_date                  = Date,
    note_1
  )

# l <- yaml::read_yaml("a.yml")

# l$Description
# ds <- ds_archive %>%
#   dplyr::filter(.data$AlgorithmVersion == max(.data$AlgorithmVersion))

# ---- verify-values-current -----------------------------------------------------------
# Sniff out problems
# OuhscMunge::verify_value_headstart(ds)
checkmate::assert_integer( ds$ExtendedID                 , any.missing=F , lower=8, upper=7477    )
checkmate::assert_integer( ds$SubjectTag_S1              , any.missing=F , lower=6, upper=9021    )
checkmate::assert_integer( ds$SubjectTag_S2              , any.missing=F , lower=7, upper=9022    )
checkmate::assert_integer( ds$SubjectID_S1               , any.missing=F , lower=6, upper=9021    )
checkmate::assert_integer( ds$SubjectID_S2               , any.missing=F , lower=7, upper=9022    )
checkmate::assert_integer( ds$RelationshipPath           , any.missing=F , lower=1, upper=1       )
checkmate::assert_logical( ds$EverSharedHouse            , any.missing=F                          )
checkmate::assert_numeric( ds$R                          , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RFull                      , any.missing=T , lower=0, upper=1       )
checkmate::assert_integer( ds$MultipleBirthIfSameSex     , any.missing=T , lower=0, upper=255     )
checkmate::assert_integer( ds$IsMz                       , any.missing=T , lower=0, upper=255     )
checkmate::assert_integer( ds$LastSurvey_S1              , any.missing=T , lower=1997, upper=2015 )
checkmate::assert_integer( ds$LastSurvey_S2              , any.missing=T , lower=1997, upper=2015 )
checkmate::assert_numeric( ds$RImplicitPass1             , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RImplicit                  , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RExplicit                  , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RExplicitPass1             , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RPass1                     , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RExplicitOlderSibVersion   , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RExplicitYoungerSibVersion , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RImplicitSubject           , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds$RImplicitMother            , any.missing=T , lower=0, upper=1       )

subject_combo   <- paste0(ds$SubjectTag_S1, "vs", ds$SubjectTag_S2)
checkmate::assert_character(subject_combo, min.chars=3            , any.missing=F, unique=T)
checkmate::assert_character(subject_combo, pattern  ="^\\d{1,4}vs\\d{1,4}$"            , any.missing=F, unique=T)

# ---- verify-values-archive -----------------------------------------------------------
# Sniff out problems
# OuhscMunge::verify_value_headstart(ds)
checkmate::assert_integer( ds_archive$AlgorithmVersion           , any.missing=F , lower=1, upper=1000    )
checkmate::assert_integer( ds_archive$ExtendedID                 , any.missing=F , lower=8, upper=7477    )
checkmate::assert_integer( ds_archive$SubjectTag_S1              , any.missing=F , lower=6, upper=9021    )
checkmate::assert_integer( ds_archive$SubjectTag_S2              , any.missing=F , lower=7, upper=9022    )
checkmate::assert_integer( ds_archive$SubjectID_S1               , any.missing=F , lower=6, upper=9021    )
checkmate::assert_integer( ds_archive$SubjectID_S2               , any.missing=F , lower=7, upper=9022    )
# checkmate::assert_integer( ds_archive$RelationshipPath           , any.missing=F , lower=1, upper=1       )
# checkmate::assert_logical( ds_archive$EverSharedHouse            , any.missing=F                          )
checkmate::assert_numeric( ds_archive$R                          , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RFull                      , any.missing=T , lower=0, upper=1       )
checkmate::assert_integer( ds_archive$MultipleBirthIfSameSex     , any.missing=T , lower=0, upper=255     )
checkmate::assert_integer( ds_archive$IsMz                       , any.missing=T , lower=0, upper=255     )
checkmate::assert_integer( ds_archive$LastSurvey_S1              , any.missing=T , lower=1997, upper=2015 )
checkmate::assert_integer( ds_archive$LastSurvey_S2              , any.missing=T , lower=1997, upper=2015 )
checkmate::assert_numeric( ds_archive$RImplicitPass1             , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RImplicit                  , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RExplicit                  , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RExplicitPass1             , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RPass1                     , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RExplicitOlderSibVersion   , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RExplicitYoungerSibVersion , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RImplicitSubject           , any.missing=T , lower=0, upper=1       )
checkmate::assert_numeric( ds_archive$RImplicitMother            , any.missing=T , lower=0, upper=1       )

algorithm_subject_combo   <- paste0(ds_archive$AlgorithmVersion, ":", ds_archive$SubjectTag_S1, "vs", ds_archive$SubjectTag_S2)
checkmate::assert_character(algorithm_subject_combo, min.chars=3            , any.missing=F, unique=T)
checkmate::assert_character(algorithm_subject_combo, pattern  ="^\\d{1,4}:\\d{1,4}vs\\d{1,4}$"            , any.missing=F, unique=T)

# ---- specify-columns-to-upload-current -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write_current <- c(
  "ExtendedID", "SubjectTag_S1", "SubjectTag_S2", "SubjectID_S1",
  "SubjectID_S2", "RelationshipPath", "EverSharedHouse",
  "R", "RFull",
  "MultipleBirthIfSameSex", "IsMz", "LastSurvey_S1", "LastSurvey_S2",
  "RImplicitPass1", "RImplicit", "RExplicit", "RExplicitPass1",
  "RPass1", "RExplicitOlderSibVersion", "RExplicitYoungerSibVersion",
  "RImplicitSubject", "RImplicitMother"
)
ds_slim_current <- ds %>%
  # dplyr::slice(1:100) %>%
  dplyr::select_(.dots=columns_to_write_current)
ds_slim_current

rm(columns_to_write_current)

# ---- specify-columns-to-upload-archive -----------------------------------------------
# dput(colnames(ds_archive)) # Print colnames for line below.
columns_to_write_archive <- c(
  "AlgorithmVersion", "ExtendedID", "SubjectTag_S1", "SubjectTag_S2",
  "SubjectID_S1", "SubjectID_S2", "MultipleBirthIfSameSex", "IsMz",
  "SameGeneration", "RosterAssignmentID", "RRoster", "LastSurvey_S1",
  "LastSurvey_S2", "RImplicitPass1", "RImplicit", "RImplicitSubject",
  "RImplicitMother", "RExplicitOlderSibVersion", "RExplicitYoungerSibVersion",
  "RExplicitPass1", "RExplicit", "RPass1", "R", "RFull", "RPeek"
)
ds_slim_archive <- ds_archive %>%
  # dplyr::slice(1:100) %>%
  dplyr::select_(.dots=columns_to_write_archive)
ds_slim_archive

rm(columns_to_write_archive)

# ---- save-to-disk ------------------------------------------------------------
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds_slim_current, config$links_97_current)
readr::write_csv(ds_slim_archive, config$links_97_archive)
# utils::write.csv(ds_slim_archive, config$links_97_archive, row.names=F)

ds_description %>%
  purrr::transpose() %>%
  yaml::write_yaml(config$links_97_metadata)


# ---- save-to-db --------------------------------------------------------------
sql_create <- "
  CREATE TABLE `archive_97` (
    AlgorithmVersion                integer NOT NULL,
    ExtendedID                      integer NOT NULL,
    SubjectTag_S1                   integer NOT NULL,
    SubjectTag_S2                   integer NOT NULL,
    SubjectID_S1                    integer NOT NULL,
    SubjectID_S2                    integer NOT NULL,
    MultipleBirthIfSameSex          integer,
    IsMz                            integer,
    SameGeneration                  integer,
    RosterAssignmentID              integer,
    RRoster                         text,
    LastSurvey_S1                   integer,
    LastSurvey_S2                   integer,
    RImplicitPass1                  real,
    RImplicit                       real,
    RImplicitSubject                real,
    RImplicitMother                 real,
    RExplicitOlderSibVersion        real,
    RExplicitYoungerSibVersion      real,
    RExplicitPass1                  real,
    RExplicit                       real,
    RPass1                          real,
    R                               real,
    RFull                           real,
    RPeek                           real
  )
"
# Remove old DB
if( file.exists(config$links_97_archive_db) ) file.remove(config$links_97_archive_db)

# Open connection
cnn <- DBI::dbConnect(drv=RSQLite::SQLite(), dbname=config$links_97_archive_db)
result_pragma <- DBI::dbSendQuery(cnn, "PRAGMA foreign_keys=ON;") #This needs to be activated each time a connection is made. #http://stackoverflow.com/questions/15301643/sqlite3-forgets-to-use-foreign-keys
DBI::dbClearResult(result_pragma)
DBI::dbListTables(cnn)

# Create tables
result_create <- DBI::dbSendQuery(cnn, sql_create)
DBI::dbClearResult(result_create)
DBI::dbListTables(cnn)

# Write to database
DBI::dbWriteTable(cnn, name='archive_97', value=ds_slim_archive, append=TRUE, row.names=FALSE)

# Close connection
DBI::dbDisconnect(cnn)
