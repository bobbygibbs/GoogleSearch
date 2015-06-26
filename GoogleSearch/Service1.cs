using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using System.IO;
using System.Configuration;

namespace GoogleSearch
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    [AspNetCompatibilityRequirements(RequirementsMode=AspNetCompatibilityRequirementsMode.Allowed)]
    public class Service1 : IService1
    {

        public string processSearch(string query)
        {
            String url = ConfigurationManager.AppSettings["TargetAddress"];

            if (query == null)
            {
                query = "George";
            }

            HttpClient client = new HttpClient();
            //Uri address = new Uri("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=" + query); Limited queries; Cannot be automated; Deprecated
            Uri address = new Uri(url + query);

            HttpResponseMessage response = client.GetAsync(address).Result;
            String stream = response.Content.ReadAsStringAsync().Result;
            //dynamic result = JsonConvert.DeserializeObject(stream);
            String[] partitions = Regex.Split(stream, "h3");

            int first_result = 4;
            if (partitions[first_result].Contains("Verbatim") || partitions[first_result].Contains("Images for") || partitions[first_result].Contains("Map for") || partitions[first_result].Contains("News for"))
                first_result = 6;
            
            String trim = Regex.Replace(partitions[first_result], "<[^>]+>", String.Empty);

            return trim.Substring(trim.IndexOf(">") + 1, trim.IndexOf("<") - trim.IndexOf(">") - 1);
        }
    }

}
