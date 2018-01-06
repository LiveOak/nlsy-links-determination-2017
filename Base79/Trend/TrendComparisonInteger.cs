﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Nls.Base79.Trend {
	public sealed class TrendComparisonInteger : ITrendComparison {
		#region Fields
		private readonly Int32 _count = Int32.MinValue;
		private readonly Int32 _countOfNullZeros = 0;
		private readonly Int32 _countOfNullSingles = 0;
		private readonly Int32 _countOfNullDoubles = 0;
		private readonly Int32 _agreementCountOfNulls = 0;
		private readonly Int32 _agreementCountExcludingNulls = 0;
		private readonly Int32 _agreementCountOfOnes = 0;//Used for BiodadinHH
		private readonly Int32 _disagreementCountExcludingNulls = 0;
		private readonly Int32 _disagreementCountIncludingNulls = 0;
		private readonly Int32 _disagreementCountOfOnes = 0;//Used for BiodadinHH
		private readonly bool _jumpsAgreePerfectly;
		private readonly bool? _lastMutualNonNullPointsAgree = null;
		private readonly Int16? _lastNonMutualNullPointsYear = null;
		#endregion
		#region Properties
		public Int32 AgreementCountOfNulls { get { return _agreementCountOfNulls; } }
		public Int32 AgreementCountOfOnes { get { return _agreementCountOfOnes; } }
		public Int32 AgreementCountExcludingNulls { get { return _agreementCountExcludingNulls; } }
		public Int32 Count { get { return _count; } }
		public Int32 CountOfNullZeroes { get { return _countOfNullZeros; } }
		public Int32 CountOfNullSingles { get { return _countOfNullSingles; } }
		public Int32 CountOfNullDoubles { get { return _countOfNullDoubles; } }
		public Int32 CountOfAtLeastOneResponseIsOne { get { return _agreementCountOfOnes + _disagreementCountOfOnes; } }
		public double AgreementProportionExcludingNulls { get { return _agreementCountExcludingNulls / (double)(_agreementCountExcludingNulls + _disagreementCountExcludingNulls); } }
		public double AgreementProportionOfOnes { get { return _agreementCountOfOnes / (double)(_agreementCountOfOnes + _disagreementCountOfOnes); } }
		public Int32 DisagreementCountExcludingNulls { get { return _disagreementCountExcludingNulls; } }
		public Int32 DisagreementCountIncludingNulls { get { return _disagreementCountIncludingNulls; } }
		public bool JumpsAgreePerfectly { get { return _jumpsAgreePerfectly; } }
		public bool? LastMutualNonNullPointsAgree { get { return _lastMutualNonNullPointsAgree; } }
		public Int16? LastNonMutualNullPointsYear { get { return _lastNonMutualNullPointsYear; } }
		public bool PointsAgreePerfectly { get { return _jumpsAgreePerfectly; } }
		#endregion
		#region Constructor
		public TrendComparisonInteger ( TrendLineInteger trend1, TrendLineInteger trend2 ) {
			if ( trend1 == null ) throw new ArgumentNullException("trend1");
			if ( trend2 == null ) throw new ArgumentNullException("trend2");
			if ( trend1.CountAll != trend2.CountAll ) throw new ArgumentException("The two trends should have the same number of years.");
			_count = trend1.CountAll;

			Int16[] surveyYears1 = trend1.SurveyYears;
			Int16[] surveyYears2 = trend2.SurveyYears;
			Int16?[] points1 = trend1.Values;
			Int16?[] points2 = trend2.Values;

			for ( Int32 i = 0; i < trend2.CountAll; i++ ) {
				if ( surveyYears1[i] != surveyYears2[i] ) {
					throw new ArgumentException("The SurveyYear at element " + i + " should match.");
				}
				else if ( points1[i] == null && points2[i] == null ) {
					_countOfNullDoubles += 1;
					_agreementCountOfNulls += 1;
				}
				else if ( (points1[i] == null) || (points2[i] == null) ) {
					_countOfNullSingles += 1;
					_disagreementCountIncludingNulls += 1;
					_lastNonMutualNullPointsYear = surveyYears1[i];
				}
				else if ( !points1[i].Equals(points2[i]) ) {
					_countOfNullZeros += 1;
					_disagreementCountExcludingNulls += 1;
					_disagreementCountIncludingNulls += 1;
					_lastMutualNonNullPointsAgree = false;
					_lastNonMutualNullPointsYear = surveyYears1[i];
					if ( points1[i] == 1 || points2[i] == 1 )
						_disagreementCountOfOnes += 1;
				}
				else {
					_countOfNullZeros += 1;
					_agreementCountExcludingNulls += 1;
					_lastMutualNonNullPointsAgree = true;
					_lastNonMutualNullPointsYear = surveyYears1[i];
					Trace.Assert(points1[i].Equals(points2[i]), "If the execution got here, the two values should be equal.");
					if ( points1[i] == 1 )
						_agreementCountOfOnes += 1;
				}
			}

			_jumpsAgreePerfectly = trend1.Jumps.SequenceEqual(trend2.Jumps);
		}
		#endregion
	}
}