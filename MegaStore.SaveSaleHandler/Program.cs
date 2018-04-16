using System;
using System.Threading;
using MegaStore.Helper;
using NATS.Client;

namespace MegaStore.SaveSaleHandler
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    class Program
    {
        private static ManualResetEvent _ResetEvent = new ManualResetEvent(false);
        private const string QUEUE_GROUP = "save-sale-handler";

        static void Main(string[] args)
        {
            Console.WriteLine($"Connecting to message queue url: {Env.MessageQueueUrl}");
            using (var connection = MessageQueue.CreateConnection())
            {
                var subscription = connection.SubscribeAsync(SaleCreatedEvent.MessageSubject, QUEUE_GROUP);
                subscription.MessageHandler += SaveSale;
                subscription.Start();
                Console.WriteLine($"Listening on subject: {SaleCreatedEvent.MessageSubject}, queue: {QUEUE_GROUP}");

                _ResetEvent.WaitOne();
                connection.Close();
            }
        }

        private static void SaveSale(object sender, MsgHandlerEventArgs e)
        {
            try
            {
                Console.WriteLine($"Received message, subject: {e.Message.Subject}");
                var eventMessage = MessageHelper.FromData<SaleCreatedEvent>(e.Message.Data);
                Console.WriteLine($"Saving new sale, created at: {eventMessage.CreatedAt}; event ID: {eventMessage.CorrelationId}");

                var sale = eventMessage.Sale;

                using (var db = new MegaStoreContext())
                {
                    db.Sale.Add(sale);
                    db.SaveChanges();
                }

                Console.WriteLine($"Sale saved. Sale ID: {sale.SaleID}; event ID: {eventMessage.CorrelationId}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception processing event: {ex}");
            }
        }
    }
}
