Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25553E9F82
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299941; cv=none; b=qzxeJ8HAuzPzAJ/HUaBL6zdUs6cLCT8GHfqO8PqmgPRJ4w5oKEKlNseywv6tgSJWjF2jfeI1feuuJciAzdVol2/k+q5qSUbzLbKQ8Nt8II6zG3gkZQXwCzo5m+emQbGMUh6yC37uHmBWkYh5PML2hoV1cWIQEe9g0IXGU+uaHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299941; c=relaxed/simple;
	bh=xNoM3ajeOuo+vHypFLl5eB9S7kFrp92N00jEL3zmt5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lISBGrHpeqN3Ldx0Fx1BVKTkEH3AkqYCZZOtKh8Uu0PZzUpESRvRr1kIIdaMxZNxnarrNzeGQn+DGlGQuLJDMPDHCcmssTP00yR6jrJqvT15WiPs+cp44AKEX+UvCf0UZBovkZw6hAohD2rc/oTfbau3kxAwNq9/vzPEstKVEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd5vUI8+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd5vUI8+"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c59bce68a1so56947785a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299940; x=1770904740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKmWgylkYM7IUOyI3sKx0XB35vK5p+kJUDZCEqi1vOA=;
        b=Bd5vUI8+1LA6AFMU+J0KU9pkr3fxJjmfJj12MLo97kBk2xBXNwBFq1400m7tAZBJTd
         CAGTt77O/Vrhibm4ZVl6v8xZmZQQn1wBP4wWsiDaa9/mxTreS2yv8PC4RswJr6yBVdih
         IkQl6CgzLVwwrrVsBKt6IJrfFK9xHFCrD5jOJxQxFdV6jDYSfJewH7x7klVX9+qr/WQ4
         6La9Guq8Vo473Xq4ITa5wUPmuEfbRKrFqtd4z3PFfbrGiSWTBdVH0lqWOU3QCBOjXZM9
         0nckVDkKYYtXwllPIO9zfRJ79XAn+sAjs5GwirWsaYTpfSFe5+ZKQovmzIhSH8mGlJVe
         H+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299940; x=1770904740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKmWgylkYM7IUOyI3sKx0XB35vK5p+kJUDZCEqi1vOA=;
        b=VKK7J9K077haA7E4/CwT8CMFUgLuOfiuCGgzPflSevokiZLUeRKO0sy6br4wV0NNBk
         5ri9MtzA9GFBONaNxZQOlv3Hdu10+D3hBLN8Hu358x83I+R+jXtLNHDI85ISA23k/UVJ
         k7/G6uzCPD04921HbP999MfJ2uOHalf+NF9kRZ/CpRsSNzazfEnft6MwwNxL0+rLjRkz
         tlgN5AFt93qRPcbPzoreJRzj2wPTdfP5v67dUmOrafREdidycn3HCQoed2/VdVK08d3J
         6VbWRdEmoPpQ8+ZgB+hhKTTDrMlPA0G2iYG99wW3k36cb8cH/uAutY7tha9hf86TtC+L
         E4rg==
X-Forwarded-Encrypted: i=1; AJvYcCWwWq1MBIheLIaGtmu8no/We99p9+HGRQbxwBxVRXFekrC6Ah7345kwOSJ0xryN2SDgQ+5HVqFOQva2T1uMsiLvfpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaD+dLC4RW/1B4pe/tDGBI+5HBugnQWIaoaAv0t0zXJMsc9lfH
	uorNEDsIScmyCJLuHK73A7wzVtJ5wRs1jcKUcnPMbQ1BEr3k0lV02ei8
X-Gm-Gg: AZuq6aLqM3IXlXLBWwztyl3nyRrBM3Sy28l6AQCQMqHJG57aOZEz4WkJiII9cUIiPUi
	9BONxYk1TR4mqClXLFlD6VinTL8f1IXXsymW62wn/GvFrW+4cfJXH3kifiYq2k6b5tWJp0Bt6BP
	qIDyVjOnJVc0+ZCCuLT1E6LAcVtV31s1csEyDmXgJVSim8v/j41BsHJJqFI0dNBo/UcM+XSlWlo
	YNTSdEyMwye9iIDl4o0XH2+QG0RFkBCB1TMQBCp5qZupVWsw2cwyORCa0mYJuUEF0LhQSqBYmEk
	9WNIKrLoXdXx4Svm0qbcsQgKWA0mI2QRh9SInwk9Aott0CgSOUnfVdt+EFwhIaqFlo6u369pV8N
	U4BuVo2Fqj8ZizoPvqB9k97wQXd8KevyOSctFgp4wNezbjsF7CJ6r/5C5F5x+XF6zM1qc3hlAIN
	+hpmCJr0tI/KZxZzFivvpA6FMs38yQzEVORalqlK0fS1NwVVBeje/tbH/lXh80Z6305y/V5vc=
