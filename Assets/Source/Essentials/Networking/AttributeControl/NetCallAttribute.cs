using System;

namespace Source.Essentials.Networking.AttributeControl
{
    [AttributeUsage(AttributeTargets.Method)]
    public class NetCallAttribute : Attribute
    {
        public NetCallAttribute(bool signalResult = true)
        {
        }
    }
}