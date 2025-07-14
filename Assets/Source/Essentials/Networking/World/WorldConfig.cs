using Fusion;
using Source.Essentials.Networking.Mode;
using Source.Essentials.Networking.State;
using UnityEngine;

namespace Source.Essentials.Networking.World
{
    [CreateAssetMenu(fileName = "WorldConfig", menuName = "Networking/World/World Config")]
    public class WorldConfig : ScriptableObject
    {
        public GameModeBase gameModePrefab;
        public GameState gameStatePrefab;
        
        public NetworkPrefabRef playerController;
        public NetworkPrefabRef playerState;
    }
}