﻿using System;

namespace MegaStore.Helper
{
    public class SaleCreatedEvent : Message
    {
        public override string Subject { get { return MessageSubject; } }

        public DateTime CreatedAt { get; set; }

        public Sale Sale { get; set; }

        public static string MessageSubject = "events.sale.created";
    }
}
