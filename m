Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D804134AC;
	Thu, 13 Mar 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827616; cv=none; b=HgGQ27CQO3V5CE9Nvp2KOdQMVxaGNcXlxFa/lZTMa+R+NsZlOTXxlfGUSFxbUByDJlMViZJp4/O+Ws9joZwqWSTwedxsv5LS+IgTU6nmYb8V4LZ0a3nWqHzW6rB0+aS+6KjOmgO+A+nhHPG91AvFqvUi1NbwRs2CI/zEQFJw/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827616; c=relaxed/simple;
	bh=7xUY1S6zXxsXXT8asLU92YS/TfvLV/gFRXP7obNkQWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGBpprCBQd6asSN7dnTgPcw/blf3GoQ2Efq+XM1gguVYBcgRZzu/HRMoU7tg5fNmqkazyFiUmThG9iHhDdoW1gw/5LGSdl3iN5V1aDDuuui7z8J0pEtapJXL4lyuzjlkkjD1hVu7L8/7xgT66qRjyWCJVCfRTpDIziNt3dhMLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZE6MNvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZE6MNvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1C0C4CEDD;
	Thu, 13 Mar 2025 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741827614;
	bh=7xUY1S6zXxsXXT8asLU92YS/TfvLV/gFRXP7obNkQWM=;
	h=From:To:Cc:Subject:Date:From;
	b=sZE6MNvXD8vRI3+AKi4f6VMLXNyuG4M2XRMz93jmTIlfeI2FzUhnDXdLZGmGjJte+
	 ysFbVDq08W4vEoEF9OZfNvxkin/VWmmhP5FpqdhSLDsXbIDWpGJ68EcAK0OMZdNDcX
	 DiBX3vUH+jZRUbgMGNtzDW3qK4UpzEfBdELtUmRJ8yH707evO5ozPWcnGgWtbGIIJ9
	 aTAaVmCnv/iIF6AyMFOELVJRoQbva4rlNpDBWcgY65apXhJ2KfON/ULC14zD2vRb4b
	 JYNnR3bvkKoAPPYRzQi2/Id8IS4h8kn6TRPpkio3knxzrPyDRJWuLVTo7ZtRZkd9C0
	 9CAMmxG33aSLg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: tprobe-events: Fix leakage of module refcount
Date: Thu, 13 Mar 2025 10:00:10 +0900
Message-ID: <174182761071.83274.18334217580449925882.stgit@devnote2>
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

When enabling the tracepoint at loading module, the target module
refcount is incremented by find_tracepoint_in_module(). But it is
unnecessary because the module is not unloaded while processing
module loading callbacks.
Moreover, the refcount is not decremented in that function.
To be clear the module refcount handling, move the try_module_get()
callsite to trace_fprobe_create_internal(), where it is actually
required.

Fixes: 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on future loaded modules")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_fprobe.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 88a80953ae5e..985ff98272da 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -920,13 +920,8 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
 		data->tpoint = tp;
-		if (!data->mod) {
+		if (!data->mod)
 			data->mod = mod;
-			if (!try_module_get(data->mod)) {
-				data->tpoint = NULL;
-				data->mod = NULL;
-			}
-		}
 	}
 }
 
@@ -938,13 +933,7 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-/*
- * Find a tracepoint from kernel and module. If the tracepoint is in a module,
- * this increments the module refcount to prevent unloading until the
- * trace_fprobe is registered to the list. After registering the trace_fprobe
- * on the trace_fprobe list, the module refcount is decremented because
- * tracepoint_probe_module_cb will handle it.
- */
+/* Find a tracepoint from kernel and module. */
 static struct tracepoint *find_tracepoint(const char *tp_name,
 					  struct module **tp_mod)
 {
@@ -973,6 +962,7 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
+/* Find a tracepoint from specified module. */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
 {
@@ -1179,6 +1169,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (is_tracepoint) {
 		ctx->flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
+		/* lock module until register this tprobe. */
+		if (tp_mod && !try_module_get(tp_mod)) {
+			tpoint = NULL;
+			tp_mod = NULL;
+		}
 		if (tpoint) {
 			ctx->funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,

