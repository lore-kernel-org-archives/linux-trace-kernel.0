Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E63C1989;
	Tue,  3 Feb 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137151; cv=none; b=fmUJ+Y0ZfdhU8o4NuAbNShEevNmxN1pSObU5XdHACFptZ7Wym8E1L6KG9nz8HXL5KrGOUDYtrPJvH1vJSosDceuQA30zRUh73uvZE3HN1VDPyBoJYN8yv+lpw9g/FYfSv5Pfo1l8jOZqwmdSYMzlrHecyOYtGhhEaWQuu8zAX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137151; c=relaxed/simple;
	bh=fSPz7pfxe0WSRxi0fghUscs+kv3KaRdW++TVr5fYAkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Euhtl67scUd4Zt9tmGR+5wslW0VjaHvlmakgNWl0PKRBgxjvJbMYz1sFIGITlMykiK4LfW45EHIbpHBmQibuqRW8UpZcwp33pbLLKYMXR8Z0uyK00QwaVni7m6ONk0ovQ+EQdmctLvyzReenxb2DLS5Pitkxgy/LVMS+imBcIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHhezDG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHhezDG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4116FC116D0;
	Tue,  3 Feb 2026 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137151;
	bh=fSPz7pfxe0WSRxi0fghUscs+kv3KaRdW++TVr5fYAkA=;
	h=From:To:Cc:Subject:Date:From;
	b=YHhezDG969f5C47Is6tLbpTACKaVwhYNQ4vBHX8XQW9rPWEuRAVffaV7AwdzhtZdd
	 cfCcMg1Z8/Z1BcrhDc5m4AwRGPn+0ib0ldMtAG/VwlUA81M+vr8kcVqoSHC9Z+ESq/
	 iNAZosm87IFTL0pVxyLe/+hcEAGDW4u2xbRXR+/2Gf+ovQIQXFc4xurnIEbA/nBR2G
	 dGiMlL1cNPwhdTE71R0Sg4/Gk2kzyzPcznPPmZLvuS0lw/hrzd6PaM/eqA73iJ+mDD
	 sGQwZkY8HQAZrYFiXgX4E2v/miUOzh2zbLhUoYz7Ttfiz2PKNsSpxRrLJPv8cp3BgB
	 sPSqf1f73BE8A==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Simon Horman <horms@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yury Norov <ynorov@nvidia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] [v2] tracing: move __printf() attribute on __ftrace_vbprintk()
Date: Tue,  3 Feb 2026 17:45:29 +0100
Message-Id: <20260203164545.3174910-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sunrpc change to use trace_printk() for debugging caused
a new warning for every instance of dprintk() in some configurations,
when -Wformat-security is enabled:

fs/nfs/getroot.c: In function 'nfs_get_root':
fs/nfs/getroot.c:90:17: error: format not a string literal and no format arguments [-Werror=format-security]
   90 |                 nfs_errorf(fc, "NFS: Couldn't getattr on root");

I've been slowly chipping away at those warnings over time with the
intention of enabling them by default in the future. While I could not
figure out why this only happens for this one instance, I see that the
__trace_bprintk() function is always called with a local variable as
the format string, rather than a literal.

Move the __printf(2,3) annotation on this function from the declaration
to the caller. As this is can only be validated for literals, the
attribute on the declaration causes the warnings every time, but
removing it entirely introduces a new warning on the __ftrace_vbprintk()
definition.

The format strings still get checked because the underlying literal keeps
getting passed into __trace_printk() in the "else" branch, which is not
taken but still evaluated for compile-time warnings.

Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: included fix for regression reported by kernel test robot <lkp@intel.com>
---
 include/linux/trace_printk.h | 1 -
 kernel/trace/trace_printk.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index bb5874097f24..2670ec7f4262 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -107,7 +107,6 @@ do {									\
 		__trace_printk(_THIS_IP_, fmt, ##args);			\
 } while (0)
 
-extern __printf(2, 3)
 int __trace_bprintk(unsigned long ip, const char *fmt, ...);
 
 extern __printf(2, 3)
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..48c085fcae7a 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -197,6 +197,7 @@ struct notifier_block module_trace_bprintk_format_nb = {
 	.notifier_call = module_trace_bprintk_format_notify,
 };
 
+__printf(2, 3)
 int __trace_bprintk(unsigned long ip, const char *fmt, ...)
 {
 	int ret;
-- 
2.39.5

