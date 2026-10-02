Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D683A7839;
	Fri,  2 Oct 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919864; cv=none; b=pvwY3PCdgs6ub+ZrDsHsNx88FcWd+Pk1xZ3SxOj9HgZxbDZe5NcOdOa9oaPHq1SOHwYUJswO3gAuHpFWRl7rMwJFKuUWV+90C4aQH2mfQijoQs9mG4tzBwMi7168kjf4Umq3U/8EbQfvPPWjLk/WVO5bCRrH6jIwRW63O/ZGvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919864; c=relaxed/simple;
	bh=7E+fQcwTKr6JgXtc4DzPUyUMg8oKvYVHXPzXHbgnRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBiH+qj4aOEHU0RPqBRLIGFew3WDj2xbf6TcJrwlt605Nue7yJSUn6FaI95eyvDUTn2ixvEwoyZajixqdAM9Wbgr3hwRq3lBgKmFQRbfd6ImdZ419MBFYXkS1oM8eJ0Bm2OmOu7lnuF//dOH+mElll5Q8Wo3ahF4fnkCP+3f9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKRJop7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKRJop7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAF11F000FF;
	Fri,  2 Oct 2026 05:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790919863;
	bh=28+dxyPShePBclgXYjozqJYOsOZbYNAMbiqS7GfSRYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKRJop7zxViVzlQ85wmcnkTvMV4dJWlgemKkZ2Bkw0nz0mX6Qx8/LJWNU6fWqAYMJ
	 4wgCF+0wrS6nxW/S9nxVsp0vjJ20xDyK6GLouYwdAm+hHRoW5uHds0VQ5z1zM6GVdC
	 4mVQDPZEAcyHsEWYJCQg+pAn//YffNQK8S52ahE2f9FdTLKJSRbKOWbW3Q6S0/S+HL
	 46sWxGsDVSqncgWSfRzGGXTSmpXqTZ9sjG22Lg2pZ2jOgOJkpybG4W3lirc4RCkHb/
	 DVkXbXuclFtdQl20r77PD965lZUHbE0xB8/sgTTKJBHF+sxjRxFA67d0fdlfRc24G5
	 0NfJdDb+1aPUw==
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
Subject: [PATCH v2 1/2] tracing: Override the same name trace_instance= by latter one
Date: Fri,  2 Oct 2026 14:44:18 +0900
Message-ID: <179091985884.537422.15845141877166136300.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179091984881.537422.15308457677039592540.stgit@devnote2>
References: <179091984881.537422.15308457677039592540.stgit@devnote2>
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
 kernel/trace/trace.c                            |  130 ++++++++++++++++-------
 3 files changed, 114 insertions(+), 38 deletions(-)

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
index e4a490d3d08c..4590d3896945 100644
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
@@ -9705,33 +9707,42 @@ __init static int backup_instance_area(const char *backup,
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
@@ -9743,20 +9754,62 @@ __init static void enable_instances(void)
 		if (flag_delim)
 			*flag_delim++ = '\0';
 
-		if (trace_array_find(name)) {
-			pr_warn("Tracing: Instance %s already exists\n", name);
-			continue;
+		for (i = 0; i < idx; i++) {
+			/* Override by the last defined instance */
+			if (!strcmp(name, boot_instances[i].name))
+				break;
 		}
 
-		if (backup) {
-			if (backup_instance_area(backup, &addr, &size) < 0)
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
@@ -9765,35 +9818,35 @@ __init static void enable_instances(void)
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
@@ -9816,20 +9869,20 @@ __init static void enable_instances(void)
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
 
@@ -9850,12 +9903,12 @@ __init static void enable_instances(void)
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
@@ -9864,11 +9917,12 @@ __init static void enable_instances(void)
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

