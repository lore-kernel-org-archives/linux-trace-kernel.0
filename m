Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8A2BE023;
	Fri, 18 Jul 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838496; cv=none; b=skP5no6RIKIrJXde7HNxaSFuZV2WGVBQppDyPwvaoNJR51yej+kwXLT0yAYLbSkhSH3eeJFlH1jUGMJSzw0Lmhd6uL5FEyQUaVwp4F80pyugUmD8TXllA6frdPWFZRA4LtwMN99Q1dKVZa+oCJes7MlNXT7Ht8io8wDZusQ3jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838496; c=relaxed/simple;
	bh=qyRKxjwTN7xtPYNLZgbxC3CFLiEFgy61lESI3NNCjcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7WBOgEBs/k5gD1B0EHfzYiXZ9fVmvB7qYbBVvN4iBH1eKlKBgTr7Bx3/AtvC1hekGLqoW6SNXLQR//dTF8LEIgC/O9KfTWiR0Gmd3xbmPoxzbW2BrOJz/ynssZzCNQAuwY80plSPHrv+cgqRoK9SWyfvlqnHZiXrsbR3FAjOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/H/KfUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/H/KfUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE7C4CEEB;
	Fri, 18 Jul 2025 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838496;
	bh=qyRKxjwTN7xtPYNLZgbxC3CFLiEFgy61lESI3NNCjcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/H/KfUWNzM1EgpJK5sJTRrRYAF+KAKTpDspd/mMo/aB578qJvCvVXsH5oo1E8Wkc
	 PtgIqlTxBZSW/YmWaQ02mZcHvJgkY4ShGwv4TpEg01hgrwHiEKYt1DwC0SjNiGKF50
	 cLL2iF7hrBdbFw8bsYXqCLsE1chvS8IF3oDeicWr1LJ1/KIwbH749M54L5lCFNm6Lc
	 UCGAAwjjiE8nRfUr9As43UmjOJCdU+YLnqlNm6TCF4iam5mtK+sBV0QdNnTISLwSy7
	 j8nj7yGNIjzPSmMq8deALahXxeEJhcfhacqAQRCwotfHRu69PA/sgPgkmThzhdxhl6
	 dO+fdhzkOImpQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/5] tracing: uprobe-event: Allocate string buffers from heap
Date: Fri, 18 Jul 2025 20:34:51 +0900
Message-ID: <175283849142.343578.11299469553352925660.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175283843771.343578.8524137568048302760.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
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

Allocate temporary string buffers for parsing uprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1fd479718d03..17124769e254 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/security.h>
 #include <linux/ctype.h>
@@ -19,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/percpu.h>
 
+#include "trace.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
@@ -538,15 +540,15 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 static int __trace_uprobe_create(int argc, const char **argv)
 {
 	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
-	struct trace_uprobe *tu;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
 	char *arg, *filename, *rctr, *rctr_end, *tmp;
-	char buf[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
-	enum probe_print_type ptype;
-	struct path path;
 	unsigned long offset, ref_ctr_offset;
+	char *gbuf __free(kfree) = NULL;
+	char *buf __free(kfree) = NULL;
+	enum probe_print_type ptype;
+	struct trace_uprobe *tu;
 	bool is_return = false;
+	struct path path;
 	int i, ret;
 
 	ref_ctr_offset = 0;
@@ -654,6 +656,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	/* setup a probe */
 	trace_probe_log_set_index(0);
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf) {
+			ret = -ENOMEM;
+			goto fail_address_parse;
+		}
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
@@ -674,6 +681,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		if (ptr)
 			*ptr = '\0';
 
+		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto fail_address_parse;
+		}
 		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
 		event = buf;
 		kfree(tail);

