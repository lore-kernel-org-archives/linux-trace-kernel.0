Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D31EA71;
	Tue, 11 Jun 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112651; cv=none; b=PgRQ8fGMyfEMbq40GFBY4EfW8icvfQllIx4w/JStg1uQYhnMFC12lWwxd7Ag1wEMh7V6VYNde/pPe02l+VTaYquNpp2lkqDdj/ywR55wNwzir/DQgO5zrojX73IPIskCZB20zI5vQCLcfXsGP8ssBTqLh0715B+5hImnGuBMLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112651; c=relaxed/simple;
	bh=UGXI1foWNkX1CtbMA7xI1y2o5zHE8fPmybVoBCkZGpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UowL7xanRtl9dO/xMFZ5HLHJKsMLFBzWjjUaoznUSKxumk/LGKvXKt/yy1N9Q7huwhxoC/XCQ3/S4whOCG024T45+palSfhBnANqWq3E8B7q0DMgtU+fsFRozLD0f+okAnpECxCLgoawMmalvvKFlyjQDmN5WM7bKH4nTI/AQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYq9LzV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYq9LzV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81114C2BD10;
	Tue, 11 Jun 2024 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112650;
	bh=UGXI1foWNkX1CtbMA7xI1y2o5zHE8fPmybVoBCkZGpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYq9LzV0UrQ6rFgge/s5761haf2UJ89dzXxLFB6ypXbxMM+DoEllbt7ieVww/xfJw
	 JN5064FF+yjyl9hTb8B9I8+dFUfvmxd9eAfTQGGZbW0VuQKWEP2RtqrTN4qG4hspg8
	 Z67MVG2KutNA843Iht+QRQZhyz/gEF7edVEtxvEnouu1zL+6HqYlDazLnyIpA9pNUh
	 fos0kryqw+v2njnuyAwPE5GT5b0ibfwBRRlPq/beodQc1G7pNdFaNvcpO0MeVoE3T9
	 QV/4jQ+WaTyeJp8DxBajHEzT1/iwWpAoP1HArzsSeZt55dK+i67Qm3jmuFF1+xGtCp
	 gaZZxwU4ni2/w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3 2/3] tracing/kprobe: Integrate test warnings into WARN_ONCE
Date: Tue, 11 Jun 2024 22:30:46 +0900
Message-Id: <171811264685.85078.8068819097047430463.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171811262833.85078.12421348187962271050.stgit@devnote2>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
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

Cleanup the redundant WARN_ON_ONCE(cond) + pr_warn(msg) into
WARN_ONCE(cond, msg). Also add some WARN_ONCE() for hitcount check.
These WARN_ONCE() errors makes it easy to handle errors from ktest.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - integrate WARN_ON_ONCE() and pr_warn() instead of remove
    WARN_ONCE().
---
 kernel/trace/trace_kprobe.c |   54 +++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 16383247bdbf..8c5816c04bd2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2023,19 +2023,16 @@ static __init int kprobe_trace_self_tests_init(void)
 	pr_info("Testing kprobe tracing: ");
 
 	ret = create_or_delete_trace_kprobe("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)");
