Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148311;
	b=1uu+mIVp3mSxn6KRptqjWoZ6dZ4BdMzdhM+Z8efLNBE4b3gh0kiEqQ3h6w3yIDIsRei6
	 m53ECJc1A7DJlGIi6x4jOmLx1UuJYtt98ziXHuee1hIMh1GToeVCYxMk4rvhWlNDz90c9
	 vscM+Dpz97P1SMeNyAu2mU7PlbU9xDsH1xMYxRuVofNQ+MjPdlZtgRYlX7jL5qcenjx9S
	 PrwRs/6Pdo3J3sUJtgN07M+HxHRqA7Gt+B327CxO5+SFjUpGjnxhwaxD3cwCsaxorGNWQ
	 w5V2rGkAs11WGcqJYsHCIiw8PwBLH6Z//bdG1cYydWXHdIU9D8wdrxn7dl4dU3l8wVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rgbrNjXmaNT7MSYPkedsLi+j/83Pabs49tun3+lG60w=;
	b=1pQjgpMjWiOlCGkQB3j6WwX/PfdW4Ez4g2YfYkLDRT4fxSOlegYtqLNNlNxJ0qWxzqS4
	 RiIUaceapapR94dvpzrEWB07da3pUtniGXOW5rrmNp3R88IzkFZsql5Q7ZgBJanMWX2LQ
	 PpAZJVmqV6F1SKrVHKmzrCzSXfii3pJI1pIdxcUYxzeRwHIFgUtkrgLoS2t8IilGmTYXo
	 dpH06Qm/ytNsCXaYaiCH4mnZoBSTFCIRjlCB7Eyz92Ss8r6UEoUHDc/rB1OY55Qiulo9h
	 M+buNA5l9cd6xzKrdYpjxXwKtx/QbItv73qoSZoXD/X5EVC/6uIPuYIFy2dBnN9FMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZhZHMq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF5606A31A;
	Wed, 28 Oct 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZhZHMq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1091F01829;
	Wed, 28 Oct 2026 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148310;
	bh=rgbrNjXmaNT7MSYPkedsLi+j/83Pabs49tun3+lG60w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZhZHMq8YVuQo3PA+Ntb1/YdL6HlkIY2eLicTZpNgyXGSjTjmTKDk5QNGM1mAvkL9
	 yfvcZxr75zXDHTeasRDIsLkKxdejwSP51TsbyL0rszaJVaKtLK4Cn4ffPAn/JeuR2m
	 dzzumNPHykji9CeNFr4fIGbsWm+UE8TeQ6J69vaHBpzZPynbJkcFVEtfNYBT+0ZpSc
	 eTtklqI0FolFSfKwVWj3M05TdqAVH795Zporl566BFSrsXLgD9NGpS1K8c1IzQtASQ
	 kO/cMAxlheI21JWnLF3MSUmf2Z/PaF30KuTT07fGIYiUJSRh1PKZ1RutJHNWWN6Ixp
	 cz1uCPqj9/bCw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 11/16] tracing/filters: Check for trailing characters after newline in filter string
Date: Wed, 28 Oct 2026 09:45:06 +0900
Message-ID: <179314830681.684037.17927533770192828788.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
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
newline, report it as an invalid input error (-EINVAL).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Introduce filter_check_newline() to convert the first newline to
   NUL and reject any non-whitespace characters after the newline with
   an invalid input error (-EINVAL).
---
 kernel/trace/trace_events_filter.c |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9d1446464058..f3c18324b07a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2441,6 +2441,31 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return -ENOMEM;
 }
 
+/*
+ * Convert the first newline to '\0' and check that the rest of the input
+ * contains no non-whitespace characters.
+ */
+static int filter_check_newline(char *str)
+{
+	char *p;
+
+	if (!str)
+		return 0;
+
+	p = strchr(str, '\n');
+	if (!p)
+		return 0;
+
+	*p++ = '\0';
+	while (*p) {
+		if (!isspace(*p))
+			return -EINVAL;
+		p++;
+	}
+
+	return 0;
+}
+
 static int create_filter_start(char *filter_string, bool set_str,
 			       struct filter_parse_error **pse,
 			       struct event_filter **filterp)
@@ -2452,6 +2477,10 @@ static int create_filter_start(char *filter_string, bool set_str,
 	if (WARN_ON_ONCE(*pse || *filterp))
 		return -EINVAL;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	filter = kzalloc_obj(*filter);
 	if (filter && set_str) {
 		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
@@ -2570,6 +2599,10 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	if (file->flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
@@ -2624,6 +2657,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	if (!dir->nr_events)
 		return -ENODEV;
 
+	err = filter_check_newline(filter_string);
+	if (err)
+		return err;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_free_subsystem_preds(dir, tr);
 		remove_filter_string(system->filter);

