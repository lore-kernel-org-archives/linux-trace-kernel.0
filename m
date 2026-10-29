Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237932;
	b=At+2j18dP7ro/05798qNoCLMzN3fnRd8B6U/Pw3onlVkGmA2yJAn6FXV84Rxr/BiJRvS
	 Eg4vh+UFljV+Wp8/74ooQUqKkMsfFYmS1q99kYQgcfypLFXmvWbo44NX3bM7nLykjBWiJ
	 2l4KIlqrsBjvwfYXaw5Y6cdn8o+3HljLM6magNIEh9b3tIV8huLjek/EgEqmaIFGyEEot
	 BBHag8ABJ/2HR/9hAt+OklnuOc8c3R9TgQI1HmRtFZtupnFVSUL849npvcJFr4gGgFNlz
	 KRwxUTh52aMLrfRo1Bp2axnXFob2TgTVbkyMynH7o972+nBimXEPXI91nyE71WV6i8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5milwe+zUcr1Bxa93G4m3eDpIs6Bq/oA13FtjUoRTYk=;
	b=c+WXauHKMC/Mx0lgJz5UQUv7VHVhzg+pWdL7PbWui2J14fsa/opUmyn+tgbkBmgUe/BN
	 WOD7halnqXp1v7hb4Pc1ruY9hxBpzlSKaRQUyp69tWyGOf+it3+Yhnp6CF60i3cDlxBMF
	 TRkja3G5mC6hzsz3wzwdR+/Tlfme0JI2Kek5UM7ESm/dttezRlfUop2lgwazu+2QVZlO6
	 13DWHSagBdjagkB+66YmuGhGL887W4uCPqf3GEWRulu+7rBCifgCafIFQxnO40PvTS6Cf
	 lRhgzbh1pPYp2J4ZqGofKHZqYWkr6eLU13SJHBvrAe24HLA0Zv/YGPHzJhmV74nwDxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJi3GXrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964D606A33B;
	Thu, 29 Oct 2026 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJi3GXrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768831F01829;
	Thu, 29 Oct 2026 01:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237932;
	bh=5milwe+zUcr1Bxa93G4m3eDpIs6Bq/oA13FtjUoRTYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJi3GXrd8Rgm/q0o1+JjAe/kQDt1hZrnRb75nHazwi/AHUWTPiDKnKFL7zVcPABC1
	 FMO5thLjeO+h32tB1tiUWwgjDjesV3lNM8gfTBPUFTKZ3pmXi34rR6bkU9nI1brTVD
	 Fq+U5C+58cTG6Ws54X69PtX2FZNtUNUPCoOmDWYGOwu+qPWaX8FIY32V+g2wpWd+6c
	 jPeZQh6HibhuXUMq70ybDvXMy8shngVS4EAEafD/aD1KtG/i7fz2whHziNjs8uJafu
	 EnFofUY7fqdsqKZ6h7qzv0WePJCHAe4Cx+KR3ajW/1X7z9O0500p1jyHOQ4Bgdk+DP
	 SOpPzJWzDmcjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 09/15] tracing/filters: Check for trailing characters after newline in filter string
Date: Thu, 29 Oct 2026 10:38:48 +0900
Message-ID: <179323792832.740114.8136681613581516243.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
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
apply_subsystem_event_filter() only called strstrip(), which strips
trailing newlines but leaves embedded newlines intact.

An embedded newline in a filter string (for example inside 'CPUS{0\n"}')
causes cpulist_parse() / bitmap_parselist() to treat '\n' as the end of
the cpulist and ignore trailing characters before '}', desynchronizing
quote tracking between calc_stack() and parse_pred() and misaligning
error_log caret reporting.

Introduce an internal function filter_check_newline() to convert the
first newline to NUL and check that the rest of the input contains no
non-whitespace characters. If any non-whitespace character follows the
newline, report it as an invalid input error (-EINVAL) without modifying
the input string in-place.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Verify all characters following the newline are whitespace before
   writing '\0' in filter_check_newline(), preventing in-place truncation
   on error, as pointed out by Sashiko.
Changes in v3:
 - Introduce filter_check_newline() to convert the first newline to
   NUL and reject any non-whitespace characters after the newline with
   an invalid input error (-EINVAL).
---
 kernel/trace/trace_events_filter.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 40efcef94e02..0a362ccb14ad 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2439,6 +2439,30 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return ret;
 }
 
+/*
+ * Check that the rest of the input after the first newline contains no
+ * non-whitespace characters, and convert the newline to '\0'.
+ */
+static int filter_check_newline(char *str)
+{
+	char *nl, *p;
+
+	if (!str)
+		return 0;
+
+	nl = strchr(str, '\n');
+	if (!nl)
+		return 0;
+
+	for (p = nl + 1; *p; p++) {
+		if (!isspace(*p))
+			return -EINVAL;
+	}
+
+	*nl = '\0';
+	return 0;
+}
+
 static int create_filter_start(char *filter_string, bool set_str,
 			       struct filter_parse_error **pse,
 			       struct event_filter **filterp)
@@ -2450,6 +2474,10 @@ static int create_filter_start(char *filter_string, bool set_str,
 	if (WARN_ON_ONCE(*pse || *filterp))
 		return -EINVAL;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	filter = kzalloc_obj(*filter);
 	if (filter && set_str) {
 		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
@@ -2568,6 +2596,10 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	if (file->flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
@@ -2622,6 +2654,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	if (!dir->nr_events)
 		return -ENODEV;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_free_subsystem_preds(dir, tr);
 		remove_filter_string(system->filter);

