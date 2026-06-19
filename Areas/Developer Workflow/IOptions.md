Here is a distilled, hyper-concise example of how to use `IOptions` in ASP.NET Core.

### 1. The AppSettings (`appsettings.json`)

Add your configuration section:

```json
{
  "WizardSettings": {
    "House": "Gryffindor",
    "SpellsPerDay": 10
  }
}

```

### 2. The Options Class

Create a plain class that matches the JSON structure:

```csharp
public class WizardSettings
{
    public string House { get; set; } = string.Empty;
    public int SpellsPerDay { get; set; }
}

```

### 3. Register in `Program.cs`

Bind the configuration section to your class:

```csharp
builder.Services.Configure<WizardSettings>(
    builder.Configuration.GetSection("WizardSettings")
);

```

### 4. Inject into your Controller/Service

Inject `IOptions<T>` and access the values via `.Value`:

```csharp
public class MagicController : ControllerBase
{
    private readonly WizardSettings _settings;

    // IOptions<T> is automatically injected here
    public MagicController(IOptions<WizardSettings> options)
    {
        _settings = options.Value; 
    }

    [HttpGet]
    public IActionResult GetSettings()
    {
        return Ok($"Welcome to {_settings.House}. Max spells: {_settings.SpellsPerDay}");
    }
}

```

---

> 💡 **Quick Tip:** Use `IOptions<T>` for singleton/static configurations. If you expect your `appsettings.json` to change while the app is running without restarting, inject `IOptionsSnapshot<T>` instead.