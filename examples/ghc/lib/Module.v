(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Preamble *)


(* Converted imports: *)

Require Coq.Init.Datatypes.
Require Coq.Lists.List.
Require Data.Foldable.
Require Data.Map.Internal.
Require Data.OldList.
Require Data.Ord.
Require Data.Set.Internal.
Require Data.Tuple.
Require FastString.
Require FiniteMap.
Require GHC.Base.
Require GHC.Prim.
Require Panic.
Require UniqDFM.
Require UniqDSet.
Require UniqFM.
Require Unique.
Require Util.
Import GHC.Base.Notations.

(* Converted type declarations: *)

Definition ModuleNameEnv :=
  UniqFM.UniqFM%type.

Inductive ModuleName : Type
  := Mk_ModuleName : FastString.FastString -> ModuleName.

Inductive ModLocation : Type
  := Mk_ModLocation
   : option GHC.Base.String -> GHC.Base.String -> GHC.Base.String -> ModLocation.

Inductive InstalledUnitId : Type
  := Mk_InstalledUnitId : FastString.FastString -> InstalledUnitId.

Inductive InstalledModule : Type
  := Mk_InstalledModule : InstalledUnitId -> ModuleName -> InstalledModule.

Inductive InstalledModuleEnv elt : Type
  := Mk_InstalledModuleEnv
   : (Data.Map.Internal.Map InstalledModule elt) -> InstalledModuleEnv elt.

Inductive DefUnitId : Type := Mk_DefUnitId : InstalledUnitId -> DefUnitId.

Definition DModuleNameEnv :=
  UniqDFM.UniqDFM%type.

Inductive ComponentId : Type
  := Mk_ComponentId : FastString.FastString -> ComponentId.

Inductive IndefUnitId : Type
  := Mk_IndefUnitId
   : FastString.FastString ->
     Unique.Unique ->
     ComponentId ->
     list (ModuleName * Module)%type -> UniqDSet.UniqDSet ModuleName -> IndefUnitId
with Module : Type := Mk_Module : UnitId -> ModuleName -> Module
with UnitId : Type
  := IndefiniteUnitId : IndefUnitId -> UnitId
  |  DefiniteUnitId : DefUnitId -> UnitId.

Inductive IndefModule : Type
  := Mk_IndefModule : IndefUnitId -> ModuleName -> IndefModule.

Record ContainsModule__Dict t := ContainsModule__Dict_Build {
  extractModule__ : t -> Module }.

Definition ContainsModule t :=
  forall r, (ContainsModule__Dict t -> r) -> r.

Existing Class ContainsModule.

Definition extractModule `{g : ContainsModule t} : t -> Module :=
  g _ (extractModule__ t).

Record HasModule__Dict m := HasModule__Dict_Build {
  getModule__ : m Module }.

Definition HasModule m :=
  forall r, (HasModule__Dict m -> r) -> r.

Existing Class HasModule.

Definition getModule `{g : HasModule m} : m Module :=
  g _ (getModule__ m).

Inductive NDModule : Type := Mk_NDModule : Module -> NDModule.

Inductive ModuleEnv elt : Type
  := Mk_ModuleEnv : (Data.Map.Internal.Map NDModule elt) -> ModuleEnv elt.

Definition ModuleSet :=
  (Data.Set.Internal.Set_ NDModule)%type.

Definition ShHoleSubst :=
  (ModuleNameEnv Module)%type.

Arguments Mk_InstalledModuleEnv {_} _.

Arguments Mk_ModuleEnv {_} _.

Definition installedUnitIdFS (arg_0__ : InstalledUnitId) :=
  let 'Mk_InstalledUnitId installedUnitIdFS := arg_0__ in
  installedUnitIdFS.

Definition installedModuleName (arg_0__ : InstalledModule) :=
  let 'Mk_InstalledModule _ installedModuleName := arg_0__ in
  installedModuleName.

Definition installedModuleUnitId (arg_0__ : InstalledModule) :=
  let 'Mk_InstalledModule installedModuleUnitId _ := arg_0__ in
  installedModuleUnitId.

Definition unDefUnitId (arg_0__ : DefUnitId) :=
  let 'Mk_DefUnitId unDefUnitId := arg_0__ in
  unDefUnitId.

Definition indefUnitIdComponentId (arg_0__ : IndefUnitId) :=
  let 'Mk_IndefUnitId _ _ indefUnitIdComponentId _ _ := arg_0__ in
  indefUnitIdComponentId.

Definition indefUnitIdFS (arg_0__ : IndefUnitId) :=
  let 'Mk_IndefUnitId indefUnitIdFS _ _ _ _ := arg_0__ in
  indefUnitIdFS.

Definition indefUnitIdFreeHoles (arg_0__ : IndefUnitId) :=
  let 'Mk_IndefUnitId _ _ _ _ indefUnitIdFreeHoles := arg_0__ in
  indefUnitIdFreeHoles.

Definition indefUnitIdInsts (arg_0__ : IndefUnitId) :=
  let 'Mk_IndefUnitId _ _ _ indefUnitIdInsts _ := arg_0__ in
  indefUnitIdInsts.

Definition indefUnitIdKey (arg_0__ : IndefUnitId) :=
  let 'Mk_IndefUnitId _ indefUnitIdKey _ _ _ := arg_0__ in
  indefUnitIdKey.

Definition moduleName (arg_0__ : Module) :=
  let 'Mk_Module _ moduleName := arg_0__ in
  moduleName.

Definition moduleUnitId (arg_0__ : Module) :=
  let 'Mk_Module moduleUnitId _ := arg_0__ in
  moduleUnitId.

Definition indefModuleName (arg_0__ : IndefModule) :=
  let 'Mk_IndefModule _ indefModuleName := arg_0__ in
  indefModuleName.

Definition indefModuleUnitId (arg_0__ : IndefModule) :=
  let 'Mk_IndefModule indefModuleUnitId _ := arg_0__ in
  indefModuleUnitId.

Definition unNDModule (arg_0__ : NDModule) :=
  let 'Mk_NDModule unNDModule := arg_0__ in
  unNDModule.
(* Midamble *)

Require Import GHC.Err.

Instance Default__InstalledUnitId : Default InstalledUnitId := Build_Default _ (Mk_InstalledUnitId default ).
Instance Default__DefUnitId : Default DefUnitId := Build_Default _ (Mk_DefUnitId default).
Instance Default__UnitId : Default UnitId := Build_Default _ (DefiniteUnitId default).
Instance Default__ModuleName : Default ModuleName :=
  Build_Default _ (Mk_ModuleName default).
