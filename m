Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D803234;
	Mon, 31 Mar 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429912; cv=none; b=lVfkgiADIAsHQps3I3TV05VEVexajTc6JGRf8EVNBwa+fjR4fe30KBGBII8/uUHyR83JkRAvPkfOp41ddNJMUr9wQZxHoxfOFIDbdtD3K3hc7NJT6DwuhhpViYTRaIZHc2op3b5OzWYNXhItCKud0KhTLjFqwzwix29AGIr5R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429912; c=relaxed/simple;
	bh=XfxUmWlDoXAenKpS0CquwXTLrNbsbqfRSmcog6/7CvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JuX+3oLLoM+ojieyNMiuWC11xGlZZgE1iI00PH0IZSw+aR1Zxa6x5F2mM25Gq8WxLGSBupsgN7olvNqmkxgDKbQ6psn9M4WsukMqpG1ltnog0mV7sGzIRQrykW/GJc4vB+HhpPqvVhjECtMoT49EAccrWmHrfrcqly1N25qfd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdUZN1Dv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdUZN1Dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86171C4CEE3;
	Mon, 31 Mar 2025 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743429911;
	bh=XfxUmWlDoXAenKpS0CquwXTLrNbsbqfRSmcog6/7CvM=;
	h=From:To:Cc:Subject:Date:From;
	b=SdUZN1DvHmeu+pbYLuf62LFELRotRIeDATP+c1zVR6LjGmc7wZ0oE1PWjdPmfdRgv
	 VEg/gaPZ6208sL+BVhSTFnntkt2y3+Fwk2k8gea//xcgo+S0xfNnNxdv4cS+5aohJ7
	 Nk+qqnwQjOb9U/XWbdzfH9Ul0/i3f5IbE7UmZvCV7dEEmqHcAPKGN3e6HKWGWGYGGv
	 nUCM8I19YNmOmvs8WwmhpDIIRkI0htLhjJIDEtt5MWq6miQDDFQFWDPgbYSH64YLle
	 zH4vGmu2RSwD+Kn+DLEZVpXKIFeO0P/1TuMP7QM6FaITKgnvNcGO2RmZqlsk7N3AIC
	 R9uJTUk/QoIMA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fprobe events: Fix possible UAF on modules
Date: Mon, 31 Mar 2025 23:05:07 +0900
Message-ID: <174342990779.781946.9138388479067729366.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Commit ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module
refcount") moved try_module_get() from __find_tracepoint_module_cb()
to find_tracepoint() caller, but that introduced a possible UAF
because the module can be unloaded before try_module_get(). In this
case, the module object should be freed too. Thus, try_module_get()
does not only fail but may access to the freed object.

To avoid that, try_module_get() in __find_tracepoint_module_cb()
again.

Fixes: ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module refcount")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 985ff98272da..2cd9ff1049f1 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -919,9 +919,15 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 	struct __find_tracepoint_cb_data *data = priv;
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
-		data->tpoint = tp;
-		if (!data->mod)
+		/* If module is not specified, try getting module refcount. */
+		if (!data->mod && mod) {
+			/* If failed to get refcount, ignore this tracepoint. */
+			if (!try_module_get(mod))
+				return;
+
 			data->mod = mod;
+		}
+		data->tpoint = tp;
 	}
 }
 
@@ -933,7 +939,11 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-/* Find a tracepoint from kernel and module. */
+/*
+ * Find a tracepoint from kernel and module. If the tracepoint is on the module,
+ * the module's refcount is incremented and returned as *@tp_mod. Thus, if it is
+ * not NULL, caller must call module_put(*tp_mod) after used the tracepoint.
+ */
 static struct tracepoint *find_tracepoint(const char *tp_name,
 					  struct module **tp_mod)
 {
@@ -962,7 +972,10 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
-/* Find a tracepoint from specified module. */
+/*
+ * Find a tracepoint from specified module. In this case, this does not get the
+ * module's refcount. The caller must ensure the module is not freed.
+ */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
 {
@@ -1169,11 +1182,6 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (is_tracepoint) {
 		ctx->flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
-		/* lock module until register this tprobe. */
-		if (tp_mod && !try_module_get(tp_mod)) {
-			tpoint = NULL;
-			tp_mod = NULL;
-		}
 		if (tpoint) {
 			ctx->funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,

