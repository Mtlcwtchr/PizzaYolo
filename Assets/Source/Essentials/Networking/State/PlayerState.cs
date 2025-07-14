using Fusion;
using Source.Essentials.Networking.World;

namespace Source.Essentials.Networking.State
{
    public partial class PlayerState : NetworkBehaviour
    {
        public PlayerRef Player { get; private set; }

        public static implicit operator PlayerRef(PlayerState state)
        {
            return state.Player;
        }

        public override void Spawned()
        {
            Player = Object.InputAuthority;
            WorldBase.Instance.Register(this);
        }
    }
}