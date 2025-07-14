using System;
using System.Collections.Generic;
using Fusion;
using R3;
using Source.Essentials.Networking.AttributeControl;
using Source.Essentials.Networking.State;
using Source.Essentials.Networking.World;

namespace Source.Essentials.Networking.Mode
{
    public partial class GameModeBase : NetworkBehaviour
    {
        private readonly List<Controller.PlayerController> _players = new();
        private readonly List<Controller.PlayerController> _readyPlayers = new();

        private PlayerRef _gameplayOwner;
        
        [NetProperty]
        private ReactiveProperty<bool> IsGameStarted { get; set; }

        private GameState GameState => WorldBase.Instance.GameState;

        public override void Spawned()
        {
            WorldBase.Instance.Register(this);
        }
        
        private void StartGame() => 
            SetIsGameStarted(true);
    }
}