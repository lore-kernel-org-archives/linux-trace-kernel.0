Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737922D9493;
	Fri, 18 Jul 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838464; cv=none; b=tUO2EqehFwCCHsHhxOBmTmE3kYaj7XUKf78RpM4GCCNHML/W3Fud9riAD4uMTOoSz89BUvlJwThnuzZylZqss146bUq8umZ3XtCjE10KI0dWbFCfRc64iAXsOFobD2kU/q+z+HT0IVN60DHP4cLcWv+5lA3RUj8KMnLpol0QEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838464; c=relaxed/simple;
	bh=oBnvY0GESgkHTGe+X4QPvvoGt0YxYYQo5O6GaTuTlJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag29atv5vtp19HJiRnjoEM68HCD65RaJXlwKIB2MGFBvxn95BNkhUF3A7lwSuT/k0jhMNeIxRwRbZ/IHRYVTjb4RLDi+x6LrE9ahNEnsZD5puF+eabojxyzLTTqSUds3bxeIjLcu9nkexeuByTgqH+vJ3cgIMBxiQosVbgC4tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF5ZnXyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF5ZnXyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96311C4CEEB;
	Fri, 18 Jul 2025 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838464;
	bh=oBnvY0GESgkHTGe+X4QPvvoGt0YxYYQo5O6GaTuTlJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF5ZnXyXp3tp5H441Eb9ghSCM0SK0qhXl5ZnF4+1VThgX4n1Ose5Ixf59mSing2Cz
	 bkjZc412LuhIYx5AhZFZ8ush4Ag8MalkFy8PCQq8nJSzZ7zby2SHUj5hDilEp7hBSo
	 WbcpzuqJJchhVXlxS1b2rT5c6RhGYNHo3N6C1WQafFpJ1YIc8BzKVuMl/bgWbSrXDp
	 krCo7qFIcOrkHWsY7yI6Gj8P4PFn2LoJU/CZRYvT+FhFCfzNjurn7BuLy6k6tI4yza
	 1kZr9kKpHVljzug9qWst6+mpp1PF55FMzyDDF+nQhPtiZ2p0wkZtDXRikHeGvt1ze+
	 Fyr76yso9cfSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/5] tracing: fprobe-event: Allocate string buffers from heap
Date: Fri, 18 Jul 2025 20:34:19 +0900
Message-ID: <175283845881.343578.10010946807218897188.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175283843771.343578.8524137568048302760.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
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
---
 kernel/trace/trace_fprobe.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 264cf7fc9a1d..fd1036e27309 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1234,18 +1234,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
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
@@ -1273,6 +1273,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(0);
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			return -ENOMEM;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
@@ -1280,15 +1283,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
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
@@ -1304,13 +1310,20 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
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

