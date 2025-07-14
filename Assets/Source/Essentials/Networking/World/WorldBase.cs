using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Fusion;
using Source.Essentials.Networking.Mode;
using Source.Essentials.Networking.State;
using UnityEngine;

namespace Source.Essentials.Networking.World
{
    public class WorldBase : NetworkBehaviour, IPlayerJoined
    {
        [SerializeField] private WorldConfig worldConfig;
        
        public event Action<Controller.PlayerController> OnPlayerRegistered;
        public event Action<PlayerState> OnPlayerStateRegistered;
        
        public static WorldBase Instance { get; private set; }

        public GameModeBase GameMode { get; private set; }
        public GameState GameState { get; private set; }

        public Controller.PlayerController LocalPlayer { get; private set; }
        public PlayerState PlayerState { get; private set; }

        public Controller.PlayerController Enemy { get; private set; }
        public PlayerState EnemyState { get; private set; }

        public Dictionary<PlayerRef, Controller.PlayerController> ActivePlayers { get; } = new();
        public Dictionary<PlayerRef, PlayerState> PlayerStates { get; } = new();

        private void Awake()
        {
            Instance = this;

            SpawnStateAuthorityObjects().Forget();
        }

        public void PlayerJoined(PlayerRef player)
        {
            SpawnInputAuthorityObjects(player).Forget();
        }

        public void Register(GameModeBase gameMode)
        {
            GameMode = gameMode;
        }

        public void Register(GameState gameState)
        {
            GameState = gameState;
        }

        public void Register(Controller.PlayerController localPlayer)
        {
            ActivePlayers.Add(localPlayer, localPlayer);
            if (Runner.IsClient)
            {
                if (localPlayer == Runner.LocalPlayer)
                    LocalPlayer = localPlayer;
                else
                    Enemy = localPlayer;
            }

            OnPlayerRegistered?.Invoke(localPlayer);
        }

        public void Register(PlayerState playerState)
        {
            PlayerStates.Add(playerState, playerState);
            if (Runner.IsClient)
            {
                if (playerState == Runner.LocalPlayer)
                    PlayerState = playerState;
                else
                    EnemyState = playerState;
            }

            OnPlayerStateRegistered?.Invoke(playerState);
        }

        private async UniTask SpawnStateAuthorityObjects()
        {
            if (!Runner.IsServer)
                return;
            
            await Runner.SpawnAsync(worldConfig.gameModePrefab, inputAuthority: null, flags: NetworkSpawnFlags.DontDestroyOnLoad);
            await Runner.SpawnAsync(worldConfig.gameStatePrefab, inputAuthority: null, flags: NetworkSpawnFlags.DontDestroyOnLoad);

            await Runner.SpawnAsync(worldConfig.gameModePrefab, inputAuthority: null, flags: NetworkSpawnFlags.DontDestroyOnLoad);
            await Runner.SpawnAsync(worldConfig.gameStatePrefab, inputAuthority: null, flags: NetworkSpawnFlags.DontDestroyOnLoad);
        }

        private async UniTask SpawnInputAuthorityObjects(PlayerRef player)
        {
            if (!Runner.IsServer)
                return;

            await Runner.SpawnAsync(worldConfig.playerController, inputAuthority: player);
            await Runner.SpawnAsync(worldConfig.playerState, inputAuthority: player);
        }
    }
}