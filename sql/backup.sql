DROP TABLE "public"."classExercises";
CREATE TABLE "public"."classExercises" ("id" INTEGER DEFAULT nextval('"classExercises_id_seq"'::regclass) NOT NULL, "exerciseId" INTEGER, "index" INTEGER, "classMovementCategoryId" INTEGER, "notes" TEXT, "duration" INTEGER DEFAULT 1, "repetitions" INTEGER DEFAULT 1, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."classExercises" ("id", "exerciseId", "index", "classMovementCategoryId", "notes", "duration", "repetitions", "createdAt", "updatedAt") VALUES (33, 9, 0, 136, 'Notes...', 10, 1, '2018-04-10 23:26:48', '2018-04-10 23:26:48');
INSERT INTO "public"."classExercises" ("id", "exerciseId", "index", "classMovementCategoryId", "notes", "duration", "repetitions", "createdAt", "updatedAt") VALUES (34, 10, 1, 136, 'Notes...', 5, 1, '2018-04-10 23:26:48', '2018-04-10 23:26:48');
DROP TABLE "public"."classMovementCategories";
CREATE TABLE "public"."classMovementCategories" ("id" INTEGER DEFAULT nextval('"classMovementCategories_id_seq"'::regclass) NOT NULL, "index" INTEGER, "classId" INTEGER, "labelId" INTEGER, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."classMovementCategories" ("id", "index", "classId", "labelId", "createdAt", "updatedAt") VALUES (136, 0, 16, 6, '2018-04-10 23:26:48', '2018-04-10 23:26:48');
INSERT INTO "public"."classMovementCategories" ("id", "index", "classId", "labelId", "createdAt", "updatedAt") VALUES (137, 1, 16, 7, '2018-04-10 23:26:48', '2018-04-10 23:26:48');
DROP TABLE "public"."classTemplates";
CREATE TABLE "public"."classTemplates" ("id" INTEGER DEFAULT nextval('"classTemplates_id_seq"'::regclass) NOT NULL, "genreId" INTEGER, "templateId" TEXT, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."classTemplates" ("id", "genreId", "templateId", "createdAt", "updatedAt") VALUES (1, 1, '2', '2018-04-05 22:04:33', '2018-04-05 22:04:33');
INSERT INTO "public"."classTemplates" ("id", "genreId", "templateId", "createdAt", "updatedAt") VALUES (2, 2, '1', '2018-04-05 22:04:33', '2018-04-05 22:04:33');
INSERT INTO "public"."classTemplates" ("id", "genreId", "templateId", "createdAt", "updatedAt") VALUES (3, 3, '2', '2018-04-05 22:04:33', '2018-04-05 22:04:33');
INSERT INTO "public"."classTemplates" ("id", "genreId", "templateId", "createdAt", "updatedAt") VALUES (4, 4, '2', '2018-04-05 22:04:33', '2018-04-05 22:04:33');
INSERT INTO "public"."classTemplates" ("id", "genreId", "templateId", "createdAt", "updatedAt") VALUES (5, 5, '2', '2018-04-05 22:04:33', '2018-04-05 22:04:33');
DROP TABLE "public"."classes";
CREATE TABLE "public"."classes" ("id" SERIAL NOT NULL, "name" TEXT, "status" TEXT, "genreId" INTEGER, "createdBy" INTEGER, "notes" TEXT, "categorySummary" TEXT, "durationSummary" INTEGER, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."classes" ("id", "name", "status", "genreId", "createdBy", "notes", "categorySummary", "durationSummary", "createdAt", "updatedAt") VALUES (16, 'New Pump Classfd', 'submitted', 1, 1, '<p>refd</p>', 'Warm Up,Supine Legs', 15, '2018-04-10 23:26:25', '2018-04-10 23:26:48');
DROP TABLE "public"."exercise_labels";
CREATE TABLE "public"."exercise_labels" ("id" SERIAL NOT NULL, "exerciseId" INTEGER, "genreId" INTEGER, "movementId" INTEGER, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (688, 15, 3, 7, '2018-03-28 03:50:25', '2018-03-28 03:50:25');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (595, 33, 1, 8, '2018-03-28 03:43:18', '2018-03-28 03:43:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (597, 33, 3, 8, '2018-03-28 03:43:18', '2018-03-28 03:43:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (599, 33, 5, 8, '2018-03-28 03:43:18', '2018-03-28 03:43:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (601, 32, 2, 8, '2018-03-28 03:43:32', '2018-03-28 03:43:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (602, 32, 3, 8, '2018-03-28 03:43:32', '2018-03-28 03:43:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (604, 32, 5, 8, '2018-03-28 03:43:32', '2018-03-28 03:43:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (605, 31, 1, 8, '2018-03-28 03:43:59', '2018-03-28 03:43:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (608, 31, 4, 8, '2018-03-28 03:43:59', '2018-03-28 03:43:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (610, 30, 1, 7, '2018-03-28 03:44:21', '2018-03-28 03:44:21');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (612, 30, 3, 7, '2018-03-28 03:44:21', '2018-03-28 03:44:21');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (614, 30, 5, 7, '2018-03-28 03:44:21', '2018-03-28 03:44:21');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (615, 29, 1, 7, '2018-03-28 03:44:55', '2018-03-28 03:44:55');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (617, 29, 3, 7, '2018-03-28 03:44:55', '2018-03-28 03:44:55');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (689, 15, 4, 7, '2018-03-28 03:50:25', '2018-03-28 03:50:25');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (692, 14, 3, 7, '2018-03-28 03:50:31', '2018-03-28 03:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (695, 13, 1, 6, '2018-03-28 03:51:00', '2018-03-28 03:51:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (841, 34, 1, 8, '2018-03-29 12:14:04', '2018-03-29 12:14:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (842, 34, 2, 8, '2018-03-29 12:14:04', '2018-03-29 12:14:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (697, 13, 4, 6, '2018-03-28 03:51:00', '2018-03-28 03:51:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (699, 13, 5, 12, '2018-03-28 03:51:00', '2018-03-28 03:51:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (843, 34, 3, 8, '2018-03-29 12:14:04', '2018-03-29 12:14:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (844, 34, 4, 8, '2018-03-29 12:14:04', '2018-03-29 12:14:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (845, 34, 5, 8, '2018-03-29 12:14:04', '2018-03-29 12:14:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (846, 69, 3, 10, '2018-03-29 12:20:14', '2018-03-29 12:20:14');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (704, 10, 1, 6, '2018-03-28 03:52:16', '2018-03-28 03:52:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (705, 10, 3, 6, '2018-03-28 03:52:16', '2018-03-28 03:52:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (706, 10, 4, 6, '2018-03-28 03:52:16', '2018-03-28 03:52:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (707, 10, 5, 6, '2018-03-28 03:52:16', '2018-03-28 03:52:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (709, 9, 3, 6, '2018-03-28 03:52:47', '2018-03-28 03:52:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (711, 9, 5, 6, '2018-03-28 03:52:47', '2018-03-28 03:52:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (716, 6, 3, 6, '2018-03-28 03:54:17', '2018-03-28 03:54:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (717, 6, 5, 6, '2018-03-28 03:54:17', '2018-03-28 03:54:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (847, 69, 4, 10, '2018-03-29 12:20:14', '2018-03-29 12:20:14');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (848, 69, 5, 10, '2018-03-29 12:20:14', '2018-03-29 12:20:14');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (722, 4, 3, 6, '2018-03-28 03:55:38', '2018-03-28 03:55:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (849, 68, 1, 10, '2018-03-29 12:21:04', '2018-03-29 12:21:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (850, 68, 3, 10, '2018-03-29 12:21:04', '2018-03-29 12:21:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (851, 68, 4, 10, '2018-03-29 12:21:04', '2018-03-29 12:21:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (852, 68, 5, 10, '2018-03-29 12:21:04', '2018-03-29 12:21:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (724, 52, 1, 10, '2018-03-28 04:00:53', '2018-03-28 04:00:53');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (725, 52, 2, 10, '2018-03-28 04:00:53', '2018-03-28 04:00:53');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (726, 52, 3, 10, '2018-03-28 04:00:53', '2018-03-28 04:00:53');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (727, 52, 4, 10, '2018-03-28 04:00:53', '2018-03-28 04:00:53');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (729, 53, 1, 10, '2018-03-28 04:04:39', '2018-03-28 04:04:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (730, 53, 2, 10, '2018-03-28 04:04:39', '2018-03-28 04:04:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (731, 53, 3, 10, '2018-03-28 04:04:39', '2018-03-28 04:04:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (732, 53, 4, 10, '2018-03-28 04:04:39', '2018-03-28 04:04:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (739, 54, 1, 10, '2018-03-28 04:08:17', '2018-03-28 04:08:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (742, 54, 4, 10, '2018-03-28 04:08:17', '2018-03-28 04:08:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (744, 55, 1, 10, '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (745, 55, 2, 10, '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (746, 55, 3, 10, '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (747, 55, 4, 10, '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (749, 56, 1, 10, '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (750, 56, 2, 10, '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (70, 12, 1, 6, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (71, 12, 1, 7, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (72, 12, 3, 6, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (73, 12, 3, 7, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (74, 12, 5, 12, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (75, 12, 4, 6, '2018-03-22 10:20:33', '2018-03-22 10:20:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (751, 56, 3, 10, '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (752, 56, 4, 10, '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (754, 57, 1, 10, '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (755, 57, 2, 10, '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (756, 57, 3, 10, '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (757, 57, 4, 10, '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (759, 58, 3, 10, '2018-03-28 04:38:33', '2018-03-28 04:38:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (760, 58, 5, 10, '2018-03-28 04:38:33', '2018-03-28 04:38:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (771, 59, 1, 10, '2018-03-28 04:50:31', '2018-03-28 04:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (772, 59, 2, 10, '2018-03-28 04:50:31', '2018-03-28 04:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (773, 59, 3, 10, '2018-03-28 04:50:31', '2018-03-28 04:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (774, 59, 4, 10, '2018-03-28 04:50:31', '2018-03-28 04:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (781, 61, 1, 10, '2018-03-28 04:56:48', '2018-03-28 04:56:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (784, 61, 4, 10, '2018-03-28 04:56:48', '2018-03-28 04:56:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (795, 62, 5, 10, '2018-03-28 05:00:35', '2018-03-28 05:00:35');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (890, 70, 3, 10, '2018-03-29 12:37:38', '2018-03-29 12:37:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (815, 64, 4, 10, '2018-03-28 05:29:00', '2018-03-28 05:29:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (817, 66, 3, 10, '2018-03-28 05:30:16', '2018-03-28 05:30:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (818, 66, 4, 10, '2018-03-28 05:30:16', '2018-03-28 05:30:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (819, 66, 5, 10, '2018-03-28 05:30:16', '2018-03-28 05:30:16');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (891, 70, 5, 9, '2018-03-29 12:37:38', '2018-03-29 12:37:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (892, 70, 5, 10, '2018-03-29 12:37:38', '2018-03-29 12:37:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (896, 72, 3, 10, '2018-03-29 12:37:51', '2018-03-29 12:37:51');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (897, 72, 5, 9, '2018-03-29 12:37:51', '2018-03-29 12:37:51');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (898, 72, 5, 10, '2018-03-29 12:37:51', '2018-03-29 12:37:51');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (899, 71, 3, 10, '2018-03-29 12:37:57', '2018-03-29 12:37:57');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (900, 71, 5, 9, '2018-03-29 12:37:57', '2018-03-29 12:37:57');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (901, 71, 5, 10, '2018-03-29 12:37:57', '2018-03-29 12:37:57');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (902, 73, 3, 10, '2018-03-29 12:38:04', '2018-03-29 12:38:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (903, 73, 5, 9, '2018-03-29 12:38:04', '2018-03-29 12:38:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (833, 67, 1, 10, '2018-03-29 12:12:28', '2018-03-29 12:12:28');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (904, 73, 5, 10, '2018-03-29 12:38:04', '2018-03-29 12:38:04');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (527, 51, 1, 10, '2018-03-28 03:35:48', '2018-03-28 03:35:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (834, 67, 3, 10, '2018-03-29 12:12:28', '2018-03-29 12:12:28');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (835, 67, 4, 10, '2018-03-29 12:12:28', '2018-03-29 12:12:28');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (836, 67, 5, 10, '2018-03-29 12:12:28', '2018-03-29 12:12:28');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (530, 51, 4, 10, '2018-03-28 03:35:48', '2018-03-28 03:35:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (531, 51, 5, 10, '2018-03-28 03:35:48', '2018-03-28 03:35:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (539, 49, 4, 6, '2018-03-28 03:36:54', '2018-03-28 03:36:54');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (548, 47, 4, 6, '2018-03-28 03:37:59', '2018-03-28 03:37:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (549, 47, 5, 8, '2018-03-28 03:37:59', '2018-03-28 03:37:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (554, 46, 4, 6, '2018-03-28 03:38:27', '2018-03-28 03:38:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (557, 44, 4, 7, '2018-03-28 03:39:12', '2018-03-28 03:39:12');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (558, 43, 4, 7, '2018-03-28 03:39:30', '2018-03-28 03:39:30');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (561, 41, 1, 8, '2018-03-28 03:40:26', '2018-03-28 03:40:26');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (562, 41, 4, 8, '2018-03-28 03:40:26', '2018-03-28 03:40:26');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (565, 39, 1, 8, '2018-03-28 03:41:18', '2018-03-28 03:41:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (566, 39, 3, 8, '2018-03-28 03:41:18', '2018-03-28 03:41:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (567, 39, 4, 8, '2018-03-28 03:41:18', '2018-03-28 03:41:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (568, 38, 1, 8, '2018-03-28 03:41:45', '2018-03-28 03:41:45');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (569, 38, 3, 8, '2018-03-28 03:41:45', '2018-03-28 03:41:45');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (570, 38, 4, 8, '2018-03-28 03:41:45', '2018-03-28 03:41:45');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (571, 37, 1, 8, '2018-03-28 03:42:06', '2018-03-28 03:42:06');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (572, 37, 3, 8, '2018-03-28 03:42:06', '2018-03-28 03:42:06');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (573, 37, 4, 8, '2018-03-28 03:42:06', '2018-03-28 03:42:06');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (574, 37, 5, 8, '2018-03-28 03:42:06', '2018-03-28 03:42:06');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (576, 36, 3, 8, '2018-03-28 03:42:23', '2018-03-28 03:42:23');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (578, 36, 5, 8, '2018-03-28 03:42:23', '2018-03-28 03:42:23');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (579, 36, 5, 12, '2018-03-28 03:42:23', '2018-03-28 03:42:23');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (580, 35, 1, 8, '2018-03-28 03:42:39', '2018-03-28 03:42:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (582, 35, 3, 8, '2018-03-28 03:42:39', '2018-03-28 03:42:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (583, 35, 4, 8, '2018-03-28 03:42:39', '2018-03-28 03:42:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (584, 35, 5, 8, '2018-03-28 03:42:39', '2018-03-28 03:42:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (596, 33, 2, 8, '2018-03-28 03:43:18', '2018-03-28 03:43:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (598, 33, 4, 8, '2018-03-28 03:43:18', '2018-03-28 03:43:18');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (600, 32, 1, 8, '2018-03-28 03:43:32', '2018-03-28 03:43:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (603, 32, 4, 8, '2018-03-28 03:43:32', '2018-03-28 03:43:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (606, 31, 2, 8, '2018-03-28 03:43:59', '2018-03-28 03:43:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (607, 31, 3, 8, '2018-03-28 03:43:59', '2018-03-28 03:43:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (609, 31, 5, 8, '2018-03-28 03:43:59', '2018-03-28 03:43:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (611, 30, 2, 7, '2018-03-28 03:44:21', '2018-03-28 03:44:21');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (613, 30, 4, 7, '2018-03-28 03:44:21', '2018-03-28 03:44:21');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (616, 29, 2, 7, '2018-03-28 03:44:55', '2018-03-28 03:44:55');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (687, 15, 1, 7, '2018-03-28 03:50:25', '2018-03-28 03:50:25');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (690, 15, 5, 7, '2018-03-28 03:50:25', '2018-03-28 03:50:25');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (691, 14, 1, 7, '2018-03-28 03:50:31', '2018-03-28 03:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (693, 14, 4, 7, '2018-03-28 03:50:31', '2018-03-28 03:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (694, 14, 5, 7, '2018-03-28 03:50:31', '2018-03-28 03:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (696, 13, 1, 7, '2018-03-28 03:51:00', '2018-03-28 03:51:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (698, 13, 4, 7, '2018-03-28 03:51:00', '2018-03-28 03:51:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (700, 11, 1, 6, '2018-03-28 03:51:38', '2018-03-28 03:51:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (701, 11, 3, 6, '2018-03-28 03:51:38', '2018-03-28 03:51:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (702, 11, 4, 6, '2018-03-28 03:51:38', '2018-03-28 03:51:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (703, 11, 5, 6, '2018-03-28 03:51:38', '2018-03-28 03:51:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (708, 9, 1, 6, '2018-03-28 03:52:47', '2018-03-28 03:52:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (710, 9, 4, 6, '2018-03-28 03:52:47', '2018-03-28 03:52:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (712, 8, 3, 6, '2018-03-28 03:53:15', '2018-03-28 03:53:15');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (713, 8, 5, 6, '2018-03-28 03:53:15', '2018-03-28 03:53:15');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (618, 29, 4, 7, '2018-03-28 03:44:55', '2018-03-28 03:44:55');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (619, 29, 5, 7, '2018-03-28 03:44:55', '2018-03-28 03:44:55');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (714, 7, 3, 6, '2018-03-28 03:53:33', '2018-03-28 03:53:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (715, 7, 5, 6, '2018-03-28 03:53:33', '2018-03-28 03:53:33');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (620, 28, 3, 7, '2018-03-28 03:45:08', '2018-03-28 03:45:08');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (621, 28, 4, 7, '2018-03-28 03:45:08', '2018-03-28 03:45:08');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (622, 28, 5, 7, '2018-03-28 03:45:08', '2018-03-28 03:45:08');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (718, 5, 3, 6, '2018-03-28 03:54:51', '2018-03-28 03:54:51');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (719, 5, 5, 6, '2018-03-28 03:54:52', '2018-03-28 03:54:52');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (723, 4, 5, 6, '2018-03-28 03:55:38', '2018-03-28 03:55:38');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (728, 52, 5, 10, '2018-03-28 04:00:53', '2018-03-28 04:00:53');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (733, 53, 5, 10, '2018-03-28 04:04:39', '2018-03-28 04:04:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (740, 54, 2, 10, '2018-03-28 04:08:17', '2018-03-28 04:08:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (741, 54, 3, 10, '2018-03-28 04:08:17', '2018-03-28 04:08:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (743, 54, 5, 10, '2018-03-28 04:08:17', '2018-03-28 04:08:17');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (748, 55, 5, 10, '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (623, 27, 1, 7, '2018-03-28 03:45:27', '2018-03-28 03:45:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (624, 27, 2, 7, '2018-03-28 03:45:27', '2018-03-28 03:45:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (625, 27, 3, 7, '2018-03-28 03:45:27', '2018-03-28 03:45:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (626, 27, 4, 7, '2018-03-28 03:45:27', '2018-03-28 03:45:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (627, 27, 5, 7, '2018-03-28 03:45:27', '2018-03-28 03:45:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (528, 51, 2, 10, '2018-03-28 03:35:48', '2018-03-28 03:35:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (529, 51, 3, 10, '2018-03-28 03:35:48', '2018-03-28 03:35:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (532, 50, 1, 6, '2018-03-28 03:36:29', '2018-03-28 03:36:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (628, 26, 1, 7, '2018-03-28 03:45:46', '2018-03-28 03:45:46');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (533, 50, 4, 6, '2018-03-28 03:36:29', '2018-03-28 03:36:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (534, 50, 5, 8, '2018-03-28 03:36:29', '2018-03-28 03:36:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (538, 49, 1, 6, '2018-03-28 03:36:54', '2018-03-28 03:36:54');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (540, 49, 5, 8, '2018-03-28 03:36:54', '2018-03-28 03:36:54');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (541, 48, 1, 6, '2018-03-28 03:37:20', '2018-03-28 03:37:20');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (542, 48, 4, 6, '2018-03-28 03:37:20', '2018-03-28 03:37:20');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (543, 48, 5, 8, '2018-03-28 03:37:20', '2018-03-28 03:37:20');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (547, 47, 1, 6, '2018-03-28 03:37:59', '2018-03-28 03:37:59');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (629, 26, 2, 7, '2018-03-28 03:45:46', '2018-03-28 03:45:46');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (630, 26, 3, 7, '2018-03-28 03:45:46', '2018-03-28 03:45:46');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (631, 26, 4, 7, '2018-03-28 03:45:46', '2018-03-28 03:45:46');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (632, 26, 5, 7, '2018-03-28 03:45:46', '2018-03-28 03:45:46');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (633, 25, 1, 7, '2018-03-28 03:46:00', '2018-03-28 03:46:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (553, 46, 1, 6, '2018-03-28 03:38:27', '2018-03-28 03:38:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (555, 46, 5, 8, '2018-03-28 03:38:27', '2018-03-28 03:38:27');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (556, 45, 4, 7, '2018-03-28 03:38:50', '2018-03-28 03:38:50');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (559, 42, 1, 8, '2018-03-28 03:40:03', '2018-03-28 03:40:03');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (560, 42, 4, 8, '2018-03-28 03:40:03', '2018-03-28 03:40:03');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (563, 40, 1, 8, '2018-03-28 03:40:49', '2018-03-28 03:40:49');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (564, 40, 4, 8, '2018-03-28 03:40:49', '2018-03-28 03:40:49');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (575, 36, 1, 8, '2018-03-28 03:42:23', '2018-03-28 03:42:23');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (577, 36, 4, 8, '2018-03-28 03:42:23', '2018-03-28 03:42:23');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (581, 35, 2, 8, '2018-03-28 03:42:39', '2018-03-28 03:42:39');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (634, 25, 2, 7, '2018-03-28 03:46:00', '2018-03-28 03:46:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (635, 25, 3, 7, '2018-03-28 03:46:00', '2018-03-28 03:46:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (636, 25, 4, 7, '2018-03-28 03:46:00', '2018-03-28 03:46:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (637, 25, 5, 7, '2018-03-28 03:46:00', '2018-03-28 03:46:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (638, 24, 1, 7, '2018-03-28 03:46:19', '2018-03-28 03:46:19');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (639, 24, 2, 7, '2018-03-28 03:46:19', '2018-03-28 03:46:19');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (640, 24, 3, 7, '2018-03-28 03:46:19', '2018-03-28 03:46:19');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (641, 24, 4, 7, '2018-03-28 03:46:19', '2018-03-28 03:46:19');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (642, 24, 5, 7, '2018-03-28 03:46:19', '2018-03-28 03:46:19');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (753, 56, 5, 10, '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (758, 57, 5, 10, '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (647, 21, 1, 7, '2018-03-28 03:47:10', '2018-03-28 03:47:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (648, 21, 2, 7, '2018-03-28 03:47:10', '2018-03-28 03:47:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (649, 21, 3, 7, '2018-03-28 03:47:10', '2018-03-28 03:47:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (650, 21, 4, 7, '2018-03-28 03:47:10', '2018-03-28 03:47:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (651, 21, 5, 7, '2018-03-28 03:47:10', '2018-03-28 03:47:10');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (652, 22, 1, 7, '2018-03-28 03:47:32', '2018-03-28 03:47:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (653, 22, 3, 7, '2018-03-28 03:47:32', '2018-03-28 03:47:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (654, 22, 4, 7, '2018-03-28 03:47:32', '2018-03-28 03:47:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (655, 22, 5, 7, '2018-03-28 03:47:32', '2018-03-28 03:47:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (656, 23, 1, 7, '2018-03-28 03:47:37', '2018-03-28 03:47:37');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (657, 23, 3, 7, '2018-03-28 03:47:37', '2018-03-28 03:47:37');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (658, 23, 4, 7, '2018-03-28 03:47:37', '2018-03-28 03:47:37');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (659, 23, 5, 7, '2018-03-28 03:47:37', '2018-03-28 03:47:37');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (660, 20, 1, 7, '2018-03-28 03:47:56', '2018-03-28 03:47:56');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (661, 20, 3, 7, '2018-03-28 03:47:56', '2018-03-28 03:47:56');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (662, 20, 4, 7, '2018-03-28 03:47:56', '2018-03-28 03:47:56');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (663, 19, 1, 7, '2018-03-28 03:48:09', '2018-03-28 03:48:09');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (664, 19, 3, 7, '2018-03-28 03:48:09', '2018-03-28 03:48:09');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (665, 19, 4, 7, '2018-03-28 03:48:09', '2018-03-28 03:48:09');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (666, 19, 5, 7, '2018-03-28 03:48:09', '2018-03-28 03:48:09');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (667, 18, 1, 7, '2018-03-28 03:48:29', '2018-03-28 03:48:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (668, 18, 3, 7, '2018-03-28 03:48:29', '2018-03-28 03:48:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (669, 18, 4, 7, '2018-03-28 03:48:29', '2018-03-28 03:48:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (670, 18, 5, 7, '2018-03-28 03:48:29', '2018-03-28 03:48:29');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (671, 17, 1, 7, '2018-03-28 03:48:52', '2018-03-28 03:48:52');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (672, 17, 3, 7, '2018-03-28 03:48:52', '2018-03-28 03:48:52');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (673, 17, 4, 7, '2018-03-28 03:48:52', '2018-03-28 03:48:52');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (674, 17, 5, 7, '2018-03-28 03:48:52', '2018-03-28 03:48:52');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (675, 16, 1, 7, '2018-03-28 03:49:22', '2018-03-28 03:49:22');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (676, 16, 3, 7, '2018-03-28 03:49:22', '2018-03-28 03:49:22');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (677, 16, 4, 7, '2018-03-28 03:49:22', '2018-03-28 03:49:22');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (678, 16, 5, 7, '2018-03-28 03:49:22', '2018-03-28 03:49:22');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (775, 59, 5, 10, '2018-03-28 04:50:31', '2018-03-28 04:50:31');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (782, 61, 2, 10, '2018-03-28 04:56:48', '2018-03-28 04:56:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (783, 61, 3, 9, '2018-03-28 04:56:48', '2018-03-28 04:56:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (785, 61, 5, 10, '2018-03-28 04:56:48', '2018-03-28 04:56:48');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (791, 62, 1, 10, '2018-03-28 05:00:35', '2018-03-28 05:00:35');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (792, 62, 2, 10, '2018-03-28 05:00:35', '2018-03-28 05:00:35');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (793, 62, 3, 10, '2018-03-28 05:00:35', '2018-03-28 05:00:35');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (794, 62, 4, 10, '2018-03-28 05:00:35', '2018-03-28 05:00:35');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (802, 63, 3, 10, '2018-03-28 05:14:36', '2018-03-28 05:14:36');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (803, 63, 4, 10, '2018-03-28 05:14:36', '2018-03-28 05:14:36');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (804, 63, 5, 10, '2018-03-28 05:14:36', '2018-03-28 05:14:36');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (808, 65, 3, 10, '2018-03-28 05:27:32', '2018-03-28 05:27:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (809, 65, 4, 10, '2018-03-28 05:27:32', '2018-03-28 05:27:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (810, 65, 5, 10, '2018-03-28 05:27:32', '2018-03-28 05:27:32');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (814, 64, 3, 10, '2018-03-28 05:29:00', '2018-03-28 05:29:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (816, 64, 5, 10, '2018-03-28 05:29:00', '2018-03-28 05:29:00');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (932, 74, 1, 10, '2018-04-10 00:53:47', '2018-04-10 00:53:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (933, 74, 2, 10, '2018-04-10 00:53:47', '2018-04-10 00:53:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (934, 74, 3, 10, '2018-04-10 00:53:47', '2018-04-10 00:53:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (935, 74, 4, 10, '2018-04-10 00:53:47', '2018-04-10 00:53:47');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (936, 75, 3, 10, '2018-04-10 20:58:20', '2018-04-10 20:58:20');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (937, 75, 1, 10, '2018-04-10 20:58:20', '2018-04-10 20:58:20');
INSERT INTO "public"."exercise_labels" ("id", "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") VALUES (938, 75, 4, 10, '2018-04-10 20:58:20', '2018-04-10 20:58:20');
DROP TABLE "public"."exercises";
CREATE TABLE "public"."exercises" ("id" SERIAL NOT NULL, "name" TEXT, "description" TEXT, "springs" TEXT, "photo" TEXT, "video" TEXT, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (8, 'Double Leg Lowers ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral<em> </em><em><strong>or imprint</strong></em>. Arms by sides. Head rest comfortable.&nbsp;Both legs at table top.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Exhale connect to the core, anchor low ribs &nbsp;lower legs from table top to point of control. Maintain <strong>Neutral Spnie</strong> or <strong>Imprint</strong>. &nbsp;</p>
<p><br></p>
<p><em><strong>NOTE: People with with low back pain, or decreaced core control may find it helpful to maintain a gentle imprint. Be sure it is an imprint not a pelvic tilt.&nbsp;</strong></em></p>', '3 RED or 1 BLUE', null, '', '2018-03-22 06:26:06', '2018-03-22 06:26:06');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (7, 'Single Leg Lifts ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Exhale connect to core lift single leg to table top maintain neutral spine. Inhale lower leg. Alternate legs.&nbsp;</p>', '3 RED or 1 BLUE  ', null, '', '2018-03-22 06:13:13', '2018-03-22 06:13:13');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (6, 'Imprint Single Leg', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable. Float one leg up to table top.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u><u>&nbsp;</u></p>
<p>Inhale neutral spine and pelvis. Exhale imprint lumbar spine into the mat with single leg lifted in table top.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Can be done on the mat or reformer</strong></em></p>', '3 RED or 1 Blue', null, '', '2018-03-22 06:03:34', '2018-03-22 06:03:34');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (53, 'Kneeling Arms Side Series Straight Arm Side Lift ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Strap in hand closest to foot bar.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Arm straight by side. Exhale adduct arm to shoulder hight.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Regression sitting on Long Box&nbsp;</strong></em></p>', '1 BLUE or 1 RED + ', null, '', '2018-03-28 04:01:11', '2018-03-28 04:01:11');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (68, 'Mermaid with Rotation ', '<p><u><strong>Set Up&nbsp;</strong></u></p>
<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise</strong></u></p>
<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion bring hand to foot bar and spine into rotation. Add arm presses. &nbsp;Inhale into top lung. Exhale return to starting position.&nbsp;</p>', '1 RED', null, '', '2018-03-29 12:12:18', '2018-03-29 12:12:18');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (54, 'Kneeling Arm Side Series Draw a Sword ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Strap in hand closest to foot bar.&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>&nbsp;Strap in hand closest to foot bar. Fist at opposite hip “draw the sword” Diagonally up across chest untill elbow is extended.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Variation add rotation. Can sit on Long Box&nbsp;</strong></em></p>', '1 BLUE or 1 RED+', null, '', '2018-03-28 04:07:58', '2018-03-28 04:07:58');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (16, 'Footwork Small V ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Toes in small V on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine. Squeeze heels together.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE </strong></em><em><strong>Optional add pulses.&nbsp;</strong></em></p>', '3 + RED ', null, '', '2018-03-22 10:33:53', '2018-03-22 10:33:53');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (69, 'Mermaid with Rotation and Extension ', '<p><u><strong>Set Up&nbsp;</strong></u></p>
<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise</strong></u></p>
<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion bring hand to foot bar and go into spine rotation and extension. Inhale into top lung. Exhale return to starting position.&nbsp;</p>', '1 RED ', null, '', '2018-03-29 12:20:14', '2018-03-29 12:20:14');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (15, 'Footwork Toes Parallel', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Toes on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>', '3 + RED', null, '', '2018-03-22 10:31:42', '2018-03-22 10:31:42');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (39, 'Abdominal Series Scissors ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Exhale chest left extend straight legs to L shape switch legs through scissors. Stay in chest lift.&nbsp;</p>', '1 RED, 1 BLUE', null, '', '2018-03-26 05:19:44', '2018-03-26 05:19:44');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (74, 'Matadore ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling side facing on carriage. Knee closest to foot bar against shoulder rest other foot on frame 90/90 flexion at hip and knee. Arms crossed at shoulder hight.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press foot into frame and knee into shoulder. Adduct knee to centre line.&nbsp;</p>
<p><br></p>
<p><br></p>', '1 BLUE ', 'Triceps.jpg', '', '2018-03-29 12:39:15', '2018-04-01 20:16:14');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (61, 'Kneeling Arm Series Hug a Tree', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Hands in straps elbows slightly flexed shoulder distance apart (1st position)</p>
<p><br></p>
<p><u><strong>The Excersise</strong></u></p>
<p>Inhale open arms out to side finger tips stay infront of shoulders 2nd position. Exhale return to 1st position.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Sit on Long Box for variation.&nbsp;</strong></em></p>', '1 BLUE or 1 RED ', 'phoenix-pilates-logo-2.jpg', '', '2018-03-28 04:56:25', '2018-04-07 00:54:42');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (11, 'Pelvic Curl Marches ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale curl up into top of Pelvic Curl while pelvis is lifted single leg marches.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE </strong></em><strong>&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>
<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong>&nbsp;</p>
<p><u><em><strong>In technique class use 3 RED&nbsp;</strong></em></u></p>', '3 RED or 1 Blue In technique class use 3 RED ', null, '', '2018-03-22 10:11:06', '2018-03-22 10:11:06');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (55, 'Kneeling Arm Side Series Side Triceps ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.Strap in hand closest to foot bar other hand on shoulder rest spine in lateral flexion like kneeling mermaid. Hand with strap at crown palm up.</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Exhale extend elbow.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Can sit on a Long Box</strong></em></p>', '1 BLUE or 1 RED ', null, '', '2018-03-28 04:11:10', '2018-03-28 04:11:10');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (62, 'Kneeling Arm Series Kneeling Triceps ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Holing hand straps ir foot straps. Palms facing out finger tips at “3rd eye”&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Exhale press diagonally up as elbows extend. Inhale connect core on eccentric contraction. Lean body into the tension of the straps.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Sit on box for variation.&nbsp;</strong></em></p>', '1 BLUE or 1 RED ', null, '', '2018-03-28 04:59:56', '2018-03-28 04:59:56');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (70, 'Kneeling Shoulder Press Elbows Down ', '<p><u><strong>Set up</strong></u></p>
<p>Active child’s pose. Hands on Foot bar. Elbows down, fingertips to celiling.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows into tricep press.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>', '1 RED ', null, '', '2018-03-29 12:25:46', '2018-03-29 12:25:46');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (56, 'Kneeling Arms Series Kneeling Biceps ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Straps in hands elbows extended arms shoulder hight.&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Flex elbows into bicep curl. Maintain elbow hight.&nbsp;</p>', '1 BLUE or 1 RED+ ', null, '', '2018-03-28 04:18:43', '2018-03-28 04:18:43');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (63, 'Stomach Massage Round back ', '<p><u><strong>Set up</strong></u></p>
<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise</strong></u></p>
<p>Forward flexion C curve of the spine. Holding bottom of carriage. Inhale prepare. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>', '1RED +  ', null, '', '2018-03-28 05:11:16', '2018-03-28 05:11:16');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (34, 'Hands in Straps Triceps ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Arms beside side, palms down.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Bring elbows to a 90 degree angle and press back to starting position.</p>
<p><br></p>
<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. ', null, '', '2018-03-23 10:28:11', '2018-03-23 10:28:11');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (71, 'Kneeling Shoulder Press Elbows Wide ', '<p><u><strong>Set up</strong></u></p>
<p>Active child’s pose. Hands wide on Foot bar. Elbows wide, fingertips to eachother.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows.</p>
<p><br></p>
<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>', '1 RED ', null, '', '2018-03-29 12:30:14', '2018-03-29 12:30:14');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (5, 'Imprint ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u><u><strong> &nbsp;</strong></u></p>
<p>Inhale neutral spine and pelvis. Exhale imprint lumbar spine into the mat.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Can be done on the </strong></em><em><strong>mat</strong></em><em><strong> or </strong></em><em><strong>reformer</strong></em></p>', '3 RED or 1 BLUE ', null, '', '2018-03-22 06:02:09', '2018-03-22 06:02:09');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (4, 'Neutral Spine ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. &nbsp;Arms by sides. Head rest comfortable.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u><u>&nbsp;</u></p>
<p>Feel spine long, allow the natural curves of the spine to be present. The ASIS and Pubic Bone align. Release low ribs, widen the collar bones. Exhale connect core without changing spine and pelvic alignment.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE This can be done on the mat or the reformer.&nbsp;</strong></em></p>', '3 RED ', null, '', '2018-03-22 05:57:33', '2018-03-22 05:57:33');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (57, 'Kneeling Arm Series Chest Expansion ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Holing hand straps.&nbsp;</p>
<p>Tension on the straps arms are by the mid side.</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Exhale press the arms back into shoulder flexion. HOLD breath in look left right. Inhale return arms to start.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Bet mindful of losing balance with heavier springs. To regress sit on a Long Box.&nbsp;</strong></em></p>', '1 BULE or 1 RED+ ', null, '', '2018-03-28 04:35:34', '2018-03-28 04:35:34');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (64, 'Stomach Massage Flat Back ', '<p><u><strong>Set up</strong></u></p>
<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Lengthen spine into active neutral, or as close as possible. Reach arm diagonally up. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>', '1 RED + ', null, '', '2018-03-28 05:23:51', '2018-03-28 05:23:51');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (72, 'Kneeling Shoulder Press Single Arm ', '<p><u><strong>Set up</strong></u></p>
<p>Active child’s pose. SIng hands on Foot bar closer to center. Elbows down or wide.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale draw core away from thighs press hand into Foot bar to extend elbow.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Press other hand into bed to counter ballance the shoulders.&nbsp;</strong></em></p>', '1 BLUE or 1 RED +', null, '', '2018-03-29 12:32:45', '2018-03-29 12:32:45');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (12, 'Pelvic Curl Press ', '<p><em><strong>Set up</strong></em></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>
<p><em><strong>The exercise</strong></em></p>
<p>Inhale to prepare. Exhale curl up into top of Pelvic Curl. Press carriage out and draw in.&nbsp;</p>
<p><em><strong>NOTE </strong></em>&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</p>
<p>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</p>', '1-2 RED or 1 BLUE ', null, '', '2018-03-22 10:12:52', '2018-03-22 10:12:52');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (25, 'Feet in Straps Big Frogs ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press feet into straps to move. make a breast stroke action with legs. Alternate directions.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED, or 1 BLUE ', null, '', '2018-03-22 11:41:29', '2018-03-22 11:41:29');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (24, 'Feet in Straps Small Frogs ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press feet into straps to move. Spine and Pelvis maintain neutral. Push equal pressure in both feet.&nbsp;</p>', '1RED, 1BLUE or 2 RED or 1 BLUE ', null, '', '2018-03-22 11:31:56', '2018-03-22 11:31:56');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (20, 'Footwork VMO ', '<p><u><strong>Set up</strong></u></p>
<p>Supine.toes wide on foot bar knees together. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press toes into foot bar keeoing knees together and pulse.&nbsp;</p>', '3 Springs ', null, '', '2018-03-22 11:01:00', '2018-03-22 11:01:00');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (21, 'Footwork Rises ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Toes parallel on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Rise onto balls of feet then sink heels under the foot bar. Maintain Neutral Spine.&nbsp;</p>
<p><br></p>
<p><strong>NOTE </strong><em><strong>Smooth movement be sure not to bounce.</strong></em></p>', '3 RED ', null, '', '2018-03-22 11:03:35', '2018-03-22 11:03:35');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (22, 'Footwork Prances ', '<p><strong>Set up</strong></p>
<p>Supine.Toes on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale sink single heel under footbar bend oppisite knee. Keep pelvis stable.&nbsp;</p>', '3 RED ', null, '', '2018-03-22 11:05:34', '2018-03-22 11:05:34');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (23, 'Footwork Single Legs ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heel or toe on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;Single leg in table top&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press heel into foot bar to extend knees. Maintain Neutral Spine. Table top leg can reach under or over the bar.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>', '3 RED or  2 RED ', null, '', '2018-03-22 11:14:32', '2018-03-22 11:14:32');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (19, 'Footwork Circles ', '<p><u><strong>Set up</strong></u></p>
<p>Supine.Toes wideon foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press toes into footbar as knees ectend circle at hips. Alternate directions. &nbsp;Maintain Neutral Spine.&nbsp;</p>', '3 RED ', null, '', '2018-03-22 10:38:03', '2018-03-22 10:38:03');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (18, 'Footwork Toes Wide ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Toes wide on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>
<p><br></p>
<p><strong>NOTE </strong><em><strong>Optional add pulses.&nbsp;</strong></em></p>', '3 + RED ', null, '', '2018-03-22 10:36:17', '2018-03-22 10:36:17');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (17, 'Footwork Heels Wide ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels wide on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE </strong></em><em><strong>Optional add pulses.&nbsp;</strong></em></p>', '3 + RED ', null, '', '2018-03-22 10:35:07', '2018-03-22 10:35:07');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (13, 'Pelvic Curl Press Single Leg', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;one leg at table top.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale curl up into top of Pelvic Curl with single leg at table top. Press out and draw in.&nbsp;</p>
<p><br></p>
<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>
<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong>&nbsp;</p>', '1-2 RED or 1 BLUE ', null, '', '2018-03-22 10:19:03', '2018-03-22 10:19:03');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (14, 'Footwork Heels Parallel ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>', '3 + RED ', null, '', '2018-03-22 10:26:21', '2018-03-22 10:26:21');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (58, 'Kneeling Arm Series  Egyptian Arms ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Foot or hand straps around elbows.&nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise</strong></u></p>
<p>Straps on elbows arms at shoulder level shoulder distance apart elbows 90 degrees. Exhale press elbows back to goal post position. Inhale return to start position connect core on return.&nbsp;</p>
<p><br></p>', '1 RED +', null, '', '2018-03-28 04:38:33', '2018-03-28 04:38:33');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (65, 'Stomach Massage Monkey', '<p><u><strong>Set up</strong></u></p>
<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>
<p><br></p>
<p><u><strong>The Exercise</strong></u></p>
<p>&nbsp;Holding onto foot bar between V toes. If this is not comfortable take toes wide on Foot bar. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>', '1 RED + ', null, '', '2018-03-28 05:27:32', '2018-03-28 05:27:32');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (36, 'Abdominal series Chest Lift ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Begin by pressing into hands first lift the head, neck, shoulders and come into a a chest lift as you press arms by the sides.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Reach legs long as hands press down. Maintain neutral spine or imprint.&nbsp;</strong></em></p>', '1 RED, 1 BLUE ', null, '', '2018-03-24 01:00:50', '2018-03-24 01:00:50');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (35, 'Hands in Straps Cheerleader', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. SIngle arm to celiling single arm to side&nbsp;</p>
<p><br></p>
<p><u><em><strong>The exercise</strong></em></u></p>
<p>Bring both arms to side of body alternate arm that goes to the roof.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. ', null, '', '2018-03-23 11:03:27', '2018-03-23 11:03:27');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (33, 'Hands in Straps Circles ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to ceiling.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press the arms around. Alternate directions.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. ', null, '', '2018-03-23 10:01:28', '2018-03-23 10:01:28');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (32, 'Hands in Straps Sides ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to the sides.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press the hands towards side of the body.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. ', null, '', '2018-03-23 04:21:48', '2018-03-23 04:21:48');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (31, 'Hands in Straps Up Down ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to ceiling.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press the hands down to sides Inhale return. Maintain set up position while disassociating the shoulders.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. ', null, '', '2018-03-23 01:14:57', '2018-03-23 01:14:57');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (30, 'Feet in Straps Open Close ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs 45 degrees.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale open both straight legs to the side exhale bring back together. Keep hips externally rotated. Can be samll or big.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED or 1 BLUE ', null, '', '2018-03-23 01:07:29', '2018-03-23 01:07:29');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (29, 'Feet in Straps Peter Pan ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs 45 degrees small V</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Take one leg to the side, bend the other knee to the stag possition. Keep equal tension on both straps.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED, or 1 BLUE ', null, '', '2018-03-23 01:04:25', '2018-03-23 01:04:25');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (28, 'Feet In Straps Walking On The Ceiling. ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs 45 degrees.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Send one straight leg to as close to 90 degrees at hip as possible bend the other knee. Maintain tension on both straps.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED or 1 BLUE ', null, '', '2018-03-23 01:00:21', '2018-03-23 01:00:21');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (27, 'Feet in Straps Circles', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs 45 degrees.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale lift straight legs to as close to 90 degrees as possible circle legs around to starting point. Alternate direction.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1RED, 1 BLUE or 2 RED or 1 BLUE ', null, '', '2018-03-23 00:48:53', '2018-03-23 00:48:53');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (66, 'Stomach Massage Rotation ', '<p><u><strong>Set up</strong></u></p>
<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>
<p><u><strong>The Exercise&nbsp;</strong></u></p>
<p>Lengthen spine into active neutral, or as close as possible. Reach arm diagonally up. Exhale deepen core connection press toes into foot bar to extend the knees. Rotate arm behind body at shoulder hight. Inhale return to both arms reaching diagonally up. Alternate arms.</p>', '1 RED +', null, '', '2018-03-28 05:28:35', '2018-03-28 05:28:35');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (51, 'Kneeling Arms Side Series Side Lift', '<p><u><em><strong>Set up</strong></em></u></p>
<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.</p>
<p><br></p>
<p><u><em><strong>The exercise</strong></em></u></p>
<p>Strap in hand closest to shoulder rest. Shoulder and elbow 90/90. Chest broad. Exhale lift hand up towards roof adducting shoulder. Imagine sliding back of hand up a wall.</p>
<p><br></p>
<p><em><strong>NOTE for beginners let them sit on a long box&nbsp;</strong></em></p>', '1 BLUE ', null, '', '2018-03-26 07:58:52', '2018-03-26 07:58:52');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (50, 'Series 5 Single Straight Leg Stretch ', '<p><u><em><strong>Set up</strong></em></u></p>
<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>
<p><br></p>
<p><u><em><strong>The excersice&nbsp;</strong></em></u></p>
<p>Legs extended into L shape. Holding behind one knee. Exhale switch pulling leg towards chest.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Do this on the mat or the long box</strong></em></p>', 'MAT', null, '', '2018-03-26 06:28:06', '2018-03-26 06:28:06');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (48, 'Series 5 Criss Cross', '<p><u><em><strong>Set up</strong></em></u></p>
<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>
<p><br></p>
<p><u><em><strong>The exercise</strong></em></u></p>
<p>Interlace hands behind bead continue single bent leg stretch. Exhale oblique rotation towards bent leg. Be sure to rotate torso not just elbows.</p>
<p><br></p>
<p><em><strong>NOTE Do this on the Mat or Long Box</strong></em></p>', 'MAT', null, '', '2018-03-26 06:24:43', '2018-03-26 06:24:43');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (49, 'Series 5 Double Straight Leg Stretch ', '<p><u><em><strong>Set up</strong></em></u></p>
<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>
<p><br></p>
<p><u><em><strong>The exercise</strong></em></u><u>&nbsp;</u></p>
<p>Hands interlaced behind head. Both legs extended creating L shape. Exhale lower legs to point of control. Inhale return.</p>
<p><br></p>
<p><em><strong>NOTE Do this on the long box or mat</strong></em></p>', 'MAT', null, '', '2018-03-26 06:27:01', '2018-03-26 06:27:01');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (45, 'Long Spine ', '<p><u><strong>Set Up&nbsp;</strong></u></p>
<p>Supine. Feet in straps. HEAD REST DOWN. Legs together parallel.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Come to L shape with legs. Exhale Roll through the spine to Scapular bringing feet directly above pelvis. Keep carriage still. Inhale feet to hip distance apart. Exhale keeping carriage still roll back down to L shape when pelvis reaches neutral circle legs back to start.</p>', '1 RED, 1 BLUE or 2 RED ', null, '', '2018-03-26 06:04:57', '2018-03-26 06:04:57');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (47, 'Series 5 Double Bent Leg Stretch ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Pull both knees towards chest stretch arms and legs out on exhale circles arms around and pull knees back in.</p>
<p><br></p>
<p><em><strong>NOTE Do this on MAT or Long Box</strong></em></p>', 'MAT', null, '', '2018-03-26 06:10:51', '2018-03-26 06:10:51');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (46, 'Series 5 Single Bent Leg Stretch ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>
<p><br></p>
<p><u><strong>The Excercise&nbsp;</strong></u></p>
<p>Holding one leg at table top the other reached out straight. Hands on table top knee. Exhale switch. Keep toes in same plane.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Do this on Mat or Long Box</strong></em></p>', 'MAT', null, '', '2018-03-26 06:08:36', '2018-03-26 06:08:36');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (44, 'Long Spine Prep ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Feet in straps. HEAD REST DOWN. Heels together toes apart.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Come to L shape with legs. Exhale pelvic tilt bringing feet directly up above pelvis. Keep carriage still. Inhale feet to hip distance apart. Exhale keeping carriage still roll back down to L shape when pelvis reaches neutral circle legs back to start.</p>
<p><br></p>
<p><em><strong>NOTE Only do this if you know the people in your class and their limits.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED ', null, '', '2018-03-26 05:48:48', '2018-03-26 05:48:48');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (43, 'Short Spine', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Feet in straps. HEAD REST DOWN. Heels together toes apart.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Exhale with straight legs take feet above pubic bone. L shape. Roll up through spine to to scapular, allow the carriage to move, feet over above head. Inhale bend knees. Exhale roll spine back down bringing heel with pubic bone. Inhale lengthen legs away.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Only do this if you know the people in your class and their limits.&nbsp;</strong></em></p>', '1 RED, 1 BLUE or 2 RED', null, '', '2018-03-26 05:46:05', '2018-03-26 05:46:05');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (42, 'Abdominal Series Double Straight Leg Stretch ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Exhale chest lift. Inhale reach both legs towards ceiling as close to L shape as possible. Exhale lower both legs to point of control. Inhale return legs to L shape. Maintain Chest Lift.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE only go to ''point of control"</strong></em></p>', '1 RED, 1 BLUE ', null, '', '2018-03-26 05:36:44', '2018-03-26 05:36:44');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (41, 'Abdominal Series Double Bent Leg Stretch ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Exhale chest lift reach both legs away from body until straight. Inhale return to table top. Maintain Chest Lift.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE only go to " point of control "</strong></em></p>', '1 RED, 1 BLUE ', null, '', '2018-03-26 05:33:49', '2018-03-26 05:33:49');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (52, 'Kneeling Arm Side Series RTC  ', '<p><u><em><strong>Set up</strong></em></u></p>
<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.</p>
<p><br></p>
<p><u><em><strong>The exercise</strong></em></u></p>
<p>Strap in hand closest to foot bar. Fist at navel. Elbow fist distance from waist. Exhale externally rotate humerus keeping the fist distance space between elbow and waist. Wrist long and neutral.</p>
<p><br></p>
<p><em><strong>NOTE Beginners sit on a Long Box</strong></em></p>', '1 YELLOW or 1 BLUE ', 'small-square.png', '', '2018-03-27 04:18:17', '2018-03-27 04:18:17');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (40, 'Abdominal Series Single Bent Leg Stretch ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Exhale chest lift reach single leg away from body. Alternate legs. Keep toes in the same plane.</p>
<p><br></p>
<p><em><strong>NOTE Keep pelvis stable.&nbsp;</strong></em></p>', '1 RED, 1 BLUE ', null, '', '2018-03-26 05:33:00', '2018-03-26 05:33:00');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (38, 'Abdominal Series Co-ordination ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise&nbsp;</strong></u></p>
<p>Exhale chest lift arms go into tricep press as legs extended. Hold breath beat heels in, out. Inhale return legs to table top and arms to tricep press.</p>', '1 RED, 1 BLUE', null, '', '2018-03-26 05:15:22', '2018-03-26 05:15:22');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (37, 'Abdominal Series 100''s', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Exhale chest lift. Beat arms down, inhale for 5 beats exhale for 5 beats. Reach straight legs to point of control. The goal is the full 100''s position.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE In the technique class do this in multipals of 20 or 50 untill you reach 100.&nbsp;</strong></em></p>', '1 RED, 1 BLUE ', null, '', '2018-03-26 05:12:30', '2018-03-26 05:12:30');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (26, 'Feet in Straps  Up Down ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet Parallel legs straight. Start at 45 degrees.</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale lift straight legs to as close to 90 degrees at hips while maintaining neutral spine. Exhale press straight legs down.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>', '1 RED, 1 BLUE OR 2 RED, OR 1 BLUE ', null, '', '2018-03-22 11:43:49', '2018-03-22 11:43:49');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (59, 'Kneeling Arm Series Serving ', '<p><u><strong>Set up</strong></u></p>
<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Holing hand straps. Elbos bent as though holding a tray.&nbsp;</p>
<p><br></p>
<p><u><strong>The excersise&nbsp;</strong></u></p>
<p>Exhale press hands forward extending elbows keeping the tray level. Inhale return to start.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE &nbsp;Variation Exhale press hands forward extending elbows and continue into shoulder extension “offering” the tray. Inhale return to start.&nbsp;</strong></em></p>', '1 BLUE or 1 RED +', null, '', '2018-03-28 04:49:05', '2018-03-28 04:49:05');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (67, 'Mermaid', '<p><u><strong>Set Up&nbsp;</strong></u></p>
<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>
<p>&nbsp;</p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion. Inhale into top lung. Exhale return to starting position.&nbsp;</p>', '1 RED ', null, '', '2018-03-28 05:42:00', '2018-03-28 05:42:00');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (73, 'Kneeling Shoulder Press Straight Arm Spine Extension ', '<p><u><strong>Set up</strong></u></p>
<p>Active child’s pose. Hands on Foot bar. Elbows down, fingertips to celiling.&nbsp;</p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows. Inhale come into spine extension maintaing straight elbows. Exhale return to starting position.&nbsp;</p>
<p><br></p>
<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>', '1 RED ', 'Triceps-Portrait.jpg', '', '2018-03-29 12:36:42', '2018-04-01 21:09:38');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (10, 'Pelvic Curl Single Leg', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;One leg at table top.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.</p>
<p><br></p>
<p><em><strong>NOTE </strong></em><em><strong>&nbsp;Kepp table top legs shin parallel to the roof.&nbsp;</strong></em><em><strong>&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></em></p>
<p><em><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong></em></p>
<p><u><em><strong>In technique class use 3 RED </strong></em></u>&nbsp;</p>', '3 RED or 1 BLUE In technique class use 3 RED ', 'phoenix-pilates-logo-2.jpg', '', '2018-03-22 10:07:56', '2018-04-08 00:22:18');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (9, 'Pelvic Curl ', '<p><u><strong>Set up</strong></u></p>
<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>
<p><br></p>
<p><u><strong>The exercise</strong></u></p>
<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;</p>
<p><br></p>
<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>
<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong></p>', '3 RED or 1 BLUE', 'medium-square.png', '', '2018-03-22 06:40:47', '2018-04-08 00:32:12');
INSERT INTO "public"."exercises" ("id", "name", "description", "springs", "photo", "video", "createdAt", "updatedAt") VALUES (75, 'Rowing Back Series Round Back 2', '<p><u><strong>Set up</strong></u></p>
<p>Sitting tall on carriage legs long through shoulder rests.</p>
<p>&nbsp;</p>
<p><u><strong>The exercise</strong></u></p>
<p>Elbows wide fists together at heart.&nbsp;</p>
<p>Inhale to prepare. Exhale roll back into long C curve. Inhale press arms out to side palms back. Exhale press hands together at back as head comes towards needs. Roll arms around to “dead swan” Stack spine back up to starting position.&nbsp;</p>', '1 RED ', 'small-landscape.png', '', '2018-03-29 12:46:25', '2018-04-10 20:58:20');
DROP TABLE "public"."labels";
CREATE TABLE "public"."labels" ("id" SERIAL NOT NULL, "type" INTEGER, "name" TEXT, "description" TEXT, "color" TEXT, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (1, 0, 'Pump', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (2, 0, 'Jump', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (3, 0, 'Connect', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (4, 0, 'Freestyle', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (5, 0, 'Technique', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (6, 1, 'Warm Up', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (7, 1, 'Supine Legs', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (8, 1, 'Supine Arms & Abs', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (9, 1, 'Weight Bearing Arms', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (10, 1, 'Seated / Knealing', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (11, 1, 'Prone', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (12, 1, 'Full Body / Standing', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (14, 1, 'Core and HIIT', null, null, '2018-04-04 03:02:59', '2018-04-04 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (13, 1, 'Jump', null, null, '2018-04-04 03:02:59', '2018-04-04 03:02:59');
INSERT INTO "public"."labels" ("id", "type", "name", "description", "color", "createdAt", "updatedAt") VALUES (15, 1, 'Jump Side Lying', null, null, '2018-03-22 03:02:59', '2018-03-22 03:02:59');
DROP TABLE "public"."ping";
CREATE TABLE "public"."ping" ("id" SERIAL NOT NULL, "lastPing" TIMESTAMP(6) WITH TIME ZONE, PRIMARY KEY ("id"));
INSERT INTO "public"."ping" ("id", "lastPing") VALUES (14199, '2018-04-11 00:04:44');
DROP TABLE "public"."templates";
CREATE TABLE "public"."templates" ("id" SERIAL NOT NULL, "categories" TEXT, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."templates" ("id", "categories", "createdAt", "updatedAt") VALUES (1, '6,13,14,15,13,10,9,14,13,14', '2018-04-05 22:01:56', '2018-04-05 22:01:56');
INSERT INTO "public"."templates" ("id", "categories", "createdAt", "updatedAt") VALUES (2, '6,7,8,9,10,11,12', '2018-04-05 22:01:56', '2018-04-05 22:01:56');
DROP TABLE "public"."users";
CREATE TABLE "public"."users" ("id" SERIAL NOT NULL, "firstName" TEXT, "lastName" TEXT, "email" TEXT, "password" TEXT, "permissions" TEXT, "lastLogin" TIMESTAMP(6) WITH TIME ZONE, "createdAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, "updatedAt" TIMESTAMP(6) WITH TIME ZONE NOT NULL, PRIMARY KEY ("id"));
INSERT INTO "public"."users" ("id", "firstName", "lastName", "email", "password", "permissions", "lastLogin", "createdAt", "updatedAt") VALUES (1, 'Liz', 'Chamas', 'magnoliasoup@gmail.com', 'pbkdf2$10000$b38c4931c3346ce44b32235b4859ca55b01417bc9c4d69972a26eb79cba9bc5642c3ed31b9c0d84e9e311571400334e04c2b423a339ac53c93173db863287558$a5ad0fc8634bb4914c06b13c7b94cba83e9908f1147b3612504f7577084796ad5b1caf4160b338c92e7efa94d08aef20bd3fb1c05c63241606099988e556c091$sha512', '333', '2018-04-11 00:04:53', '2018-04-04 23:16:02', '2018-04-11 00:04:53');
