(* ::Package:: *)

(* ::Title:: *)
(*Transmitter Region Disambiguation*)


(* ::Section:: *)
(*This notebook aims to disambiguate the regions assigned to transmitters by GK. It does so by using three rules:*)
(*1) if a transmitter is assigned a city that is enclosed by a region which they are also assigned, we simply say that the transmitter is from the city;*)
(*2) if a transmitter is assigned a region, and their teacher belongs to a city in that region, we say they are from that city; and,*)
(*3) if a transmitter is assigned a region, and their student belongs to a city in that region, we say they are from that city.*)


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
(*(*narrator to cities*)*)


(* ::Input:: *)
(*narrCits=ToExpression[Import["data/cities/xxx_transmitter_to_cities.csv","CSV"]];*)


(* ::Input:: *)
(*narrCits[[1]]*)


(* ::Input:: *)
(*narrToCits=Association[Table[IntegerPart[narrCits[[i,1]]]->narrCits[[i,2]],{i,1,Length[narrCits],1}]];*)


(* ::Input:: *)
(*narrToCits[8272]*)


(* ::Input:: *)
(*(*region (that we want to disambiguate) to the cities in that region*)*)


(* ::Input:: *)
(*regionCities=ToExpression[Import["data/regions/xxx_regions_to_cities.csv","CSV"]];*)


(* ::Input:: *)
(*regionCities[[1]]*)


(* ::Input:: *)
(*regionToCities=Association[Table[regionCities[[i,1]]->regionCities[[i,2]],{i,1,Length[regionCities],1}]];*)


(* ::Input:: *)
(*regionToCities[\:0627\:0644\:0639\:0631\:0627\:0642]*)


(* ::Input:: *)
(*disambig=Keys[regionToCities]*)


(* ::Input:: *)
(*disambig[[1]]*)


(* ::Input:: *)
(*(*if transmitter's place of stay is a region and a city within that region, we delete the region and assume they are from the city within the region (rule 1)*)*)


(* ::Input:: *)
(*narrToCits2=narrToCits;*)


(* ::Input:: *)
(*disambigList={};*)


(* ::Input:: *)
(*For[i=1,i<=Length[transmitters],i++,*)
(*transmit=transmitters[[i]];*)
(*transmitCits=narrToCits[transmit];*)
(*For[j=1,j<=Length[disambig],j++,*)
(*citD=disambig[[j]];*)
(*cit=Intersection[transmitCits,List[citD]];*)
(*If[Length[cit]==0,Continue[]];*)
(*cits=Intersection[transmitCits,regionToCities[citD]];*)
(*If[Length[cits]==0,Continue[]];*)
(*disambigList=Append[disambigList,{transmit,citD,"Rule 1"}];*)
(*narrToCits2[transmit]=DeleteCases[narrToCits2[transmit],citD];*)
(*];*)
(*];*)


(* ::Input:: *)
(*disambigList[[1]]*)


(* ::Input:: *)
(*narrToCits[2]*)


(* ::Input:: *)
(*narrToCits2[2]*)


(* ::Input:: *)
(*(**the amount of biographies disambiguated through rule 1**)*)


(* ::Input:: *)
(*rule1=Length[disambigList]*)


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
(*(*transmiter to his/her death date*)*)


(* ::Input:: *)
(*transmitterBDDD=Import["data/base/xxx_transmitter_birth_death_with_range_evaluated.csv","CSV"];*)


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
(*(*if transmitter's place of stay is a region and he/she has teacher (rule 2) or student (rule 3) from a city/cities in that region, we delete the transmitter's region and assume he/she is from such city/cities*)*)


(* ::Input:: *)
(*(*note: sensibly, we don't replace the region with the corresponding city if the transmitter died before the city was founded*)*)


(* ::Input:: *)
(*narrToCits3=narrToCits2;*)


(* ::Input:: *)
(*For[i=1,i<=Length[transmitters],i++,*)
(*transmit=transmitters[[i]];*)
(*transmitCits=narrToCits3[transmit];*)
(*transmitDD=transmitterToDeathDate[transmit];*)
(*teachers=incidenceToTeachersStudents[transmit][[1]][[;;,1]];*)
(*students=incidenceToTeachersStudents[transmit][[2]][[;;,2]];*)
(*For[j=1,j<=Length[disambig],j++,*)
(*citD=disambig[[j]];*)
(*cit=Intersection[transmitCits,List[citD]];*)
(*citsR=regionToCities[citD];*)
(*If[Length[cit]==0,Continue[]];*)
(*tN=DeleteDuplicates[Flatten[Table[Intersection[narrToCits[teachers[[z]]],citsR],{z,1,Length[teachers],1}]]];*)
(*tS=DeleteDuplicates[Flatten[Table[Intersection[narrToCits[students[[r]]],citsR],{r,1,Length[students],1}]]];*)
(*replacedCities=DeleteDuplicates[Flatten[{tN,tS}]];*)
(*replacedCitiesLegal={};*)
(*For[z=1,z<=Length[replacedCities],z++,If[transmitDD>=cityToFoundingYear[replacedCities[[z]]],replacedCitiesLegal=Append[replacedCitiesLegal,replacedCities[[z]]]]];*)
(*replacedCities=replacedCitiesLegal;*)
(*If[Length[replacedCities]==0,Continue[];];*)
(*narrToCits3[transmit]=DeleteCases[narrToCits3[transmit],citD];*)
(*narrToCits3[transmit]=DeleteDuplicates[Flatten[Append[narrToCits3[transmit],replacedCities]]];*)
(*disambigList=Append[disambigList,{transmit,citD,replacedCities, "Rule 2 and Rule 3"}];*)
(*];*)
(*];*)


(* ::Input:: *)
(*narrToCits2[22334]*)


(* ::Input:: *)
(*narrToCits3[22334]*)


(* ::Input:: *)
(*(**the amount of biographies disambiguated through rules 2 and 3**)*)


(* ::Input:: *)
(*rule2=Length[disambigList];*)


(* ::Input:: *)
(*rule2 - rule1*)


(* ::Input:: *)
(*narrCitsResults=Table[{transmitters[[i]],narrToCits3[transmitters[[i]]]},{i,1,Length[transmitters],1}];*)


(* ::Input:: *)
(*narrCitsResults[[1]]*)


(* ::Input:: *)
(*(*Export["data/cities/m2_transmitter_to_cities_with_region_disambiguation.csv",narrCitsResults];*)*)


(* ::Input:: *)
(*disambigList[[1]]*)


(* ::Input:: *)
(*disambigList[[600]]*)


(* ::Input:: *)
(*(*Export["data/cities/m2_transmitter_city_region_disambiguation_analysis.csv",disambigList];*)*)
