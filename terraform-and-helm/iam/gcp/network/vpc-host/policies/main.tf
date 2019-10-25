resource "google_project_iam_member" "itx-secuirty-team" {
  role   = "roles/owner"
  member = "group:"
}

resource "google_project_iam_member" "logicmonitor" {
  role   = "roles/viewer"
  member = "serviceAccount:"
}

resource "google_project_iam_member" "itx-ops-sys-all" {
  role   = "roles/owner"
  member = "group:"
}

resource "google_project_iam_member" "ncs" {
  role   = "roles/owner"
  member = "group:"
}

resource "google_project_iam_member" "itx-ops-all" {
  role   = "roles/viewer"
  member = "group:"
}

resource "google_project_iam_member" "itx-sys-eng-all" {
  role   = "roles/viewer"
  member = "group:"
}

resource "google_project_iam_member" "itx-ops-net-all" {
  role = "roles/owner"
  member = "group:"

}
