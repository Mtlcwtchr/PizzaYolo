using Fusion;

namespace Source.Essentials.Networking
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