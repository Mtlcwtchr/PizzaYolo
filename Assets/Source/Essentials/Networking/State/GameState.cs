using Fusion;
using Source.Essentials.Networking.World;

namespace Source.Essentials.Networking.State
{
    public partial class GameState : NetworkBehaviour
    {
        public override void Spawned()
        {
            WorldBase.Instance.Register(this);
        }
    }
}