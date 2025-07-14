using System;

namespace Source.Essentials.Networking.AttributeControl
{
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property)]
    public class NetPropertyAttribute : Attribute
    {
        public NetPropertyAttribute(bool requireAuthority = true)
        {
        }
    }
}