Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F71531E8;
	Tue, 15 Jul 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590946; cv=none; b=ZcKnSwes8brwyFSlfMD6aFZ8sYDTf2lBxgxchb7Aw0PmEJcx/Jzf7MyucjkB+0grSg7yU83BdkWK9ss6B38QGXF4gHNYA0w1OzK4yQ/2vOGPzm368x/l+IZiCRjA/40BbfRCzoJsScZt60XF9+rhRK2sNtLsAnS6SGn0M3XA7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590946; c=relaxed/simple;
	bh=/i8hp2A63xErh+VqtEwyoNTl9Erl2EmboCvW+eFlchM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkqo6g+QBXTj9qS8hhHiSn5JDhtoNT/Z9zXdr84RgJYgUWmbbqir0zQrJ/5X9IjQTWCnVVxaAaBeIF20tYSoeUtmb2eM8+YMGAn0mLHarz4Vd/4TaJAcmJlgRKB6JzimJlJGd2HDy9FlhxUrmrmpmE+eYvrTa4GzQvXdBJmdQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jc1ulnuX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7iP4mBwN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jc1ulnuX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7iP4mBwN"
Date: Tue, 15 Jul 2025 16:48:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752590939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhs4oDExnFBWWlX2efUPYBaJUeuHGbsczHs2gZahTWI=;
	b=jc1ulnuXEK8hy0xZsHSzFdlEOEitDkQIMyTjMoaGh4gMZPJGGCpE1NXrtF+LpkuDfMBKX3
	t25X99oWc9MseXo7eDwem/HAkdeF2xmnpSehth1P5GR55fP9eGqdrAnE5DF6JYED478HJm
	UCeW5q2ydHaz9NT1e8hHR4tlmP5SpyEPKqSNTMIh8P+UwZjRQ9PmDVQSNT8rP12lUYHhek
	GYt8gYZVmofeJH28CkgcKAUuVbEBf1s4t4Y0+kR4yjOAT5T+kWSSoLxskna4Oce9/66WMp
	X/GvuWCFY0E7ThyRB8BfagOv1RYgGGfYsh4WeyGxfJSLK4/pluTh3p010A5i4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752590939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhs4oDExnFBWWlX2efUPYBaJUeuHGbsczHs2gZahTWI=;
	b=7iP4mBwNsSBmpNYNxkqe6QMfm4fPpKoTCrgT1eP346KNtXS2kUbEg3ugCwMYBCnhjOn41p
	AynfNmlSmcf4EwCw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 08/17] verification/rvgen: Organise Kconfig entries
 for nested monitors
