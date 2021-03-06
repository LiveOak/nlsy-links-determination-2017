USE [NlsyLinks97]

SELECT --TOP (1000) 
	r.[RelatedID]
	,rs.ExtendedID

	,rs.SubjectTag_S1
	,rs.SubjectTag_S2
	,rs.hh_internal_id_s1
	,rs.hh_internal_id_s2

	,r.[RosterAssignmentID]
	,r.[ResponseLower]
	,r.[ResponseUpper]
	,r.[Resolved]
	,r.[R]
	,r.[RBoundLower]
	,r.[RBoundUpper]
	,r.[SameGeneration]
	,r.[ShareBiodad]
	,r.[ShareBiomom]
	,r.[ShareBiograndparent]
	,r.[Inconsistent]
 FROM [Process].[tblRoster] r
  left join process.tblRelatedStructure rs on r.RelatedID=rs.ID
		