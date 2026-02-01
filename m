Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3D274B59;
	Sun,  1 Feb 2026 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916573; cv=none; b=fnaugQfRr7HQya4t9ltVh+fl5VqNhIFJqGT20mRaL67O9SuNhBwVSIGrWYjuXlDdoZGAjUPekr3e/f0Mb/BWahrPJvmSUtiKjUh/wXLsvZcvxm4bXu/YKrhjCPxN7l7bAlJnTKHGQuYsjqAkr0PYP9JjpyZTjPQ1QFU7fUe6rcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916573; c=relaxed/simple;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUQk1+ZOpVAMFHrRS9VMnBPbh3lynxi+c1G1lyVrjv+VZmPxwdNAxX1OcrE7JnFsMbAGwI5N2QK5V32LBsXFyHCCVxfc22fhXmb0IYdzhmX6KD1BwRE0ZFqcRF40Xdxo40ova0F8LFKkrgnBFYNXA3tRYtdavVy9IjxQdIVcBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8882s9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8882s9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0942C4CEF7;
	Sun,  1 Feb 2026 03:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769916572;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8882s9/3Kfdc2IlteSXUjy/vV33PZkt3pEOqFMHaeAA/5ZsXNcq7enW1/gxJbDHK
	 gCT9/RHmK3+678+YbK2VHyCnJXz1QR9m5m3FBenjVW0ks4oaJ12hDEoiw/+FsHCDuQ
	 yYU3fEuPNEroRl99G8DbV7aiLJE38o45GGo2Gmr1KviF7FwqTTXQR/VMmO2AfEtPo8
	 lsdP1A5XxBTeY//qHPl/r8s3Al7aeDLQXxYn7PbungV1voCLieKSlFw0Ir26yvO3YT
	 +yKvuI57+uQOQ9LcnHQhvs2pmUc2faq9CQP4YAITq+DCdzxjS6woEgWOemwgzENp6s
	 zn61HZ7FSm/6w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] tracing/Documentation: Add a section about backup instance
Date: Sun,  1 Feb 2026 12:29:30 +0900
Message-ID:  <176991657015.4025429.14835098082961554583.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
References:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
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

