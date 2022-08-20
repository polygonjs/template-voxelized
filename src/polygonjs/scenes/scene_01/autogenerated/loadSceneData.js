import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1661019205183",
  root: "1661019205183",
  nodes: {
    cameras: "1661019205183",
    "cameras/cameraControls1": "1661019205183",
    "cameras/cameraControls2": "1661019205183",
    lights: "1661019205183",
    voxelizedObject: "1661019205183",
    "voxelizedObject/MAT": "1661019205183",
    "voxelizedObject/MAT/meshStandardBuilder_INSTANCES": "1661019205183",
    "voxelizedObject/eventsNetwork1": "1661019205183",
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
