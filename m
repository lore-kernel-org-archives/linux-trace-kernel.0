Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1769323416;
	Sat, 19 Sep 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828713; cv=none; b=igf0x/atJP57gsGSO+4IVFZ+Jj3/nFzO1iL7KzcHHNwKvHyKVu9zVmVC8g75Y5PBsrerKt+QYPD6ffHsT0VmbRr4k3G2LTQu/a4ROrgBI9noZttEZdB3Hx8efq0uj/b/7koHNmb1gQwNWDX9p/3ZsIzQ0lo1ABsTrIv7Ac9MvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828713; c=relaxed/simple;
	bh=WkFwwEGwXunA6CRjKdvA161yL92eNohakoz6vokz+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIKqOLFvueDuIm0Y68oGp5saA+6zYO+ADctY71lzgcB1aIPuQvqx3/X/KZT3D6uYrRnfeqcP9Y4EVoySazqIn7J4nfZ3Hb2FJkvLbeO/nHXkHzm2UcWmMVArlCxoOWflRNRGeIgcoDrQ+tujV9YEKu1QRpRqqWSbPB4aPT8xoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi3vrJxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi3vrJxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEF1F000FF;
	Sat, 19 Sep 2026 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789828711;
	bh=wLd9E546h4iUqMUIOwgazII1NOQSfP8ntwUQaQbvMes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hi3vrJxuXqZqJ8ARW7D/+Ng99C8uJRx4h4qL1dL0OqTj9VvpzOfd8019PF5EvS0O8
	 /F7tZh+tjgW4KY49O4S2IzvoQylrYPCUZ6R92yJ4jGBbgSZRKU6VIX4mFj2vx1fvTn
	 +Qyk/UXsIP9kREt99y9AxALrUISQfJEOZCKW5cNSL4PJrhKOXb1oGur4NMHxO/oF/W
	 kQ71ON1Nj3M/47twOOAvVIOxd4bvOygNr005dKe6XHiSJ89Swf57NeI3NRp8g63Kmk
	 30gSvSfoq9Qik1noGesk2reLGHYPOhEG5wuMJE1IZ7Vu5RcfwvQKwbqnMGpVVPsLkJ
	 yTEKolPv63uiw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] tracing: Override the same name trace_instance= by latter one
Date: Sat, 19 Sep 2026 23:38:26 +0900
Message-ID: <178982870684.289221.3913908968761883887.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178982869661.289221.2143320719673148321.stgit@devnote2>
References: <178982869661.289221.2143320719673148321.stgit@devnote2>
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

Override the same name boot instance by the latter parameter.
This allows user to override the trace instance in bootconfig by the
cmdline from bootloader.

For example, set default trace_instance parameter in bootconfig
e.g.:

  kernel {
     reserve_mem=12M:32M:trace
     trace_instance=boot_map@trace
  }

This just add a persistent trace instance.

And when you need to record events, you can override the boot_map
trace instance from bootloader:

  trace_instance=boot_map@trace,sched:*

Then the boot_map instance is start tracing sched:* events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +
 Documentation/trace/debugging.rst               |   15 +++
 kernel/trace/trace.c                            |  127 +++++++++++++++++------
 3 files changed, 115 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..232edcd9f2c9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7768,6 +7768,13 @@ Kernel parameters
 
 			NB: Both the mapped address and size must be page aligned for the architecture.
 
+			Multiple trace_instance= options can be specified to
+			create multiple instances. If the same instance name is
+			specified more than once, the latter one will override
+			any earlier definitions for that instance. This allows
+			overriding an instance configuration that was defined
+			earlier on the command line or via bootconfig.
+
 			See also Documentation/trace/debugging.rst
 
 
diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index bca1710d92bf..b66cc070ae79 100644
--- a/Documentation/trace/debugging.rst
+++ b/Documentation/trace/debugging.rst
@@ -178,3 +178,18 @@ instance without stopping the trace.
 Note that this "backup" instance is readonly, and will be removed automatically
 if you clear the trace data or read out all trace data from the "trace_pipe"
 or the "trace_pipe_raw" files.
