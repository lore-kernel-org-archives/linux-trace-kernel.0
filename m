Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29260282F5;
	Tue, 22 Jul 2025 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221702; cv=none; b=GPqBDUEigLuOD1oj6JaqrjHEWA0exwtDxPswkz2Y/q1aSI38zXRURHxEBdTqHcInsoj7VPFM57cfBhMeN6YLB8KqtIiatNr0CYEwRcwso4bri6EFOxKAnxn9HhxySbMxs1WXRGI/0E53DnKNHIOmSKD0UnD3o9zrkB4zExa+/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221702; c=relaxed/simple;
	bh=9/BE9hurBedeM2z86Blmg+TQ7LrJEFOGlOX5tOPf8rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li3QLH7rH52cS6CKCtQOZAUEzTHPwwjIhou7Ot0dzodrrHH4xt8ec5vAwAE/9RSOQrXyetLImpl4QdNH/6uGJxTYGa5HcclvOdqkKFuNA9jSPJrhOMpfvgeJ6TYSSbc0vYPwcdhsvqc0C2sZjhIFkaTnZxf/glqDCFjWoUkDoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kklo3Aw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kklo3Aw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D24C4CEEB;
	Tue, 22 Jul 2025 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221700;
	bh=9/BE9hurBedeM2z86Blmg+TQ7LrJEFOGlOX5tOPf8rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kklo3Aw4/DyzE7ZS4G4YO6jmvXAzVDODzWp5+XEOeqV+RPFJ3B60TDV7fxLDU1AN7
	 EFVWmxlPMxBgSqbcmMWCYtvy+9q6h6EogyYmtCnJFG0Y2hjC+WJ+ZcnZbIxb+DJWfm
	 55fkVhykz7BaTIICwGog9CdUIu3VmM/QGZvU0zsAtUqbhfIVaWuf1dmc6znifYmapn
	 kCJDyafPACXFA86LGXPKzW1vuiWzgkCPHNLBakbNJ+rabW9nqUMgaG0nKuRK/BBCdx
	 1+VHFjrUprOWPrKydhRWvvvs4A13hUZ7DH5FzV3+SOB0fuWgBdcpBnuhNyBN0oh0or
	 E3ycksFzdHvhw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] tracing: probes: Sort #include alphabetically
Date: Wed, 23 Jul 2025 07:01:36 +0900
Message-ID: <175322169649.44400.17852098236914311512.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175322168606.44400.9155291012158349647.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
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

Sort the #include directives in trace_probe* files alphabetically for
easier maintenance and avoid double includes.
This also groups headers as linux-generic, asm-generic, and local
headers.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 kernel/trace/trace_eprobe.c |    4 ++--
 kernel/trace/trace_fprobe.c |    3 ++-
 kernel/trace/trace_kprobe.c |    8 ++++----
 kernel/trace/trace_probe.c  |    2 +-
 kernel/trace/trace_probe.h  |   17 +++++++++--------
 kernel/trace/trace_uprobe.c |   12 ++++++------
 6 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 916555f0de81..23e06712bead 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -9,14 +9,14 @@
  * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
  *
  */
+#include <linux/ftrace.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/ftrace.h>
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
 #include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
 
 #define EPROBE_EVENT_SYSTEM "eprobes"
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index dbf9d413125a..add08ffb04d7 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2022 Google LLC.
  */
 #define pr_fmt(fmt)	"trace_fprobe: " fmt
-#include <asm/ptrace.h>
 
 #include <linux/fprobe.h>
 #include <linux/list.h>
@@ -15,6 +14,8 @@
 #include <linux/tracepoint.h>
 #include <linux/uaccess.h>
 
+#include <asm/ptrace.h>
+
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3e5c47b6d7b2..cac128a5f7e0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -9,19 +9,19 @@
 
 #include <linux/bpf-cgroup.h>
 #include <linux/cleanup.h>
-#include <linux/security.h>
+#include <linux/error-injection.h>
 #include <linux/module.h>
-#include <linux/uaccess.h>
 #include <linux/rculist.h>
-#include <linux/error-injection.h>
+#include <linux/security.h>
+#include <linux/uaccess.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
 #include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index abfab8957a6c..9d26d901c9e5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -13,8 +13,8 @@
 
 #include <linux/bpf.h>
 #include <linux/fs.h>
-#include "trace_btf.h"
 
+#include "trace_btf.h"
 #include "trace_probe.h"
 
 #undef C
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 854e5668f5ee..719604855279 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -10,20 +10,21 @@
  * Author:     Srikar Dronamraju
  */
 
+#include <linux/bitops.h>
+#include <linux/btf.h>
+#include <linux/kprobes.h>
+#include <linux/limits.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/tracefs.h>
-#include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/perf_event.h>
-#include <linux/kprobes.h>
 #include <linux/stringify.h>
-#include <linux/limits.h>
+#include <linux/tracefs.h>
+#include <linux/types.h>
 #include <linux/uaccess.h>
-#include <linux/bitops.h>
-#include <linux/btf.h>
+
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f95a2c3d5b1b..3cc3404b09f0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -8,16 +8,16 @@
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/bpf-cgroup.h>
-#include <linux/security.h>
 #include <linux/ctype.h>
+#include <linux/filter.h>
 #include <linux/module.h>
-#include <linux/uaccess.h>
-#include <linux/uprobes.h>
 #include <linux/namei.h>
-#include <linux/string.h>
-#include <linux/rculist.h>
-#include <linux/filter.h>
 #include <linux/percpu.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uprobes.h>
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"

