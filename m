Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85511D6195
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699110; cv=none; b=ljJDAKEcESvwYu6G/RhYBofFhJ7Yz2ftmM1/5JE28hKuHCk52/uRouwWmrytoWxTPUMYoZMcOBAXLU+msvIN9b9xth9BrxKCLVUmUf226JEBR8XuPHi7fI1oyMAjWy60jxBMfmpkRNhwLlBbdQlQt2d/SdbWoNC1QvKGqxr1krM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699110; c=relaxed/simple;
	bh=BCBYGa3TPryM/GRbyXK+YdnO4CpcUQ+fZVY68WD+2I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihw/jnyuqCPEhCdjOKgbUI4/uQCir0vMEsyJJ20OK54HDQdghF3bA5pO6WCX5VCuJw68kGCaJqfl85UNaiISYgwEAENfztjffJc7Q3g/Qiq3N+kuIA2m/kaL6ipqw30guCZVkKixs1K+Nvuan0C7aklFCeTF5RYYndc7jmlqYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpsbUpj3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpsbUpj3"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a234f094so322160285a.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Jan 2026 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699106; x=1769303906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeU9WtZvrzGKMp4I/N6B6Rs+f85g1m5C1V/fZOteYUE=;
        b=ZpsbUpj3OhY8pF7FzbOD/PjlE+GjEpgnXNW9jW856MD/lHuDJbIc9b6vVNgGgYfjt4
         WVM2JwLPhyU5lhGSBogVY0Hw5Wq/uEmaFmDp1OMCv7hsQ87gme2txVXcesN4ZGPBbHrp
         hplN7qL4hp8bnDnAtt63NUxp8JdSTFaqP9eJsL8cCR7iMHj/4sKmdYBMPm+dezjsjRUZ
         SOYuu4o7BVaNH8MYI+KW9WsZDnSm/aPdT9wDgCqL/fDdEvXfVpBlodhQ7YOdjqSRGeai
         5wF22NEr+bkkfBR0WbX65iJCAjkm+Q/1UN5w8oCKRIAJxRGK1RNDHIjvOuMFoLd5fhfW
         pGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699106; x=1769303906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeU9WtZvrzGKMp4I/N6B6Rs+f85g1m5C1V/fZOteYUE=;
        b=jQQTc4fT+bHCmo/GT7WTT6M8HIZuV2kk60mVqAiU0mlmWJgjkJROy6F1OScVIsU1g6
         3eXmUyvrTsfXzUUMnj/qlNZzh5F1OG+ekHVCV+xLQO/LyUFDL/uax5lCFQ3v6satKjZo
         duHzlm/UQRehRzaOaC+roXv1NSn4feMlVJVvsN0d2+IiL/FAIvR0PU+6OqRcFXielFXm
         mPVTnv2mA4RsAuwOgSwbgxV4FVmiYktdsP9QUeyuPNlflsVgxWG2OSPQIkbbIDpjdkTP
         5WO17XRkr0nyGWixzA4kMo4n//JB112Rx4mN8U6Cpa+M4LGuJd7yuTiW557rqLeni+ZM
         xYYw==
X-Forwarded-Encrypted: i=1; AJvYcCUmiNpqk7k++fg79GZtLrNU20S/sBALKtpFMoJRN8CHirl1uFTH03rY5Pl5aBYviuEFyvORZpwItdNrlaRoxFzNqQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPtEgNtgRvHwCb0U3m6E7XDj8x3Pv1ls6Kv4Pe07YZkb8u3r6
	5qm//97EH+E1+Jc89tRlj2Rg8ZYrY0SBDY441PaamKBiM0/Y2rM4x6lH
X-Gm-Gg: AY/fxX61tzMrTZdei0jg4Zj5Ye6W7YlH+1bD5KmjNfGiwvCfyRl4POo8wLYsqYmlXPo
	8Rf5g/l4IsnDIN8k+XQIqLW31YcYpjt5s7GS6p7AoWlbswkMTrcFr3BrxP21a8eG7SCSLvRRaIK
	iHQ5mySGIwjCSV3K2okd+IU1wlzd7DR4lfvuZ7b/KIEz6fzIK0wLBW75yz9Wj+9xNQniNK28P4T
	cN8ooL7EsOC4BvYD7eOjvntgB7O/hmAARAIx9SQfXiC+m/gznAzVaPoqMR/IGx1c6ikonlW/4Ul
	E4WYA3eMc3Z/jnrzeGDhNXCqA7JlgMWT9RKuH+2PwXIdujS7a8xcImR16bllLzz0pAaHiSpamrU
	kHt07cNPU/ZNFzuX+Bwof1g6qobcxK6MsIq+Hc/NrlGEA/tujkcm3sW7KfkCpPvzpTQ+TQHZvPo
	mymp4Saua5vZUtfw5sP/jXf+CMiX1l+r+76UjOzUU9LG2zr4nWtlzGq6V1xO05
