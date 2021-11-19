(* ::Package:: *)

(* ::Title:: *)
(*Transmitter Birth Assumption*)


(* ::Section:: *)
(*This notebook aims to replace null birth dates with a birth date that is deduced by subtracting the median life span from the transmitter's death date.*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(** transmitter birth date and death date data with ranges evaluated **)*)


(* ::Input:: *)
(*transmitterBDDD=Import["data/base/xxx_transmitter_birth_death_with_range_evaluated.csv","CSV"];*)


(* ::Input:: *)
(*transmitterBDDD[[1]]*)


(* ::Input:: *)
(*ages={};For[i=2,i<=Length[transmitterBDDD],i++,*)
(*bd=transmitterBDDD[[i,2]];*)
(*dd=transmitterBDDD[[i,3]];*)
(*If[bd==""||dd=="",Continue[]];*)
(*ages=Append[ages,dd-bd]*)
(*]*)


(* ::Input:: *)
(*(** calculate average life span to replace null birth dates **)*)


(* ::Input:: *)
(*averageLifeSpan=Median[ages];*)


(* ::Input:: *)
(*averageLifeSpan*)


(* ::Input:: *)
(*transmitterBDDDFixed=Reap[For[i=1,i<=Length[transmitterBDDD],i++,*)
(*id=transmitterBDDD[[i,1]];*)
(*bd=transmitterBDDD[[i,2]];*)
(*dd=transmitterBDDD[[i,3]];*)
(*If[bd==""&&dd!="",bd=dd-averageLifeSpan];*)
(*If[bd==""&&dd=="",Sow[{Floor[id],"",""}],Sow[{Floor[id],Floor[bd],Floor[dd]}]];*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*transmitterBDDDFixed[[1]]*)


(* ::Input:: *)
(*(*Export["data/time/m0_transmitter_birth_death_range_evaluated_and_birth_assumed.csv",transmitterBDDDFixed];*)*)
