import * as ajax from "../../common/ajax";

export const revoke = entity => ajax.patch("/apply/revoke", entity);

export const update = entity => ajax.put("/apply/updateApply", entity);

export const submit = entity => ajax.put("/apply/updateApply", entity);

export const deleteItem = entity => ajax.del("/apply/deleteApply", entity);