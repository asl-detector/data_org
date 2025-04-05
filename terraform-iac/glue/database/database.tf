resource "aws_glue_catalog_database" "glue_database" {
  name = "${var.project_name}_glue_database_${var.uuid}"
}