Instance Default__Module : Default Module :=
  Build_Default _ (Mk_Module default default).
Instance Default__NDModule : Default NDModule :=
  Build_Default _ (Mk_NDModule default).
Instance Default__ModLocation : Default ModLocation :=
  Build_Default _ (Mk_ModLocation default default default).


Instance instance_Uniquable_ModuleName : Unique.Uniquable ModuleName := {}.
Admitted.
Instance instance_Uniquable_UnitId : Unique.Uniquable UnitId := {}.
Admitted.

Instance Unpeel_DefUnitId : Prim.Unpeel DefUnitId InstalledUnitId :=
  Prim.Build_Unpeel _ _ (fun arg_102__ => match arg_102__ with | Mk_DefUnitId fs => fs end) Mk_DefUnitId.
(*
Instance Unpeel_UnitId : Prim.Unpeel UnitId FastString.FastString :=
  Prim.Build_Unpeel _ _ (fun arg_102__ => match arg_102__ with | PId fs => fs end) PId.
Instance Unpeel_ModuleName : Prim.Unpeel ModuleName FastString.FastString :=
  Prim.Build_Unpeel _ _ (fun arg_142__ => match arg_142__ with | Mk_ModuleName mod_ => mod_ end) Mk_ModuleName.
*)
Instance Unpeel_NDModule : Prim.Unpeel NDModule Module :=
  Prim.Build_Unpeel _ _ (fun arg_142__ => match arg_142__ with | Mk_NDModule mod_ => mod_ end) Mk_NDModule.




(*
Definition moduleNameSlashes : ModuleName -> GHC.Base.String := fun x => default.
Definition mkModuleName : GHC.Base.String -> ModuleName := fun x => default.
*)

(* Converted value declarations: *)

Local Definition Ord__NDModule_compare : NDModule -> NDModule -> comparison :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_NDModule (Mk_Module p1 n1), Mk_NDModule (Mk_Module p2 n2) =>
        Util.thenCmp (Unique.nonDetCmpUnique (Unique.getUnique p1) (Unique.getUnique
                                              p2)) (Unique.nonDetCmpUnique (Unique.getUnique n1) (Unique.getUnique n2))
    end.

Local Definition Ord__NDModule_op_zgze__ : NDModule -> NDModule -> bool :=
  fun x y => Ord__NDModule_compare x y GHC.Base./= Lt.

Local Definition Ord__NDModule_op_zg__ : NDModule -> NDModule -> bool :=
  fun x y => Ord__NDModule_compare x y GHC.Base.== Gt.

Local Definition Ord__NDModule_op_zlze__ : NDModule -> NDModule -> bool :=
  fun x y => Ord__NDModule_compare x y GHC.Base./= Gt.

Local Definition Ord__NDModule_max : NDModule -> NDModule -> NDModule :=
  fun x y => if Ord__NDModule_op_zlze__ x y : bool then y else x.

Local Definition Ord__NDModule_min : NDModule -> NDModule -> NDModule :=
  fun x y => if Ord__NDModule_op_zlze__ x y : bool then x else y.

Local Definition Ord__NDModule_op_zl__ : NDModule -> NDModule -> bool :=
  fun x y => Ord__NDModule_compare x y GHC.Base.== Lt.

(* Skipping instance Outputable__IndefModule of class Outputable *)

(* Skipping instance Outputable__Module of class Outputable *)

(* Skipping instance Binary__Module of class Binary *)

(* Skipping instance Data__Module of class Data *)

(* Skipping instance NFData__Module of class NFData *)

(* Skipping instance
   DbUnitIdModuleRep__InstalledUnitId__ComponentId__UnitId__ModuleName__Module of
   class DbUnitIdModuleRep *)

Local Definition Eq___IndefUnitId_op_zeze__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun u1 u2 => indefUnitIdKey u1 GHC.Base.== indefUnitIdKey u2.

Local Definition Eq___IndefUnitId_op_zsze__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun x y => negb (Eq___IndefUnitId_op_zeze__ x y).

Program Instance Eq___IndefUnitId : GHC.Base.Eq_ IndefUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___IndefUnitId_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___IndefUnitId_op_zsze__ |}.

Local Definition Ord__IndefUnitId_compare
   : IndefUnitId -> IndefUnitId -> comparison :=
  fun u1 u2 => GHC.Base.compare (indefUnitIdFS u1) (indefUnitIdFS u2).

Local Definition Ord__IndefUnitId_op_zgze__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun x y => Ord__IndefUnitId_compare x y GHC.Base./= Lt.

Local Definition Ord__IndefUnitId_op_zg__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun x y => Ord__IndefUnitId_compare x y GHC.Base.== Gt.

Local Definition Ord__IndefUnitId_op_zlze__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun x y => Ord__IndefUnitId_compare x y GHC.Base./= Gt.

Local Definition Ord__IndefUnitId_max
   : IndefUnitId -> IndefUnitId -> IndefUnitId :=
  fun x y => if Ord__IndefUnitId_op_zlze__ x y : bool then y else x.

Local Definition Ord__IndefUnitId_min
   : IndefUnitId -> IndefUnitId -> IndefUnitId :=
  fun x y => if Ord__IndefUnitId_op_zlze__ x y : bool then x else y.

Local Definition Ord__IndefUnitId_op_zl__
   : IndefUnitId -> IndefUnitId -> bool :=
  fun x y => Ord__IndefUnitId_compare x y GHC.Base.== Lt.

Program Instance Ord__IndefUnitId : GHC.Base.Ord IndefUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__IndefUnitId_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__IndefUnitId_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__IndefUnitId_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__IndefUnitId_op_zgze__ ;
         GHC.Base.compare__ := Ord__IndefUnitId_compare ;
         GHC.Base.max__ := Ord__IndefUnitId_max ;
         GHC.Base.min__ := Ord__IndefUnitId_min |}.

(* Skipping instance Binary__IndefUnitId of class Binary *)

(* Skipping instance Outputable__IndefUnitId of class Outputable *)

(* Skipping instance Show__UnitId of class Show *)

Local Definition Ord__UnitId_compare : UnitId -> UnitId -> comparison :=
  fun nm1 nm2 => Eq.