+
+Overriding trace instances
+--------------------------
+
+Multiple ``trace_instance=`` options can be specified on the kernel command
+line to create multiple instances. If the same instance name is specified
+more than once, the latter definition will override any previous definitions
+for that instance.
+
+This is useful when an instance configuration is defined in bootconfig, but
+needs to be overridden or modified from the bootloader command line (for
+example, to change the enabled events or add flags like ``traceoff``)::
+
+  trace_instance=boot_map^traceoff@trace
+
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9e182d40059..39a6eeb52d28 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -220,6 +220,7 @@ static char *default_bootup_tracer;
 
 static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_instance_index;
+static int nr_boot_instances;
 
 /*
  * Repeated boot parameters, including Bootconfig array expansions, need
@@ -308,6 +309,7 @@ static int __init boot_instance(char *str)
 
 	ret = snprintf(slot, left, "%s\t", str);
 	boot_instance_index += ret;
+	nr_boot_instances++;
 
 	return 1;
 }
@@ -9611,33 +9613,42 @@ __init static int backup_instance_area(const char *backup,
 	return 0;
 }
 
-__init static void enable_instances(void)
+struct boot_instance {
+	char *name;
+	char *flag_delim;
+	char *addr_delim;
+	char *backup;
+	char *events;
+};
+
+__init static void parse_boot_instance_info(struct boot_instance *boot_instances)
 {
-	struct trace_array *tr;
-	bool memmap_area = false;
-	char *curr_str;
+	char *flag_delim;
+	char *addr_delim;
+	char *backup;
+	char *events;
 	char *name;
-	char *str;
 	char *tok;
+	char *str;
+	int idx = 0;
+	int i;
 
 	/* A tab is always appended */
 	boot_instance_info[boot_instance_index - 1] = '\0';
 	str = boot_instance_info;
 
