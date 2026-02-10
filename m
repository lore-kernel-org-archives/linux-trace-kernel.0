Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385252DCC08;
	Tue, 10 Feb 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713057; cv=none; b=H2B7WGt+5u9QnyCA78JUV6Hf9U8hhq8uU5qpev/pLcPUZq6ujVz7Lbt/hFaRHCKKa+rkY1sFB9bA0QW5H6QXolF8suNEyA05RBWgFqqiO462zxMxRIaSVbJ/valHkdqm1yMLx2r9Dn0r0sqUNANz3fnT5sICKnJWTI8fRZ7fe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713057; c=relaxed/simple;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=illPF2al4QvTqceU+69n7O+kuD6AkjcOKVo7AwlMdegHYQWN9TirU59X5rM9x2mpBbvvr6f5Vb/KYoh2sO8G6gzc52yF2NkUXyDCZJ4PmrdEcWdjMsvZhu+tyH0d+YnbR/YGxijToTfxsMJyaESneT+h5oCXysslnahrZRrTBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLsX7Ahp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLsX7Ahp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F2C116C6;
	Tue, 10 Feb 2026 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713056;
	bh=S5HUOKOwvhSR3nZmMfKa96wdR+Qt2kEIy+bpCsLdFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLsX7AhpJndJgeaK8VFX34vK6SUep9cV422qvD6auL/9ZoYwHl4ofXhqRsKoKtY8X
	 4oqEaZrjspd2IJyWMvLLV8UxE8W23ldpgxldPvG9vU5CTBV/CmZpL7QjeU6tzdhDHH
	 FyN5XhUWkeFCq79VM3R0nyyJDzoe+PWmsjui1Jnf5uybY4vA/MMVLBJrRoM9CToCL2
	 OXd3wzh8K5/nIra0adefymBGvkDRVusCpHknhE/FFjbZ/L1oSpCiYo+JBlK2Xml5KL
	 Ggsa1FRqBkRobGHTlJZw3nP129qH+ZvKjRMUs+Vl76y5e7xd7RYqbsk4XSfy5lZGQQ
	 8hf2ORD0bv1fA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 6/6] tracing/Documentation: Add a section about backup instance
Date: Tue, 10 Feb 2026 17:44:14 +0900
Message-ID:  <177071305440.2293046.5538536293035707901.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
References:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
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

