Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCA2820B9;
	Tue, 22 Jul 2025 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221720; cv=none; b=SiZNdBFkrWxDdHlKymiAB67zD5pGuDePzExlfGJzyUezTmE885xNPmjp8h+L4EAUZyvsskFRogmXMbpp/YkO2i2yT4ox46Yhv4Z+lJXSpEJI9DVkf0tCzzBflbewvhn4E6mxhBQeaxvNatw1St5wPxUUDE/0eRnOgBZoGv/5hyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221720; c=relaxed/simple;
	bh=PZmuufTGGGjiYbuJdT+PeG1AGZmHgds/7leKlUMWos0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htNEmbjwphrL9MMVYo2hBjLbnH2veUlxb9tjvZnGMhLa3ioYio8+Nck23PvdKlhssKsxJfpW+brv1yKb11kQWEgXIwFyPgFNTiQS0t7tAJxG2OPS6xcDZZ1izW6TfMjDxLFyK3MpEOSGW8KMheVdgBNxPGpawNbAjtbq8p0BK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWWosBli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWWosBli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B338FC4CEEB;
	Tue, 22 Jul 2025 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221720;
	bh=PZmuufTGGGjiYbuJdT+PeG1AGZmHgds/7leKlUMWos0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWWosBli1Yyg5likZVVoX3up0dDiB4iInxtsH84XraZ1PLa8c/c3+RhuybSUixHud
	 jTNBEz4OeTayqnHD3HsIUNopPTSqA9oY5o+tJuul8nShSeCMD04tJ1p7tkHRoYy6ZM
	 PvQ5wJAtiGYnpDFBMqp7S65KS+BJYkJz5yq80uSpi39C8p8jrDnHAya9NroNeoBe+1
	 +yQ+CB37EwLFwbtRdg0eMcyYzpLjcjyAZ1xtYS4SDHxDx7kaBLUTBrDgh032OR//SC
	 OLNaudGXBJ6q4p3anO37rqdVPP0HEwlnkj5t81MaHxDfO5BEEugoSCKSp8exUlQYUL
	 0dAmvxAh07B6w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] tracing: fprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 07:01:55 +0900
Message-ID: <175322171522.44400.1130912986696109830.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175322168606.44400.9155291012158349647.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
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