X-Received: by 2002:a05:620a:4720:b0:8ca:2cf9:81a3 with SMTP id af79cd13be357-8ca2f868aa7mr799096385a.40.1770299939812;
        Thu, 05 Feb 2026 05:58:59 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:87a6:ecbb:44f:b3c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm404975985a.41.2026.02.05.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:58:59 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	corbet@lwn.net,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v6 1/4] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Thu,  5 Feb 2026 08:58:39 -0500
Message-ID: <20260205135842.20517-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the fprobe event interface to support:
  - Comma-separated symbol lists: "func1,func2,func3"
  - Exclusion prefix: "func1,!func2,func3"
  - Explicit :entry and :exit suffixes (replacing %return for lists)

Single-symbol probes retain backward compatibility with %return.

The list parsing is factored into a dedicated parse_fprobe_list()
helper that splits comma-separated input into filter (included) and
nofilter (excluded) strings.  Tracepoint validation now reports the
error position via trace_probe_log_err() so users can see what went
wrong in tracefs/error_log.

Changes since v5:
  - Fix missing closing brace in the empty-token check that caused a
    build error.
  - Remove redundant strchr/strstr checks for tracepoint validation
    (the character validation loop already rejects ',', ':', and '%').
  - Add trace_probe_log_err() to the tracepoint character validation
    loop per reviewer feedback.
  - Remove unnecessary braces around single-statement if per kernel
    coding style.
  - Extract list parsing into parse_fprobe_list() per reviewer feedback
    to keep parse_fprobe_spec() focused.

Update tracefs/README to reflect the new syntax.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c        |   3 +-
 kernel/trace/trace_fprobe.c | 219 ++++++++++++++++++++++++++++--------
 2 files changed, 174 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..649a6e6021b4 100644
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
index 262c0556e4af..f8846cd1d020 100644
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
 
@@ -1154,60 +1164,131 @@ static struct notifier_block tprobe_event_module_nb = {
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
+static int parse_fprobe_list(char *b, char **filter, char **nofilter)
+{
+	char *f __free(kfree) = NULL;
+	char *nf __free(kfree) = NULL;
+	char *tmp = b, *tok;
+	size_t sz;
 
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
+	sz = strlen(b) + 1;
+
+	f = kzalloc(sz, GFP_KERNEL);
+	nf = kzalloc(sz, GFP_KERNEL);
+	if (!f || !nf)
 		return -ENOMEM;
 
-	if (*is_return)
-		return 0;
+	while ((tok = strsep(&tmp, ",")) != NULL) {
+		char *dst;
+		bool neg = (*tok == '!');
 
-	if (is_tracepoint) {
-		tmp = *symbol;
-		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
-			tmp++;
-		if (*tmp) {
-			/* find a wrong character. */
-			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
-			kfree(*symbol);
-			*symbol = NULL;
+		if (*tok == '\0') {
+			trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
 			return -EINVAL;
 		}
+
+		if (neg)
+			tok++;
+		dst = neg ? nf : f;
+		if (dst[0] != '\0')
+			strcat(dst, ",");
+		strcat(dst, tok);
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
+	*filter = no_free_ptr(f);
+	*nofilter = no_free_ptr(nf);
+
+	return 0;
+}
+
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
+
+	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
+		return -EINVAL;
+
+	*base = NULL; *filter = NULL; *nofilter = NULL;
+	*is_return = false; *list_mode = false;
+
+	if (is_tracepoint) {
+		for (p = in; *p; p++)
+			if (!isalnum(*p) && *p != '_') {
+				trace_probe_log_err(p - in, BAD_TP_NAME);
+				return -EINVAL;
+			}
+		b = kstrdup(in, GFP_KERNEL);
+		if (!b)
+			return -ENOMEM;
+		*base = no_free_ptr(b);
+		return 0;
+	}
+
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
+	if (list && legacy_ret)
+		return -EINVAL;
+
+	if (legacy_ret)
+		*is_return = true;
+
+	b = kstrdup(work, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	if (list) {
+		ret = parse_fprobe_list(b, &f, &nf);
+		if (ret)
+			return ret;
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
@@ -1241,6 +1322,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	struct module *mod __free(module_put) = NULL;
 	const char **new_argv __free(kfree) = NULL;
+	char *parsed_nofilter __free(kfree) = NULL;
+	char *parsed_filter __free(kfree) = NULL;
 	char *symbol __free(kfree) = NULL;
 	char *ebuf __free(kfree) = NULL;
 	char *gbuf __free(kfree) = NULL;
@@ -1249,6 +1332,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	char *dbuf __free(kfree) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_tracepoint = false;
+	bool list_mode = false;
 	bool is_return = false;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
@@ -1270,11 +1354,26 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
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
@@ -1287,6 +1386,15 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
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
@@ -1322,7 +1430,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 							NULL, NULL, NULL, sbuf);
 		}
 	}
-	if (!ctx->funcname)
+
+	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
 		ctx->funcname = symbol;
 
 	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
@@ -1356,6 +1465,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
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
@@ -1442,8 +1566,9 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
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