Local Definition Ord__UnitId_op_zgze__ : UnitId -> UnitId -> bool :=
  fun x y => Ord__UnitId_compare x y GHC.Base./= Lt.

Local Definition Ord__UnitId_op_zg__ : UnitId -> UnitId -> bool :=
  fun x y => Ord__UnitId_compare x y GHC.Base.== Gt.

Local Definition Ord__UnitId_op_zlze__ : UnitId -> UnitId -> bool :=
  fun x y => Ord__UnitId_compare x y GHC.Base./= Gt.

Local Definition Ord__UnitId_max : UnitId -> UnitId -> UnitId :=
  fun x y => if Ord__UnitId_op_zlze__ x y : bool then y else x.

Local Definition Ord__UnitId_min : UnitId -> UnitId -> UnitId :=
  fun x y => if Ord__UnitId_op_zlze__ x y : bool then x else y.

Local Definition Ord__UnitId_op_zl__ : UnitId -> UnitId -> bool :=
  fun x y => Ord__UnitId_compare x y GHC.Base.== Lt.

(* Skipping instance Data__UnitId of class Data *)

(* Skipping instance NFData__UnitId of class NFData *)

(* Skipping instance Outputable__UnitId of class Outputable *)

(* Skipping instance Binary__UnitId of class Binary *)

(* Skipping instance Outputable__DefUnitId of class Outputable *)

(* Skipping instance Binary__DefUnitId of class Binary *)

(* Skipping instance Outputable__InstalledModule of class Outputable *)

(* Skipping instance Binary__InstalledUnitId of class Binary *)

(* Skipping instance BinaryStringRep__InstalledUnitId of class
   BinaryStringRep *)

Local Definition Ord__InstalledUnitId_compare
   : InstalledUnitId -> InstalledUnitId -> comparison :=
  fun u1 u2 => GHC.Base.compare (installedUnitIdFS u1) (installedUnitIdFS u2).

Local Definition Ord__InstalledUnitId_op_zgze__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun x y => Ord__InstalledUnitId_compare x y GHC.Base./= Lt.

Local Definition Ord__InstalledUnitId_op_zg__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun x y => Ord__InstalledUnitId_compare x y GHC.Base.== Gt.

Local Definition Ord__InstalledUnitId_op_zlze__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun x y => Ord__InstalledUnitId_compare x y GHC.Base./= Gt.

Local Definition Ord__InstalledUnitId_max
   : InstalledUnitId -> InstalledUnitId -> InstalledUnitId :=
  fun x y => if Ord__InstalledUnitId_op_zlze__ x y : bool then y else x.

Local Definition Ord__InstalledUnitId_min
   : InstalledUnitId -> InstalledUnitId -> InstalledUnitId :=
  fun x y => if Ord__InstalledUnitId_op_zlze__ x y : bool then x else y.

Local Definition Ord__InstalledUnitId_op_zl__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun x y => Ord__InstalledUnitId_compare x y GHC.Base.== Lt.

(* Skipping instance Outputable__InstalledUnitId of class Outputable *)

(* Skipping instance BinaryStringRep__ComponentId of class BinaryStringRep *)

Local Definition Uniquable__ComponentId_getUnique
   : ComponentId -> Unique.Unique :=
  fun '(Mk_ComponentId n) => Unique.getUnique n.

Program Instance Uniquable__ComponentId : Unique.Uniquable ComponentId :=
  fun _ k => k {| Unique.getUnique__ := Uniquable__ComponentId_getUnique |}.

(* Skipping instance Outputable__ComponentId of class Outputable *)

(* Skipping instance Binary__ComponentId of class Binary *)

Local Definition Uniquable__ModuleName_getUnique
   : ModuleName -> Unique.Unique :=
  fun '(Mk_ModuleName nm) => Unique.getUnique nm.

Program Instance Uniquable__ModuleName : Unique.Uniquable ModuleName :=
  fun _ k => k {| Unique.getUnique__ := Uniquable__ModuleName_getUnique |}.

Local Definition Eq___ModuleName_op_zeze__ : ModuleName -> ModuleName -> bool :=
  fun nm1 nm2 => Unique.getUnique nm1 GHC.Base.== Unique.getUnique nm2.

Local Definition Eq___ModuleName_op_zsze__ : ModuleName -> ModuleName -> bool :=
  fun x y => negb (Eq___ModuleName_op_zeze__ x y).

Program Instance Eq___ModuleName : GHC.Base.Eq_ ModuleName :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___ModuleName_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___ModuleName_op_zsze__ |}.

Local Definition Ord__ModuleName_compare
   : ModuleName -> ModuleName -> comparison :=
  fun nm1 nm2 => Eq.

Local Definition Ord__ModuleName_op_zgze__ : ModuleName -> ModuleName -> bool :=
  fun x y => Ord__ModuleName_compare x y GHC.Base./= Lt.

Local Definition Ord__ModuleName_op_zg__ : ModuleName -> ModuleName -> bool :=
  fun x y => Ord__ModuleName_compare x y GHC.Base.== Gt.

Local Definition Ord__ModuleName_op_zlze__ : ModuleName -> ModuleName -> bool :=
  fun x y => Ord__ModuleName_compare x y GHC.Base./= Gt.

Local Definition Ord__ModuleName_max : ModuleName -> ModuleName -> ModuleName :=
  fun x y => if Ord__ModuleName_op_zlze__ x y : bool then y else x.

Local Definition Ord__ModuleName_min : ModuleName -> ModuleName -> ModuleName :=
  fun x y => if Ord__ModuleName_op_zlze__ x y : bool then x else y.

Local Definition Ord__ModuleName_op_zl__ : ModuleName -> ModuleName -> bool :=
  fun x y => Ord__ModuleName_compare x y GHC.Base.== Lt.

Program Instance Ord__ModuleName : GHC.Base.Ord ModuleName :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__ModuleName_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__ModuleName_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__ModuleName_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__ModuleName_op_zgze__ ;
         GHC.Base.compare__ := Ord__ModuleName_compare ;
         GHC.Base.max__ := Ord__ModuleName_max ;
         GHC.Base.min__ := Ord__ModuleName_min |}.

(* Skipping instance Outputable__ModuleName of class Outputable *)

(* Skipping instance Binary__ModuleName of class Binary *)

(* Skipping instance BinaryStringRep__ModuleName of class BinaryStringRep *)