X-Received: by 2002:a05:620a:46a5:b0:8b2:62f9:9fd8 with SMTP id af79cd13be357-8c6a678058emr1062620285a.61.1768699105669;
        Sat, 17 Jan 2026 17:18:25 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:25 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 v5 2/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Sat, 17 Jan 2026 20:18:14 -0500
Message-ID: <20260118011815.56516-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Update DEFINE_FREE to use standard __free()
- Extend fprobe to support multiple symbols per event. Add parsing logic for
  lists, ! exclusions, and explicit suffixes. Update tracefs/README to reflect
  the new syntax

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c        |   3 +-
 kernel/trace/trace_fprobe.c | 209 +++++++++++++++++++++++++++---------
 2 files changed, 163 insertions(+), 49 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index baec63134ab6..10cdcc7b194e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5578,7 +5578,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
+	"\t		(single symbols still accept %return)\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 262c0556e4af..5a2a41eea603 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -187,11 +187,14 @@ DEFINE_FREE(tuser_put, struct tracepoint_user *,
  */
 struct trace_fprobe {
 	struct dyn_event	devent;
+	char			*filter;
 	struct fprobe		fp;
+	bool			list_mode;
+	char			*nofilter;
 	const char		*symbol;
+	struct trace_probe	tp;
 	bool			tprobe;
 	struct tracepoint_user	*tuser;
-	struct trace_probe	tp;
 };
 
 static bool is_trace_fprobe(struct dyn_event *ev)
@@ -559,6 +562,8 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 		trace_probe_cleanup(&tf->tp);
 		if (tf->tuser)
 			tracepoint_user_put(tf->tuser);
+		kfree(tf->filter);
+		kfree(tf->nofilter);
 		kfree(tf->symbol);
 		kfree(tf);
 	}
@@ -838,7 +843,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_tracepoint(tf))
 		return __regsiter_tracepoint_fprobe(tf);
 
-	/* TODO: handle filter, nofilter or symbol list */
+	/* Registration path:
+	 * - list_mode: pass filter/nofilter
+	 * - single: pass symbol only (legacy)
+	 */
+	if (tf->list_mode)
+		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
 }
 
@@ -1154,60 +1164,119 @@ static struct notifier_block tprobe_event_module_nb = {
 };
 #endif /* CONFIG_MODULES */
 
-static int parse_symbol_and_return(int argc, const char *argv[],
-				   char **symbol, bool *is_return,
-				   bool is_tracepoint)
+static bool has_wildcard(const char *s)
 {
-	char *tmp = strchr(argv[1], '%');
-	int i;
+	return s && (strchr(s, '*') || strchr(s, '?'));
+}
 
