Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF963DEFE7;
	Mon, 20 Jul 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542349; cv=none; b=X3N0CPRPZEjkDq16I9MdpEHafYveolXsHdZwFFn9rYp9dKTrARmqOIsrMLwOrK+wmu2miKG1j9ebNKwq7xliUpW+ySsN0Ha7PkTYjD+CPSMuWwJDjNMY0QYGCT1jVFFZRiwUXrqVFLoHIb5z7d08GXE5O6KNO9xlZUMpAJjWr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542349; c=relaxed/simple;
	bh=nW1XWdnCO2/couf4O46tAqF5rrEEQ3N4ykGS5f5lubw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mctbGpep1VW4Y5SDMRBU2lIPd/xgw3KiWkZkwSHijkTs41InyKTTfLjla0nsC1knQTSXM7zca+mr3OizsuXjy5+xTdanXnc6jLYuhWLv9rvE/oAnJDDbUki/Y1LWTeffjClDE6EJUAjOM4pdbMVtTWARcdVVEA6NkUqFp9RPQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDP8MkhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDP8MkhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53601F00A3A;
	Mon, 20 Jul 2026 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542334;
	bh=YxV8jmxvGTn0ml/JttIpiyp/M5Pb/0W7C9FqCS1HgJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDP8MkhQagpBIZQK7vUKYt5uebHK+jlhFR7ZQHGbats8m3XbS7Igc97RJ82L3Qcc2
	 I7LSt2uj27nBRJD0KYO7RIeHdp8CKMg2HkUYW5WGkmoOfjl+VIsiTgRkzIIrUq69p8
	 0CjB6H9gCAG7WM5oSwa0sc55wubpkE7LqraAg00L+QdaQVa6u2tpW6ly/UwmyzAze6
	 HZ/Ik583+Xb2gTiFdtBqWCVX9DnJsK6I0Hmyr5pvtq/tTliH88+SXVj/hyuH8ORHED
	 6jEZvgZ2GJJFIaopEyxS+WBsvpIwf8Tvp9/EJvdYStD72wqPUpprfq5OgHHqkhrH9q
	 Mik56rLRj8LTQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing/probes: Avoid temporary buffer truncation in trace_probe_match_command_args()
Date: Mon, 20 Jul 2026 19:12:10 +0900
Message-ID: <178454233010.290363.10428767141343428804.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454232006.290363.11301475407231432622.stgit@devnote2>
References: <178454232006.290363.11301475407231432622.stgit@devnote2>
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

In trace_probe_match_command_args(), a stack buffer buf[MAX_ARGSTR_LEN + 1]
(256 bytes) is used to format "<name>=<comm>". However, since name can
be up to 32 bytes (MAX_ARG_NAME_LEN) and comm up to 255 bytes
(MAX_ARGSTR_LEN), the formatted string can exceed 256 bytes and get
truncated by snprintf(), causing spurious argument matching failures.

Instead of formatting into a temporary buffer on stack, compare the
argument name, the '=' delimiter, and the comm expression directly.

Fixes: eb5bf81330a7 ("tracing/kprobe: Add per-probe delete from event")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d17cfee77d9c..95e3d072321f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2338,16 +2338,17 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 bool trace_probe_match_command_args(struct trace_probe *tp,
 				    int argc, const char **argv)
 {
-	char buf[MAX_ARGSTR_LEN + 1];
 	int i;
 
 	if (tp->nr_args < argc)
 		return false;
 
 	for (i = 0; i < argc; i++) {
-		snprintf(buf, sizeof(buf), "%s=%s",
-			 tp->args[i].name, tp->args[i].comm);
-		if (strcmp(buf, argv[i]))
+		int len = strlen(tp->args[i].name);
+
+		if (strncmp(argv[i], tp->args[i].name, len) ||
+		    argv[i][len] != '=' ||
+		    strcmp(argv[i] + len + 1, tp->args[i].comm))
 			return false;
 	}
 	return true;

