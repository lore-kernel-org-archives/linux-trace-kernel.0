Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAF425CE4;
	Tue, 31 Mar 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974763; cv=none; b=fUJyTx0DS8BT65aQps6Pbf0FTVaF7sNaIo/nkNKBRfxYouM3vUlcRGosXsyPl/4mJZG3p6qfC2w/7EAeZC3HNui1ca6KfF/TgeM6Svb0yO9DiIHz1uIs80WqPQNmwQMxZtFU19q6DP2+GtheYvmfsWLIKEG1M1cVYGTEwxoalPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974763; c=relaxed/simple;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOQgg+JjJXhN++Z1qh8ea22Z8l4LZwRnjIvdZDJb1gzO+iPNGoq/KWiRZMryRB1NbbtE87cr+XXduVQR1XitrZgB7CUrqF+xC8GsBSew/MHQt8PjfyYezIT1GEv29dFbJl2sTFccfQF+N9m3IiT+poSyuZBfX/1X8QENvNAz4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqxyKDGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqxyKDGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1678C2BCB2;
	Tue, 31 Mar 2026 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774974763;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqxyKDGiVchiEghQP8GkQdijGBRZTSmKlRUipJRI8+wDvvmr8C1gLqB6LErDc6+b6
	 HI7HxHle3Jy+v81Njjjqybv92EYUmETaH2StfzDiSjxYYvio5CAG8co8Q1SSk5ieTO
	 goLfRK0XMQ6vV2L/BHmwfhOABEbfWfEVqVMPv8woSixyxg8DPWjZak9zQe3Q3CbKdN
	 3uaAFQsophoWYNoSu6A5MVpPew6laznAsL0+obOvAd6l5sI7wNT/POi3ees4l9juYK
	 p2pPZalALgMXEmycZhy+JoL6Ji6w84EawUcUfVtqvKZ1C/0g6uBTiD7CA8MaFY0+VY
	 lhPxMxbRiY72Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 3/3] tracing/Documentation: Add a section about backup instance
Date: Wed,  1 Apr 2026 01:32:41 +0900
Message-ID:  <177497476117.569199.18085846838539980210.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
In-Reply-To:  <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
References:  <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
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