(* Skipping instance Data__ModuleName of class Data *)

(* Skipping instance NFData__ModuleName of class NFData *)

(* Skipping instance Outputable__ModLocation of class Outputable *)

Local Definition Ord__IndefModule_compare
   : IndefModule -> IndefModule -> comparison :=
  fun a b =>
    let 'Mk_IndefModule a1 a2 := a in
    let 'Mk_IndefModule b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => Lt
    | Eq => (GHC.Base.compare a2 b2)
    | Gt => Gt
    end.

Local Definition Eq___IndefModule_op_zeze__
   : IndefModule -> IndefModule -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_IndefModule a1 a2, Mk_IndefModule b1 b2 =>
        (andb ((a1 GHC.Base.== b1)) ((a2 GHC.Base.== b2)))
    end.

Local Definition Eq___IndefModule_op_zsze__
   : IndefModule -> IndefModule -> bool :=
  fun x y => negb (Eq___IndefModule_op_zeze__ x y).

Program Instance Eq___IndefModule : GHC.Base.Eq_ IndefModule :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___IndefModule_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___IndefModule_op_zsze__ |}.

(* Skipping instance Ord__ComponentId *)

(* Skipping instance Eq___ComponentId *)

(* Skipping instance Show__ModLocation of class Show *)

Definition emptyModuleSet : ModuleSet :=
  Data.Set.Internal.empty.

Definition filterInstalledModuleEnv {a}
   : (InstalledModule -> a -> bool) ->
     InstalledModuleEnv a -> InstalledModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, Mk_InstalledModuleEnv e =>
        Mk_InstalledModuleEnv (Data.Map.Internal.filterWithKey f e)
    end.

Definition filterModuleEnv {a}
   : (Module -> a -> bool) -> ModuleEnv a -> ModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, Mk_ModuleEnv e =>
        Mk_ModuleEnv (Data.Map.Internal.filterWithKey (f GHC.Base.∘ unNDModule) e)
    end.

Definition fsToInstalledUnitId : FastString.FastString -> InstalledUnitId :=
  fun fs => Mk_InstalledUnitId fs.

Definition stringToInstalledUnitId : GHC.Base.String -> InstalledUnitId :=
  fsToInstalledUnitId GHC.Base.∘ FastString.mkFastString.

Definition componentIdToInstalledUnitId : ComponentId -> InstalledUnitId :=
  fun '(Mk_ComponentId fs) => fsToInstalledUnitId fs.

Definition splitUnitIdInsts
   : UnitId -> (InstalledUnitId * option IndefUnitId)%type :=
  fun arg_0__ =>
    match arg_0__ with
    | IndefiniteUnitId iuid =>
        pair (componentIdToInstalledUnitId (indefUnitIdComponentId iuid)) (Some iuid)
    | DefiniteUnitId (Mk_DefUnitId uid) => pair uid None
    end.

Definition splitModuleInsts
   : Module -> (InstalledModule * option IndefModule)%type :=
  fun m =>
    let 'pair uid mb_iuid := splitUnitIdInsts (moduleUnitId m) in
    pair (Mk_InstalledModule uid (moduleName m)) (GHC.Base.fmap (fun iuid =>
                                                                   Mk_IndefModule iuid (moduleName m)) mb_iuid).

Definition toInstalledUnitId : UnitId -> InstalledUnitId :=
  fun arg_0__ =>
    match arg_0__ with
    | DefiniteUnitId (Mk_DefUnitId iuid) => iuid
    | IndefiniteUnitId indef =>
        componentIdToInstalledUnitId (indefUnitIdComponentId indef)
    end.

Definition fsToUnitId : FastString.FastString -> UnitId :=
  DefiniteUnitId GHC.Base.∘ (Mk_DefUnitId GHC.Base.∘ Mk_InstalledUnitId).

Definition holeUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "hole")).

Definition interactiveUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "interactive")).

Definition mainUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "main")).

Definition newSimpleUnitId : ComponentId -> UnitId :=
  fun '(Mk_ComponentId fs) => fsToUnitId fs.

Definition primUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "ghc-prim")).

Definition rtsUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "rts")).

Definition stringToUnitId : GHC.Base.String -> UnitId :=
  fsToUnitId GHC.Base.∘ FastString.mkFastString.

Definition thUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "template-haskell")).

Definition thisGhcUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "ghc")).

Definition dphSeqUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "dph-seq")).

Definition dphParUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "dph-par")).

Definition baseUnitId : UnitId :=
  fsToUnitId (FastString.fsLit (GHC.Base.hs_string__ "base")).

Definition installedUnitIdKey : InstalledUnitId -> Unique.Unique :=
  Unique.getUnique GHC.Base.∘ installedUnitIdFS.

Definition unitIdKey : UnitId -> Unique.Unique :=
  fun arg_0__ =>
    match arg_0__ with
    | IndefiniteUnitId x => indefUnitIdKey x
    | DefiniteUnitId (Mk_DefUnitId x) => installedUnitIdKey x
    end.

Local Definition Uniquable__UnitId_getUnique : UnitId -> Unique.Unique :=
  unitIdKey.

Program Instance Uniquable__UnitId : Unique.Uniquable UnitId :=
  fun _ k => k {| Unique.getUnique__ := Uniquable__UnitId_getUnique |}.

Local Definition Eq___UnitId_op_zeze__ : UnitId -> UnitId -> bool :=
  fun uid1 uid2 => unitIdKey uid1 GHC.Base.== unitIdKey uid2.

Local Definition Eq___UnitId_op_zsze__ : UnitId -> UnitId -> bool :=
  fun x y => negb (Eq___UnitId_op_zeze__ x y).

Program Instance Eq___UnitId : GHC.Base.Eq_ UnitId :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___UnitId_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___UnitId_op_zsze__ |}.

Definition isHoleModule : Module -> bool :=
  fun mod_ => moduleUnitId mod_ GHC.Base.== holeUnitId.

Definition isInteractiveModule : Module -> bool :=
  fun mod_ => moduleUnitId mod_ GHC.Base.== interactiveUnitId.

Local Definition Eq___Module_op_zeze__ : Module -> Module -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_Module a1 a2, Mk_Module b1 b2 =>
        (andb ((a1 GHC.Base.== b1)) ((a2 GHC.Base.== b2)))
    end.

Local Definition Eq___Module_op_zsze__ : Module -> Module -> bool :=
  fun x y => negb (Eq___Module_op_zeze__ x y).