-	if (WARN_ON_ONCE(ret)) {
-		pr_warn("error on probing function entry.\n");
+	if (WARN_ONCE(ret, "error on probing function entry.")) {
 		warn++;
 	} else {
 		/* Enable trace point */
 		tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
-		if (WARN_ON_ONCE(tk == NULL)) {
-			pr_warn("error on getting new probe.\n");
+		if (WARN_ONCE(tk == NULL, "error on probing function entry.")) {
 			warn++;
 		} else {
 			file = find_trace_probe_file(tk, top_trace_array());
-			if (WARN_ON_ONCE(file == NULL)) {
-				pr_warn("error on getting probe file.\n");
+			if (WARN_ONCE(file == NULL, "error on getting probe file.")) {
 				warn++;
 			} else
 				enable_trace_kprobe(
@@ -2044,19 +2041,16 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	ret = create_or_delete_trace_kprobe("r:testprobe2 kprobe_trace_selftest_target $retval");
-	if (WARN_ON_ONCE(ret)) {
-		pr_warn("error on probing function return.\n");
+	if (WARN_ONCE(ret, "error on probing function return.")) {
 		warn++;
 	} else {
 		/* Enable trace point */
 		tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
-		if (WARN_ON_ONCE(tk == NULL)) {
-			pr_warn("error on getting 2nd new probe.\n");
+		if (WARN_ONCE(tk == NULL, "error on getting 2nd new probe.")) {
 			warn++;
 		} else {
 			file = find_trace_probe_file(tk, top_trace_array());
-			if (WARN_ON_ONCE(file == NULL)) {
-				pr_warn("error on getting probe file.\n");
+			if (WARN_ONCE(file == NULL, "error on getting probe file.")) {
 				warn++;
 			} else
 				enable_trace_kprobe(
@@ -2079,18 +2073,15 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	/* Disable trace points before removing it */
 	tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
-	if (WARN_ON_ONCE(tk == NULL)) {
-		pr_warn("error on getting test probe.\n");
+	if (WARN_ONCE(tk == NULL, "error on getting test probe.")) {
 		warn++;
 	} else {
-		if (trace_kprobe_nhit(tk) != 1) {
-			pr_warn("incorrect number of testprobe hits\n");
+		if (WARN_ONCE(trace_kprobe_nhit(tk) != 1,
+				 "incorrect number of testprobe hits."))
 			warn++;
-		}
 
 		file = find_trace_probe_file(tk, top_trace_array());
-		if (WARN_ON_ONCE(file == NULL)) {
-			pr_warn("error on getting probe file.\n");
+		if (WARN_ONCE(file == NULL, "error on getting probe file.")) {
 			warn++;
 		} else
 			disable_trace_kprobe(
@@ -2098,18 +2089,15 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
-	if (WARN_ON_ONCE(tk == NULL)) {
-		pr_warn("error on getting 2nd test probe.\n");
+	if (WARN_ONCE(tk == NULL, "error on getting 2nd test probe.")) {
 		warn++;
 	} else {
-		if (trace_kprobe_nhit(tk) != 1) {
-			pr_warn("incorrect number of testprobe2 hits\n");
+		if (WARN_ONCE(trace_kprobe_nhit(tk) != 1,
+				 "incorrect number of testprobe2 hits."))
 			warn++;
-		}
 
 		file = find_trace_probe_file(tk, top_trace_array());
-		if (WARN_ON_ONCE(file == NULL)) {
-			pr_warn("error on getting probe file.\n");
+		if (WARN_ONCE(file == NULL, "error on getting probe file.")) {
 			warn++;
 		} else
 			disable_trace_kprobe(
@@ -2117,23 +2105,19 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	ret = create_or_delete_trace_kprobe("-:testprobe");
-	if (WARN_ON_ONCE(ret)) {
-		pr_warn("error on deleting a probe.\n");
+	if (WARN_ONCE(ret, "error on deleting a probe."))
 		warn++;
-	}
 
 	ret = create_or_delete_trace_kprobe("-:testprobe2");
-	if (WARN_ON_ONCE(ret)) {
-		pr_warn("error on deleting a probe.\n");
+	if (WARN_ONCE(ret, "error on deleting a probe."))
 		warn++;
-	}
+
 
 end:
 	ret = dyn_events_release_all(&trace_kprobe_ops);
-	if (WARN_ON_ONCE(ret)) {
-		pr_warn("error on cleaning up probes.\n");
+	if (WARN_ONCE(ret, "error on cleaning up probes."))
 		warn++;
-	}
+
 	/*
 	 * Wait for the optimizer work to finish. Otherwise it might fiddle
 	 * with probes in already freed __init text.

