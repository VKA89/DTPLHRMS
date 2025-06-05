<%@ Application Language="C#" %>

<script runat="server">
    void Application_BeginRequest(object sender, EventArgs e)
    {
        //    ////Public Pages
        //    string[] publicPages = new string[] {
        //    "/",
        //    "/Default.aspx",
        //    "/ObjectivesandFeatures.aspx",
        //    "/Composition.aspx",
        //    "/OrganisationChart.aspx"
        //};

        //string requestedPath = Request.Url.AbsolutePath.ToLower();
        ////Is Page from Public Pages
        //bool isAllowed = publicPages.Any(page => page.ToLower() == requestedPath);
        //if (requestedPath != "/")
        //{
        //    if (!isAllowed)
        //    {
        //        if (HttpContext.Current.Session != null)
        //        {
        //            if (HttpContext.Current.Session["User Session"] != null)
        //            {

        //            }
        //            else
        //            {
        //                Response.Redirect("/default.aspx", true);
        //            }
        //        }
        //        else
        //        {
        //            Response.Redirect("/default.aspx", true);
        //        }
        //    }
        //}
    }
    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

</script>
