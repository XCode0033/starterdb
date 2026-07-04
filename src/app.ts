import express from "express";
import bodyParser from "body-parser";
import path from "path";
import router from "./routes/router";
import { errorHandler } from "./middleware/errorHandler";

const app = express();
const PORT = process.env.PORT || 3000;

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "..", "views"));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "..", "public")));
app.use(express.json())
app.use("/", router);

app.use(errorHandler)
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