-	if (tmp) {
-		int len = tmp - argv[1];
+static int parse_fprobe_spec(const char *in, bool is_tracepoint,
+		char **base, bool *is_return, bool *list_mode,
+		char **filter, char **nofilter)
+{
+	char *work __free(kfree) = NULL;
+	char *b __free(kfree) = NULL;
+	char *f __free(kfree) = NULL;
+	char *nf __free(kfree) = NULL;
+	bool legacy_ret = false;
+	bool list = false;
+	const char *p;
+	int ret = 0;
 
-		if (!is_tracepoint && !strcmp(tmp, "%return")) {
-			*is_return = true;
-		} else {
-			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
-			return -EINVAL;
-		}
-		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
-	} else
-		*symbol = kstrdup(argv[1], GFP_KERNEL);
-	if (!*symbol)
-		return -ENOMEM;
+	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
+		return -EINVAL;
 
-	if (*is_return)
-		return 0;
+	*base = NULL; *filter = NULL; *nofilter = NULL;
+	*is_return = false; *list_mode = false;
 
 	if (is_tracepoint) {
-		tmp = *symbol;
-		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
-			tmp++;
-		if (*tmp) {
-			/* find a wrong character. */
-			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
-			kfree(*symbol);
-			*symbol = NULL;
+		if (strchr(in, ',') || strchr(in, ':'))
 			return -EINVAL;
-		}
+		if (strstr(in, "%return"))
+			return -EINVAL;
+		for (p = in; *p; p++)
+			if (!isalnum(*p) && *p != '_')
+				return -EINVAL;
+		b = kstrdup(in, GFP_KERNEL);
+		if (!b)
+			return -ENOMEM;
+		*base = no_free_ptr(b);
+		return 0;
 	}
 
-	/* If there is $retval, this should be a return fprobe. */
-	for (i = 2; i < argc; i++) {
-		tmp = strstr(argv[i], "$retval");
-		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
-			if (is_tracepoint) {
-				trace_probe_log_set_index(i);
-				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
-				kfree(*symbol);
-				*symbol = NULL;
+	work = kstrdup(in, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	p = strstr(work, "%return");
+	if (p && p[7] == '\0') {
+		*is_return = true;
+		legacy_ret = true;
+		*(char *)p = '\0';
+	} else {
+		/*
+		 * If "symbol:entry" or "symbol:exit" is given, it is new
+		 * style probe.
+		 */
+		p = strrchr(work, ':');
+		if (p) {
+			if (!strcmp(p, ":exit")) {
+				*is_return = true;
+				*(char *)p = '\0';
+			} else if (!strcmp(p, ":entry")) {
+				*(char *)p = '\0';
+			} else {
 				return -EINVAL;
 			}
-			*is_return = true;
-			break;
 		}
 	}
-	return 0;
+
+	list = !!strchr(work, ',');
+	
+	if (list && legacy_ret) {
+		return -EINVAL;
+	}
+
+	if (legacy_ret)
+		*is_return = true;
+
+	b = kstrdup(work, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	if (list) {
+		char *tmp = b, *tok;
+		size_t fsz, nfsz;
+
+		fsz = nfsz = strlen(b) + 1;
+
+		f = kzalloc(fsz, GFP_KERNEL);
+		nf = kzalloc(nfsz, GFP_KERNEL);
+		if (!f || !nf)
+			return -ENOMEM;
+
+		while ((tok = strsep(&tmp, ",")) != NULL) {
+			char *dst;
+			bool neg = (*tok == '!');
+
+			if (*tok == '\0') {
+				trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
+				return -EINVAL;
+
+			if (neg)
+				tok++;
+			dst = neg ? nf : f;
+			if (dst[0] != '\0')
+				strcat(dst, ",");
+			strcat(dst, tok);
+		}
+		*list_mode = true;
+	}
+
+	*base = no_free_ptr(b);
+	*filter = no_free_ptr(f);
+	*nofilter = no_free_ptr(nf);
+
+	return ret;
 }
 
 static int trace_fprobe_create_internal(int argc, const char *argv[],
@@ -1241,6 +1310,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	struct module *mod __free(module_put) = NULL;
 	const char **new_argv __free(kfree) = NULL;
+	char *parsed_nofilter __free(kfree) = NULL;
+	char *parsed_filter __free(kfree) = NULL;
 	char *symbol __free(kfree) = NULL;
 	char *ebuf __free(kfree) = NULL;
 	char *gbuf __free(kfree) = NULL;
@@ -1249,6 +1320,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	char *dbuf __free(kfree) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_tracepoint = false;
+	bool list_mode = false;
 	bool is_return = false;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
@@ -1270,11 +1342,26 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(1);
 
-	/* a symbol(or tracepoint) must be specified */
-	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
+	/* Parse spec early (single vs list, suffix, base symbol) */
+	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
+			&list_mode, &parsed_filter, &parsed_nofilter);
 	if (ret < 0)
 		return -EINVAL;
 
+	for (i = 2; i < argc; i++) {
+		char *tmp = strstr(argv[i], "$retval");
+
+		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
+			if (is_tracepoint) {
+				trace_probe_log_set_index(i);
+				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				return -EINVAL;
+			}
+			is_return = true;
+			break;
+		}
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
@@ -1287,6 +1374,15 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	}
 
 	if (!event) {
+		/*
+		 * Event name rules:
+		 * - For list/wildcard: require explicit [GROUP/]EVENT
+		 * - For single literal: autogenerate symbol__entry/symbol__exit
+		 */
+		if (list_mode || has_wildcard(symbol)) {
+			trace_probe_log_err(0, NO_GROUP_NAME);
+			return -EINVAL;
+		}
 		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!ebuf)
 			return -ENOMEM;
@@ -1322,7 +1418,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 							NULL, NULL, NULL, sbuf);
 		}
 	}
-	if (!ctx->funcname)
+
+	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
 		ctx->funcname = symbol;
 
 	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
@@ -1356,6 +1453,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 	}
 
+	/* carry list parsing result into tf */
+	if (!is_tracepoint) {
+		tf->list_mode = list_mode;
+		if (parsed_filter) {
+			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
+			if (!tf->filter)
+				return -ENOMEM;
+		}
+		if (parsed_nofilter) {
+			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
+			if (!tf->nofilter)
+				return -ENOMEM;
+		}
+	}
+
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1442,8 +1554,9 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 
-	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
-			       trace_fprobe_is_return(tf) ? "%return" : "");
+	seq_printf(m, " %s", trace_fprobe_symbol(tf));
+	if (!trace_fprobe_is_tracepoint(tf) && trace_fprobe_is_return(tf))
+		seq_puts(m, ":exit");
 
 	for (i = 0; i < tf->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
-- 
2.43.0