Message-ID: <20250715144858.ZS4_m8Qm@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-9-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:25AM +0200, Gabriele Monaco wrote:
> The current behaviour of rvgen when running with the -a option is to
> append the necessary lines at the end of the configuration for Kconfig,
> Makefile and tracepoints.
> This is not always the desired behaviour in case of nested monitors:
> while tracepoints are not affected by nesting and the Makefile's only
> requirement is that the parent monitor is built before its children, in
> the Kconfig it is better to have children defined right after their
> parent, otherwise the result has wrong indentation:
> 
> [*]   foo_parent monitor
> [*]     foo_child1 monitor
> [*]     foo_child2 monitor
> [*]   bar_parent monitor
> [*]     bar_child1 monitor
> [*]     bar_child2 monitor
> [*]   foo_child3 monitor
> [*]   foo_child4 monitor
> 
> Adapt rvgen to look for a different marker for nested monitors in the
> Kconfig file and append the line right after the last sibling, instead
> of the last monitor.
> Also add the marker when creating a new parent monitor.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/trace/rv/Kconfig                     |  5 +++++
>  tools/verification/rvgen/rvgen/container.py | 13 +++++++++++++
>  tools/verification/rvgen/rvgen/generator.py | 13 ++++++++-----
>  3 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index c11bf7e61ebf0..26017378f79b8 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -43,6 +43,7 @@ config RV_PER_TASK_MONITORS
>  
>  source "kernel/trace/rv/monitors/wip/Kconfig"
>  source "kernel/trace/rv/monitors/wwnr/Kconfig"
> +
>  source "kernel/trace/rv/monitors/sched/Kconfig"
>  source "kernel/trace/rv/monitors/tss/Kconfig"
>  source "kernel/trace/rv/monitors/sco/Kconfig"
> @@ -50,9 +51,13 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
>  source "kernel/trace/rv/monitors/scpd/Kconfig"
>  source "kernel/trace/rv/monitors/snep/Kconfig"
>  source "kernel/trace/rv/monitors/sncid/Kconfig"
> +# Add new sched monitors here
> +
>  source "kernel/trace/rv/monitors/rtapp/Kconfig"
>  source "kernel/trace/rv/monitors/pagefault/Kconfig"
>  source "kernel/trace/rv/monitors/sleep/Kconfig"
> +# Add new rtapp monitors here
> +
>  # Add new monitors here
>  
>  config RV_REACTORS
> diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verification/rvgen/rvgen/container.py
> index 47d8ab2ad3ec4..fee493f89fde6 100644
> --- a/tools/verification/rvgen/rvgen/container.py
> +++ b/tools/verification/rvgen/rvgen/container.py
> @@ -20,3 +20,16 @@ class Container(generator.RVGenerator):
>          main_h = self.main_h
>          main_h = main_h.replace("%%MODEL_NAME%%", self.name)
>          return main_h
> +
> +    def fill_kconfig_tooltip(self):
> +        """Override to produce a marker for this container in the Kconfig"""
> +        container_marker = f"# Add new {self.name} monitors here\n"
> +        if self.auto_patch:
> +            self._patch_file("Kconfig",
> +                            "# Add new monitors here", "")

Isn't this one excessive? I gave it a try, but I had double blank line:

python3 tools/verification/rvgen -a container -n hello

   61 source "kernel/trace/rv/monitors/sleep/Kconfig"
   62 # Add new rtapp monitors here
   63 
+  64 
+  65 source "kernel/trace/rv/monitors/hello/Kconfig"
+  66 # Add new hello monitors here
+  67 
   68 # Add new monitors here
   69 
   70 config RV_REACTORS

> +        result = super().fill_kconfig_tooltip()
> +        if self.auto_patch:
> +            self._patch_file("Kconfig",
> +                            "# Add new monitors here", container_marker)
> +            return result
> +        return result + container_marker
> diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
> index 19d0078a38032..ac97c4505ff00 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -137,7 +137,8 @@ class RVGenerator:
>          kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
>          return kconfig
>  
> -    def __patch_file(self, file, marker, line):
> +    def _patch_file(self, file, marker, line):
> +        assert(self.auto_patch)
>          file_to_patch = os.path.join(self.rv_dir, file)
>          content = self._read_file(file_to_patch)
>          content = content.replace(marker, line + "\n" + marker)
> @@ -146,7 +147,7 @@ class RVGenerator:
>      def fill_tracepoint_tooltip(self):
>          monitor_class_type = self.fill_monitor_class_type()
>          if self.auto_patch:
> -            self.__patch_file("rv_trace.h",
> +            self._patch_file("rv_trace.h",
>                              "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
>                              "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
>              return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
> @@ -158,8 +159,10 @@ Add this line where other tracepoints are included and %s is defined:
>  
>      def fill_kconfig_tooltip(self):
>          if self.auto_patch:
> -            self.__patch_file("Kconfig",
> -                            "# Add new monitors here",
> +            # monitors with a container should stay together in the Kconfig
> +            self._patch_file("Kconfig",
> +                            "# Add new %smonitors here" %
> +                              (self.parent + " " if self.parent else ""),

This one must be kept in sync with container_marker in
Container.fill_kconfig_tooltip(). I think this is hard to maintain later
on.

How about we keep in centralized with a helper function, something like:

def container_marker(container: str) -> str:
    return f"# Add new {container} monitors here\n"

Nam
