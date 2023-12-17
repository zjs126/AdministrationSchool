import * as ajax from "../../common/ajax";

export const getPage = entity => ajax.get("apply/findApplyPage", entity);

export const audit = entity => ajax.patch("apply/audit", entity);

export const pageSize = 20;