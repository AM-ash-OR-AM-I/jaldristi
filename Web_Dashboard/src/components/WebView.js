import Public from "./Public";

const WebView = () => {
  return (
    <>
      <Public />
      <div className="min-h-screen flex items-center justify-center">
        <div className="bg-blue-500 text-white p-4 rounded-lg shadow-lg">
          WebView Dashboard for App
        </div>
      </div>
    </>
  );
};
export default WebView;
