Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436F156677;
	Tue, 22 Jul 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218497; cv=none; b=rkUits87dkZ9b8TbCIVK+oKINSaewtkgAKmXiI+66y7UH7EcvAAZKb+7KyTeTStwIVsrMmC0LRImG+L2lftFlmVlvTqgdCkajRfHTpiJfiEQ7A7jNSiX7QITr2c4SViFZRkEHqdjKaz3shsfDxtpF9kwIFzIlYzxrHFbP83xu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218497; c=relaxed/simple;
	bh=0QiBRgGwvjCuCX8kb0kVm0xQWdttx6I/T7Itq+8XYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d26yFifyED2Ppopc2vudX/K5uhNa0jNaIy/lWNspApR5t8lCrEa1FHuDC8/UH4bFY+MKLWIREap4V7inwVFrQ9XToZoOXhFNW1Xl3qr1rWNr8xMO8DNSKpNQ/U4bV1bB/xtl227V65L7rujjrw8cwvwz4rD+gcZNOhNd2u7FF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6B0C8112D11;
	Tue, 22 Jul 2025 21:08:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B58E731;
	Tue, 22 Jul 2025 21:08:07 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:08:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, "linux-trace-users@vger.kernel.org"
 <linux-trace-users@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Arnaldo Carvalho de Melo <acme@kernel.org>, Frederic
 Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: [RESEND][PATCH v3] tracing: Deprecate auto-mounting tracefs in
 debugfs
Message-ID: <20250722170806.40c068c6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f5b1gffxfp433okad4njjbxpjxf88ub9
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B58E731
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+0rDTvL5ctrPISeOmyVD1ODfdNFO0Mvw4=
X-HE-Tag: 1753218487-586842
X-HE-Meta: U2FsdGVkX18pxv3p7s3sTPJP1pPeiaLUvO/CmMUtfuD0IHQDMK9HG0cVd5GuMaNBMk4BQYlCkN0XiPt+zYhFxF+Xe26CAbOJEg1NINgvr5OlO/UBedyy8XzyuNOddg3D2wQka3jvWPGCOkMTkaowYaXdtjRcxsuTyKKea4CLs/4PkEIWNYncJSpmdMUeo7Y+OST7mRkx/hVn7SOLyC4vFVMxkMEtn9Gx344HrPVS4KNGsVVgiU+J0FVF16GuRR00FdmDBzIgu3yqndgHm3icSDng7RJq0FB+nVS97vCstdiQSMEsIEzwUufR8iu6TSqQrHWCprbnQ5sqW/QaQgd73FJSCRBq2EPK9mXH3GYK4Pnx3BFRIqINRXCBnHt3BSz8GJvuRq8A/eXdLBNB06PQPg==

From: Steven Rostedt <rostedt@goodmis.org>

In January 2015, tracefs was created to allow access to the tracing
infrastructure without needing to compile in debugfs. When tracefs is
configured, the directory /sys/kernel/tracing will exist and tooling is
expected to use that path to access the tracing infrastructure.

To allow backward compatibility, when debugfs is mounted, it would
automount tracefs in its "tracing" directory so that tooling that had hard
coded /sys/kernel/debug/tracing would still work.

It has been over 10 years since the new interface was introduced, and all
tooling should now be using it. Start the process of deprecating the old
path so that it doesn't need to be maintained anymore.

A new config is added to allow distributions to disable automounting of
tracefs on debugfs.

If /sys/kernel/debug/tracing is accessed, a pr_warn() will trigger stating:

"NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030"

Expect to remove this feature in 5 years (2030).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

[ RESEND due to using old address for Jiri Olsa that was on my laptop ]

Changes since v2: https://lore.kernel.org/20250617162625.1d44862b@gandalf.local.home

- Change the time to remove it from 2 to 5 years, as that should
  hopefully be plenty enough.


 .../ABI/obsolete/automount-tracefs-debugfs    | 20 +++++++++++++++++++
 kernel/trace/Kconfig                          | 13 ++++++++++++
 kernel/trace/trace.c                          | 14 +++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/automount-tracefs-debugfs

diff --git a/Documentation/ABI/obsolete/automount-tracefs-debugfs b/Documentation/ABI/obsolete/automount-tracefs-debugfs
new file mode 100644
index 000000000000..8d03cf9e579f
--- /dev/null
+++ b/Documentation/ABI/obsolete/automount-tracefs-debugfs
@@ -0,0 +1,20 @@
+What:		/sys/kernel/debug/tracing
+Date:		May 2008
+KernelVersion:	2.6.27
+Contact:	linux-trace-kernel@vger.kernel.org
+Description:
+
+	The ftrace was first added to the kernel, its interface was placed
+	into the debugfs file system under the "tracing" directory. Access
+	to the files were in /sys/kernel/debug/tracing. As systems wanted
+	access to the tracing interface without having to enable debugfs, a
+	new interface was created called "tracefs". This was a stand alone
+	file system and was usually mounted in /sys/kernel/tracing.
+
+	To allow older tooling to continue to operate, when mounting
+	debugfs, the tracefs file system would automatically get mounted in
+	the "tracing" directory of debugfs. The tracefs interface was added
+	in January 2015 in the v4.1 kernel.
+
+	All tooling should now be using tracefs directly and the "tracing"
+	directory in debugfs should be removed by January 2030.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c2ce834313a9..a3ae11beafb2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -194,6 +194,19 @@ menuconfig FTRACE
 
 if FTRACE
 
+config TRACEFS_AUTOMOUNT_DEPRECATED
+	bool "Automount tracefs on debugfs [DEPRECATED]"
+	depends on TRACING
+	default y
+	help
+	  The tracing interface was moved from /sys/kernel/debug/tracing
+	  to /sys/kernel/tracing in 2015, but the tracing file system
+	  was still automounted in /sys/kernel/debug for backward
+	  compatibility with tooling.
+
+	  The new interface has been around for more than 10 years and
+	  the old debug mount will soon be removed.
+
 config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
 	depends on TRACING
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..2dafe2748b16 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6303,7 +6303,7 @@ static bool tracer_options_updated;
 static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
-	if (!tr->dir)
+	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
 		return;
 
 	/* Only create trace option files after update_tracer_options finish */
@@ -8984,13 +8984,13 @@ static inline __init int register_snapshot_cmd(void) { return 0; }
 
 static struct dentry *tracing_get_dentry(struct trace_array *tr)
 {
-	if (WARN_ON(!tr->dir))
-		return ERR_PTR(-ENODEV);
-
 	/* Top directory uses NULL as the parent */
 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return NULL;
 
+	if (WARN_ON(!tr->dir))
+		return ERR_PTR(-ENODEV);
+
 	/* All sub buffers have a descriptor */
 	return tr->dir;
 }
@@ -10256,6 +10256,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 {
 	struct vfsmount *mnt;
@@ -10277,6 +10278,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
+	pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030\n");
+
 	ret = vfs_parse_fs_string(fc, "source",
 				  "tracefs", strlen("tracefs"));
 	if (!ret)
@@ -10287,6 +10290,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	put_fs_context(fc);
 	return mnt;
 }
+#endif
 
 /**
  * tracing_init_dentry - initialize top level trace array
@@ -10311,6 +10315,7 @@ int tracing_init_dentry(void)
 	if (WARN_ON(!tracefs_initialized()))
 		return -ENODEV;
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 	/*
 	 * As there may still be users that expect the tracing
 	 * files to exist in debugfs/tracing, we must automount
@@ -10319,6 +10324,7 @@ int tracing_init_dentry(void)
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
+#endif
 
 	return 0;
 }
-- 
2.47.2

