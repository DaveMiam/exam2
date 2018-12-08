using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
 
public class AimPostProcessing : MonoBehaviour {
    Material material;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    void Awake()
    {
        material = new Material(Shader.Find("Hidden/ShaderQ2"));
        
    }
}
