// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
import { PointerEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/Pointer";
import { RaycastEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/Raycast";
// mat
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
// obj
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { AreaLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AreaLight";
import { AttribDeleteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribDelete";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { EventsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/EventsNetwork";
import { FileOBJSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileOBJ";
import { FuseSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Fuse";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { InstanceSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Instance";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { PaletteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Palette";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PointSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Point";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { ScatterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Scatter";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";
import { TransformResetSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/TransformReset";

export const requiredImports_scene_01 = {
  nodes: [
    CameraOrbitControlsEventNode,
    PointerEventNode,
    RaycastEventNode,
    MeshStandardBuilderMatNode,
    GeoObjNode,
    AreaLightSopNode,
    AttribDeleteSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    EventsNetworkSopNode,
    FileOBJSopNode,
    FuseSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    InstanceSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    PaletteSopNode,
    PerspectiveCameraSopNode,
    PointSopNode,
    PolarTransformSopNode,
    ScatterSopNode,
    TransformSopNode,
    TransformResetSopNode,
  ],
  operations: [],
};
