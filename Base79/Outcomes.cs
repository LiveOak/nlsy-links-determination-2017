﻿//using System;
//using System.Collections.Generic;
//using System.Diagnostics;
//using System.Linq;
//using System.Threading;
//using System.Threading.Tasks;

//namespace Nls.Base79 {
//    public class Outcomes {
//        #region Fields
//        private readonly LinksDataSet _ds;
//        private readonly Item[] _items = { Item.Gen1HeightInches, Item.Gen1WeightPounds, Item.Gen1AfqtScaled5Decimals };
//        private readonly string _itemIDsString = "";
//        //private static IList<OverridesGen1.SubjectYear> _overrides = OverridesGen1.InverviewDateInvalidSkip;
//        #endregion
//        //#region Structs
//        //private struct DeathCondition {
//        //   private readonly bool? _isDead;
//        //   private readonly DateTime? _deathDate;

//        //   public bool? IsDead { get { return _isDead; } }
//        //   public DateTime? DeathDate { get { return _deathDate; } }

//        //   internal DeathCondition ( bool? isDead, DateTime? deathDate ) {
//        //      _isDead = isDead;
//        //      _deathDate = deathDate;
//        //   }
//        //}
//        //#endregion
//        #region Constructor
//        public Outcomes ( LinksDataSet ds ) {
//            if ( ds == null ) throw new ArgumentNullException("ds");
//            if ( ds.tblSubject.Count <= 0 ) throw new InvalidOperationException("tblSubject must NOT be empty.");
//            if ( ds.tblResponse.Count <= 0 ) throw new InvalidOperationException("tblResponse must NOT be empty.");
//            if ( ds.tblSurveyTime.Count <= 0 ) throw new InvalidOperationException("tblSurveyTime must NOT be empty.");
//            if ( ds.tblOutcomes.Count != 0 ) throw new InvalidOperationException("tblOutcomes must be empty before creating rows for it.");
//            _ds = ds;

//            _itemIDsString = CommonCalculations.ConvertItemsToString(_items);
//        }
//        #endregion
//        #region Public Methods
//        public string Go ( ) {
//            const Int32 minRowCount = 1;//This is somewhat arbitrary.
//            Stopwatch sw = new Stopwatch();
//            sw.Start();
//            Retrieve.VerifyResponsesExistForItem(_items, _ds);
//            Int32 recordsAddedTotal = 0;
//            _ds.tblOutcomes.BeginLoadData();
//            Int16[] extendedIDs = CommonFunctions.CreateExtendedFamilyIDs(_ds);
//            Parallel.ForEach(extendedIDs, ( extendedID ) => {//
//                //foreach(Int32 extendedID in  extendedIDs){
//                LinksDataSet.tblResponseDataTable dtExtended = Retrieve.ExtendedFamilyRelevantResponseRows(extendedID, _itemIDsString, minRowCount, _ds.tblResponse);
//                LinksDataSet.tblSubjectRow[] subjectsInExtendedFamily = Retrieve.SubjectsInExtendFamily(extendedID, _ds.tblSubject);
//                foreach ( LinksDataSet.tblSubjectRow drSubject in subjectsInExtendedFamily ) {
//                    Int32 recordsAddedForLoop = ProcessSubject(drSubject, dtExtended);//subjectsInExtendedFamily
//                    Interlocked.Add(ref recordsAddedTotal, recordsAddedForLoop);
//                }
//            });
//            _ds.tblOutcomes.EndLoadData();
//            Trace.Assert(recordsAddedTotal == Constants.Gen1Count + Constants.Gen2Count, "The number of Gen1+Gen2 subjects should be correct.");
//            //Trace.Assert(recordsAddedTotal == Constants.Gen1Count , "The number of Gen1+Gen2 subjects should be correct.");


//            sw.Stop();
//            return string.Format("{0:N0} SubjectDetails records were created.\nElapsed time: {1}", recordsAddedTotal, sw.Elapsed.ToString());
//        }
//        #endregion
//        #region Private Methods
//        private Int32 ProcessSubject ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended){//, LinksDataSet.tblSubjectRow[] subjectsInExtendedFamily ) {//, LinksDataSet.tblResponseDataTable dtResponseFamily
//            Int32 subjectTag = drSubject.SubjectTag;
//            byte? heightInchesLateTeens=null;
//            Int16? weightPoundsLateTeens = null;
//            float? afqt = null;

