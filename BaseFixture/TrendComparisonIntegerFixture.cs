﻿using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Nls.BaseAssembly;
using Nls.BaseAssembly.Trend;

namespace Nls.Tests.BaseFixture {
	[TestClass()]
	public class TrendComparisonIntegerFixture {
		#region Fields
		private readonly Int16[] _surveyYears1 = { 1998, 2000, 2002, 2004, 2006 };
		private readonly Int16[] _surveyYears2 = { 1998, 2000, 2002, 2004, 2006 };
		private TrendLineInteger _trend0;
		private TrendLineInteger _trend1;
		private TrendLineInteger _trend2;
		private TrendLineInteger _trend3;
		private TrendLineInteger _trend4;
		private TrendLineInteger _trend5;
		private ITrendComparison _comparison0vs0;
		private ITrendComparison _comparison0vs1;
		private ITrendComparison _comparison0vs3;
		private ITrendComparison _comparison1vs2;
		private ITrendComparison _comparison1vs3;
		private ITrendComparison _comparison1vs4;
		private ITrendComparison _comparison1vs5;
		private ITrendComparison _comparison2vs3;
		private ITrendComparison _comparison3vs3;
		private ITrendComparison _comparison3vs4;
		private readonly Int16?[] _values0 = { null, null, null, null, null };
		private readonly Int16?[] _values1 = { 1, 1, 2, 2, 2 };
		private readonly Int16?[] _values2 = { 1, 1, 2, 2, 2 };
		private readonly Int16?[] _values3 = { null, 1, 2, null, 2 };
		private readonly Int16?[] _values4 = { null, 91, 92, 93, 94 };
		private readonly Int16?[] _values5 = { 1, 1, 2, 2, 3 };
		#endregion
		#region Additional test attributes
		[TestInitialize()]
		public void TestInitialize ( ) {
			_trend0 = new TrendLineInteger(_surveyYears2, _values0);
			_trend1 = new TrendLineInteger(_surveyYears1, _values1);
			_trend2 = new TrendLineInteger(_surveyYears2, _values2);
			_trend3 = new TrendLineInteger(_surveyYears2, _values3);
			_trend4 = new TrendLineInteger(_surveyYears2, _values4);
			_trend5 = new TrendLineInteger(_surveyYears2, _values5);
			_comparison0vs0 = new TrendComparisonInteger(_trend0, _trend0);
			_comparison0vs1 = new TrendComparisonInteger(_trend0, _trend1);
			_comparison0vs3 = new TrendComparisonInteger(_trend0, _trend3);
			_comparison1vs2 = new TrendComparisonInteger(_trend1, _trend2);
			_comparison1vs3 = new TrendComparisonInteger(_trend1, _trend3);
			_comparison1vs4 = new TrendComparisonInteger(_trend1, _trend4);
			_comparison1vs5 = new TrendComparisonInteger(_trend1, _trend5);
			_comparison2vs3 = new TrendComparisonInteger(_trend2, _trend3);
			_comparison3vs3 = new TrendComparisonInteger(_trend3, _trend3);
			_comparison3vs4 = new TrendComparisonInteger(_trend3, _trend4);
		}
		[TestCleanup()]
		public void TestCleanup ( ) {
			_trend0 = null;
			_trend1 = null;
			_trend2 = null;
			_trend3 = null;
			_trend4 = null;
			_trend5 = null;
			_comparison0vs0 = null;
			_comparison0vs1 = null;
			_comparison0vs3 = null;
			_comparison1vs2 = null;
			_comparison1vs3 = null;
			_comparison1vs4 = null;
			_comparison1vs5 = null;
			_comparison2vs3 = null;
			_comparison3vs3 = null;
			_comparison3vs4 = null;
		}
		#endregion
		#region AgreementCountExcludingNulls
		private void AgreementCountExcludingNulls ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.AgreementCountExcludingNulls;
			Assert.AreEqual(expected, actual, "The AgreementCountExcludingNulls should match.");
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest0vs0 ( ) {
			AgreementCountExcludingNulls(0, _comparison0vs0);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest0vs1 ( ) {
			AgreementCountExcludingNulls(0, _comparison0vs1);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest0vs3 ( ) {
			AgreementCountExcludingNulls(0, _comparison0vs3);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest1vs2 ( ) {
			AgreementCountExcludingNulls(5, _comparison1vs2);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest1vs3 ( ) {
			AgreementCountExcludingNulls(3, _comparison1vs3);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest1vs4 ( ) {
			AgreementCountExcludingNulls(0, _comparison1vs4);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest1vs5 ( ) {
			AgreementCountExcludingNulls(4, _comparison1vs5);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest2vs3 ( ) {
			AgreementCountExcludingNulls(3, _comparison2vs3);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest3vs3 ( ) {
			AgreementCountExcludingNulls(3, _comparison3vs3);
		}
		[TestMethod()]
		public void AgreementCountExcludingNullsTest3vs4 ( ) {
			AgreementCountExcludingNulls(0, _comparison3vs4);
		}
		#endregion
		#region AgreementCountOfNulls
		private void AgreementCountOfNulls ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.AgreementCountOfNulls;
			Assert.AreEqual(expected, actual, "The AgreementCountOfNulls should match.");
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest0vs0 ( ) {
			AgreementCountOfNulls(5, _comparison0vs0);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest0vs1 ( ) {
			AgreementCountOfNulls(0, _comparison0vs1);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest0vs3 ( ) {
			AgreementCountOfNulls(2, _comparison0vs3);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest1vs2 ( ) {
			AgreementCountOfNulls(0, _comparison1vs2);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest1vs3 ( ) {
			AgreementCountOfNulls(0, _comparison1vs3);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest1vs4 ( ) {
			AgreementCountOfNulls(0, _comparison1vs4);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest1vs5 ( ) {
			AgreementCountOfNulls(0, _comparison1vs5);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest2vs3 ( ) {
			AgreementCountOfNulls(0, _comparison2vs3);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest3vs3 ( ) {
			AgreementCountOfNulls(2, _comparison3vs3);
		}
		[TestMethod()]
		public void AgreementCountOfNullsTest3vs4 ( ) {
			AgreementCountOfNulls(1, _comparison3vs4);
		}
		#endregion
		#region AgreementProportionExcludingNulls
		private void AgreementProportionExcludingNulls ( double expected, ITrendComparison comparison ) {
			double actual = comparison.AgreementProportionExcludingNulls;
			Assert.AreEqual(expected, actual, "The AgreementProportionExcludingNulls should match.");
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest0vs0 ( ) {
			AgreementProportionExcludingNulls(double.NaN, _comparison0vs0);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest0vs1 ( ) {
			AgreementProportionExcludingNulls(double.NaN, _comparison0vs1);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest0vs3 ( ) {
			AgreementProportionExcludingNulls(double.NaN, _comparison0vs3);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest1vs2 ( ) {
			AgreementProportionExcludingNulls(1.0, _comparison1vs2);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest1vs3 ( ) {
			AgreementProportionExcludingNulls(1.0, _comparison1vs3);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest1vs4 ( ) {
			AgreementProportionExcludingNulls(0.0, _comparison1vs4);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest1vs5 ( ) {
			AgreementProportionExcludingNulls(4 / 5.0, _comparison1vs5);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest2vs3 ( ) {
			AgreementProportionExcludingNulls(1.0, _comparison2vs3);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest3vs3 ( ) {
			AgreementProportionExcludingNulls(1.0, _comparison3vs3);
		}
		[TestMethod()]
		public void AgreementProportionExcludingNullsTest3vs4 ( ) {
			AgreementProportionExcludingNulls(0, _comparison3vs4);
		}
		#endregion
		#region CountOfNullZeros
		private void CountOfNullZeros ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.CountOfNullZeroes;
			Assert.AreEqual(expected, actual, "The CountOfNullZeros should match.");
		}
		[TestMethod()]
		public void CountOfNullZerosTest0vs0 ( ) {
			CountOfNullZeros(0, _comparison0vs0);
		}
		[TestMethod()]
		public void CountOfNullZerosTest0vs1 ( ) {
			CountOfNullZeros(0, _comparison0vs1);
		}
		[TestMethod()]
		public void CountOfNullZerosTest0vs3 ( ) {
			CountOfNullZeros(0, _comparison0vs3);
		}
		[TestMethod()]
		public void CountOfNullZerosTest1vs2 ( ) {
			CountOfNullZeros(5, _comparison1vs2);
		}
		[TestMethod()]
		public void CountOfNullZerosTest1vs3 ( ) {
			CountOfNullZeros(3, _comparison1vs3);
		}
		[TestMethod()]
		public void CountOfNullZerosTest1vs4 ( ) {
			CountOfNullZeros(4, _comparison1vs4);
		}
		[TestMethod()]
		public void CountOfNullZerosTest1vs5 ( ) {
			CountOfNullZeros(5, _comparison1vs5);
		}
		[TestMethod()]
		public void CountOfNullZerosTest2vs3 ( ) {
			CountOfNullZeros(3, _comparison2vs3);
		}
		[TestMethod()]
		public void CountOfNullZerosTest3vs3 ( ) {
			CountOfNullZeros(3, _comparison3vs3);
		}
		[TestMethod()]
		public void CountOfNullZerosTest3vs4 ( ) {
			CountOfNullZeros(3, _comparison3vs4);
		}
		#endregion
		#region CountOfNullSingles
		private void CountOfNullSingles ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.CountOfNullSingles;
			Assert.AreEqual(expected, actual, "The CountOfNullSingles should match.");
		}
		[TestMethod()]
		public void CountOfNullSinglesTest0vs0 ( ) {
			CountOfNullSingles(0, _comparison0vs0);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest0vs1 ( ) {
			CountOfNullSingles(5, _comparison0vs1);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest0vs3 ( ) {
			CountOfNullSingles(3, _comparison0vs3);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest1vs2 ( ) {
			CountOfNullSingles(0, _comparison1vs2);
		}
		[TestMethod()]
		public void CountOfNullSingles1vs3 ( ) {
			CountOfNullSingles(2, _comparison1vs3);
		}
		[TestMethod()]
		public void CountOfNullSingles1vs4 ( ) {
			CountOfNullSingles(1, _comparison1vs4);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest1vs5 ( ) {
			CountOfNullSingles(0, _comparison1vs5);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest2vs3 ( ) {
			CountOfNullSingles(2, _comparison2vs3);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest3vs3 ( ) {
			CountOfNullSingles(0, _comparison3vs3);
		}
		[TestMethod()]
		public void CountOfNullSinglesTest3vs4 ( ) {
			CountOfNullSingles(1, _comparison3vs4);
		}
		#endregion
		#region CountOfNullDoubles
		private void CountOfNullDoubles ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.CountOfNullDoubles;
			Assert.AreEqual(expected, actual, "The CountOfNullDoubles should match.");
		}
		[TestMethod()]
		public void CountOfNullDoublesTest0vs0 ( ) {
			CountOfNullDoubles(5, _comparison0vs0);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest0vs1 ( ) {
			CountOfNullDoubles(0, _comparison0vs1);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest0vs3 ( ) {
			CountOfNullDoubles(2, _comparison0vs3);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest1vs2 ( ) {
			CountOfNullDoubles(0, _comparison1vs2);
		}
		[TestMethod()]
		public void CountOfNullDoubles1vs3 ( ) {
			CountOfNullDoubles(0, _comparison1vs3);
		}
		[TestMethod()]
		public void CountOfNullDoubles1vs4 ( ) {
			CountOfNullDoubles(0, _comparison1vs4);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest1vs5 ( ) {
			CountOfNullDoubles(0, _comparison1vs5);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest2vs3 ( ) {
			CountOfNullDoubles(0, _comparison2vs3);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest3vs3 ( ) {
			CountOfNullDoubles(2, _comparison3vs3);
		}
		[TestMethod()]
		public void CountOfNullDoublesTest3vs4 ( ) {
			CountOfNullDoubles(1, _comparison3vs4);
		}
		#endregion
		#region DisagreementCountIncludingNulls
		private void DisagreementCountIncludingNulls ( Int32 expected, ITrendComparison comparison ) {
			Int32 actual = comparison.DisagreementCountIncludingNulls;
			Assert.AreEqual(expected, actual, "The DisagreementCountIncludingNulls should match.");
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest0vs0 ( ) {
			DisagreementCountIncludingNulls(0, _comparison0vs0);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest0vs1 ( ) {
			DisagreementCountIncludingNulls(5, _comparison0vs1);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest0vs3 ( ) {
			DisagreementCountIncludingNulls(3, _comparison0vs3);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest1vs2 ( ) {
			DisagreementCountIncludingNulls(0, _comparison1vs2);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest1vs3 ( ) {
			DisagreementCountIncludingNulls(2, _comparison1vs3);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest1vs4 ( ) {
			DisagreementCountIncludingNulls(5, _comparison1vs4);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest1vs5 ( ) {
			DisagreementCountIncludingNulls(1, _comparison1vs5);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest2vs3 ( ) {
			DisagreementCountIncludingNulls(2, _comparison2vs3);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest3vs3 ( ) {
			DisagreementCountIncludingNulls(0, _comparison3vs3);
		}
		[TestMethod()]
		public void DisagreementCountIncludingNullsTest3vs4 ( ) {
			DisagreementCountIncludingNulls(4, _comparison3vs4);
		}
		#endregion
		#region JumpsAgreePerfectly
		[TestMethod()]
		public void JumpsAgreePerfectlyTest0vs0 ( ) {
			bool actual = _comparison0vs0.JumpsAgreePerfectly;
			Assert.IsTrue(actual, "The JumpsAgreePerfectly should be true.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest0vs1 ( ) {
			bool actual = _comparison0vs1.JumpsAgreePerfectly;
			Assert.IsFalse(actual, "The JumpsAgreePerfectly should be false.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest0vs3 ( ) {
			bool actual = _comparison0vs3.JumpsAgreePerfectly;
			Assert.IsFalse(actual, "The JumpsAgreePerfectly should be false.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest1vs2 ( ) {
			bool actual = _comparison1vs2.JumpsAgreePerfectly;
			Assert.IsTrue(actual, "The JumpsAgreePerfectly should be true.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest1vs3 ( ) {
			bool actual = _comparison1vs3.JumpsAgreePerfectly;
			Assert.IsTrue(actual, "The JumpsAgreePerfectly should be true.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest1vs4 ( ) {
			bool actual = _comparison1vs4.JumpsAgreePerfectly;
			Assert.IsFalse(actual, "The JumpsAgreePerfectly should be false.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest1vs5 ( ) {
			bool actual = _comparison1vs5.JumpsAgreePerfectly;
			Assert.IsFalse(actual, "The JumpsAgreePerfectly should be false.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest2vs3 ( ) {
			bool actual = _comparison2vs3.JumpsAgreePerfectly;
			Assert.IsTrue(actual, "The JumpsAgreePerfectly should be true.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest3vs3 ( ) {
			bool actual = _comparison3vs3.JumpsAgreePerfectly;
			Assert.IsTrue(actual, "The JumpsAgreePerfectly should be true.");
		}
		[TestMethod()]
		public void JumpsAgreePerfectlyTest3vs4 ( ) {
			bool actual = _comparison3vs4.JumpsAgreePerfectly;
			Assert.IsFalse(actual, "The JumpsAgreePerfectly should be false.");
		}
		#endregion
		#region LastMutualNonNullPointsAgree
		private void LastMutualNonNullPointsAgree ( bool? expected, ITrendComparison comparison ) {
			bool? actual = comparison.LastMutualNonNullPointsAgree;
			Assert.AreEqual(expected, actual, "The LastNonMutualNullPointsAgree should match.");
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree0vs0 ( ) {
			LastMutualNonNullPointsAgree(null, _comparison0vs0);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree0vs1 ( ) {
			LastMutualNonNullPointsAgree(null, _comparison0vs1);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree0vs3 ( ) {
			LastMutualNonNullPointsAgree(null, _comparison0vs3);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree1vs2 ( ) {
			LastMutualNonNullPointsAgree(true, _comparison1vs2);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree1vs3 ( ) {
			LastMutualNonNullPointsAgree(true, _comparison1vs3);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree1vs4 ( ) {
			LastMutualNonNullPointsAgree(false, _comparison1vs4);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree1vs5 ( ) {
			LastMutualNonNullPointsAgree(false, _comparison1vs5);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree2vs3 ( ) {
			LastMutualNonNullPointsAgree(true, _comparison2vs3);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree3vs3 ( ) {
			LastMutualNonNullPointsAgree(true, _comparison3vs3);
		}
		[TestMethod()]
		public void LastMutualNonNullPointsAgree3vs4 ( ) {
			LastMutualNonNullPointsAgree(false, _comparison3vs4);
		}
		#endregion
		#region LastNonMutualNullPointsYear
		private void LastNonMutualNullPointsYear ( Int16? expected, ITrendComparison comparison ) {
			Int16? actual = comparison.LastNonMutualNullPointsYear;
			Assert.AreEqual(expected, actual, "The LastNonMutualNullPointsYear should match.");
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear0vs0 ( ) {
			LastNonMutualNullPointsYear(null, _comparison0vs0);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear0vs1 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison0vs1);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear0vs3 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison0vs3);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear1vs2 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison1vs2);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear1vs3 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison1vs3);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear1vs4 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison1vs4);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear1vs5 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison1vs5);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear2vs3 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison2vs3);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear3vs3 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison3vs3);
		}
		[TestMethod()]
		public void LastNonMutualNullPointsYear3vs4 ( ) {
			LastNonMutualNullPointsYear(2006, _comparison3vs4);
		}
		#endregion
	}
}