-	while ((curr_str = strsep(&str, "\t"))) {
-		phys_addr_t start = 0;
-		phys_addr_t size = 0;
-		unsigned long addr = 0;
-		bool traceprintk = false;
-		bool traceoff = false;
-		char *flag_delim;
-		char *addr_delim;
-		char *rname __free(kfree) = NULL;
-		char *backup;
+	while ((events = strsep(&str, "\t"))) {
+		if (!*events)
+			continue;
 
-		tok = strsep(&curr_str, ",");
+		tok = strsep(&events, ",");
 
 		name = strsep(&tok, "=");
+		if (!*name) {
+			pr_warn("Tracing: Empty boot instance name\n");
+			continue;
+		}
+
 		backup = tok;
 
 		flag_delim = strchr(name, '^');
@@ -9649,15 +9660,62 @@ __init static void enable_instances(void)
 		if (flag_delim)
 			*flag_delim++ = '\0';
 
-		if (backup) {
-			if (backup_instance_area(backup, &addr, &size) < 0)
+		for (i = 0; i < idx; i++) {
+			/* Override by the last defined instance */
+			if (!strcmp(name, boot_instances[i].name))
+				break;
+		}
+
+		boot_instances[i].name = name;
+		boot_instances[i].flag_delim = flag_delim;
+		boot_instances[i].addr_delim = addr_delim;
+		boot_instances[i].backup = backup;
+		boot_instances[i].events = events;
+		if (i == idx)
+			idx++;
+	}
+
+	nr_boot_instances = idx;
+}
+
+__init static void enable_instances(void)
+{
+	struct boot_instance *boot_instances __free(kfree) = NULL;
+	struct boot_instance *bi;
+	struct trace_array *tr;
+	bool memmap_area = false;
+	char *tok;
+
+	if (!boot_instance_index)
+		return;
+
+	/* Parse the instance name to check the overlap */
+	boot_instances = kmalloc_array(nr_boot_instances,
+				       sizeof(*boot_instances), GFP_KERNEL);
+	if (!boot_instances)
+		return;
+
+	parse_boot_instance_info(boot_instances);
+
+	for (int i = 0; i < nr_boot_instances; i++) {
+		char *rname __free(kfree) = NULL;
+		phys_addr_t start = 0;
+		phys_addr_t size = 0;
+		unsigned long addr = 0;
+		bool traceprintk = false;
+		bool traceoff = false;
+
+		bi = &boot_instances[i];
+
+		if (bi->backup) {
+			if (backup_instance_area(bi->backup, &addr, &size) < 0)
 				continue;
 		}
 
-		if (flag_delim) {
+		if (bi->flag_delim) {
 			char *flag;
 
-			while ((flag = strsep(&flag_delim, "^"))) {
+			while ((flag = strsep(&bi->flag_delim, "^"))) {
 				if (strcmp(flag, "traceoff") == 0) {
 					traceoff = true;
 				} else if ((strcmp(flag, "printk") == 0) ||
@@ -9666,35 +9724,35 @@ __init static void enable_instances(void)
 					traceprintk = true;
 				} else {
 					pr_info("Tracing: Invalid instance flag '%s' for %s\n",
-						flag, name);
+						flag, bi->name);
 				}
 			}
 		}
 
-		tok = addr_delim;
+		tok = bi->addr_delim;
 		if (tok && isdigit(*tok)) {
 			start = memparse(tok, &tok);
 			if (!start) {
 				pr_warn("Tracing: Invalid boot instance address for %s\n",
-					name);
+					bi->name);
 				continue;
 			}
 			if (*tok != ':') {
-				pr_warn("Tracing: No size specified for instance %s\n", name);
+				pr_warn("Tracing: No size specified for instance %s\n", bi->name);
 				continue;
 			}
 			tok++;
 			size = memparse(tok, &tok);
 			if (!size) {
 				pr_warn("Tracing: Invalid boot instance size for %s\n",
-					name);
+					bi->name);
 				continue;
 			}
 			memmap_area = true;
 		} else if (tok) {
 			if (!reserve_mem_find_by_name(tok, &start, &size)) {
 				start = 0;
-				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
+				pr_warn("Failed to map boot instance %s to %s\n", bi->name, tok);
 				continue;
 			}
 			rname = kstrdup(tok, GFP_KERNEL);
@@ -9717,19 +9775,19 @@ __init static void enable_instances(void)
 				addr = (unsigned long)phys_to_virt(start);
 			if (addr) {
 				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
-					name, &start, (unsigned long)size);
+					bi->name, &start, (unsigned long)size);
 			} else {
-				pr_warn("Tracing: Failed to map boot instance %s\n", name);
+				pr_warn("Tracing: Failed to map boot instance %s\n", bi->name);
 				continue;
 			}
 		} else {
 			/* Only non mapped buffers have snapshot buffers */
-			do_allocate_snapshot(name);
+			do_allocate_snapshot(bi->name);
 		}
 
-		tr = trace_array_create_systems(name, NULL, addr, size);
+		tr = trace_array_create_systems(bi->name, NULL, addr, size);
 		if (IS_ERR(tr)) {
-			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer %s\n", bi->name);
 			continue;
 		}
 
@@ -9750,12 +9808,12 @@ __init static void enable_instances(void)
 		/*
 		 * Backup buffers can be freed but need vfree().
 		 */
-		if (backup) {
+		if (bi->backup) {
 			tr->flags |= TRACE_ARRAY_FL_VMALLOC | TRACE_ARRAY_FL_RDONLY;
 			trace_array_start_autoremove();
 		}
 
-		if (start || backup) {
+		if (start || bi->backup) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
 			tr->range_name = no_free_ptr(rname);
 		}
@@ -9764,11 +9822,12 @@ __init static void enable_instances(void)
 		 * Save the events to start and enabled them after all boot instances
 		 * have been created.
 		 */
-		tr->boot_events = curr_str;
+		tr->boot_events = bi->events;
 	}
 
 	/* Enable the events after all boot instances have been created */
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		char *curr_str;
 
 		if (!tr->boot_events || !(*tr->boot_events)) {
 			tr->boot_events = NULL;

