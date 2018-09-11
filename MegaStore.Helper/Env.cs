using System;
using System.Collections.Generic;

namespace MegaStore.Helper

{   // This code is modified from https://github.com/sixeyed/docker-on-windows
    public class Env
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string MessageQueueUrl { get { return Get("MESSAGE_QUEUE_URL"); } }

        public static string DbConnectionString { get { return Get("DB_CONNECTION_STRING"); } }

        public static string AppInsightsInstrumentationKey { get { return Get("APP_INSIGHTS_INSTRUMENTATION_KEY"); } }

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
