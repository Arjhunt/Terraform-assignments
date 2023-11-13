# Configure providers for each region
provider "aws" {
  region = var.aws_region_ohio
}

provider "aws" {
  alias  = "n_virginia"
  region = var.aws_region_n_virginia
}

