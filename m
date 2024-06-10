Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D2558B6;
	Mon, 10 Jun 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054808; cv=none; b=NuUz1LzBwJ8pcWiVGnilERVpbnHCOGKE9EH4q9/At/7rnJtmy2VDrGnrWmge7Lz7OPas7vr7MKcpi2TwDlndfBi0WVy9CXh06ji+JlNB4vHBD+G+WqXPkDcve5/Zhcjqj1C0HmkAaLVJtBJXHxLueDy9by8yMmOwfBupwxVR0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054808; c=relaxed/simple;
	bh=QL5rT7N+ISlWd/pvL6F+/ctRFbGgbCKln0OxnnVMazE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPkgc+XluU8SjABYHKYv/hU9jRfQib6PbQuzD7D5E7ati1aRsgQmWfPSqa5aN34ZUQboARdeX5vsnOPsL95VOoAfJ/iKRGJ3RzDRsfzmUq8WYC0X4NjeP6OKEusTFmNl+cmPw5ABFjxcWmrJVyI0L8hnGGuwe7/EUjXtxmDBwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdpIci3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdpIci3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F78EC2BBFC;
	Mon, 10 Jun 2024 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718054807;
	bh=QL5rT7N+ISlWd/pvL6F+/ctRFbGgbCKln0OxnnVMazE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdpIci3f8xUj15jjffEBNkGvi8Cp6obeW1TSO+l3IVyjTBwrkdV68Up8srzTntYrH
	 N4ERmcEKu9CRsQIVtJM8MRFN7OXtkXdOuKvj60ZfNzYKl8LQgFtEa8GLgi6uKmfdMm
	 kr0xsBdGtNPPSiIScqbXnAcKgazTV6Mk2kk/MTlw5lZrw9iCX5Ld7xuQu0gbn4B60N
	 HqCIuzzTxDlBLg4QdoQtC3rR73TM7cKtzqwXKrG42La5j5apaNS35qSo9TkirpV7+p
	 vB0ut415iUf1l0kkFmKzhqDHodNRmi5IfhDSOYMBIGk2sAxboZG57wAg2wSPy+ds1k
	 Aga/IGZ7ogEyA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
Date: Tue, 11 Jun 2024 06:26:44 +0900
Message-Id: <171805480405.52471.13982671291270977479.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171805478534.52471.6269290579314514778.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
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

Since the kprobe-events selftest shows OK or NG with the reason, the
WARN_ON_ONCE()s for each place are redundant. Let's remove it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 16383247bdbf..4abed36544d0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2023,18 +2023,18 @@ static __init int kprobe_trace_self_tests_init(void)
 	pr_info("Testing kprobe tracing: ");
 
 	ret = create_or_delete_trace_kprobe("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)");
-	if (WARN_ON_ONCE(ret)) {
+	if (ret) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
 	} else {
 		/* Enable trace point */
 		tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
-		if (WARN_ON_ONCE(tk == NULL)) {
+		if (tk == NULL) {
 			pr_warn("error on getting new probe.\n");
 			warn++;
 		} else {
 			file = find_trace_probe_file(tk, top_trace_array());
-			if (WARN_ON_ONCE(file == NULL)) {
+			if (file == NULL) {
 				pr_warn("error on getting probe file.\n");
 				warn++;
 			} else
@@ -2044,18 +2044,18 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	ret = create_or_delete_trace_kprobe("r:testprobe2 kprobe_trace_selftest_target $retval");
-	if (WARN_ON_ONCE(ret)) {
+	if (ret) {
 		pr_warn("error on probing function return.\n");
 		warn++;
 	} else {
 		/* Enable trace point */
 		tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
-		if (WARN_ON_ONCE(tk == NULL)) {
+		if (tk == NULL) {
 			pr_warn("error on getting 2nd new probe.\n");
 			warn++;
 		} else {
 			file = find_trace_probe_file(tk, top_trace_array());
-			if (WARN_ON_ONCE(file == NULL)) {
+			if (file == NULL) {
 				pr_warn("error on getting probe file.\n");
 				warn++;
 			} else
@@ -2079,7 +2079,7 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	/* Disable trace points before removing it */
 	tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
-	if (WARN_ON_ONCE(tk == NULL)) {
+	if (tk == NULL) {
 		pr_warn("error on getting test probe.\n");
 		warn++;
 	} else {
@@ -2089,7 +2089,7 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 
 		file = find_trace_probe_file(tk, top_trace_array());
-		if (WARN_ON_ONCE(file == NULL)) {
+		if (file == NULL) {
 			pr_warn("error on getting probe file.\n");
 			warn++;
 		} else
@@ -2098,7 +2098,7 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
-	if (WARN_ON_ONCE(tk == NULL)) {
+	if (tk == NULL) {
 		pr_warn("error on getting 2nd test probe.\n");
 		warn++;
 	} else {
@@ -2108,7 +2108,7 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 
 		file = find_trace_probe_file(tk, top_trace_array());
-		if (WARN_ON_ONCE(file == NULL)) {
+		if (file == NULL) {
 			pr_warn("error on getting probe file.\n");
 			warn++;
 		} else
@@ -2117,20 +2117,20 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 	ret = create_or_delete_trace_kprobe("-:testprobe");
-	if (WARN_ON_ONCE(ret)) {
+	if (ret) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
 	ret = create_or_delete_trace_kprobe("-:testprobe2");
-	if (WARN_ON_ONCE(ret)) {
+	if (ret) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
 end:
 	ret = dyn_events_release_all(&trace_kprobe_ops);
-	if (WARN_ON_ONCE(ret)) {
+	if (ret) {
 		pr_warn("error on cleaning up probes.\n");
 		warn++;
 	}

