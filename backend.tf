terraform {	
	backend "s3"
	{
	bucket	= "siva-tf-state"
	key 	= "tfstate"	
	}
}