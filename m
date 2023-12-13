Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84826AC7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVHXWomn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B862C433C8;
	Wed, 13 Dec 2023 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702478675;
	bh=ScXFnHPrze8ODr/xbGNGVp/Vqi3ITeCzD4ijg53p57A=;
	h=From:To:Cc:Subject:Date:From;
	b=fVHXWomnuIObu5UCEj2AcN68mEiE5qSkTczJucIZ8tWkIJLBFkWme0DBwjqlTEY9v
	 PnSMoV07SPwT/DJYzYhif5O2VzEWuyA95K9Nv9vonAVrGhSefPTLKxOjoOVKp09yh/
	 C/qywDaeGa8pa40h4E5O6dA9AOAbzZx6ia6hx69A6Vek5tZmkiSoq6opI1yivpQuMQ
	 E2WGGs9ThuK412+jtIwWZ1KktLjGLv8uzf0TwzA8JP3DN3H3tJJrA0Cct67yPGbZbr
	 Qvb+nSysvsfaH+vQmzicwnB73dTn36RgxXrw1JZbNqzRKNzxBDOd7qMyeZEBmyhB+Z
	 YeJwE7ezwz6fg==
From: Naveen N Rao <naveen@kernel.org>
To: <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH v3] trace/kprobe: Display the actual notrace function when rejecting a probe
Date: Wed, 13 Dec 2023 20:09:14 +0530
Message-ID: <20231213143914.1591175-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to probe update_sd_lb_stats() using perf results in the below
message in the kernel log:
  trace_kprobe: Could not probe notrace function _text

This is because 'perf probe' specifies the kprobe location as an offset
from '_text':
  $ sudo perf probe -D update_sd_lb_stats
  p:probe/update_sd_lb_stats _text+1830728

However, the error message is misleading and doesn't help convey the
actual notrace function that is being probed. Fix this by looking up the
actual function name that is being probed. With this fix, we now get the
below message in the kernel log:
  trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
v3: Remove tk parameter from within_notrace_func() as suggested by 
Masami

 kernel/trace/trace_kprobe.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d7a180a8427..dc36c6ed6131 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
 	return !ftrace_location_range(addr, addr + size - 1);
 }
 
-static bool within_notrace_func(struct trace_kprobe *tk)
+static bool within_notrace_func(unsigned long addr)
 {
-	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))
@@ -471,12 +470,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	return true;
 }
 #else
-#define within_notrace_func(tk)	(false)
+#define within_notrace_func(addr)	(false)
 #endif
 
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
+	unsigned long addr = trace_kprobe_address(tk);
+	char symname[KSYM_NAME_LEN];
 	int i, ret;
 
 	ret = security_locked_down(LOCKDOWN_KPROBES);
@@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
-	if (within_notrace_func(tk)) {
+	if (within_notrace_func(addr)) {
 		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
 		return -EINVAL;
 	}
 

base-commit: 4758560fa268cecfa1144f015aa9f2525d164b7e
-- 
2.43.0

