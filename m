Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8617799F;
	Sat, 15 Feb 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591031; cv=none; b=JdoKstQQpdKwJwdntCnouyNVIacIyD1Zx0ck4FfbPNYI3sBXSXKc9sj5K2xEL8zjeYbV2a9lCoHwqoJRuhP8PfF34u7jEoPXE0N7kZrh9AaOndu2ugBhvXzcEkcbGP07R+DcASznRj0RSA/gutxa2zoKuZvFkwu8VAoSMmOH5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591031; c=relaxed/simple;
	bh=dXr+X5dJgcrNCEwc2EpFMguMKGBFbGy9DrYu4JVp6HA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cJ5ktQn4IuXanifwt20yZ4KgU8IynUzap0566sDVbhDjB7b70Ji07SoxPT7NBd0zaV/Whh/1OmiCeBjUlx02tkESP/AAeUE+qDMKMSKUjtcXTet9BpYna70YHUPzjqssdBpjy3hZ6L1MmGN1uTF53xyVsfSSqEeER8VSEBoDyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE56C4CEE4;
	Sat, 15 Feb 2025 03:43:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj965-00000002gwn-0wNh;
	Fri, 14 Feb 2025 22:44:05 -0500
Message-ID: <20250215034405.074476251@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:43:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 6/8] tracing: Have persistent trace instances save module addresses
References: <20250215034301.624019422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

For trace instances that are mapped to persistent memory, have them use
the scratch area to save the currently loaded modules. This will allow
where the modules have been loaded on the next boot so that their
addresses can be deciphered by using where they were loaded previously.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 98 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 12a359c293c6..6674dc985e52 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5988,14 +5988,60 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
+struct trace_mod_entry {
+	unsigned long	mod_addr;
+	char		mod_name[MODULE_NAME_LEN];
+};
+
 struct trace_scratch {
 	unsigned long		kaslr_addr;
+	unsigned long		nr_entries;
+	struct trace_mod_entry	entries[];
 };
 
+static int save_mod(struct module *mod, void *data)
+{
+	struct trace_array *tr = data;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	unsigned int size;
+
+	tscratch = tr->scratch;
+	if (!tscratch)
+		return -1;
+	size = tr->scratch_size;
+
+	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size)
+		return -1;
+
+	entry = &tscratch->entries[tscratch->nr_entries];
+
+	tscratch->nr_entries++;
+
+	entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
+	strscpy(entry->mod_name, mod->name);
+
+	return 0;
+}
+
 static void update_last_data(struct trace_array *tr)
 {
 	struct trace_scratch *tscratch;
 
+	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
+		return;
+
+	/* Reset the module list and reload them */
+	if (tr->scratch) {
+		struct trace_scratch *tscratch = tr->scratch;
+
+		memset(tscratch->entries, 0,
+		       flex_array_size(tscratch, entries, tscratch->nr_entries));
+		tscratch->nr_entries = 0;
+
+		module_for_each_mod(save_mod, tr);
+	}
+
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return;
 
@@ -9220,6 +9266,46 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+static void setup_trace_scratch(struct trace_array *tr,
+				struct trace_scratch *tscratch, unsigned int size)
+{
+	struct trace_mod_entry *entry;
+
+	if (!tscratch)
+		return;
+
+	tr->scratch = tscratch;
+	tr->scratch_size = size;
+
+#ifdef CONFIG_RANDOMIZE_BASE
+	if (tscratch->kaslr_addr)
+		tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
+#endif
+
+	if (struct_size(tscratch, entries, tscratch->nr_entries) > size)
+		goto reset;
+
+	/* Check if each module name is a valid string */
+	for (int i = 0; i < tscratch->nr_entries; i++) {
+		int n;
+
+		entry = &tscratch->entries[i];
+
+		for (n = 0; n < MODULE_NAME_LEN; n++) {
+			if (entry->mod_name[n] == '\0')
+				break;
+			if (!isprint(entry->mod_name[n]))
+				goto reset;
+		}
+		if (n == MODULE_NAME_LEN)
+			goto reset;
+	}
+	return;
+ reset:
+	/* Invalid trace modules */
+	memset(tscratch, 0, size);
+}
+
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
@@ -9232,21 +9318,15 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	buf->tr = tr;
 
 	if (tr->range_addr_start && tr->range_addr_size) {
+		/* Add scratch buffer to handle 128 modules */
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
 						      tr->range_addr_size,
-						      sizeof(*tscratch));
+						      struct_size(tscratch, entries, 128));
 
 		tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
-		if (tscratch) {
-			tr->scratch = tscratch;
-			tr->scratch_size = scratch_size;
+		setup_trace_scratch(tr, tscratch, scratch_size);
 
-#ifdef CONFIG_RANDOMIZE_BASE
-			if (tscratch->kaslr_addr)
-				tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
-#endif
-		}
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
-- 
2.47.2


