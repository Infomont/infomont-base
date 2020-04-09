

Select StartPoint.Name || ' - ' || (Select max(DestinationPoint.Name)) as OptionName, StartPoint.Name as StartPoint, 
(Select max(DestinationPoint.Name)) as DestinationPoint, (Select group_concat(distinct MarkType.Name)) as Marks,
group_concat(distinct MarkState.Description) as MarksQuality, Sum(Portion.Duration) as Duration, Portion.Description as ShortDescription from Portion
Inner Join Point as StartPoint
On Portion.StartPointID = StartPoint.ID
Inner Join Point as DestinationPoint
On Portion.DestinationPointID = DestinationPoint.ID
Inner Join MarkType
On Portion.MarkType = MarkType.ID
Inner Join MarkState
On Portion.MarkState = MarkState.ID
where Portion.ID in (
Select IDPortion from Cache_Trek_Portions
Where CacheTrekID in (
Select ID from Cache_Trek 
Where IDDepPoint = (Select ID from Point where name like 'Complex turistic Sambata')
And IDDestPoint = (Select ID from Point where name like 'Fereastra Mare a Sambetei'))
Order By CacheTrekID, PortionOrder
)

