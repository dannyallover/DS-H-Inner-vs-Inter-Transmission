(* ::Package:: *)

(* ::Title:: *)
(*Cities Founding Years*)


(* ::Section:: *)
(*One form of data validation we can preform is to delete cities from the biographies if the transmitter died before the city was founded. This notebook aims to do just that.*)


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
(*(*narrator cities*)*)


(* ::Input:: *)
(*narrCits=ToExpression[Import["data/cities/m2_transmitter_to_cities_with_region_disambiguation.csv","CSV"]];*)


(* ::Input:: *)
(*narrCits*)


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
(*(*apply the rule*)*)


(* ::Input:: *)
(*(**before example**)*)


(* ::Input:: *)
(*narrCits[[1946]]*)


(* ::Input:: *)
(*corrected=0;*)


(* ::Input:: *)
(*For[i=1,i<=Length[transmitters],i++,*)
(*transmit=narrCits[[i,1]];*)
(*transmitDD=transmitterToDeathDate[transmit];*)
(*cits=narrCits[[i,2]];*)
(*citsCorrected={};*)
(*For[j=1,j<=Length[cits],j++,*)
(*city=cits[[j]];*)
(*If[!KeyExistsQ[cityToFoundingYear,city],citsCorrected=Append[citsCorrected,city];*)
(*Continue[];*)
(*];*)
(*If[transmitDD>=cityToFoundingYear[city],*)
(*citsCorrected=Append[citsCorrected,city];*)
(*];*)
(*];*)
(*If[cits!=citsCorrected,corrected++;];*)
(*narrCits[[i,2]]=citsCorrected;*)
(*];*)


(* ::Input:: *)
(*(**after example**)*)


(* ::Input:: *)
(*narrCits[[1946]]*)


(* ::Input:: *)
(*(*the number of biographies corrected*)*)


(* ::Input:: *)
(*corrected*)


(* ::Input:: *)
(*(*Export["data/cities/m3_transmitter_to_cities_with_region_disambiguation_and_founding_year_corrections.csv",narrCits];*)*)
