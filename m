Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E168331EBD;
	Fri,  2 Oct 2026 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949748; cv=none; b=OD8o/Edwo0TiMpfcql1sUn62uV90GpRynKfpyvE6ylxEjiynVTUTOL3AvVs+V+Fakrr0PySFEn/0lFMB0e3X16jJEBqMgIMLRTjHbzoyh2nuP1JPX57LHXjJeoMUyOO7F2jD+T1HieVjm0SAMjEQPg/DUSLtOsGxiATtUTV0peg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949748; c=relaxed/simple;
	bh=2MCwPlJFfQJd2tkp7S2m5NtuoNVmxstsicfvV70Q3JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWPmMaKRYfdeAlaKRtphLgHmt/DLYc0cC9PgzXbBpa+gXZSleCjysOzgsFY/Q7T/Yetq80FBcj89gJxjBXnFLDb71rnrMtU5WoefUsDmhd/qLGDraBitwQrgKV1iXfrI7/4Bd+jQgcvC8a2HedwfktEoPjxbxh8MujXu5iT2lLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW8clJ+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW8clJ+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E7A1F000FF;
	Fri,  2 Oct 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949746;
	bh=qMvrzwIAiSmYGjSfoW+y+Z1PW3tJz8IMPyFAFy3y9/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YW8clJ+zzBGaV7ioAWWNIl0GBeCALvL/zECHZ7h56xhhLRaN/ybvLmDRj0pWSdxci
	 eyuSqeUhVmSXPM+QnojqpG3ahStbBuXi6QZIoTWY8FBSxOTUI9aRguRWMWmJ0vq4Cm
	 i3YdTPfrQESor+rFXEZNMSa+t72YnO8LcwYR1Hl0iQG1w/e057Kf5l52HQRc80V5OV
	 jQsHTVkXrH3+g0rLclmcoztM3W2F/V6YGaMc4Gi1JhFX0UzeQtjVTmOnq4Z2nQYbE+
	 OfkaHRuQKCc8vj3yFWOEp64OmQ4szc+V62e3n5iN42ETYqf/t9wtl11He1ecwuYCx4
	 l3LXa2/dSh/xg==
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
Subject: [PATCH v3 1/2] tracing: Override the same name trace_instance= by latter one
Date: Fri,  2 Oct 2026 23:02:22 +0900
Message-ID: <179094974235.609715.7085605075646393261.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179094973121.609715.2103310055830923648.stgit@devnote2>
References: <179094973121.609715.2103310055830923648.stgit@devnote2>
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

This just adds a persistent trace instance.

And when you need to record events, you can override the boot_map
trace instance from bootloader:

  trace_instance=boot_map@trace,sched:*

Then the boot_map instance starts tracing sched:* events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Count the number of tabs in trace_instance= option as the number
    of trace instance.
  - Check whether source instance exists before the backup instance.
  - Fix memmap_area leaking in the next loop.
  - Count nr_instances in enable_instances().
  - Add index range check for boot_instances array.
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +
 Documentation/trace/debugging.rst               |   15 ++
 kernel/trace/trace.c                            |  150 +++++++++++++++++------
 3 files changed, 135 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..0695ba0234c9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7806,6 +7806,13 @@ Kernel parameters
 
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
index e4a490d3d08c..8cd8b8b045fe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9705,33 +9705,44 @@ __init static int backup_instance_area(const char *backup,
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
+__init static int parse_boot_instance_info(struct boot_instance *boot_instances,
+					   int nr_instances)
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
+	int idx;
+	int nr = 0;
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
@@ -9743,20 +9754,84 @@ __init static void enable_instances(void)
 		if (flag_delim)
 			*flag_delim++ = '\0';
 
-		if (trace_array_find(name)) {
-			pr_warn("Tracing: Instance %s already exists\n", name);
-			continue;
+		for (idx = 0; idx < nr; idx++) {
+			/* Override by the last defined instance */
+			if (!strcmp(name, boot_instances[idx].name))
+				break;
 		}
 
 		if (backup) {
-			if (backup_instance_area(backup, &addr, &size) < 0)
+			/* Check if the backup source instance exists */
+			for (i = 0; i < idx; i++) {
+				if (!strcmp(backup, boot_instances[i].name))
+					break;
+			}
+			if (i == idx) {
+				pr_warn("Tracing: Backup source instance %s is not found for %s\n",
+					backup, name);
 				continue;
+			}
 		}
 
-		if (flag_delim) {
+		if (WARN_ON(idx >= nr_instances))
+			break;
+
+		boot_instances[idx].name = name;
+		boot_instances[idx].flag_delim = flag_delim;
+		boot_instances[idx].addr_delim = addr_delim;
+		boot_instances[idx].backup = backup;
+		boot_instances[idx].events = events;
+		if (idx == nr)
+			nr++;
+	}
+
+	return nr;
+}
+
+__init static void enable_instances(void)
+{
+	struct boot_instance *boot_instances __free(kfree) = NULL;
+	struct boot_instance *bi;
+	struct trace_array *tr;
+	int nr_instances = 1;
+	char *tok;
+
+	if (!boot_instance_index)
+		return;
+
+	for (char *p = boot_instance_info; *p; p++) {
+		if (*p == '\t')
+			nr_instances++;
+	}
+
+	/* Parse the instance name to check the overlap */
+	boot_instances = kmalloc_array(nr_instances,
+				       sizeof(*boot_instances), GFP_KERNEL);
+	if (!boot_instances)
+		return;
+
+	nr_instances = parse_boot_instance_info(boot_instances, nr_instances);
+
+	for (int i = 0; i < nr_instances; i++) {
+		char *rname __free(kfree) = NULL;
+		phys_addr_t start = 0;
+		phys_addr_t size = 0;
+		unsigned long addr = 0;
+		bool traceprintk = false;
+		bool traceoff = false;
+		bool memmap_area = false;
+
+		bi = &boot_instances[i];
+
+		if (bi->backup) {
+			if (backup_instance_area(bi->backup, &addr, &size) < 0)
+				continue;
+		}
+
+		if (bi->flag_delim) {
 			char *flag;
 
-			while ((flag = strsep(&flag_delim, "^"))) {
+			while ((flag = strsep(&bi->flag_delim, "^"))) {
 				if (strcmp(flag, "traceoff") == 0) {
 					traceoff = true;
 				} else if ((strcmp(flag, "printk") == 0) ||
@@ -9765,35 +9840,35 @@ __init static void enable_instances(void)
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
@@ -9816,20 +9891,20 @@ __init static void enable_instances(void)
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
-			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
-				PTR_ERR(tr));
+			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n",
+				bi->name, PTR_ERR(tr));
 			continue;
 		}
 
@@ -9850,12 +9925,12 @@ __init static void enable_instances(void)
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
@@ -9864,11 +9939,12 @@ __init static void enable_instances(void)
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

