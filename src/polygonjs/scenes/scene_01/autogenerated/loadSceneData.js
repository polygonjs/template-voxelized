import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1664128761527",
  root: "1661019205183",
  nodes: {
    cameras: "1661019205183",
    "cameras/cameraControls1": "1661019205183",
    "cameras/cameraControls2": "1661019205183",
    lights: "1663693396203",
    voxelizedObject: "1661019205183",
    "voxelizedObject/MAT": "1661019205183",
    "voxelizedObject/MAT/meshStandardBuilder_INSTANCES": "1663693396203",
    "voxelizedObject/eventsNetwork1": "1663693396203",
  },
  shaders: {
    "/voxelizedObject/MAT/meshStandardBuilder_INSTANCES": {
      vertex: "1663693396203",
      fragment: "1663693396203",
      "customDepthMaterial.vertex": "1663693396203",
      "customDepthMaterial.fragment": "1663693396203",
      "customDistanceMaterial.vertex": "1663693396203",
      "customDistanceMaterial.fragment": "1663693396203",
      "customDepthDOFMaterial.vertex": "1663693396203",
      "customDepthDOFMaterial.fragment": "1663693396203",
    },
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
