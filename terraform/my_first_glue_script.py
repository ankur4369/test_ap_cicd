import sys
from awsglue.utils import getResolvedOptions

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
print(f"Running the job - {args['JOB_NAME']}")