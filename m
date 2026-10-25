Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917506;
	b=WeR0ov4CAEo4jdnyHtHhKVcbRVZTAMAv27mW4PhbOIFb3OKMEvlf59mQtmXJ6xiGQ3I8
	 vRZM14IQr/wo9EnyWUdDIaH7Oo/11PXKPZw3xQjLVxoZzK+VUv9bMa4NihTFf4M6a+PtW
	 vWfQoTNYCHAoPSyjfhK8ShJZKaIECSLJAgYU0Lq+PdeE5LLXyVzLnIEApwWzgou9Qce5n
	 /frYR4EafPJF0PK02O6MzFoUJq9owEPqwmZxCtEH11MNJ2TTcFSkQhdS2VLuMSprjSBVe
	 epVOdHY9vP2N5G8NMhzu1DkP7+0WVE3YcScRZ8Dp8oe2PR+O/BuygeaPJBONPaK9OBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=slCGhATDIXc0zsVH/NXCSXmxKMEWAPv2anhYyy5qN7c=;
	b=C5itIJjKJmKK8h44pFRoDGc/K3XjZ95YQvEOgCRbjOnjueQyRCdY4SrMaoWNrrywxmJi
	 b4OJ1iGlw11N7fDhqayD03+dKccw3PXjkkAuv9jY6x5eWDmaq1sADrvX5lU4tte9P2YJO
	 /mEFUi9b3xLS9f7bTqV4ermsw9BO1JX9+buOPIXhdG60xZkJqekdu6b+tVTiGAnoVDe0b
	 mEui03PHtBesUHR3R4wcIblF0V9wMkeFVHgklS5Tan9OZ5HPOIFRBgEzgFVOb9YDDS3CZ
	 ru/WdFlyMUgKQkm3FNWyWZ56IZderd/cTwcS9jxPn6wE+MlXNsLeM8cj8n3FuPpz1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0r5exFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B9606A323;
	Sun, 25 Oct 2026 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0r5exFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993601F01825;
	Sun, 25 Oct 2026 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917505;
	bh=slCGhATDIXc0zsVH/NXCSXmxKMEWAPv2anhYyy5qN7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f0r5exFq1Zfd0P/kYasxS86J5o4iIl1ZFX4uqMn8/6ESfvZfOc/UG+DWRiSyq3xuf
	 lUFNiOj/IOlWFUv4SCrnQ3T+J2ncQiVK8wqlQV743TZ7sjf7Givz2v3QEZZLdR9obM
	 DZh1gpmdSmexn5V3pGnrCFjUyuwl7x8rMShVBS6tSnKNrgK8eop9tIkLy3cX+8tDTN
	 A2pgHD+SUk7btaJudrGA4P/8wKniWMX///1CR+mvXoc2YC8PTC45sVpb8u5Bho693c
	 Hk/buiLDdrknoSTE8Uwx23eT3A26u5zzxqF2rPYtQCd/N4MP7Bg686sR71pdT50ZbT
	 nntDu/H+fAC9A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 8/9] tracing/filters: Terminate filter string at first newline
Date: Sun, 25 Oct 2026 17:38:22 +0900
Message-ID: <179291750264.492959.17808238344327959450.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179291742944.492959.11659339795290028998.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
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
index 8d7fb6e9d7f8..14afcca7a444 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2426,10 +2426,15 @@ static int create_filter_start(char *filter_string, bool set_str,
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
@@ -2543,11 +2548,16 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
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
@@ -2595,6 +2605,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	struct trace_array *tr = dir->tr;
 	struct event_filter *filter = NULL;
 	int err = 0;
+	char *p;
 
 	guard(mutex)(&event_mutex);
 
@@ -2602,6 +2613,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	if (!dir->nr_events)
 		return -ENODEV;
 
+	p = strchr(filter_string, '\n');
+	if (p)
+		*p = '\0';
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_free_subsystem_preds(dir, tr);
 		remove_filter_string(system->filter);