//            if ( drSubject.Generation == (byte)Generation.Gen1 ) {
//                heightInchesLateTeens = DetermineHeightIn1982(drSubject, dtExtended);
//                weightPoundsLateTeens = DetermineWeightIn1982(drSubject, dtExtended);
//                afqt = DetermineAfqtIn1985(drSubject, dtExtended);
//                AddRow(subjectTag, heightInchesLateTeens, weightPoundsLateTeens, afqt);
//                return 1;
//            }
//            else if ( drSubject.Generation == (byte)Generation.Gen2 ) {
//                AddRow(subjectTag,	null, null, null);

//                return 1;
//            }
//            else {
//                return 0;
//            }

//            //AddRow(subjectTag, siblingCountInNls, birthOrderInNls, similarAgeCount, hasMzPossibly, kidCountBio, kidCountInNls, mob, lastSurveyYear, lastAge, isDead, deathDate, isBiodadDead, biodadDeathDate);
//            //return 1;
//            //throw new NotImplementedException();
//        }
//        private byte? DetermineHeightIn1982 ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended ) {
//            const Int16 surveyYear = 1982;
//            const Item item = Item.Gen1HeightInches;
//            const SurveySource source = SurveySource.Gen1;
//            const byte maxRows = 1;
//            //return Retrieve.ResponseNullPossible(surveyYear, item, source, drSubject.SubjectTag, maxRows, dtExtended);
//            Int32? response = Retrieve.ResponseNullPossible(surveyYear, item, source, drSubject.SubjectTag, maxRows, dtExtended);
//            byte? converted = (byte?)response;
//            return converted;
//            //return Convert.ToByte(response);
//        }
//        private Int16? DetermineWeightIn1982 ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended ) {
//            const Int16 surveyYear = 1982;
//            const Item item = Item.Gen1WeightPounds;
//            const SurveySource source = SurveySource.Gen1;
//            const byte maxRows = 1;
//            Int32? response= Retrieve.ResponseNullPossible(surveyYear, item, source, drSubject.SubjectTag, maxRows, dtExtended);
//            return (Int16?)response;
//            //return Convert.ToByte(response);
//        }
//        private float? DetermineAfqtIn1985 ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended ) {
//            const Int16 surveyYear = 1981;
//            const Item item = Item.Gen1AfqtScaled5Decimals;
//            const SurveySource source = SurveySource.Gen1;
//            const byte maxRows = 1;
//            Int32? response = Retrieve.ResponseNullPossible(surveyYear, item, source, drSubject.SubjectTag, maxRows, dtExtended);

//            if ( response.HasValue && response >= 0 )
//                return ((float)(response / (double)100000));
//            else
//                return null;
//        }
//        private void AddRow ( Int32 subjectTag, byte? heightInchesLateTeens, Int16? weightPoundsLateTeens, float? afqt ) {
//            lock ( _ds.tblSubjectDetails ) {
//                LinksDataSet.tblOutcomesRow drNew = _ds.tblOutcomes.NewtblOutcomesRow();
//                drNew.SubjectTag = subjectTag;

//                if ( heightInchesLateTeens.HasValue ) drNew.HeightInchesLateTeens = (byte)heightInchesLateTeens;
//                else drNew.SetHeightInchesLateTeensNull();

//                if ( weightPoundsLateTeens.HasValue ) drNew.WeightPoundsLateTeens = (Int16)weightPoundsLateTeens;
//                else drNew.SetWeightPoundsLateTeensNull();

//                if ( afqt.HasValue ) drNew.AfqtRescaled2006Bounded = (float)afqt;
//                else drNew.SetAfqtRescaled2006BoundedNull();

//                _ds.tblOutcomes.AddtblOutcomesRow(drNew);
//            }
//        }
//        #endregion
//    }
//}

