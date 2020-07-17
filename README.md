# Unity Build Action

This action build Unity project.

And, can run on Linux, Mac, Windows, or self-hosted.

## Inputs

### `unity-version`

**Required** For example, `2018.4.16f1`.

### `unity-username`

**Required** Unity username.

### `unity-password`

**Required** Unity password.

### `unity-serial`

**Required** Unity serial.

### `build-target`

**Required** Choose `Android`, `iOS` `Mac`, `Windows`, or `WebGL`.

### `project-path`

Unity project path. Default `.`.

### `execute-method`

Use by -executeMethod. Default `UnityBuild.BatchBuild.Build`.

### `output-path`

Output path of default execute-method. Default `Output`.

### `command-args`

Build command args.

## Example usage

### Unity Build

```yaml
- uses: yukiarrr/unity-build-action@v0.6.0
  with:
    unity-version: 2018.4.12f1
    unity-username: ${{ secrets.UNITY_USERNAME }}
    unity-password: ${{ secrets.UNITY_PASSWORD }}
    unity-serial: ${{ secrets.UNITY_SERIAL }}
    build-target: iOS
```

### And export ipa

```yaml
- uses: yukiarrr/unity-build-action@v0.6.0
  with:
    unity-version: 2018.4.12f1
    unity-username: ${{ secrets.UNITY_USERNAME }}
    unity-password: ${{ secrets.UNITY_PASSWORD }}
    unity-serial: ${{ secrets.UNITY_SERIAL }}
    build-target: iOS
- uses: yukiarrr/ios-build-action@v1.0.0
  with:
    project-path: Output/Unity-iPhone.xcodeproj
    p12-base64: ${{ secrets.P12_BASE64 }}
    mobileprovision-base64: ${{ secrets.MOBILEPROVISION_BASE64 }}
    code-signing-identity: ${{ secrets.CODE_SIGNING_IDENTITY }}
    team-id: ${{ secrets.TEAM_ID }}
```