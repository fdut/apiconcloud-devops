
echo "Start: `date`"
SECONDS=0

# ---------
# In PIPELINE, Add an environment variable named apikey with your IAM api key to access to youy IBM Clous services
# ----------
# For local test ONLY create a file apiKey.txt with IAM api key inside 
# ----------

if [ ! "$apikey" ]; then
    apikey=`cat apiKey.txt`;
fi

if [ ! "$apicserver" ]; then
    . $PWD/apic.properties;
fi

FILE=./livrable.txt
. $FILE

if [ -z "$product" ]; then

   # if product not exist, add empty named "nopublish" in the working "packages" directory
   echo "Product $product does not exist."

else

   echo "Product: $product , Version: $version"
   product2publish=yaml/${product}_${version}.yaml
   
   # -- FOR PIPELINE ADD HERE INSTALL OF CLI IF REQUIRED
   # -- 
    echo "---- nvm change version ----"
    echo "---- for apic compatibility ----"
    nvm install 10.15.1
    nvm use 10.15.1
    node -v

    echo "---- install apiconnect cli ----"
    npm install -g apiconnect --unsafe-perm=true --allow-root
 
    echo "y" | apic
    echo "n" | apic
   # -- 


   # log to apiconnect saas instance
   echo "Login to $apicserver"
   apic login --server $apicserver -k  $apikey

   retVal=$?
   if [ $retVal -ne 0 ]; then
    	echo "Error with login -> $retVal"
	exit 1
   fi

   echo "Publish $product2publish to server $apicserver on organization $org on catalog $catalog"
   apic products:publish $product2publish --server $apicserver --organization $org --catalog $catalog
   
fi

echo "End: `date`"
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."