////private static  DeathCondition DetermineSubjectDeath ( ) {
////   return new DeathCondition(false	, null);
////}
////private static DeathCondition DetermineBiodadDeath ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended ) {
////   if ( (Generation)drSubject.Generation == Generation.Gen1 )
////      return new DeathCondition(null, null);
////   Int32 motherTag = CommonCalculations.MotherTagOfGen2Subject(drSubject.SubjectID);
////   byte? childLoop = Retrieve.MotherLoopIndexForChildTag(motherTag, drSubject, dtExtended);
////   if ( !childLoop.HasValue )
////      return new DeathCondition(null, null);
////   ////TODO: retrieve an array of these values, and return the most recent
////   //const Item livingItem = Item.BabyDaddyAliveGen1;
////   ////isDead = Retrieve.ResponseNullPossible(livingItem,
////   //Int16[] isDeads = Retrieve.ResponseArray(livingItem, drSubject.SubjectTag, childLoop.Value, dtExtended);
////   //They answer the 'Living in HH' item first, and only a subset answer if he's still alive.
////   Int16[] itemYearsFourDigitsReversed = ItemYears.BabyDaddyDeathFourDigitYear.Reverse().ToArray();
////   foreach ( Int16 surveyYear in itemYearsFourDigitsReversed ) {
////      Int32? deathYear = Retrieve.ResponseNullPossible(surveyYear, Item.BabyDaddyDeathYearFourDigit, motherTag, childLoop.Value, dtExtended);
////      if ( (deathYear.HasValue) && (deathYear.Value > 0) ) {
////         Int32? deathMonth = Retrieve.ResponseNullPossible(surveyYear, Item.BabyDaddyDeathMonth, motherTag, childLoop.Value, dtExtended);
////         if ( (!deathMonth.HasValue) || (deathMonth.Value < 1) )
////            deathMonth = Constants.DefaultMonthOfYear;
////         DateTime deathDate = new DateTime(deathYear.Value, deathMonth.Value, Constants.DefaultDayOfMonth);
////         return new DeathCondition(true, deathDate);
////      }
////   }

////   Int16[] itemYearsTwoDigitsReversed = ItemYears.BabyDaddyDeathTwoDigitYear.Reverse().ToArray();
////   foreach ( Int16 surveyYear in itemYearsTwoDigitsReversed ) {
////      Int32? deathYear = Retrieve.ResponseNullPossible(surveyYear, Item.BabyDaddyDeathYearTwoDigit, motherTag, childLoop.Value, dtExtended);
////      if ( (deathYear.HasValue ) && ( deathYear.Value >0)) {
////         Int32? deathMonth = Retrieve.ResponseNullPossible(surveyYear, Item.BabyDaddyDeathMonth, motherTag, childLoop.Value, dtExtended);
////         if ( (!deathMonth.HasValue) || (deathMonth.Value < 1) )
////            deathMonth = Constants.DefaultMonthOfYear;
////         DateTime deathDate = new DateTime(1900+deathYear.Value, deathMonth.Value, Constants.DefaultDayOfMonth);
////         return new DeathCondition(true, deathDate);
////      }
////   }

////   return new DeathCondition(null, null);
////}
////private byte DetermineSiblingCountInNls ( LinksDataSet.tblSubjectRow drSubject ) {
////   string select = string.Format("{0}={1} AND {2}={3}",
////      drSubject.ExtendedID, _ds.tblSubject.ExtendedIDColumn.ColumnName,
////      drSubject.Generation, _ds.tblSubject.GenerationColumn);
////   LinksDataSet.tblSubjectRow[] drs = (LinksDataSet.tblSubjectRow[])_ds.tblSubject.Select(select);
////   Trace.Assert(drs.Length > 0, "At least one row should be returned.");
////   switch ( (Generation)drSubject.Generation ) {
////      case Generation.Gen1:
////         return (byte)drs.Length;
////      case Generation.Gen2:
////         byte siblingCount = 0;
////         Int32 motherID = CommonCalculations.MotherIDOfGen2Subject(drSubject.SubjectTag);

