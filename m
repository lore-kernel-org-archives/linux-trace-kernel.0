Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DCC257820
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621841; cv=none; b=pIQBCloXwXDOcyKwrZV198QnwJQmyi19tIZgf5peCbcHSemIfcbwT6tfW8q2Fu4gfMX+nCZYhiyErXuDoUlxZw6pn0hIO9M0OOSt7qtoUhYaKYxznuvc0QSqrC//X6PML5mqEzGyCWtmCZ+b9jUsFVyBUcQBXmtRZAu+nMgWDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621841; c=relaxed/simple;
	bh=MWAW5VhfWlORCG3RklRaoqfXc6Pl+r6/x4eDwg+XNP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW/HJpXQBsPEQt6UuvkzYL2nNUvwK+/lZ2EO+EdRU7R2WLLkkurbCQMZhSwNl6Cm4+059KMgHgZ1BL67cGsLwSKmzqO9YT6+W2K/Gtvju8p2ay8ifEWhoVHo9NTtXLUkwGXEtnYVi5hT5MXd8y742ao8qikOfTn8LLg+J4SNoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtOYVSxY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtOYVSxY"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78eba712e89so31873296d6.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621837; x=1760226637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKpSd7nKkEP6TPwK8huS4lw5ZBZ0Awry5aiCZmFREXY=;
        b=EtOYVSxYUr2vLD1TGDyUpImsjKjaYvueya6SSME6tbh6GNx3Bj2qNTe7oYT2iY2Pic
         ESbNklCrshBqAzZVvkGVlcmA34OUAlKNXOoivVzDn/PnsUmGkJIKtC+z3bN7UoTsdIwe
         gM4VUWqEPeRPUZPTI0RQqUxRqiWltTTI+uuxbAQyZGbZ2OXROt4U/zrOzGHtn0ZUTsAI
         PYtgl7TjcMDz+63X3ftjfX2y7P4nJibIihlOh2sNmL1j2YtGB+B8CmOf5/YK9Mhns6MS
         Icuh/hDWaWCneYQz21oZJMk/fYWB3VRs9ir0GvefKarQUIFKDEHH/m6IUth02rCkvoxm
         NY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621837; x=1760226637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKpSd7nKkEP6TPwK8huS4lw5ZBZ0Awry5aiCZmFREXY=;
        b=qipNcMAL9iDovKmHz+99tZ7fUEkImvnGVTX45MiVmFLWxg1MK39rd7N/+BdM1hu7iO
         gtIoSie+AhswV9kW7aKC6bkp3YiL7kBcBlXLqP70PGHxlYf8lD3gZ+w2HB1jljDHrkTF
         5fBUIZwJ7f/RgXBVCkJOk8uQgRsXzrgttsFM+81MemVQaVG+N9roX7rAqAbQ5fdBGHSs
         JfCDlXr8CgOnaKLD1H+JC7KlS1WcgikjQqlKo1gkqQzlcUwgkMMIwzjKkPaH7Edlofgf
         SxpzpwBeV6+fSy6ci4NGXuOFxVf31JSfGSKgqJ0xzycT582ewzt9Q8OH2Bw+jTxvSYYU
         qZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgU5xc044M+hoCZmlmX7VYxdZWS49dpFpEqe65YhcxZIqpD/ie1q/aJ45OKnv3ZS07bm3jnDo+fb+DhOK/Ivq0nsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEBqBbjvm2cCnhKl1j4qNpXx6LpB+1mhed5u7+W7hUlxM5bfB
	zw0ar3B9pJr/ORvbsFGkQr1ZhxnMGFYQlPF/d1E15NAyfmz3ADUMQz7J
X-Gm-Gg: ASbGncuGMg8ln6yWm5f5nCW1b6Xvo0k8h2JnEO9ZLwbFWAbmnof94i/C9nHnuNgASta
	5fHk43FW0ljiD20xdZMNAHfi1sKAawaXI4uMzq3XND2jzvOXZLjUESi3MYxqGx149vSN3g4rCWf
	saD28n8L3lxZ3k4HnX9XFzMYVe1KEEQLA5KVjGpb7qp0tDYwGflpcDFL1QUWHHZtxs5MhvScXuY
	MRzuCzYJa3gh6xHSxHYjDlXAi7scGA3rD29zOMEIp5aWiH4YLaP65AeudJvRzCCtzTm757etqoX
	28dz5+s1EANhtttJNQMKS0/7Uy5Q8G88TA9acBpN7Uta/AGP21Ox4tct843g/8w4xLZoHMjWIbF
	xnUHnp+mFzC2iZ9X2ADRCGcyYI8rnaklakL0jl7UWFDULQvBgl7Y6IGwxy0HSJu9XiSLU1MFY5Q
	DMl7PXu8Vux73qD0BS7X/xh6nkEw==
X-Google-Smtp-Source: AGHT+IFTFbWAAtyaYWQZu7JpRusB2bhk0aVf9mwA/xe8QOYGt6MnziETDI6P8vQ523aryY3fgxqaAw==
X-Received: by 2002:a05:6214:3319:20b0:879:defa:a6f2 with SMTP id 6a1803df08f44-879defaa90emr75983146d6.18.1759621837280;
        Sat, 04 Oct 2025 16:50:37 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:35 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols and :entry/:exit
