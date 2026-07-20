Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773212FD68B;
	Mon, 20 Jul 2026 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544320; cv=none; b=BBhTSedzKgzg1fGm9Zpsocn2L9/bgPoy/Jr5j8IqZfv2O3IYTxO5Y7XH8a6oAaMN6uizwxhRuZmnREep/OJ8xiepfNgjLPu6LoJNixfuFZYqkzH9+E2jqq1/9FzvJbfoh0dEZCbwlD386fx7vR/QE1NWeQo1LNwnfRk5XTd/gJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544320; c=relaxed/simple;
	bh=cjxSwuLlduv7vNavamNRS5b1a5l14ctDnJVO5czszNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm0mR84yRRAudi7BF+oqcOGtG+8QvnH7HwHNPr31UkRT/69BHpCvHkMpNwsbcKtT+d6G+NMkRDxF8MXmFr4uPqaZ5lmuibyLfD78hSJWpNR1ugWy4dStWTEEzQUblDOIYBWeD77VqUf6oUnb5E4VWFSL3esS/ds+7DlFZX/blx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zan1DjI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zan1DjI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9D61F00A3E;
	Mon, 20 Jul 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544306;
	bh=5EiU38AUN9ixRY5i2B6B8FAhm2x98CYweIuaUwwxgDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zan1DjI0QZUdBwwehMOndd7rRWqkuhPiB80pEyDpB4WYsKiMoYO4FonyGxKLEvLd4
	 Sjw1wz46B+vB0wdvxEvR1hq7IJJLTH9bb6pojCTiq/baltYWy5zbyWcYAav0oxfn6o
	 bxUrcr0RloqrfaZZL9oDOwJi0ZjBvXS7FOAsBQoQsODPBsiq8hsLY+ic8kZWfRDVI3
	 dfbuUd8I3+BZFsbKbR38Atc1ZLFPyDC/fMO+PTgpd71ZQZHitcO5rTXc31jc7C/c27
	 1qYoOyfIpypT1ZQDWw62MosJiIvkXXSBT6I8I8/CT+phlAsKhaVjur8e9YB/iU37nI
	 l25taxK5JeYbA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 10/10] tracing/probes: Fix extra whitespace in trace_probe_kernel.h
Date: Mon, 20 Jul 2026 19:45:02 +0900
Message-ID: <178454430235.296567.9486503882045148585.stgit@devnote2>
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

Clean up extra space after '=' in fetch_store_strlen_user().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_kernel.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index bb723eefd7b7..4eb4acfa09ba 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -12,7 +12,7 @@
 static nokprobe_inline int
 fetch_store_strlen_user(unsigned long addr)
 {
-	const void __user *uaddr =  (__force const void __user *)addr;
+	const void __user *uaddr = (__force const void __user *)addr;
 
 	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }

