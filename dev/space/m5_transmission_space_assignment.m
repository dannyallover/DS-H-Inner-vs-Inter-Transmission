(* ::Package:: *)

(* ::Title:: *)
(*Transmission Space Assignment*)


(* ::Section:: *)
(*This notebook takes each transmission in our city-network and uses a probabilistic model to place the transmission in space.*)


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
(*(*narrator to city ratios*)*)


(* ::Input:: *)
(*narrCityRatios=ToExpression[Import["data/cities/m4_transmitter_to_city_ratios.csv","CSV"]];*)


(* ::Input:: *)
(*narrCityRatios[[1,2,1]]*)


(* ::Input:: *)
(*narrToCityRatios=Association[Table[narrCityRatios[[i,1]]->Association[Table[narrCityRatios[[i,2,j,1]]->narrCityRatios[[i,2,j,2]],{j,1,Length[narrCityRatios[[i,2]]],1}]],{i,1,Length[narrCityRatios],1}]];*)


(* ::Input:: *)
(*narrToCityRatios[2]*)


(* ::Input:: *)
(*(*transmiter to his/her age*)*)


(* ::Input:: *)
(*transmitterBDDD=ToExpression[Import["data/base/xxx_transmitter_birth_death_with_range_evaluated.csv","CSV"]];*)


(* ::Input:: *)
(*transmitterBDDD[[1]]*)


(* ::Input:: *)
(*transmitterToDeathDate=Association[Table[transmitterBDDD[[i,1]]->transmitterBDDD[[i,3]],{i,1,Length[transmitterBDDD],1}]];*)


(* ::Input:: *)
(*transmitterToDeathDate[2]*)


(* ::Input:: *)
(*(*cities to founding years*)*)


(* ::Input:: *)
(*cityFoundingYears=ToExpression[Import["data/cities/xxx_cities_cherry-picked_founding_years.csv","CSV"]];*)


(* ::Input:: *)
(*cityFoundingYears[[1]]*)


(* ::Input:: *)
(*cityToFoundingYear=Association[Table[{cityFoundingYears[[i,1]]->cityFoundingYears[[i,2]]},{i,1,Length[cityFoundingYears],1}]];*)


(* ::Input:: *)
(*cityToFoundingYear[\:0646\:064a\:0633\:0627\:0628\:0648\:0631]*)


(* ::Input:: *)
(*(*We place transmissions in space: for each transmission, 1) take intersection of teacher cities and student cities and 2) distribute the tarafs amongst the common cities in accordace to the city ratios of the teacher*)*)


(* ::Input:: *)
(*edgeSpaceWithRatio=Reap[For[i=1,i<=Length[edges],i++,*)
(*teacher=edges[[i,1]];*)
(*student=edges[[i,2]];*)
(*teacherCits=narrToCits[teacher];*)
(*studentCits=narrToCits[student];*)
(*list=Intersection[teacherCits,studentCits];*)
(*If[Length[list]==0,*)
(*list=teacherCits;*)
(*ddT=transmitterToDeathDate[teacher];*)
(*ddS=transmitterToDeathDate[student];*)
(*delete={};*)
(*(**if student died before teacher, we need to check for founding years again**)*)
(*For[w=1,w<=Length[list],w++,*)
(*If[ddS<cityToFoundingYear[list[[w]]],*)
(*delete=Append[delete,list[[w]]];*)
(*];*)
(*];*)
(*list=Complement[list,delete];*)
(*];*)
(*total=0;*)
(*For[z=1,z<=Length[list],z++,*)
(*total+=narrToCityRatios[teacher][list[[z]]];];*)
(*For[j=1,j<=Length[list],j++,*)
(*Sow[{edges[[i]],list[[j]],(narrToCityRatios[teacher][list[[j]]]/total)}];*)
(*]]][[2]][[1]];*)


(* ::Input:: *)
(*edgeSpaceWithRatio[[1]]*)


(* ::Input:: *)
(*(*Export["data/space/m5_edge_to_space_assignment.csv",edgeSpaceWithRatio];*)*)
