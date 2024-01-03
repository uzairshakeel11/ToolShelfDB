CREATE OR ALTER PROCEDURE GetToolList
    @ToolSearch NVARCHAR(100) =''
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        t.ToolID,
        t.ToolName,
        t.ToolDescription,
        COUNT(td.IsAvailable) AS ToolAvailable,
        (SELECT TOP 1 p.PhotoLink FROM Photo p
         INNER JOIN ToolPhotoDetails tpd ON p.PhotoID = tpd.PhotoID AND tpd.ToolID = t.ToolID) AS PhotoLink
    FROM
        Tool t
    LEFT JOIN ToolDetail td ON t.ToolID = td.ToolID AND td.IsAvailable = 1
    WHERE
        t.ToolName LIKE '%' + @ToolSearch + '%' OR
        t.ToolDescription LIKE '%' + @ToolSearch + '%'
    GROUP BY
        t.ToolID,
        t.ToolName,
        t.ToolDescription;
END;


