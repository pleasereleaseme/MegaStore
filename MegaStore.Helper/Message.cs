using System;

namespace MegaStore.Helper
{
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