Program Instance Eq___Module : GHC.Base.Eq_ Module :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___Module_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___Module_op_zsze__ |}.

Local Definition Eq___NDModule_op_zeze__ : NDModule -> NDModule -> bool :=
  GHC.Prim.coerce _GHC.Base.==_.

Local Definition Eq___NDModule_op_zsze__ : NDModule -> NDModule -> bool :=
  GHC.Prim.coerce _GHC.Base./=_.

Program Instance Eq___NDModule : GHC.Base.Eq_ NDModule :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___NDModule_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___NDModule_op_zsze__ |}.

Program Instance Ord__NDModule : GHC.Base.Ord NDModule :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__NDModule_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__NDModule_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__NDModule_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__NDModule_op_zgze__ ;
         GHC.Base.compare__ := Ord__NDModule_compare ;
         GHC.Base.max__ := Ord__NDModule_max ;
         GHC.Base.min__ := Ord__NDModule_min |}.

Definition extendModuleSetList : ModuleSet -> list Module -> ModuleSet :=
  fun s ms =>
    Data.Foldable.foldl' (GHC.Prim.coerce GHC.Base.∘
                          GHC.Base.flip Data.Set.Internal.insert) s ms.

Definition extendModuleSet : ModuleSet -> Module -> ModuleSet :=
  fun s m => Data.Set.Internal.insert (Mk_NDModule m) s.

Definition extendModuleEnvWith {a}
   : (a -> a -> a) -> ModuleEnv a -> Module -> a -> ModuleEnv a :=
  fun arg_0__ arg_1__ arg_2__ arg_3__ =>
    match arg_0__, arg_1__, arg_2__, arg_3__ with
    | f, Mk_ModuleEnv e, m, x =>
        Mk_ModuleEnv (Data.Map.Internal.insertWith f (Mk_NDModule m) x e)
    end.

Definition extendModuleEnvList_C {a}
   : (a -> a -> a) -> ModuleEnv a -> list (Module * a)%type -> ModuleEnv a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | f, Mk_ModuleEnv e, xs =>
        Mk_ModuleEnv (FiniteMap.insertListWith f (let cont_3__ arg_4__ :=
                                                    let 'pair k v := arg_4__ in
                                                    cons (pair (Mk_NDModule k) v) nil in
                                                  Coq.Lists.List.flat_map cont_3__ xs) e)
    end.

Definition extendModuleEnvList {a}
   : ModuleEnv a -> list (Module * a)%type -> ModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_ModuleEnv e, xs =>
        Mk_ModuleEnv (FiniteMap.insertList (let cont_2__ arg_3__ :=
                                              let 'pair k v := arg_3__ in
                                              cons (pair (Mk_NDModule k) v) nil in
                                            Coq.Lists.List.flat_map cont_2__ xs) e)
    end.

Definition extendModuleEnv {a} : ModuleEnv a -> Module -> a -> ModuleEnv a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | Mk_ModuleEnv e, m, x =>
        Mk_ModuleEnv (Data.Map.Internal.insert (Mk_NDModule m) x e)
    end.

Definition emptyModuleEnv {a} : ModuleEnv a :=
  Mk_ModuleEnv Data.Map.Internal.empty.

Definition emptyInstalledModuleEnv {a} : InstalledModuleEnv a :=
  Mk_InstalledModuleEnv Data.Map.Internal.empty.

Definition elemModuleSet : Module -> ModuleSet -> bool :=
  Data.Set.Internal.member GHC.Base.∘ GHC.Prim.coerce.

Definition elemModuleEnv {a} : Module -> ModuleEnv a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | m, Mk_ModuleEnv e => Data.Map.Internal.member (Mk_NDModule m) e
    end.

Definition delModuleSet : ModuleSet -> Module -> ModuleSet :=
  GHC.Prim.coerce (GHC.Base.flip Data.Set.Internal.delete).

Definition delModuleEnvList {a} : ModuleEnv a -> list Module -> ModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_ModuleEnv e, ms =>
        Mk_ModuleEnv (FiniteMap.deleteList (GHC.Base.map Mk_NDModule ms) e)
    end.

Definition delModuleEnv {a} : ModuleEnv a -> Module -> ModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_ModuleEnv e, m => Mk_ModuleEnv (Data.Map.Internal.delete (Mk_NDModule m) e)
    end.

Program Instance Ord__UnitId : GHC.Base.Ord UnitId :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__UnitId_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__UnitId_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__UnitId_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__UnitId_op_zgze__ ;
         GHC.Base.compare__ := Ord__UnitId_compare ;
         GHC.Base.max__ := Ord__UnitId_max ;
         GHC.Base.min__ := Ord__UnitId_min |}.

Local Definition Ord__Module_op_zl__ : Module -> Module -> bool :=
  fun a b =>
    let 'Mk_Module a1 a2 := a in
    let 'Mk_Module b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => true
    | Eq => (a2 GHC.Base.< b2)
    | Gt => false
    end.

Local Definition Ord__Module_op_zlze__ : Module -> Module -> bool :=
  fun a b => negb (Ord__Module_op_zl__ b a).

Local Definition Ord__Module_max : Module -> Module -> Module :=
  fun x y => if Ord__Module_op_zlze__ x y : bool then y else x.

Local Definition Ord__Module_min : Module -> Module -> Module :=
  fun x y => if Ord__Module_op_zlze__ x y : bool then x else y.

Local Definition Ord__Module_op_zg__ : Module -> Module -> bool :=
  fun a b => Ord__Module_op_zl__ b a.

Local Definition Ord__Module_op_zgze__ : Module -> Module -> bool :=
  fun a b => negb (Ord__Module_op_zl__ a b).

Local Definition Ord__Module_compare : Module -> Module -> comparison :=
  fun a b =>
    let 'Mk_Module a1 a2 := a in
    let 'Mk_Module b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => Lt
    | Eq => (GHC.Base.compare a2 b2)
    | Gt => Gt
    end.

Program Instance Ord__Module : GHC.Base.Ord Module :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__Module_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__Module_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__Module_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__Module_op_zgze__ ;
         GHC.Base.compare__ := Ord__Module_compare ;
         GHC.Base.max__ := Ord__Module_max ;
         GHC.Base.min__ := Ord__Module_min |}.