////         foreach ( LinksDataSet.tblSubjectRow dr in drs ) {
////            if ( motherID == CommonCalculations.MotherIDOfGen2Subject(dr.SubjectTag) )
////               siblingCount += 1;
////         }
////         return siblingCount;
////      default:
////         throw new InvalidOperationException("The Generation value was not recognized.");
////   }
////}
////private BirthCondition DetermineNlsBirthOrder ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended, byte siblingCountInNls ) {//, LinksDataSet.tblResponseDataTable dtResponse 
////   string select = string.Format("{0}={1} AND {2}={3}",
////      drSubject.ExtendedID, dtExtended.ExtendedIDColumn.ColumnName,
////      drSubject.Generation, dtExtended.GenerationColumn.ColumnName);
////   LinksDataSet.tblSubjectRow[] drs = (LinksDataSet.tblSubjectRow[])_ds.tblSubject.Select(select);
////   byte orderTally = 1;
////   byte similarAgeTally = 0;
////   bool hasMzPossibly = false;
////   DateTime? mobOfSubject = Mob.Retrieve(drSubject, dtExtended); //There shouldn't be any missing Mobs in Gen1.

////   switch ( (Generation)drSubject.Generation ) {
////      case Generation.Gen1:
////         Trace.Assert(drs.Length == siblingCountInNls, "The number of returned rows should match 'siblingCountInNls'.");

////         foreach ( LinksDataSet.tblSubjectRow dr in drs ) {
////            DateTime mobOfSibling = Mob.Retrieve(dr, dtExtended).Value;//There aren't any missings Mobs in Gen1.
////            double ageDifferenceInDays = mobOfSubject.Value.Subtract(mobOfSibling).TotalDays;
////            if ( ageDifferenceInDays > 0 )//This should account for twins and the subject himself.
////               orderTally += 1;
////            if ( Math.Abs(ageDifferenceInDays) <= Constants.MaxDaysBetweenTwinBirths ) {
////               similarAgeTally += 1;//This counts themselves; eg, a only child will still have a value of one.
////               hasMzPossibly = hasMzPossibly || DetermineMzPossibility(drSubject, dr);
////            }
////         }
////         break;
////      case Generation.Gen2:
////         Trace.Assert(drs.Length >= siblingCountInNls, "The number of returned rows should be equal or greater than 'siblingCountInNls'.");
////         Int32 motherIDV1 = CommonCalculations.MotherIDOfGen2Subject(drSubject.SubjectTag);
////         Int32 motherIDV2 = Retrieve.Response(Item.Gen1MomOfGen2Subject, drSubject.SubjectTag, dtExtended);
////         Trace.Assert(motherIDV1 == motherIDV2, "The mother IDs should match.");

////         if ( OverridesGen2.MissingBirthOrderInvalidSkip.Contains(drSubject.SubjectTag) ) {
////            Trace.Assert(Mob.Retrieve(drSubject, dtExtended) == null, "Subject should be overriden here only if their MOB is missing in the NLS.");
////            orderTally = (byte)CommonFunctions.LastTwoDigitsOfGen2SubjectID(drSubject);
////            similarAgeTally = 1;
////         }
////         else {
////            foreach ( LinksDataSet.tblSubjectRow dr in drs ) {
////               if ( CommonCalculations.Gen2SubjectsHaveCommonMother(drSubject.SubjectID, dr.SubjectID) ) {
////                  DateTime mobOfSibling = Mob.Retrieve(dr, dtExtended).Value;//There aren't any missings Mobs in Gen1.
////                  double ageDifferenceInDays = mobOfSubject.Value.Subtract(mobOfSibling).TotalDays;
////                  if ( ageDifferenceInDays > 0 )//This should account for twins and the subject himself.
////                     orderTally += 1; //Twins will be tied.  This contrasts with Variable C00058.00 (which had problems anyway, as of August 2011)
////                  if ( Math.Abs(ageDifferenceInDays) <= Constants.MaxDaysBetweenTwinBirths ) {
////                     similarAgeTally += 1;//This counts themselves; eg, a only child will still have a value of one.
////                     hasMzPossibly = hasMzPossibly || DetermineMzPossibility(drSubject, dr);
////                  }
////               }
////            }
////            //Int32 xrndMachineCheck = Retrieve.Response(Item.BirthOrderInNlsGen2, drSubject.SubjectTag, dtExtended);//C00058.00
////            //if ( xrndMachineCheck != orderTally ) Debug.WriteLine("SubjectTag {0}: orderTally={1}, xrnd={2}", drSubject.SubjectTag, orderTally, xrndMachineCheck);
////            //return orderTally;
////         }
////         break;
////      default:
////         throw new InvalidOperationException("The Generation value was not recognized.");
////   }
////   return new BirthCondition(orderTally, similarAgeTally, hasMzPossibly);
////}
////private static bool DetermineMzPossibility ( LinksDataSet.tblSubjectRow dr1, LinksDataSet.tblSubjectRow dr2 ) {
////   if ( dr1.SubjectTag == dr2.SubjectTag ) {
////      return false;//The rows point to the same subject;
////   }
////   else if ( dr1.Gender != dr2.Gender ) {
////      return false; //Mzs can't have different genders.
////   }
////   return true;
////}
////private static byte? DetermineBioKidCount ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblResponseDataTable dtExtended, float? lastAge ) {
////   switch ( (Generation)drSubject.Generation ) {
////      case Generation.Gen1:
////         return (byte)Retrieve.Response(Item.BioKidCountGen1, drSubject.SubjectTag, dtExtended);

