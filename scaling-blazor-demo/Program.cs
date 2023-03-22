using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;

using Neon.Web.SignalR;

using ScalingBlazorDemo.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages().Services
    .AddSignalR()
    .AddNats(options =>
    {
        options.Servers = new[]
        {
            Environment.GetEnvironmentVariable("NATS_URI")
        };
    })
    .AddServerSideBlazor().Services
    .AddResponseCompression()
    .AddSingleton<WeatherForecastService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}


app.UseResponseCompression();
app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
