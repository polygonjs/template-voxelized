import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1660605744815",
  root: "1660605744815",
  nodes: {
    cameras: "1660605744815",
    "cameras/cameraControls1": "1660605744815",
    "cameras/cameraControls2": "1660605744815",
    lights: "1660605744815",
    voxelizedObject: "1660605744815",
    "voxelizedObject/MAT": "1660605744815",
    "voxelizedObject/MAT/meshStandardBuilder_INSTANCES": "1660605744815",
    "voxelizedObject/eventsNetwork1": "1660605744815",
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
