(* ::Package:: *)

(* ::Title:: *)
(*Transmitter City Ratios*)


(* ::Section:: *)
(*When assigning a transmission to a place, we predicate it on the amount that a person is from a particular city (since transmitters often have multiple cities in their biographies). This notebook quantifies the amount that a transmitter belongs to each city (e.g. 2/5 Basra and 3/5 Kufa).*)


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
(*(*transmitters in our city-network*)*)


(* ::Input:: *)
(*transmitters=VertexList[edges];*)


(* ::Input:: *)
(*transmitters[[1]]*)


(* ::Input:: *)
(*(*each transmitter to their students and teachers*)*)


(* ::Input:: *)
(*incidence=ToExpression[Import["data/base/xxx_edge_to_teacher_and_student_incidence_edge_list.csv","CSV"]];*)


(* ::Input:: *)
(*incidence[[1]]*)


(* ::Input:: *)
(*incidenceToTeachersStudents=Association[Table[incidence[[i,1]]->{incidence[[i,2]],incidence[[i,3]]},{i,1,Length[incidence],1}]];*)


(* ::Input:: *)
(*incidenceToTeachersStudents[2]*)


(* ::Input:: *)
(*(*narrator to cities*)*)


(* ::Input:: *)
(*narrCits=ToExpression[Import["data/cities/m3_transmitter_to_cities_with_region_disambiguation_and_founding_year_corrections.csv","CSV"]];*)


(* ::Input:: *)
(*narrCits[[1]]*)


(* ::Input:: *)
(*narrToCits=Association[Table[IntegerPart[narrCits[[i,1]]]->narrCits[[i,2]],{i,1,Length[narrCits],1}]];*)


(* ::Input:: *)
(*narrToCits[8272]*)


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
(*(*since transmitters can have more than one place of stay, we say he/she is not equally from all places of stay; rather, we assign ratios to indicate a magnitude of belonging to a particular city*) *)


(* ::Input:: *)
(*transmitToRatios=Association[Table[transmitters[[i]]->{},{i,1,Length[transmitters],1}]];*)


(* ::Input:: *)
(*(*for each teacher\[Rule]transmitter and transmitter\[Rule]student relationship, find the common cities that they share, and add the taraf count of the relationship to those common cities*)For[i=1,i<=Length[transmitters],i++,*)
(*transmit=transmitters[[i]];*)
(*transmitCits=narrToCits[transmit];*)
(*teachers=incidenceToTeachersStudents[transmit][[1]][[;;,1]];*)
(*students=incidenceToTeachersStudents[transmit][[2]][[;;,2]];*)
(*For[j=1,j<=Length[teachers],j++,*)
(*teacher=teachers[[j]];*)
(*teacherCits=narrToCits[teacher];*)
(*tarafCount=edgeToCounts[DirectedEdge[teacher,transmit]][[3]];*)
(*cits=Intersection[transmitCits,teacherCits];*)
(*If[Length[cits]>0,transmitToRatios[transmit]=*)
(*Append[transmitToRatios[transmit],{cits,tarafCount}]];*)
(*];*)
(*For[j=1,j<=Length[students],j++,*)
(*student=students[[j]];*)
(*studentCits=narrToCits[student];*)
(*tarafCount=edgeToCounts[DirectedEdge[transmit,student]][[3]];*)
(*cits=Intersection[transmitCits,studentCits];*)
(*If[Length[cits]>0,transmitToRatios[transmit]=Append[transmitToRatios[transmit],{cits,tarafCount}]];*)
(*If[Length[cits]==0,transmitToRatios[transmit]=Append[transmitToRatios[transmit],{transmitCits,tarafCount}]];*)
(*];*)
(*];*)


(* ::Input:: *)
(*(*now, use the tallied taraf count for each city to assign city ratios for a transmitters cities*)*)


(* ::Input:: *)
(*For[z=1,z<=Length[transmitters],z++,*)
(*transmit=transmitters[[z]];*)
(*temp=transmitToRatios[transmit];*)
(*totalTarafs=Total[Table[temp[[i,2]],{i,1,Length[temp],1}]];*)
(*cits=DeleteDuplicates[Flatten[Table[temp[[i,1]],{i,1,Length[temp],1}]]];*)
(*citToCount=Association[Table[cits[[i]]->0,{i,1,Length[cits],1}]];*)
(*For[i=1,i<=Length[temp],i++,*)
(*list=temp[[i,1]];*)
(*count=temp[[i,2]];*)
(*For[j=1,j<=Length[list],j++,*)
(*citToCount[list[[j]]]+=(count/Length[list]);]];*)
(*For[r=1,r<=Length[cits],r++,citToCount[cits[[r]]]=citToCount[cits[[r]]]/totalTarafs];*)
(*transmitToRatios[transmit]=citToCount;]*)


(* ::Input:: *)
(*transmitToRatios[2969]*)


(* ::Input:: *)
(*(*format data to export: transmitter, list of tuples for city + ratio*)*)


(* ::Input:: *)
(*Keys[transmitToRatios][[1]]*)


(* ::Input:: *)
(*Keys[Values[transmitToRatios][[1]]]*)


(* ::Input:: *)
(*Values[Values[transmitToRatios][[1]]]*)


(* ::Input:: *)
(*transmitterCityRatios=Reap[For[i=1,i<=Length[transmitToRatios],i++,*)
(*transmitter=Keys[transmitToRatios][[i]];*)
(*cits=Keys[Values[transmitToRatios][[i]]];*)
(*ratios=Values[Values[transmitToRatios][[i]]];*)
(*dat=Partition[Riffle[cits,ratios],2];*)
(*Sow[{transmitter,dat}];*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*transmitterCityRatios[[1]]*)


(* ::Input:: *)
(*(*Export["data/cities/m4_transmitter_to_city_ratios.csv",transmitterCityRatios];*)*)