Local Definition Uniquable__InstalledUnitId_getUnique
   : InstalledUnitId -> Unique.Unique :=
  installedUnitIdKey.

Program Instance Uniquable__InstalledUnitId
   : Unique.Uniquable InstalledUnitId :=
  fun _ k => k {| Unique.getUnique__ := Uniquable__InstalledUnitId_getUnique |}.

Local Definition Eq___InstalledUnitId_op_zeze__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun uid1 uid2 => installedUnitIdKey uid1 GHC.Base.== installedUnitIdKey uid2.

Local Definition Eq___InstalledUnitId_op_zsze__
   : InstalledUnitId -> InstalledUnitId -> bool :=
  fun x y => negb (Eq___InstalledUnitId_op_zeze__ x y).

Program Instance Eq___InstalledUnitId : GHC.Base.Eq_ InstalledUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___InstalledUnitId_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___InstalledUnitId_op_zsze__ |}.

Definition installedUnitIdEq : InstalledUnitId -> UnitId -> bool :=
  fun iuid uid => Data.Tuple.fst (splitUnitIdInsts uid) GHC.Base.== iuid.

Local Definition Eq___InstalledModule_op_zeze__
   : InstalledModule -> InstalledModule -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_InstalledModule a1 a2, Mk_InstalledModule b1 b2 =>
        (andb ((a1 GHC.Base.== b1)) ((a2 GHC.Base.== b2)))
    end.

Local Definition Eq___InstalledModule_op_zsze__
   : InstalledModule -> InstalledModule -> bool :=
  fun x y => negb (Eq___InstalledModule_op_zeze__ x y).

Program Instance Eq___InstalledModule : GHC.Base.Eq_ InstalledModule :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___InstalledModule_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___InstalledModule_op_zsze__ |}.

Definition installedModuleEq : InstalledModule -> Module -> bool :=
  fun imod mod_ => Data.Tuple.fst (splitModuleInsts mod_) GHC.Base.== imod.

Local Definition Eq___DefUnitId_op_zeze__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base.==_.

Local Definition Eq___DefUnitId_op_zsze__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base./=_.

Program Instance Eq___DefUnitId : GHC.Base.Eq_ DefUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___DefUnitId_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___DefUnitId_op_zsze__ |}.

Program Instance Ord__InstalledUnitId : GHC.Base.Ord InstalledUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__InstalledUnitId_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__InstalledUnitId_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__InstalledUnitId_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__InstalledUnitId_op_zgze__ ;
         GHC.Base.compare__ := Ord__InstalledUnitId_compare ;
         GHC.Base.max__ := Ord__InstalledUnitId_max ;
         GHC.Base.min__ := Ord__InstalledUnitId_min |}.

Local Definition Ord__InstalledModule_op_zl__
   : InstalledModule -> InstalledModule -> bool :=
  fun a b =>
    let 'Mk_InstalledModule a1 a2 := a in
    let 'Mk_InstalledModule b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => true
    | Eq => (a2 GHC.Base.< b2)
    | Gt => false
    end.

Local Definition Ord__InstalledModule_op_zlze__
   : InstalledModule -> InstalledModule -> bool :=
  fun a b => negb (Ord__InstalledModule_op_zl__ b a).

Local Definition Ord__InstalledModule_max
   : InstalledModule -> InstalledModule -> InstalledModule :=
  fun x y => if Ord__InstalledModule_op_zlze__ x y : bool then y else x.

Local Definition Ord__InstalledModule_min
   : InstalledModule -> InstalledModule -> InstalledModule :=
  fun x y => if Ord__InstalledModule_op_zlze__ x y : bool then x else y.

Local Definition Ord__InstalledModule_op_zg__
   : InstalledModule -> InstalledModule -> bool :=
  fun a b => Ord__InstalledModule_op_zl__ b a.

Local Definition Ord__InstalledModule_op_zgze__
   : InstalledModule -> InstalledModule -> bool :=
  fun a b => negb (Ord__InstalledModule_op_zl__ a b).

Local Definition Ord__InstalledModule_compare
   : InstalledModule -> InstalledModule -> comparison :=
  fun a b =>
    let 'Mk_InstalledModule a1 a2 := a in
    let 'Mk_InstalledModule b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => Lt
    | Eq => (GHC.Base.compare a2 b2)
    | Gt => Gt
    end.

Program Instance Ord__InstalledModule : GHC.Base.Ord InstalledModule :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__InstalledModule_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__InstalledModule_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__InstalledModule_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__InstalledModule_op_zgze__ ;
         GHC.Base.compare__ := Ord__InstalledModule_compare ;
         GHC.Base.max__ := Ord__InstalledModule_max ;
         GHC.Base.min__ := Ord__InstalledModule_min |}.

Definition extendInstalledModuleEnv {a}
   : InstalledModuleEnv a -> InstalledModule -> a -> InstalledModuleEnv a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | Mk_InstalledModuleEnv e, m, x =>
        Mk_InstalledModuleEnv (Data.Map.Internal.insert m x e)
    end.

Definition delInstalledModuleEnv {a}
   : InstalledModuleEnv a -> InstalledModule -> InstalledModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_InstalledModuleEnv e, m =>
        Mk_InstalledModuleEnv (Data.Map.Internal.delete m e)
    end.

Local Definition Ord__DefUnitId_op_zl__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base.<_.

Local Definition Ord__DefUnitId_op_zlze__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base.<=_.

Local Definition Ord__DefUnitId_op_zg__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base.>_.

Local Definition Ord__DefUnitId_op_zgze__ : DefUnitId -> DefUnitId -> bool :=
  GHC.Prim.coerce _GHC.Base.>=_.

Local Definition Ord__DefUnitId_compare
   : DefUnitId -> DefUnitId -> comparison :=
  GHC.Prim.coerce GHC.Base.compare.

Local Definition Ord__DefUnitId_max : DefUnitId -> DefUnitId -> DefUnitId :=
  GHC.Prim.coerce GHC.Base.max.

Local Definition Ord__DefUnitId_min : DefUnitId -> DefUnitId -> DefUnitId :=
  GHC.Prim.coerce GHC.Base.min.

Program Instance Ord__DefUnitId : GHC.Base.Ord DefUnitId :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__DefUnitId_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__DefUnitId_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__DefUnitId_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__DefUnitId_op_zgze__ ;
         GHC.Base.compare__ := Ord__DefUnitId_compare ;
         GHC.Base.max__ := Ord__DefUnitId_max ;
         GHC.Base.min__ := Ord__DefUnitId_min |}.

