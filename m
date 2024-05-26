Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA6DF43;
	Sun, 26 May 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718279; cv=none; b=jld+KnIFH5zAhPAy0RLDyJoTsby5/5jbQK3zlVDPMEbSgoDdZaiAYyMHGwgAGrq8rt7xfeKhqBJHQ4h0zcIJVASOBiDypBwWBEYCm54CcpORDafB5I3rHH31MnGHyO4zfGAfU7TgLtOIMD3SVMcYRTTTreySQDfkhQigXQzieTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718279; c=relaxed/simple;
	bh=QL5rT7N+ISlWd/pvL6F+/ctRFbGgbCKln0OxnnVMazE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAX1ACR/juGxmVV3x/HufASYAaHMvvu3GgVN1QiAxmidId/yVNHTTE2cEcsA9+j/D9MMqyA6KCTrki4V8Q8YS2buSQLN9e35VbSvbn5u8qdotlkPIjFp7mAVIbtdOj11ajvNytYwqs5qBNpJ4i9CORsYQfMeqxyisFtro2+W8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce5WG25y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce5WG25y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3835EC2BD10;
	Sun, 26 May 2024 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716718278;
	bh=QL5rT7N+ISlWd/pvL6F+/ctRFbGgbCKln0OxnnVMazE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce5WG25yRIgbFyzxZs6M6E9qccNFLpevuNQNaBP82/NcklOnJlcI0tlaTtMIsz/7d
	 +HLPPgDiqfR6Oe9t5yKABuq5oQ/qqAFANjeWLhH3spPcYmn0UisN06hawyUKD1diPm
	 g5uPQw5hQ8M759k57A0KQn69g3FTL851qj1GBompO2+HPMGFd40IkuMkifCuLYxw0R
	 8w4347iCxmXRoskWoJDfmHqHPqrm249y0b4k58SEs4BauB2cv60cClZd8VMI4qsIQB
	 16NJmPIQH+IoYFWtG1psHI4+oxFg3xV84w6VHnctob7+07mpv00c+IkIbjIWokUwRd
	 XHMVaOwABiGvA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
Date: Sun, 26 May 2024 19:11:14 +0900
Message-Id: <171671827473.39694.17352493351563662948.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171671825710.39694.6859036369216249956.stgit@devnote2>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
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

