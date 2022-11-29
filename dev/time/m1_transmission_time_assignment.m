(* ::Package:: *)

(* ::Title:: *)
(*Transmission Time Assignment*)


(* ::Section:: *)
(*This notebook aims to bound a time span for each transmission. The motivating idea is that a transmission occurs sometime between a student's adult age and a teacher's death date.*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(** transmitter to birth and death date **)*)


(* ::Input:: *)
(*transmitterBDDDFixed=Import["data/time/m0_transmitter_birth_death_range_evaluated_and_birth_assumed.csv","CSV"];*)


(* ::Input:: *)
(*transmitterBDDDFixed[[1]]*)


(* ::Input:: *)
(*transmitterToDates=Association[Table[Floor[transmitterBDDDFixed[[i,1]]]->{transmitterBDDDFixed[[i,2]],transmitterBDDDFixed[[i,3]]},{i,1,Length[transmitterBDDDFixed],1}]];*)


(* ::Input:: *)
(*transmitterToDates[1]*)


(* ::Input:: *)
(*(** edges where each transmitter has a death date and a city **)*)


(* ::Input:: *)
(*edges=Flatten[ToExpression[Import["data/base/xxx_city_network_edges.csv","CSV"]]];*)


(* ::Input:: *)
(*edges[[1]]*)


(* ::Input:: *)
(*(** HADITH TRANSMISSION DOESN'T START UNTIL -11 **)*)


(* ::Input:: *)
(*(** USE THE +20 IF WE CAN **)*)


(* ::Input:: *)
(*count=0;*)


(* ::Input:: *)
(*edgesTimeSpan=Reap[For[i=1,i<=Length[edges],i++,*)
(*edge=edges[[i]];*)
(*teacher=edge[[1]];*)
(*student=edge[[2]];*)
(*datesTeacher=transmitterToDates[teacher];*)
(*datesStudent=transmitterToDates[student];*)
(*bdTeacher=datesTeacher[[1]];*)
(*ddTeacher=datesTeacher[[2]];*)
(*bdStudent=datesStudent[[1]];*)
(*ddStudent=datesStudent[[2]];*)
(*If[bdStudent>ddTeacher,count++;Continue[];];*)
(*CHILDHOODCONSTANT=20;*)
(*HIJRACONSTANT=-11;*)
(*startYear=Max[HIJRACONSTANT,bdStudent+CHILDHOODCONSTANT,bdTeacher+CHILDHOODCONSTANT];*)
(*endYear=Min[ddTeacher,ddStudent];*)
(*If[startYear>endYear,*)
(*startYear=Max[HIJRACONSTANT,bdStudent,bdTeacher];*)
(*];*)
(*Sow[{edge,startYear,endYear}]*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*edgesTimeSpan[[1]]*)


(* ::Input:: *)
(*(*Export["data/time/m1_edge_to_transmission_span.csv",edgesTimeSpan];*)*)
