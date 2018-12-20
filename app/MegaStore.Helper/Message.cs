using System;

namespace MegaStore.Helper
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    public abstract class Message
    {
        public string CorrelationId { get; set; }

        public abstract string Subject { get; }

        public Message()
        {
            CorrelationId = Guid.NewGuid().ToString();
        }
    }
}