Local Definition Ord__IndefModule_op_zl__
   : IndefModule -> IndefModule -> bool :=
  fun a b =>
    let 'Mk_IndefModule a1 a2 := a in
    let 'Mk_IndefModule b1 b2 := b in
    match (GHC.Base.compare a1 b1) with
    | Lt => true
    | Eq => (a2 GHC.Base.< b2)
    | Gt => false
    end.

Local Definition Ord__IndefModule_op_zlze__
   : IndefModule -> IndefModule -> bool :=
  fun a b => negb (Ord__IndefModule_op_zl__ b a).

Local Definition Ord__IndefModule_max
   : IndefModule -> IndefModule -> IndefModule :=
  fun x y => if Ord__IndefModule_op_zlze__ x y : bool then y else x.

Local Definition Ord__IndefModule_min
   : IndefModule -> IndefModule -> IndefModule :=
  fun x y => if Ord__IndefModule_op_zlze__ x y : bool then x else y.

Local Definition Ord__IndefModule_op_zg__
   : IndefModule -> IndefModule -> bool :=
  fun a b => Ord__IndefModule_op_zl__ b a.

Local Definition Ord__IndefModule_op_zgze__
   : IndefModule -> IndefModule -> bool :=
  fun a b => negb (Ord__IndefModule_op_zl__ a b).

Program Instance Ord__IndefModule : GHC.Base.Ord IndefModule :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__IndefModule_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__IndefModule_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__IndefModule_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__IndefModule_op_zgze__ ;
         GHC.Base.compare__ := Ord__IndefModule_compare ;
         GHC.Base.max__ := Ord__IndefModule_max ;
         GHC.Base.min__ := Ord__IndefModule_min |}.

Definition installedUnitIdString : InstalledUnitId -> GHC.Base.String :=
  FastString.unpackFS GHC.Base.∘ installedUnitIdFS.

Definition intersectModuleSet : ModuleSet -> ModuleSet -> ModuleSet :=
  GHC.Prim.coerce Data.Set.Internal.intersection.

Definition isEmptyModuleEnv {a} : ModuleEnv a -> bool :=
  fun '(Mk_ModuleEnv e) => Data.Map.Internal.null e.

Definition lookupInstalledModuleEnv {a}
   : InstalledModuleEnv a -> InstalledModule -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_InstalledModuleEnv e, m => Data.Map.Internal.lookup m e
    end.

Definition lookupModuleEnv {a} : ModuleEnv a -> Module -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_ModuleEnv e, m => Data.Map.Internal.lookup (Mk_NDModule m) e
    end.

Definition lookupWithDefaultModuleEnv {a} : ModuleEnv a -> a -> Module -> a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | Mk_ModuleEnv e, x, m => Data.Map.Internal.findWithDefault x (Mk_NDModule m) e
    end.

Definition mapModuleEnv {a} {b} : (a -> b) -> ModuleEnv a -> ModuleEnv b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, Mk_ModuleEnv e =>
        Mk_ModuleEnv (Data.Map.Internal.mapWithKey (fun arg_2__ arg_3__ =>
                                                      match arg_2__, arg_3__ with
                                                      | _, v => f v
                                                      end) e)
    end.

Definition minusModuleSet : ModuleSet -> ModuleSet -> ModuleSet :=
  GHC.Prim.coerce Data.Set.Internal.difference.

Definition mkModule : UnitId -> ModuleName -> Module :=
  Mk_Module.

Definition mkHoleModule : ModuleName -> Module :=
  mkModule holeUnitId.

Definition mkModuleEnv {a} : list (Module * a)%type -> ModuleEnv a :=
  fun xs =>
    Mk_ModuleEnv (Data.Map.Internal.fromList (let cont_0__ arg_1__ :=
                                                let 'pair k v := arg_1__ in
                                                cons (pair (Mk_NDModule k) v) nil in
                                              Coq.Lists.List.flat_map cont_0__ xs)).

Definition mkModuleNameFS : FastString.FastString -> ModuleName :=
  fun s => Mk_ModuleName s.

Definition mkModuleSet : list Module -> ModuleSet :=
  Data.Set.Internal.fromList GHC.Base.∘ GHC.Prim.coerce.

Definition moduleEnvKeys {a} : ModuleEnv a -> list Module :=
  fun '(Mk_ModuleEnv e) =>
    Data.OldList.sort (GHC.Base.map unNDModule (Data.Map.Internal.keys e)).

Definition moduleEnvToList {a} : ModuleEnv a -> list (Module * a)%type :=
  fun '(Mk_ModuleEnv e) =>
    Data.OldList.sortBy (Data.Ord.comparing Data.Tuple.fst) (let cont_1__ arg_2__ :=
                                                               let 'pair (Mk_NDModule m) v := arg_2__ in
                                                               cons (pair m v) nil in
                                                             Coq.Lists.List.flat_map cont_1__ (Data.Map.Internal.toList
                                                                                      e)).

Definition moduleEnvElts {a} : ModuleEnv a -> list a :=
  fun e => GHC.Base.map Data.Tuple.snd (moduleEnvToList e).

Definition moduleNameFS : ModuleName -> FastString.FastString :=
  fun '(Mk_ModuleName mod_) => mod_.

Definition stableModuleNameCmp : ModuleName -> ModuleName -> comparison :=
  fun n1 n2 => GHC.Base.compare (moduleNameFS n1) (moduleNameFS n2).

Definition moduleNameString : ModuleName -> GHC.Base.String :=
  fun '(Mk_ModuleName mod_) => FastString.unpackFS mod_.

Definition moduleNameColons : ModuleName -> GHC.Base.String :=
  let dots_to_colons :=
    GHC.Base.map (fun c =>
                    if c GHC.Base.== GHC.Char.hs_char__ "." : bool
                    then GHC.Char.hs_char__ ":"
                    else c) in
  dots_to_colons GHC.Base.∘ moduleNameString.

Definition moduleSetElts : ModuleSet -> list Module :=
  Data.OldList.sort GHC.Base.∘
  (GHC.Prim.coerce GHC.Base.∘ Data.Set.Internal.toList).

Definition plusModuleEnv {a} : ModuleEnv a -> ModuleEnv a -> ModuleEnv a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_ModuleEnv e1, Mk_ModuleEnv e2 =>
        Mk_ModuleEnv (Data.Map.Internal.union e1 e2)
    end.

