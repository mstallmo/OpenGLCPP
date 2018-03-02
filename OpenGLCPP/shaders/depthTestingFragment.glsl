#version 330 core
out vec4 FragColor;

in vec2 TexCoords;

uniform sampler2D texture1;
uniform bool viewZBufferLinear = false;
uniform bool viewZBufferNonLinear = false;

float near = 0.5;
float far = 100.0;

float LinearizeDepth(float depth)
{
    float z = depth * 2.0 - 1.0;
    return (2.0 * near * far) / (far + near - z * (far - near));
}


void main()
{
    if (viewZBufferLinear == true)
    {
        float depth = LinearizeDepth(gl_FragCoord.z) / far;
        FragColor = vec4(vec3(depth), 1.0);
    }
    else if (viewZBufferNonLinear == true)
    {
        FragColor = vec4(vec3(gl_FragCoord.z), 1.0);
    }
    else
    {
        FragColor = texture(texture1, TexCoords);
    }
    
}