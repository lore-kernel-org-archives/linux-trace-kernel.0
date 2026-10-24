Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859212;
	b=aOBB9DsEgT4/BlWZUIGtkdPX9d9pCyllcC80kzB7Jh5HZMFOCfN31sT918AY+jgabV1B
	 j/vi+/meryumLoEcxBd0/DmIXJp/sjj16IFj09PxK5GgOd3rcEs/5Hn6SidgvKV1fIa9o
	 m7t+p1ZKvcNKtN4Gz65cITE5c1PrDyVmoFd95xSI1ZjuGn0u6nqel8P++XCStS74XOayS
	 PFhev34G/Mj5ukNvinx+zBkrv/S5l5VgFYS/f3dIYrrE3vHjAZIfzpdfM/+1NehV9viAx
	 kh8cSEwR8atkQsUxG/lIqRk5sviQcmxXvi0CtivzTUTkKmm+iwV5EGVFxME1mEFItVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h34A9ML9ik3KJXsE5nE+s5W3b7SYRZ1eoX9MmAZBOyI=;
	b=gCkS5hGkWSHDtuoPOu9KWTNDB6cqnmPgsr/Gq09GeDrsZRzyNc9xE+isIzEgSLituHtI
	 2k+UsTxk7Lezb57N4QCx9yqsE4PqkfAwq+yyMsNwmmAi7qzjJWVaibnv8W70E/Q2Fc8zz
	 JwBeoRqGRt3i0jFpcmGjbgkgfA+O9rQsIBUR7E6kiq1wBZjczltChH2IRZYy1VMf9+WpX
	 garyElaTQbL8GLZG++PwJVdHc3uXleUVRXA0UwSuM4ol1NHpJGK99dDlqpRShR8/LMj/z
	 dJIzgOs25xLX2baLabuhIaGXBeHEaVyOhMuAfHA6RNLAntaXhtxbnwGNQd9jRavqltQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MA0p4bnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7632606A31A;
	Sat, 24 Oct 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MA0p4bnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A405E1F01828;
	Sat, 24 Oct 2026 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859211;
	bh=h34A9ML9ik3KJXsE5nE+s5W3b7SYRZ1eoX9MmAZBOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MA0p4bnSItdm55b3AdfDpUjMdyCZzSR7Ir46OhVZHX2wyvqJyu0OpN5uGIpz9v2gi
	 qd9Dv8tOla1ZV9FRYM8UOptIWSC3qQ5bht9V34zcriLa4piwMiI0hCqvUWIjCw9HD9
	 v+AzNXLpF7Pey5oqnjD4kooztkptrQNS1NCgmdG3nNZ4JDO5fx58qmrVBWcCdWUpo4
	 jepZ9nFG+UGlgi7gS+qyTmG4wZMFaSVjTEuI6G1w1/zeDlgp6VcDO+hVNKv+Qb/48N
	 EB+FjnRRbNyaOAGVDt2zTjB3ZyGgcjZcF9LRmiK+PSJeVSskUSgqRCG5yYd1JCHqvm
	 m4zjsAM4cM1Xg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 09/10] tracing/filters: Terminate filter string at first newline
Date: Sun, 25 Oct 2026 01:26:47 +0900
Message-ID: <179285920744.466249.13202891755334148747.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179285912318.466249.7425922682086130057.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Each trace event or subsystem only holds a single filter, and
append_filter_err() / tracing_log_err() caret placement assumes a
single-line filter string. However, apply_event_filter() and
apply_subsystem_event_filter() only call strstrip(), which strips
trailing newlines but leaves embedded newlines intact.

An embedded newline in a filter string (for example inside 'CPUS{0\n"}')
causes cpulist_parse() / bitmap_parselist() to treat '\n' as the end of
the cpulist and ignore trailing characters before '}', desynchronizing
quote tracking between calc_stack() and parse_pred() and misaligning
error_log caret reporting.

Terminate filter_string at the first '\n' in apply_event_filter(),
apply_subsystem_event_filter(), and create_filter_start() so only the
first line is parsed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 89f4e119628f..213ed9bdf6f3 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2425,10 +2425,15 @@ static int create_filter_start(char *filter_string, bool set_str,
 	struct event_filter *filter;
 	struct filter_parse_error *pe = NULL;
 	int err = 0;
+	char *p;
 
 	if (WARN_ON_ONCE(*pse || *filterp))
 		return -EINVAL;
 
+	p = strchr(filter_string, '\n');
+	if (p)
+		*p = '\0';
+
 	filter = kzalloc_obj(*filter);
 	if (filter && set_str) {
 		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
@@ -2542,11 +2547,16 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 {
 	struct trace_event_call *call = file->event_call;
 	struct event_filter *filter = NULL;
+	char *p;
 	int err;
 
 	if (file->flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
+	p = strchr(filter_string, '\n');
+	if (p)
+		*p = '\0';
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
@@ -2594,6 +2604,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	struct trace_array *tr = dir->tr;
 	struct event_filter *filter = NULL;
 	int err = 0;
+	char *p;
 
 	guard(mutex)(&event_mutex);
 
@@ -2601,6 +2612,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	if (!dir->nr_events)
 		return -ENODEV;
 
+	p = strchr(filter_string, '\n');
+	if (p)
+		*p = '\0';
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_free_subsystem_preds(dir, tr);
 		remove_filter_string(system->filter);

