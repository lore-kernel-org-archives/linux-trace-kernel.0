Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88803DEAC0;
	Mon, 20 Jul 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544287; cv=none; b=Kr+UEoSsPxPCnYLV7RYzafrUYelS+SkHX5C0sCgnbwVEnP//GobnEGAL2nxx4j5n4wKIBOxYKwaS6LXzgAdK8fRZmRN/jguoxJVP6J0WDZSWTulFcUT0rUv04+cvP6w/G0zLe6IgBrbiz0mn9j+QMRepUBV4vlW5Gw2Fp8v5K14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544287; c=relaxed/simple;
	bh=aA+R0IiYHA0OfmjHLL3+6BUYT0Y/6KxI8s9ffIHr1bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhLizv2Nj0JsJuV1Ecl0NkkdZLtEjVDFdXxkBCUZwJVLEBjyYH+hNLqAVn+mS87Y73qhzgZAVDU+2kH25rzmAvHWJVhJXnx+pjuNDkNmKYRDN7SYvSYcwKWHzWzBKQHz0LO8tLpiICNk4oUFun0YKVycQKF7/3MaUhl+WmtVG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3OZ8/x8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3OZ8/x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67FF1F00A3A;
	Mon, 20 Jul 2026 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544278;
	bh=iopxLIu1LWBuR4o+YVogozwucUAvF1mqRMs64bfaww8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3OZ8/x8NCYEv4s6gBtJ8PWYV0XWE+byoz+Zk0hjD7bJRmJo4XPVHKYVF7zC2JGt2
	 fYK5/UMRmhwO/xbWGUZD9RUwkOzpR07G+SFJvjNXZRRFzpzUuw7TkgeKPj8CdqD6wc
	 IqMLCKx8mxD+4P3oOdkeZ1EjBr6AHkBhYNLqEWxXrPhLgG5q8oHR+xqS5mHq5SM60f
	 VG5fmugsydGbOJvBvNYpk7hVoKvG6IHs8NRs199CBzyzRSRbQAID9mT+QB+qgZmRIl
	 C7AyWZeZ4kVQAGK018N5txmA7HpYBEkNeHN25ZPztIu3jkoYrLJvxaaw+e9igRwbIB
	 elw/ilM88vJug==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 07/10] tracing/fprobe: Remove redundant snprintf in trace_fprobe_match_command_head()
Date: Mon, 20 Jul 2026 19:44:34 +0900
Message-ID: <178454427449.296567.12336315661120939938.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
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

trace_fprobe_match_command_head() copies trace_fprobe_symbol(tf) into a
local buffer 'buf' of size MAX_COMMON_HEAD_LEN + 1 using snprintf before
comparing with argv[0].

Since trace_fprobe_symbol(tf) already returns a null-terminated string,
comparing it directly with argv[0] via strcmp() avoids stack buffer usage
and potential symbol truncation at MAX_COMMON_HEAD_LEN.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 5638a90e61cc..566b64853c61 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -238,13 +238,10 @@ static bool trace_fprobe_is_busy(struct dyn_event *ev)
 static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
 					    int argc, const char **argv)
 {
-	char buf[MAX_COMMON_HEAD_LEN + 1];
-
 	if (!argc)
 		return true;
 
-	snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
-	if (strcmp(buf, argv[0]))
+	if (strcmp(trace_fprobe_symbol(tf), argv[0]))
 		return false;
 	argc--; argv++;
 

