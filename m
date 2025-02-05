Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EA21C9F8;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795824; cv=none; b=NJIzgK+x82qnk4CvW+hkUPuHt6wchNPnlzRF69DHXX1pXLakIQ1Eg4z05AKvq5yGz/7lZumL83pKrnw+wy4l2DelvAw5QKOEqdNuJQVU9wJLpI668vRz4BLY/M9jvp0gCSxvGgfpkOmDIkWx3yZqb88p9Eu+bRvV4QGZSLrYLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795824; c=relaxed/simple;
	bh=acT27wujFzHBmghTMfek6s956/UyXG1nRM3Qxh/UYIk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P2ah6fIKmWBw4dO9HYZSSxTkwgz7hUJmv5oa29oTWwBTzwf1sUoHKEnTq5FiTK6VcLqqB1XXVxsDgclMWmnoj3f5yAwueFLUKp2aPIBuHL58oZ62rx+tMxinAKyK3shrMXZV1up17oWhK+5CC9S4rNsGiy1/U5xnPc+XiM/NtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954C5C4CEE6;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEa-00000007gW5-0Jht;
	Wed, 05 Feb 2025 17:51:04 -0500
Message-ID: <20250205225103.930895467@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/8] tracing: Have persistent trace instances save module addresses
References: <20250205225031.799739376@goodmis.org>
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
 kernel/trace/trace.c | 99 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index cb9f8e6878a0..a8e5f7ac2193 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5994,14 +5994,60 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 	return ret;
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
 
@@ -9226,6 +9272,46 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned int size)
+{
+	struct trace_scratch *tscratch = scratch;
+	struct trace_mod_entry *entry;
+
+	if (!scratch)
+		return;
+
+	tr->scratch = scratch;
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
+	memset(scratch, 0, size);
+}
+
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
@@ -9243,19 +9329,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 						      tr->range_addr_size);
 
 		scratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
-		if (scratch) {
-			tr->scratch = scratch;
-			tr->scratch_size = scratch_size;
+		setup_trace_scratch(tr, scratch, scratch_size);
 
-#ifdef CONFIG_RANDOMIZE_BASE
-			{
-				struct trace_scratch *tscratch = tr->scratch;
-
-				if (tscratch->kaslr_addr)
-					tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
-			}
-#endif
-		}
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
-- 
2.45.2


