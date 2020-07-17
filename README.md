# Unity Build Action

This action build Unity project.

And, can run on Linux, Mac, Windows, or any VM.

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

**Required** Choose `android`, `ios` `windows`, `webgl`, etc.

### `changeset`

**Required** Required for Unity Hub, available at the bottom of Unity's Release Note.

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
- uses: yukiarrr/unity-build-action@v0.5.0
  with:
    unity-version: 2018.4.12f1
    unity-username: ${{ secrets.UNITY_USERNAME }}
    unity-password: ${{ secrets.UNITY_PASSWORD }}
    unity-serial: ${{ secrets.UNITY_SERIAL }}
    build-target: iOS
    changeset: 59ddc4c59b4f
```

### And export ipa

```yaml
- uses: yukiarrr/unity-build-action@v0.5.0
  with:
    unity-version: 2018.4.12f1
    unity-username: ${{ secrets.UNITY_USERNAME }}
    unity-password: ${{ secrets.UNITY_PASSWORD }}
    unity-serial: ${{ secrets.UNITY_SERIAL }}
    build-target: iOS
    changeset: 59ddc4c59b4f
- uses: yukiarrr/ios-build-action@v0.5.0
  with:
    project-path: Output/Unity-iPhone.xcodeproj
    p12-base64: ${{ secrets.P12_BASE64 }}
    mobileprovision-base64: ${{ secrets.MOBILEPROVISION_BASE64 }}
    code-signing-identity: ${{ secrets.CODE_SIGNING_IDENTITY }}
    team-id: ${{ secrets.TEAM_ID }}
```