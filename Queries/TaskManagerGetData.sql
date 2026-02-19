select * from Users



declare @selectedUser uniqueidentifier = '8051a558-6f25-409b-9823-d5f5603ee625'

select * from Users where id = @selectedUser

select 
Id
,Name [ListName]
,CreatedDate
,CreatedUserId

from Lists
where CreatedUserId = @selectedUser

select * from Statuses

select * from TaskItemNotes
where CreatedUserId = @selectedUser

select * from TaskItems
where CreatedUserId = @selectedUser

select 
	t.Id
	,t.Title
	,s.Name
	,tis.CreatedDate
from TaskItemStatusHistory tis
inner join TaskItems t on tis.TaskItemId = t.Id
inner join Statuses s on tis.StatusId = s.Id
where tis.CreatedUserId = @selectedUser

select 
	l.Id
	,l.Name
	,t.Id
	,t.Title
from TaskWithinList tl
inner join Lists l on tl.TaskListId = l.Id
inner join TaskItems t on tl.TaskItemId = t.Id
where tl.CreatedUserId = @selectedUser

select 
	p.Id [parentId]
	,p.Title [parentTitle]

	,c.Id [childId]
	,c.Title [childTitle]
	,p.CreatedUserId [p - createdUser]
	,c.CreatedUserId [c - createdUser]
	,st.CreatedUserId [relation - createdUser]
from SubTasks st
inner join TaskItems p on st.TaskItemId = p.Id
inner join TaskItems c on st.SubTaskItemId = c.Id
Where st.CreatedUserId = @selectedUser




