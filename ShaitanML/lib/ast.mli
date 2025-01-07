type id = string

type rec_flag =
  | Rec
  | Nonrec

type const =
  | CInt of int
  | CBool of bool
  | CString of id
  | CUnit
  | CNil

type type_annot =
  | AInt
  | ABool
  | AString
  | AUnit
  | AList of type_annot
  | AFun of type_annot * type_annot
  | ATuple of type_annot list
  | AVar of id

type pattern =
  | PAny
  | PConst of const
  | PVar of id
  | PTuple of pattern list
  | PCons of pattern * pattern
  | PConstraint of pattern * type_annot

type expr =
  | EConst of const
  | EVar of id
  | EIf of expr * expr * expr
  | EMatch of expr * case list
  | ELet of rec_flag * binding * expr
  | EFun of pattern * expr
  | ETuple of expr list
  | ECons of expr * expr
  | EApply of expr * expr
  | EConstraint of expr * type_annot

and case = pattern * expr
and binding = pattern * expr

type str_item =
  | SEval of expr
  | SValue of rec_flag * binding list

val constr_apply : expr -> expr list -> expr
val constr_fun : pattern list -> expr -> expr

type structure = str_item list