////      case Generation.Gen2:
////         //EnumResponsesGen2.KidBioCount count = (EnumResponsesGen2.KidBioCount)Retrieve.Response(Item.BioKidCountGen2, drSubject.SubjectTag, dtExtended);
////         Int32? response =Retrieve.ResponseNullPossible(Item.BioKidCountGen2, drSubject.SubjectTag, dtExtended);
////         if ( response.HasValue ) 
////            return (byte)response.Value;
////         else if ( lastAge.HasValue && lastAge.Value <= Constants.Gen2AgeMissingHasChildrenThreshold )
////            return 0;
////         else
////            return null;
////      default:
////         throw new InvalidOperationException("The Generation value was not recognized.");
////   }
////}
////private static byte? DetermineNlsKidCount ( LinksDataSet.tblSubjectRow drSubject, LinksDataSet.tblSubjectRow[] subjectsInExtendedFamily ) {
////   switch ( (Generation)drSubject.Generation ) {
////      case Generation.Gen1:
////         byte tally = 0;
////         foreach ( LinksDataSet.tblSubjectRow drRelative in subjectsInExtendedFamily ) {
////            if ( (Generation)drRelative.Generation == Generation.Gen2 ) {
////               Int32 motherIDV1 = CommonCalculations.MotherIDOfGen2Subject(drRelative.SubjectTag);
////               //Int32 motherIDV2 = Retrieve.Response(Item.Gen1MomOfGen2Subject, drSubject.SubjectTag, dtExtended);
////               //Trace.Assert(motherIDV1 == motherIDV2, "The mother IDs should match.");
////               if ( drSubject.SubjectID == motherIDV1 )
////                  tally += 1;
////            }
////         }
////         return tally;
////      case Generation.Gen2:
////         return null;
////      default:
////         throw new InvalidOperationException("The Generation value was not recognized.");
////   }
////}

////private LastSurvey LastSurveyCouplet ( Int32 subjectTag ) {
////   string select = string.Format("{0}={1} AND {2}>0",
////      subjectTag, _ds.tblSurveyTime.SubjectTagColumn.ColumnName,
////      _ds.tblSurveyTime.SurveySourceColumn.ColumnName);
////   string sort = _ds.tblSurveyTime.SurveyYearColumn.ColumnName + " DESC";
////   LinksDataSet.tblSurveyTimeRow[] drs = (LinksDataSet.tblSurveyTimeRow[])_ds.tblSurveyTime.Select(select, sort);
////   if ( drs.Length <= 0 )
////      return new LastSurvey(null, null);
////   else
////      return new LastSurvey(drs[0].SurveyYear, (float)drs[0].AgeCalculateYears); //There's only one case where the calculated age is missing; in this case it's not their last survey, so it doesn't matter here.
////}
////}
