using Newtonsoft.Json;
using System.Text;

namespace MegaStore.Helper
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    public class MessageHelper
    {
        public static byte[] ToData<TMessage>(TMessage message)
            where TMessage : Message
        {
            var json = JsonConvert.SerializeObject(message);
            return Encoding.Unicode.GetBytes(json);
        }

        public static TMessage FromData<TMessage>(byte[] data)
            where TMessage : Message
        {
            var json = Encoding.Unicode.GetString(data);
            return (TMessage)JsonConvert.DeserializeObject<TMessage>(json);
        }
    }
}
