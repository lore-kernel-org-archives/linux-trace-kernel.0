Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663472FDC52;
	Mon,  9 Feb 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629157; cv=none; b=NSxIZCjkocHg8aK1cW9YJ0499arUvjEOwnfta55Zieo1+qDHxem3frd+7BE3Yu7rwiy1T9lPFbbAdGVbPZx0ORDsseBxXzhbv6OC2qcWmzU2wHDMQxeQLyxkk00s3lL3klV21VR2G59mXlIhzBR6aDUolN96TdEaNHmQH4O3eyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629157; c=relaxed/simple;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpGAPSRW5vmqhCUV3A3RKlRwpzP/rtUa5UXaa4m317HNVaVyhFC+m6dxN6n/wFzSQ/9BSy2N4SImZSY2WopWvD8XDTIy6z7tN2FounSavtXqa+PXI3EWzcPW0VzDHfSMnoYrmdoXxAlJ3MBM+ULiQDgCQgGTFq86dfEQdipBubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdQSaEFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdQSaEFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F9EC116C6;
	Mon,  9 Feb 2026 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629157;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdQSaEFb+0dEUeFrZGmHwNUNrgCRSJANRUZEn6hf5K027gQVqIgReSJxi2DlHU7/m
	 SV2S8KGKy0z9OQ6tNIngYcHLaOVY52BoqnQ8bymI4B6FPB27uZ2pAMhmmCmNXLdQrH
	 vdJQ6wU4EFK8xtbAm69vYffxqimpb3BhtFkUwHerC3ig2YJqYO37HfZY+oBWLWWI6n
	 hkmLeH079lsXIFGq8a07hA9RPEha2LTFuECDolZQJzjDG4as+jj9NTxpEcfM8wlVrZ
	 uAwRI5XFH0v11cG78tBNWWfWsRLXKC/RJ9QHf7LYfAnoDH94r76ubBA9k4R6dtvJ4M
	 nnD22GKWheRxg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] tracing/Documentation: Add a section about backup instance
Date: Mon,  9 Feb 2026 18:25:55 +0900
Message-ID:  <177062915493.1230888.7689297490214883376.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
References:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
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
  Changes in v6:
   - Fix typos.
---
 Documentation/trace/debugging.rst |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index 4d88c346fc38..15857951b506 100644
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
+On boot up, the previous data in the "boot_map" is copied to the "backup"
+instance, and the "sched:*" and "irq:*" events for the current boot are traced
+in the "boot_map". Thus the user can read the previous boot data from the "backup"
+instance without stopping the trace.
+
+Note that this "backup" instance is readonly, and will be removed automatically
+if you clear the trace data or read out all trace data from the "trace_pipe"
+or the "trace_pipe_raw" files.
\ No newline at end of file

