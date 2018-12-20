using NATS.Client;

namespace MegaStore.Helper
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    public class MessageQueue
    {
        public static void Publish<TMessage>(TMessage message)
            where TMessage : Message
        {
            using (var connection = CreateConnection())
            {
                var data = MessageHelper.ToData(message);
                connection.Publish(message.Subject, data);
            }
        }

        public static IConnection CreateConnection()
        {
            return new ConnectionFactory().CreateConnection(Env.MessageQueueUrl);
        }
    }
}
