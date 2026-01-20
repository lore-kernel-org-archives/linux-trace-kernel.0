Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B221DF25F;
	Tue, 20 Jan 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871393; cv=none; b=vFokzV5m0KvhiGAhnF1n+AUnLOerYMT7oB0EBjfZjTLy20x75zy9y65T19dopNL6Q8dbeLEVXBKBw1oNiBpVeA4RvKB7zWXK4YXxAQoo1qLJFby0Vxws0AUUOA2cNegstssje41UahW4R2lCeAj7pFNVipM+fpdaZS22KZyqHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871393; c=relaxed/simple;
	bh=ZaW5oZCDs9KNm6pL3BS/uCrrK5EMecxzSSpu9ruwHzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSHCt0o4dS8C0IFo0JoLkJET5oaZjo0OaJpyj6xehyCJD2XtnxEzrMrumzYvJp68gtgqwNGCU3aGrxeiuTBUh7KferudT+bS9xOHoyLdgwxpxWC1eDNj0d7jaj8SMfk+xTWbo1+QumLiT/DkputOvjgJ7A+RwJNVz/ifoqX3jJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/TvJ7pS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/TvJ7pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF00AC116C6;
	Tue, 20 Jan 2026 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768871393;
	bh=ZaW5oZCDs9KNm6pL3BS/uCrrK5EMecxzSSpu9ruwHzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/TvJ7pS0NhR61CwdDHcHKYj8XVBlvJpo2SsZ47Ep9K55gm0G8+0fPqEDV31nusMV
	 UhRdQRtc73chc/r1Mh+mnd2YmeNUsAi65FzbXg3msdM2e8SRSG8W3mdqF3pXMIM5LW
	 NckKc+qfiy26KG9tUQpkaK2uDqJZpGL73Dx51cvn9pFORCUAtMqWlzqNZkLpu5X5Y1
	 aJSNudIAV6Z8Yxm6tGg2B59dBAwS5Anl8b0vw76nFEHpq7qQEu6ykjbtiTbJWCtHvH
	 +jf8ToRkG1LBlkAoZI4TWmQb6zF4agaymfprF3VFeA4EkT5vTiiDPfhcTgX7FEofAR
	 YUMhj+OuHV/Aw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] tracing/Documentation: Add a section about backup instance
Date: Tue, 20 Jan 2026 10:09:51 +0900
Message-ID:  <176887139099.578403.7828440306150090568.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
References:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
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

