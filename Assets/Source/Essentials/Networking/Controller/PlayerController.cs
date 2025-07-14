using System;
using Fusion;
using Source.Essentials.Networking.AttributeControl;
using Source.Essentials.Networking.World;

namespace Source.Essentials.Networking.Controller
{
    public partial class PlayerController : NetworkBehaviour
    {
        public event Action OnReadyToPlay;
        
        public PlayerRef Player { get; private set; }

        public static implicit operator PlayerRef(PlayerController controller)
        {
            return controller.Player;
        }

        public override void Spawned()
        {
            Player = Object.InputAuthority;
            WorldBase.Instance.Register(this);
            if (Player != Runner.LocalPlayer)
                return;
        }
        
        [NetCall(false)]
        private void SignalReadyToPlay() => OnReadyToPlay?.Invoke();
    }
}