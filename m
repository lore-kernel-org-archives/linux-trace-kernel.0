Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE618A6A7;
	Wed, 23 Jul 2025 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234271; cv=none; b=m7urqKf3FaPeMpeC5VCs+FZFqIzR8wXq7/al7tW7q5bpz9P4x1O+F9MHjl0AiT6Jty8RKfmtm82B5mdLBGQ3D2Iy8m9iQUgHs5eLAqwP459YTGY6fU0NfBTTSFbgC3gditmQYXKXTKunSS41i6RCUYCWUcEqyRRQhK0ERDXFFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234271; c=relaxed/simple;
	bh=oCXlNSKRLrIZUtDs78uGqslRmQt0ZVedRl6AtLEJ8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx54/syKIkCpUx1fbnFl1DoJ/zKoR+v1ebDmm72YVs9FNuKnsmvOZ3QsQIKFTlHH3XNg9+IMqjPL8P4dFD7iARSVFyICgepqg1FWAxN1IZE81tgriBJ0Iqyc8n0ckIte3whdw0BOgxeKHHke/+yqQxn+Jlw1PTkDZ41xJmSgy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7YpgvmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7YpgvmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C1C4CEEB;
	Wed, 23 Jul 2025 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234270;
	bh=oCXlNSKRLrIZUtDs78uGqslRmQt0ZVedRl6AtLEJ8L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7YpgvmZJJoPddQGsFacMSUhwcOuQvHj1FNawNA4a3i579xkx2PF5hdaCqu64WBvD
	 5RoOV6GG9VYPOjyj0JWmH90MzJfPjZgEbsCyQFQsuQe7Wl+OZIFJDy1LONaiigZ5xE
	 ghwWdDGwvq7FOOEyogNfZfScKAAAxyhtbAKgLpPHRKH9Gsx0+dk39U1RfbNj8yjLcg
	 39TD9ySy5zhm75SHxFlSvTppGKYj4uc5cBu202BZrgSThVEgKZUN7Q4/0cmaMQ2vhg
	 QdWeHCKObqsHR9hHbpg0sCMPZY4WdkXj4T6bWWhV/uXRUe+/U0Fv+ARjuXBMWhVBXZ
	 UdxMsFybOKWBw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] tracing: fprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 10:31:06 +0900
Message-ID: <175323426643.57270.6657152008331160704.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175323423662.57270.14650807176845939538.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
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

Allocate temporary string buffers for fprobe-event from heap
instead of stack. This fixes the stack frame exceed limit error.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_fprobe.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 610f8d53be8a..9d14a910fbf7 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1235,18 +1235,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
-	struct module *mod __free(module_put) = NULL;
-	int i, new_argc = 0, ret = 0;
-	bool is_return = false;
-	char *symbol __free(kfree) = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
+	struct module *mod __free(module_put) = NULL;
 	const char **new_argv __free(kfree) = NULL;
-	char buf[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
-	char sbuf[KSYM_NAME_LEN];
-	char abuf[MAX_BTF_ARGS_LEN];
+	char *symbol __free(kfree) = NULL;
+	char *ebuf __free(kfree) = NULL;
+	char *gbuf __free(kfree) = NULL;
+	char *sbuf __free(kfree) = NULL;
+	char *abuf __free(kfree) = NULL;
 	char *dbuf __free(kfree) = NULL;
+	int i, new_argc = 0, ret = 0;
 	bool is_tracepoint = false;
+	bool is_return = false;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
@@ -1274,6 +1274,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(0);
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			return -ENOMEM;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
@@ -1281,15 +1284,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	}
 
 	if (!event) {
+		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!ebuf)
+			return -ENOMEM;
 		/* Make a new event name */
 		if (is_tracepoint)
-			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
+			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
 				 isdigit(*symbol) ? "_" : "", symbol);
 		else
-			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
+			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
 				 is_return ? "exit" : "entry");
-		sanitize_event_name(buf);
-		event = buf;
+		sanitize_event_name(ebuf);
+		event = ebuf;
 	}
 
 	if (is_return)
@@ -1305,13 +1311,20 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		ctx->flags |= TPARG_FL_TPOINT;
 		mod = NULL;
 		tpoint = find_tracepoint(symbol, &mod);
-		if (tpoint)
+		if (tpoint) {
+			sbuf = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
+			if (!sbuf)
+				return -ENOMEM;
 			ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
 							NULL, NULL, NULL, sbuf);
+		}
 	}
 	if (!ctx->funcname)
 		ctx->funcname = symbol;
 
+	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
+	if (!abuf)
+		return -ENOMEM;
 	argc -= 2; argv += 2;
 	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
 					       abuf, MAX_BTF_ARGS_LEN, ctx);

