using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

namespace GoogleSearch
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    [AspNetCompatibilityRequirements(RequirementsMode=AspNetCompatibilityRequirementsMode.Allowed)]
    public class Service1 : IService1
    {
        public string processSearch(string query)
        {
            HttpClient client = new HttpClient();
            Uri address = new Uri("https://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=" + query);

            HttpResponseMessage response = client.GetAsync(address).Result;
            String stream = response.Content.ReadAsStringAsync().Result;
            dynamic result = JsonConvert.DeserializeObject(stream);
            
            return Regex.Replace(result.responseData.results[0].title.ToString(), "<[^>]+>", String.Empty);
        }
    }
}
