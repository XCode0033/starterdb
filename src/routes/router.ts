import { Router } from "express";
import { createDream, getAllDreams, getDreamById, getEditPage } from "../controllers/dreamController";
const router = Router();
router.get('/', getAllDreams);
router.get("/:id", getDreamById);
router.get("/:id/editPage", getEditPage)

router.post("/", createDream)
export default router;