Definition plusModuleEnv_C {a}
   : (a -> a -> a) -> ModuleEnv a -> ModuleEnv a -> ModuleEnv a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | f, Mk_ModuleEnv e1, Mk_ModuleEnv e2 =>
        Mk_ModuleEnv (Data.Map.Internal.unionWith f e1 e2)
    end.

Definition pprUnitId : UnitId -> GHC.Base.String :=
  fun arg_0__ =>
    match arg_0__ with
    | DefiniteUnitId uid => Panic.noString uid
    | IndefiniteUnitId uid => Panic.noString uid
    end.

Definition unionModuleSet : ModuleSet -> ModuleSet -> ModuleSet :=
  GHC.Prim.coerce Data.Set.Internal.union.

Definition unitIdFS : UnitId -> FastString.FastString :=
  fun arg_0__ =>
    match arg_0__ with
    | IndefiniteUnitId x => indefUnitIdFS x
    | DefiniteUnitId (Mk_DefUnitId x) => installedUnitIdFS x
    end.

Definition unitIdString : UnitId -> GHC.Base.String :=
  FastString.unpackFS GHC.Base.∘ unitIdFS.

Definition moduleStableString : Module -> GHC.Base.String :=
  fun '(Mk_Module moduleUnitId moduleName) =>
    Coq.Init.Datatypes.app (GHC.Base.hs_string__ "$") (Coq.Init.Datatypes.app
                            (unitIdString moduleUnitId) (Coq.Init.Datatypes.app (GHC.Base.hs_string__ "$")
                                                                                (moduleNameString moduleName))).

Definition stableUnitIdCmp : UnitId -> UnitId -> comparison :=
  fun p1 p2 => GHC.Base.compare (unitIdFS p1) (unitIdFS p2).

Definition stableModuleCmp : Module -> Module -> comparison :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | Mk_Module p1 n1, Mk_Module p2 n2 =>
        Util.thenCmp (stableUnitIdCmp p1 p2) (stableModuleNameCmp n1 n2)
    end.

Local Definition Uniquable__Module_getUnique : Module -> Unique.Unique :=
  fun '(Mk_Module p n) =>
    Unique.getUnique (FastString.appendFS (unitIdFS p) (moduleNameFS n)).

Program Instance Uniquable__Module : Unique.Uniquable Module :=
  fun _ k => k {| Unique.getUnique__ := Uniquable__Module_getUnique |}.

Definition unitIdFreeHoles : UnitId -> UniqDSet.UniqDSet ModuleName :=
  fun arg_0__ =>
    match arg_0__ with
    | IndefiniteUnitId x => indefUnitIdFreeHoles x
    | DefiniteUnitId _ => UniqDSet.emptyUniqDSet
    end.

Definition unitIdIsDefinite : UnitId -> bool :=
  UniqDSet.isEmptyUniqDSet GHC.Base.∘ unitIdFreeHoles.

Definition moduleFreeHoles : Module -> UniqDSet.UniqDSet ModuleName :=
  fun m =>
    if isHoleModule m : bool then UniqDSet.unitUniqDSet (moduleName m) else
    unitIdFreeHoles (moduleUnitId m).

Definition moduleIsDefinite : Module -> bool :=
  UniqDSet.isEmptyUniqDSet GHC.Base.∘ moduleFreeHoles.

Definition unitModuleEnv {a} : Module -> a -> ModuleEnv a :=
  fun m x => Mk_ModuleEnv (Data.Map.Internal.singleton (Mk_NDModule m) x).

Definition unitModuleSet : Module -> ModuleSet :=
  GHC.Prim.coerce Data.Set.Internal.singleton.

(* External variables:
     Eq Gt Lt None Some andb bool comparison cons false list negb nil op_zt__ option
     pair true Coq.Init.Datatypes.app Coq.Lists.List.flat_map Data.Foldable.foldl'
     Data.Map.Internal.Map Data.Map.Internal.delete Data.Map.Internal.empty
     Data.Map.Internal.filterWithKey Data.Map.Internal.findWithDefault
     Data.Map.Internal.fromList Data.Map.Internal.insert Data.Map.Internal.insertWith
     Data.Map.Internal.keys Data.Map.Internal.lookup Data.Map.Internal.mapWithKey
     Data.Map.Internal.member Data.Map.Internal.null Data.Map.Internal.singleton
     Data.Map.Internal.toList Data.Map.Internal.union Data.Map.Internal.unionWith
     Data.OldList.sort Data.OldList.sortBy Data.Ord.comparing Data.Set.Internal.Set_
     Data.Set.Internal.delete Data.Set.Internal.difference Data.Set.Internal.empty
     Data.Set.Internal.fromList Data.Set.Internal.insert
     Data.Set.Internal.intersection Data.Set.Internal.member
     Data.Set.Internal.singleton Data.Set.Internal.toList Data.Set.Internal.union
     Data.Tuple.fst Data.Tuple.snd FastString.FastString FastString.appendFS
     FastString.fsLit FastString.mkFastString FastString.unpackFS
     FiniteMap.deleteList FiniteMap.insertList FiniteMap.insertListWith GHC.Base.Eq_
     GHC.Base.Ord GHC.Base.String GHC.Base.compare GHC.Base.compare__ GHC.Base.flip
     GHC.Base.fmap GHC.Base.map GHC.Base.max GHC.Base.max__ GHC.Base.min
     GHC.Base.min__ GHC.Base.op_z2218U__ GHC.Base.op_zeze__ GHC.Base.op_zeze____
     GHC.Base.op_zg__ GHC.Base.op_zg____ GHC.Base.op_zgze__ GHC.Base.op_zgze____
     GHC.Base.op_zl__ GHC.Base.op_zl____ GHC.Base.op_zlze__ GHC.Base.op_zlze____
     GHC.Base.op_zsze__ GHC.Base.op_zsze____ GHC.Prim.coerce Panic.noString
     UniqDFM.UniqDFM UniqDSet.UniqDSet UniqDSet.emptyUniqDSet
     UniqDSet.isEmptyUniqDSet UniqDSet.unitUniqDSet UniqFM.UniqFM Unique.Uniquable
     Unique.Unique Unique.getUnique Unique.getUnique__ Unique.nonDetCmpUnique
     Util.thenCmp
*)
