﻿; SET IDENTITY_INSERT dbo.[Company] ON
; WITH Company_CTE (Id, UserId, Name, Sector, City, [Profile], Website, LinkedIn, GooglePlus, IsFeatured, IsActive) AS (
		  SELECT 1, 2, 'Admin Company', 'Sector 1', 'MN', '', 'http://www.admin.com', 'http://linkedin.com/admin', 'http://google.plus.com/admin', 1, 1
	UNION SELECT 2, 3, 'Test Company', 'Sectory 2', 'MN', '', 'http://www.test.company.com', 'http://linkedin.com/test', 'http://google.plus.com/test', 1, 1
) 
MERGE INTO dbo.[Company]
	USING Company_CTE as cte
	ON dbo.[Company].Id = cte.Id
	WHEN MATCHED THEN 
		UPDATE SET  UserId = cte.UserId,
					Name = cte.Name,
					Sector = cte.Sector,
					City = cte.City,
					[Profile] = cte.[Profile],
					Website = cte.Website,
					LinkedIn = cte.LinkedIn,
					GooglePlus = cte.GooglePlus,
					IsFeatured = cte.IsFeatured,
					IsActive = cte.IsActive
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, UserId, Name, Sector, City, [Profile], Website, LinkedIn, GooglePlus, IsFeatured, IsActive)
		VALUES (cte.Id, cte.UserId, cte.Name, cte.Sector, cte.City, cte.[Profile], cte.Website, cte.LinkedIn, cte.GooglePlus, cte.IsFeatured, cte.IsActive)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;

	DECLARE @companySeed INT
		SELECT @companySeed = MAX(Id) FROM dbo.[Company]
		DBCC CHECKIDENT ("dbo.[Company]", reseed, @companySeed)

; SET IDENTITY_INSERT dbo.[Company] OFF