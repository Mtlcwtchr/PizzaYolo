using Fusion;

namespace Source.Essentials.Networking
{
    public partial class GameState : NetworkBehaviour
    {
        public override void Spawned()
        {
            WorldBase.Instance.Register(this);
        }
    }
}