Date: Sun,  5 Oct 2025 08:46:57 +0900
Message-ID: <20251004235001.133111-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace_fprobe.c | 247 ++++++++++++++++++++++++++++--------
 1 file changed, 192 insertions(+), 55 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b36ade43d4b3..ec5b6e1c1a1b 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -191,6 +191,9 @@ struct trace_fprobe {
 	bool			tprobe;
 	struct tracepoint_user	*tuser;
 	struct trace_probe	tp;
+	char			*filter;
+	char			*nofilter;
+	bool			list_mode;
 };
 
 static bool is_trace_fprobe(struct dyn_event *ev)
@@ -203,14 +206,10 @@ static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
 	return container_of(ev, struct trace_fprobe, devent);
 }
 
-/**
- * for_each_trace_fprobe - iterate over the trace_fprobe list
- * @pos:	the struct trace_fprobe * for each entry
- * @dpos:	the struct dyn_event * to use as a loop cursor
- */
-#define for_each_trace_fprobe(pos, dpos)	\
-	for_each_dyn_event(dpos)		\
-		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
+static struct trace_fprobe *trace_fprobe_from_dyn(struct dyn_event *ev)
+{
+	return is_trace_fprobe(ev) ? to_trace_fprobe(ev) : NULL;
+}
 
 static bool trace_fprobe_is_return(struct trace_fprobe *tf)
 {
@@ -227,6 +226,109 @@ static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
 	return tf->symbol ? tf->symbol : "unknown";
 }
 
