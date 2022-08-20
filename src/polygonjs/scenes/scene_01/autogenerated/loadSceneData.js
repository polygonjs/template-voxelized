import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1660955911475",
  root: "1660955911475",
  nodes: {
    cameras: "1660955911475",
    "cameras/cameraControls1": "1660955911475",
    "cameras/cameraControls2": "1660955911475",
    lights: "1660955911475",
    voxelizedObject: "1660955911475",
    "voxelizedObject/MAT": "1660955911475",
    "voxelizedObject/MAT/meshStandardBuilder_INSTANCES": "1660955911475",
    "voxelizedObject/eventsNetwork1": "1660955911475",
  },
};

export const loadSceneData_scene_01 = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "scene_01",
    urlPrefix: sceneDataRoot + "/scene_01",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
