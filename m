Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4A36D515;
	Fri, 21 Nov 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708472; cv=none; b=Nv4W95Cp3joHWK+xPNnwjtS6qDIz6NHXj30kzpBYf2SIIN1VxJEuXEN5Ngqk0LCOMifznvYnhig0QMU335ucKLD0WGFbHmx/jyW0uFWKDeH5SoQ7KhF0qwCi/N64TDEgtat/j+ZEUMSb9W1qcqRWHA77Wo4hj/0zaoQVhG57jNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708472; c=relaxed/simple;
	bh=azMswd206Zarnuud75dMwenZXaEFRXu+fZNEEPZIEjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iV4+iW4rz7AG7qbhcOifhs/F9qxHR/Rj+tiwHvJ7Wn6iL1/MoBtSMlXeYbViSAZS749lYnFNDkIridLWn9ZijgWfwy32BSz3DEpATelVlabS5FdpBgPVJG4EDo12dIZCSSSKj+qqWfY2fZmV/GV+/26WgODXZGqr7BwWw6yBq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrJVPUzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrJVPUzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5490C4CEF1;
	Fri, 21 Nov 2025 07:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763708471;
	bh=azMswd206Zarnuud75dMwenZXaEFRXu+fZNEEPZIEjg=;
	h=From:To:Cc:Subject:Date:From;
	b=rrJVPUzfoa4wW92AylcNkdo5DlfaGM/lzyYlqoFxuNnVu2TDZBMfcYwv9opyv1G0P
	 ik7Jz93R+7VUMibiOa3IlW9uwXOBAjSqRnHXYpEoS7gsQWnKrbGBHwvQC3rQgp52K5
	 +jXs6DzXvLuTB9YlxWE5x4keXM4qLyBsq1Mnv8+8+kismiiTRUv033Zr0dHRWJLsNe
	 QVhBzIVI+wmFyeWhuL5Zy9Q+b8UwlwnBxIijQfljE3ioyuiX8AGjtwpJmrT6eIB7ny
	 pZs84CukK2e+tH6lIMTZiomi007gGeE7SRdPFG4z8eaLAT64aOETARzLyjFDdY+ZkR
	 QCjmlsVsg6TwQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Add boot-time backup of persistent ring buffer
Date: Fri, 21 Nov 2025 16:01:05 +0900
Message-ID:  <176370846529.314463.7508792463190591259.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
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

Currently, the persistent ring buffer instance needs to be read before
using it. This means we have to wait for boot up user space and dump
the persistent ring buffer. However, in that case we can not start
tracing on it from the kernel cmdline.

To solve this limitation, this adds an option which allows to create
a trace instance as a backup of the persistent ring buffer at boot.
If user specifies trace_instance=<BACKUP>=<PERSIST_RB> then the
<BACKUP> instance is made as a copy of the <PERSIST_RB> instance.

For example, the below kernel cmdline records all syscalls, scheduler
and interrupt events on the persistent ring buffer `boot_map` but
before starting the tracing, it makes a `backup` instance from the
`boot_map`. Thus, the `backup` instance has the previous boot events.

'reserve_mem=12M:4M:trace trace_instance=boot_map@trace,syscalls:*,sched:*,irq:* trace_instance=backup=boot_map'

As you can see, this just make a copy of entire reserved area and
make a backup instance on it. So you can release (or shrink) the
backup instance after use it to save the memory usage.

  /sys/kernel/tracing/instances # free
                total        used        free      shared  buff/cache   available
  Mem:        1999284       55704     1930520       10132       13060     1914628
  Swap:             0           0           0
  /sys/kernel/tracing/instances # rmdir backup/
  /sys/kernel/tracing/instances # free
                total        used        free      shared  buff/cache   available
  Mem:        1999284       40640     1945584       10132       13060     1929692
  Swap:             0           0           0

Note: since there is no reason to make a copy of empty buffer, this
backup only accepts a persistent ring buffer as the original instance.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.h |    1 +
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 33fcde91924c..616d24580371 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10523,6 +10523,8 @@ static int __remove_instance(struct trace_array *tr)
 		reserve_mem_release_by_name(tr->range_name);
 		kfree(tr->range_name);
 	}
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		vfree((void *)tr->range_addr_start);
 
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
@@ -11328,6 +11330,41 @@ __init static void do_allocate_snapshot(const char *name)
 static inline void do_allocate_snapshot(const char *name) { }
 #endif
 
+__init static int backup_instance_area(const char *backup,
+				       unsigned long *addr, phys_addr_t *size)
+{
+	struct trace_array *backup_tr;
+	void *allocated_vaddr = NULL;
+
+	backup_tr = trace_array_get_by_name(backup, NULL);
+	if (!backup_tr) {
+		pr_warn("Tracing: Instance %s is not found.\n", backup);
+		return -ENOENT;
+	}
+	if (!(backup_tr->flags & TRACE_ARRAY_FL_BOOT)) {
+		pr_warn("Tracing: Instance %s is not boot mapped.\n", backup);
+		trace_array_put(backup_tr);
+		return -EINVAL;
+	}
+
+	*size = backup_tr->range_addr_size;
+
+	allocated_vaddr = vzalloc(*size);
+	if (!allocated_vaddr) {
+		pr_warn("Tracing: Failed to allocate memory for copying instance %s (size 0x%lx)\n",
+			backup, (unsigned long)*size);
+		trace_array_put(backup_tr);
+		return -ENOMEM;
+	}
+
+	memcpy(allocated_vaddr,
+		(void *)backup_tr->range_addr_start, (size_t)*size);
+	*addr = (unsigned long)allocated_vaddr;
+
+	trace_array_put(backup_tr);
+	return 0;
+}
+
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
@@ -11350,11 +11387,15 @@ __init static void enable_instances(void)
 		char *flag_delim;
 		char *addr_delim;
 		char *rname __free(kfree) = NULL;
+		char *backup;
 
 		tok = strsep(&curr_str, ",");
 
-		flag_delim = strchr(tok, '^');
-		addr_delim = strchr(tok, '@');
+		name = strsep(&tok, "=");
+		backup = tok;
+
+		flag_delim = strchr(name, '^');
+		addr_delim = strchr(name, '@');
 
 		if (addr_delim)
 			*addr_delim++ = '\0';
@@ -11362,7 +11403,10 @@ __init static void enable_instances(void)
 		if (flag_delim)
 			*flag_delim++ = '\0';
 
-		name = tok;
+		if (backup) {
+			if (backup_instance_area(backup, &addr, &size) < 0)
+				continue;
+		}
 
 		if (flag_delim) {
 			char *flag;
@@ -11458,7 +11502,13 @@ __init static void enable_instances(void)
 			tr->ref++;
 		}
 
-		if (start) {
+		/*
+		 * Backup buffers can be freed but need vfree().
+		 */
+		if (backup)
+			tr->flags |= TRACE_ARRAY_FL_VMALLOC;
+
+		if (start || backup) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
 			tr->range_name = no_free_ptr(rname);
 		}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 58be6d741d72..9e5186c96e9c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -453,6 +453,7 @@ enum {
 	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
 	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
 	TRACE_ARRAY_FL_MEMMAP		= BIT(4),
+	TRACE_ARRAY_FL_VMALLOC		= BIT(5),
 };
 
 #ifdef CONFIG_MODULES

