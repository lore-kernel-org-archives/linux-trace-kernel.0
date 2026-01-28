Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794572E40B;
	Wed, 28 Jan 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559014; cv=none; b=ljQTn+0fso9l5HQ+mnARtZSMsk0O9Sw65l52+kR5eXDa3eS1E+dBhnoJW6I/gWc4UXZNmL9PM5YCcYO0GXFok8NFOOjjs4pdwApP/mk/SPBV6CiQK7Al/vxR/22/HJXPrILn8twy39NdPVI1VYcQUF8qNZZtoRx/+b6Q+cfVZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559014; c=relaxed/simple;
	bh=ZaW5oZCDs9KNm6pL3BS/uCrrK5EMecxzSSpu9ruwHzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX82mp21btvDoM1LZdq3tJSz7qJQWWl0dk4PiBPEJrIuskVY2LNRKljeks99J6cDKWz/jPiLpPJTl+JX/1rtibkuulbqG1mxeFha0IIqBDnvGH7/3VbewHbT7v7t8uVm9t2QD5Dep6Spz6BfpG6NIor1+Nw9gD0Qm6Xhf0XFvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWXwpzuv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWXwpzuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F84DC4AF09;
	Wed, 28 Jan 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769559014;
	bh=ZaW5oZCDs9KNm6pL3BS/uCrrK5EMecxzSSpu9ruwHzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWXwpzuvY+UbJkoYESl89TsjLv1MsB+hTj1GIkjud7oIfB4TEFM2gu9GO8XPeYmXe
	 TLCEVPXuhnWnqcCCBX7mQ+Z6S/pEL9lB1BJeZCd6BvOK+lZxXcdto5krhRgTza1ggj
	 axczqAJzyhTysncXNYYCsw4TElnt3+Vg9Z+GRbmhvipRxI51d6gWW2rHHy5eGEAjZy
	 MVJ+dQtoqoW5CU3wiC9GUoRxN5dTMHxnz6OrtW7bp8AyNafcbLML3fw8CPinCQcnOm
	 6g5yzVZA7kVwpwwcaMY9evYcuiM1Wq6PQhz5E6fZEkrJHD7kHAMSEzWbXEOWmGdy2R
	 YOOkQhZZSKH6A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] tracing/Documentation: Add a section about backup instance
Date: Wed, 28 Jan 2026 09:10:11 +0900
Message-ID:  <176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
References:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
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

Add a section about backup instance to the debugging.rst.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/debugging.rst |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index 4d88c346fc38..73e2154bcf98 100644
--- a/Documentation/trace/debugging.rst
+++ b/Documentation/trace/debugging.rst
@@ -159,3 +159,22 @@ If setting it from the kernel command line, it is recommended to also
 disable tracing with the "traceoff" flag, and enable tracing after boot up.
 Otherwise the trace from the most recent boot will be mixed with the trace
 from the previous boot, and may make it confusing to read.
+
+Using a backup instance for keeping previous boot data
+------------------------------------------------------
+
+It is also possible to record trace data at system boot time by specifying
+events with the persistent ring buffer, but in this case the data before the
+reboot will be lost before it can be read. This problem can be solved by a
+backup instance. From the kernel command line::
+
+  reserve_mem=12M:4096:trace trace_instance=boot_map@trace,sched,irq trace_instance=backup=boot_map
+
+When the boot up, the previous data in the`boot_map` is copied to "backup"
+instance, and the "sched:*" and "irq:*" events for current boot are traced on
+"boot_map". Thus user can read the previous boot data from the "backup" instance
+without stopping trace.
+
+Note that this "backup" instance is readonly, and will be removed automatically
+if you clear the trace data or read out all trace data from "trace_pipe" or
+"trace_pipe_raw" files.
\ No newline at end of file

