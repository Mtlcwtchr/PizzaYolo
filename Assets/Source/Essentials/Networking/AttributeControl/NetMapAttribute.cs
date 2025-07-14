using System;

namespace Source.Essentials.Networking.AttributeControl
{
    [AttributeUsage(AttributeTargets.Property)]
    public class NetMapAttribute : Attribute
    {
        public NetMapAttribute(string repProperty = null, bool nullableSource = false, object defaultValue = null)
        {
        }
    }
}