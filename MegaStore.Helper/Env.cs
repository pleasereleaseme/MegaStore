using System;
using System.Collections.Generic;
using System.Text;

namespace MegaStore.Helper
{
    public class Env
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string MessageQueueUrl { get { return Get("MESSAGE_QUEUE_URL"); } }

        private static string Get(string variable)
        {
            if (!_Values.ContainsKey(variable))
            {
                var value = Environment.GetEnvironmentVariable(variable);
                _Values[variable] = value;
            }
            return _Values[variable];
        }
    }
}
