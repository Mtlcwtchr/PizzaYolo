using System;
using System.Collections.Generic;
using Fusion;
using Source.Essentials.Networking.State;
using Source.Essentials.Networking.World;
using UnityEngine;

namespace Source.Essentials.Networking.Mode
{
    public class GameModeBase : NetworkBehaviour
    {
        public event Action OnPlayersJoined;
        public event Action OnGameStarted;
        
        private readonly List<Controller.PlayerController> _players = new();
        private readonly List<Controller.PlayerController> _readyPlayers = new();

        private PlayerRef _gameplayOwner;

        public bool IsGameStarted { get; private set; }

        private GameState GameState => WorldBase.Instance.GameState;

        public override void Spawned()
        {
            WorldBase.Instance.Register(this);
            WorldBase.Instance.OnPlayerRegistered += PlayerRegistered;
        }

        private void PlayerRegistered(Controller.PlayerController player)
        {
            if (!HasStateAuthority)
                return;

            player.OnReadyToPlay += PlayerReady;

            Debug.Log($"Player {player.Player.PlayerId} registered");
            _players.Add(player);
            if (_players.Count >= 2) SignalPlayersJoined(); // TODO: config

            void PlayerReady()
            {
                _readyPlayers.Add(player);
                Debug.Log($"Player {player.Player.PlayerId} ready");
                if (_readyPlayers.Count >= 2)
                {
                    Debug.Log("Start game");
                    StartGame();
                }
            }
        }

        private void SignalPlayersJoined() => SignalPlayersJoined_Rpc();

        private void StartGame() => StartGame_Rpc();

        [Rpc(RpcSources.StateAuthority, RpcTargets.All)]
        private void SignalPlayersJoined_Rpc() => OnPlayersJoined?.Invoke();

        [Rpc(RpcSources.StateAuthority, RpcTargets.All)]
        private void StartGame_Rpc()
        {
            IsGameStarted = true;
            OnGameStarted?.Invoke();
        }
    }
}