(* ::Package:: *)

(* ::Title:: *)
(*Transmission Time, Space, and Magnitude*)


(* ::Section:: *)
(*Previously, we bounded a time span for each transmission. Additionally, we assigned place(s) for each transmission in accordance to 1) the shared cities of the teacher and student and 2) the teacher's calculated city ratios. All together, for each transmission, we assign the following values: place, time span, and magnitude (taraf count).*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(*edges in our city-network*)*)


(* ::Input:: *)
(*edges=Flatten[ToExpression[Import["data/base/xxx_city_network_edges.csv","CSV"]]];*)


(* ::Input:: *)
(*edges[[1]]*)


(* ::Input:: *)
(*(*edge place + place ratio*)*)


(* ::Input:: *)
(*edgeSpaceWithRatio=ToExpression[Import["data/space/m5_edge_to_space_assignment.csv","CSV"]];*)


(* ::Input:: *)
(*edgeSpaceWithRatio[[1]]*)


(* ::Input:: *)
(*(*edge to time span*)*)


(* ::Input:: *)
(*edgeTimeSpan=ToExpression[Import["data/time/m1_edge_to_transmission_span.csv","CSV"]];*)


(* ::Input:: *)
(*edgeTimeSpan[[1]]*)


(* ::Input:: *)
(*edgeToTimeSpan=Association[Table[edgeTimeSpan[[i,1]]->{edgeTimeSpan[[i,2]],edgeTimeSpan[[i,3]]},{i,1,Length[edgeTimeSpan],1}]];*)


(* ::Input:: *)
(*edgeToTimeSpan[2\[DirectedEdge]415]*)


(* ::Input:: *)
(*(*for each transmission we seek the taraf count*)*)


(* ::Input::SemiBold:: *)
(*edgeToCounts=ToExpression[Import["data/base/xxx_edge_to_isnad_count_hadith_count_taraf_count.csv","CSV"]];*)


(* ::Input::SemiBold:: *)
(*edgeToCounts[[1]]*)


(* ::Input::SemiBold:: *)
(*edgeToCounts=Association[Table[edgeToCounts[[i,1]]->{edgeToCounts[[i,2,1]],edgeToCounts[[i,2,2]],edgeToCounts[[i,2,3]]},{i,1,Length[edgeToCounts],1}]];*)


(* ::Input:: *)
(*edgeToCounts[edges[[1]]]*)


(* ::Input:: *)
(*(*data: edgee, place, time-span, and count*)*)


(* ::Input:: *)
(*stm=Reap[For[i=1,i<=Length[edgeSpaceWithRatio],i++,*)
(*edge=edgeSpaceWithRatio[[i,1]];*)
(*place=edgeSpaceWithRatio[[i,2]];*)
(*ratio=edgeSpaceWithRatio[[i,3]];*)
(*start=edgeToTimeSpan[edge][[1]];*)
(*end=edgeToTimeSpan[edge][[2]];*)
(*tc=edgeToCounts[edge][[3]];*)
(*Sow[{edge,place,start,end,ratio*tc}];*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*stm[[1]]*)


(* ::Input:: *)
(*(*cities to founding years*)*)


(* ::Input:: *)
(*cityFoundingYears=ToExpression[Import["data/cities/xxx_cities_cherry-picked_founding_years.csv","CSV"]];*)


(* ::Input:: *)
(*cityFoundingYears[[1]]*)


(* ::Input:: *)
(*(*post processing for founding years*)*)


(* ::Input:: *)
(*For[i=1,i<=Length[stm],i++,*)
(*For[j=1,j<=Length[cityFoundingYears],j++,*)
(*cit=cityFoundingYears[[j,1]];*)
(*year=cityFoundingYears[[j,2]];*)
(*If[stm[[i,2]]==cit&&stm[[i,3]]<year,*)
(*stm[[i,3]]=year;*)
(*];*)
(*];*)
(*];*)


(* ::Input:: *)
(*(** we show that the start year is never greater than the end year (as an unwanted consequence of the procedure above) **)*)


(* ::Input:: *)
(*For[i=1,i<=Length[stm],i++,*)
(*If[stm[[i,3]]>stm[[i,4]],Print[i]]]*)


(* ::Input:: *)
(*(*Export["data/space-time/m6_transmission_space_time_magnitude.csv",stm];*)*)
