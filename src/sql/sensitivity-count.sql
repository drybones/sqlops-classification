SELECT 
	labels.property_value,
	count(*) [InfoTypeCount]
FROM 
(
	SELECT 
		s.name [schema_name],
		o.name [table_name],
		c.name [column_name],
		ep.name [property_name],
		ep.value [property_value]
	FROM sys.extended_properties ep
	JOIN sys.objects AS o ON o.object_id = ep.major_id
	JOIN sys.columns AS c ON c.column_id = ep.minor_id AND c.object_id = ep.major_id
	JOIN sys.schemas AS s ON s.schema_id = o.schema_id
	WHERE 
		ep.name = 'sys_sensitivity_label_name'
		AND ep.class=1 AND ep.minor_id <> 0 -- Just columns
) labels
GROUP by labels.property_value