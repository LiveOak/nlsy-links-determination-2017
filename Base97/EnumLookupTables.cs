﻿using System;
namespace Nls.Base97 {
    public enum MarkerType : byte {
        Roster = 1,
        ShareBiomom = 2,
        ShareBiodad = 3,
        //DobSeparation = 5,
        //GenderAgreement = 6,
    }
    public enum Item : short {
        subject_id = 1,
        extended_family_id = 2,
        hh_internal_id = 3,
        gender = 10,
        DateOfBirthMonth = 11,
        DateOfBirthYear = 12,
        cross_sectional_cohort = 13,
        race_cohort = 14, // race-ethnicity
        InterviewDateDay = 20,
        InterviewDateMonth = 21,
        InterviewDateYear = 22,
        AgeAtInterviewDateMonths = 23,
        AgeAtInterviewDateYears = 24,
        roster_crosswalk = 101,
        hh_member_id = 102,
        hh_informant = 103,
        // roster_relationship_2_dim                                 =   104, // 16 x 16 square
        roster_relationship_1_dim = 105, // 1 x 16 vector
        hh_unique_id = 106, // HHI2: People living in the Household - sorted, UID; HH member's unique ID
        pair_multiple_birth = 121,
        pair_twins_mz = 122,
        pair_sister_same_bioparent = 123,
        pair_brother_same_bioparent = 124,
        // InterviewDateDayParent_NOTUSED                            =  1020, 
        // InterviewDateMonthParent_NOTUSED                          =  1021, 
        // InterviewDateYearParent_NOTUSED                           =  1022, 
    }
    public enum ExtractSource : byte {
        Demographics = 1,
        Roster = 2,
        SurveyTime = 3,
        LinksExplicit = 4,
        LinksImplicit = 5,
        Twins = 6,
    }
    public enum MultipleBirth : byte {// 'Keep these values sync'ed with tblLUMultipleBirth in the database.
        No = 0,
        Twin = 2,
        Trip = 3,
        TwinOrTrip = 4, // Currently Then Gen1 algorithm doesn't distinguish.
        DoNotKnow = 255,
    }
    public enum Tristate : byte {
        No = 0,
        Yes = 1,
        DoNotKnow = 255,
    }
    public enum MarkerEvidence : byte {
        Irrelevant = 0,
        StronglySupports = 1,
        Supports = 2,
        Consistent = 3,
        Ambiguous = 4,
        Missing = 5,
        Unlikely = 6,
        Disconfirms = 7,
    }
    //public enum YesNo : short {
    //    ValidSkipOrNoInterviewOrNotInSurvey = -6,
    //    InvalidSkip = -3,
    //    DoNotKnow = -2,
    //    Refusal = -1,
    //    No = 0,
    //    Yes = 1,
    //}

}