+static bool has_wildcard(const char *s)
+{
+	return s && (strchr(s, '*') || strchr(s, '?'));
+}
+
+static int parse_fprobe_spec(const char *in, bool is_tracepoint,
+		char **base, bool *is_return, bool *list_mode,
+		char **filter, char **nofilter)
+{
+	const char *p;
+	char *work = NULL;
+	char *b = NULL, *f = NULL, *nf = NULL;
+	bool legacy_ret = false;
+	bool list = false;
+	int ret = 0;
+
+	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
+		return -EINVAL;
+
+	*base = NULL; *filter = NULL; *nofilter = NULL;
+	*is_return = false; *list_mode = false;
+
+	if (is_tracepoint) {
+		if (strchr(in, ',') || strchr(in, ':'))
+			return -EINVAL;
+		if (strstr(in, "%return"))
+			return -EINVAL;
+		for (p = in; *p; p++)
+			if (!isalnum(*p) && *p != '_')
+				return -EINVAL;
+		b = kstrdup(in, GFP_KERNEL);
+		if (!b)
+			return -ENOMEM;
+		*base = b;
+		return 0;
+	}
+
+	work = kstrdup(in, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	p = strstr(work, "%return");
+	if (p) {
+		if (!strcmp(p, ":exit")) {
+			*is_return = true;
+			*p = '\0';
+		} else if (!strcmp(p, ":entry")) {
+			*p = '\0';
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	list = !!strchr(work, ',') || has_wildcard(work);
+	if (legacy_ret)
+		*is_return = true;
+
+	b = kstrdup(work, GFP_KERNEL);
+	if (!b) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (list) {
+		char *tmp = b, *tok;
+		size_t fsz = strlen(b) + 1, nfsz = strlen(b) + 1;
+
+		f = kzalloc(fsz, GFP_KERNEL);
+		nf = kzalloc(nfsz, GFP_KERNEL);
+		if (!f || !nf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		while ((tok = strsep(&tmp, ",")) != NULL) {
+			char *dst;
+			bool neg = (*tok == '!');
+
+			if (*tok == '\0')
+				continue;
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
+	*base = b; b = NULL;
+	*filter = f; f = NULL;
+	*nofilter = nf; nf = NULL;
+
+out:
+	kfree(work);
+	kfree(b);
+	kfree(f);
+	kfree(nf);
+	return ret;
+}
+
 static bool trace_fprobe_is_busy(struct dyn_event *ev)
 {
 	struct trace_fprobe *tf = to_trace_fprobe(ev);
@@ -556,13 +658,17 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 		trace_probe_cleanup(&tf->tp);
 		if (tf->tuser)
 			tracepoint_user_put(tf->tuser);
+		kfree(tf->filter);
+		kfree(tf->nofilter);
 		kfree(tf->symbol);
 		kfree(tf);
 	}
 }
 
 /* Since alloc_trace_fprobe() can return error, check the pointer is ERR too. */
-DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_fprobe(_T))
+DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *,
+	if (!IS_ERR_OR_NULL(_T))
+		free_trace_fprobe(_T))
 
 /*
  * Allocate new trace_probe and initialize it (including fprobe).
@@ -605,10 +711,16 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
 	struct dyn_event *pos;
 	struct trace_fprobe *tf;
 
-	for_each_trace_fprobe(tf, pos)
+	list_for_each_entry(pos, &dyn_event_list, list) {
+		tf = trace_fprobe_from_dyn(pos);
+		if (!tf)
+			continue;
+
 		if (strcmp(trace_probe_name(&tf->tp), event) == 0 &&
 		    strcmp(trace_probe_group_name(&tf->tp), group) == 0)
 			return tf;
+	}
+
 	return NULL;
 }
 
@@ -835,7 +947,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_tracepoint(tf))
 		return __regsiter_tracepoint_fprobe(tf);
 
-	/* TODO: handle filter, nofilter or symbol list */
+	/* Registration path:
+	 *  - list_mode: pass filter/nofilter
+	 *  - single: pass symbol only (legacy)
+	 */
+	if (tf->list_mode)
+		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
 }
 
@@ -1114,7 +1231,11 @@ static int __tprobe_event_module_cb(struct notifier_block *self,
 		return NOTIFY_DONE;
 
 	mutex_lock(&event_mutex);
-	for_each_trace_fprobe(tf, pos) {
+	list_for_each_entry(pos, &dyn_event_list, list) {
+		tf = trace_fprobe_from_dyn(pos);
+		if (!tf)
+			continue;
+
 		/* Skip fprobe and disabled tprobe events. */
 		if (!trace_fprobe_is_tracepoint(tf) || !tf->tuser)
 			continue;
@@ -1155,55 +1276,35 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 				   char **symbol, bool *is_return,
 				   bool is_tracepoint)
 {
-	char *tmp = strchr(argv[1], '%');
-	int i;
-
-	if (tmp) {
-		int len = tmp - argv[1];
-
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
-
-	if (*is_return)
-		return 0;
+	int i, ret;
+	bool list_mode = false;
+	char *filter = NULL; *nofilter = NULL;
 
-	if (is_tracepoint) {
-		tmp = *symbol;
-		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
-			tmp++;
-		if (*tmp) {
-			/* find a wrong character. */
-			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
-			kfree(*symbol);
-			*symbol = NULL;
-			return -EINVAL;
-		}
-	}
+	ret = parse_fprobe_spec(argv[1], is_tracepoint, symbol, is_return,
+			&list_mode, &filter, &nofilter);
+	if (ret)
+		return ret;
 
-	/* If there is $retval, this should be a return fprobe. */
 	for (i = 2; i < argc; i++) {
-		tmp = strstr(argv[i], "$retval");
+		char *tmp = strstr(argv[i], "$retval");
+
 		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
 			if (is_tracepoint) {
 				trace_probe_log_set_index(i);
 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
 				kfree(*symbol);
 				*symbol = NULL;
+				kfree(filter);
+				kfree(nofilter);
 				return -EINVAL;
 			}
 			*is_return = true;
 			break;
 		}
 	}
+
+	kfree(filter);
+	kfree(nofilter);
 	return 0;
 }
 
@@ -1247,6 +1348,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	int i, new_argc = 0, ret = 0;
 	bool is_tracepoint = false;
 	bool is_return = false;
+	bool list_mode = false;
+
+	char *parsed_filter __free(kfree) = NULL;
+	char *parsed_nofilter __free(kfree) = NULL;
+	bool has_wild = false;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
@@ -1267,8 +1373,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(1);
 
-	/* a symbol(or tracepoint) must be specified */
-	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
+	/* Parse spec early (single vs list, suffix, base symbol) */
+	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
+			&list_mode, &parsed_filter, &parsed_nofilter);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -1283,10 +1390,16 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 			return -EINVAL;
 	}
 
-	if (!event) {
-		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
-		if (!ebuf)
-			return -ENOMEM;
+		if (!event) {
+		/*
+		 * Event name rules:
+		 * - For list/wildcard: require explicit [GROUP/]EVENT
+		 * - For single literal: autogenerate symbol__entry/symbol__exit
+		 */
+			if (list_mode || has_wildcard(symbol)) {
+				trace_probe_log_err(0, NO_GROUP_NAME);
+			return -EINVAL;
+		}
 		/* Make a new event name */
 		if (is_tracepoint)
 			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
@@ -1319,7 +1432,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 							NULL, NULL, NULL, sbuf);
 		}
 	}
-	if (!ctx->funcname)
+
+	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
 		ctx->funcname = symbol;
 
 	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
@@ -1353,6 +1467,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 	}
 
+	/* carry list parsing result into tf */
+	if (!is_tracepoint) {
+		tf->list_mode = list_mode;
+			if (parsed_filter) {
+				tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
+				if (!tf->filter)
+					return -ENOMEM;
+			}
+			if (parsed_nofilter) {
+				tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
+				if (!tf->nofilter)
+					return -ENOMEM;
+			}
+		}
+
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1439,8 +1568,16 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 
-	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
-			       trace_fprobe_is_return(tf) ? "%return" : "");
+	seq_printf(m, "%s", trace_fprobe_symbol(tf));
+	if (!trace_fprobe_is_tracepoint(tf)) {
+		if (tf->list_mode) {
+			if (trace_fprobe_is_return(tf))
+				seq_puts(m, ":exit");
+		} else {
+			if (trace_fprobe_is_return(tf))
+				seq_puts(m, "%return");
+		}
+	}
 
 	for (i = 0; i < tf->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
-- 
2.43.0

