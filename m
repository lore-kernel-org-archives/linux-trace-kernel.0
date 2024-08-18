Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6017C77;
	Sun, 18 Aug 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977773; cv=none; b=GinbA0rtj3elXI6pBwPp9u+xjYunsYVsizhg3P1HfrF/p5nco6zwZcGcDQF88j1zpG/X5za8zama8iDemAadshxNIX4NzKxp1Dm/Gap+VfB4L2jluBEcvH+ruA5jwrAw/Rm2zNYZ7ICJLrzpWCqhMR2yjBi08Cfc0/vZaJWVgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977773; c=relaxed/simple;
	bh=5BY+uWUvCswrTMuiuhTAsi+IsiFot1bz1CtixOYXbyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pEefRORdqvQA4ulvWhBagnyhEBjyWmEXU3OUZcX/ev1H/cmG0JSjAlAj3aKMXiX5tG2/XyRYiGGYzez7qtgJUuKODmS6s/MZk6bID+I/1QZoM9I18hbj2FpmgeLFM2QD+0OcurKx+mrk8ik/uodvfZxwv/pEDrWxBfKCafoLhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp4OvVYl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp4OvVYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE75C32786;
	Sun, 18 Aug 2024 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723977772;
	bh=5BY+uWUvCswrTMuiuhTAsi+IsiFot1bz1CtixOYXbyo=;
	h=From:To:Cc:Subject:Date:From;
	b=sp4OvVYly11FS73BdzCneRtOlk9RQvOfAdDvDMqOtUQFUHtYpt8kxNoEtwz5kKh55
	 QQn5u+Qlr+pk59GeCJm7WcODh9wuE7scJq3CWEszYdnBSmrrBcQzNddWz5zZjMlQe6
	 KGlZ/C+jtmec6j2wmmv5gBeF4t8L81eYMIZkf9z/tQpA/hPcSgr4dbYRmeYCqWd1fI
	 wVXzhLpmxxOJAFTc4kwSOCmBF9w2RPmFNVz9ugkAgCRbl+viDIH3OXX/N0ksDVTSov
	 YfJq2AXJaA1GaczkWBsLlWK82BAsOZpDv+YT7wB7lt0USRJHnKl5UDMjY7rhphyM+K
	 Gmzgff+A9ST0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v3 0/5] tracing/probes: Support tracepoint events on modules
Date: Sun, 18 Aug 2024 19:42:49 +0900
Message-Id: <172397776900.286558.8986646398199362026.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This is the 3rd version of the raw tracepoint events on modules.
The previous version is here;

https://lore.kernel.org/all/fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com/

This version supports tracepoint event on unloaded modules according
to Mathies' suggestion ([2/5],[4/5] and part of [5/5]) .
The concern about blocking module unload by instrumentation is TBD.

Note, to support tracepoints in the unloaded modules, tracepoint event
can not check the given tracepoint is really defined or not. So unless
CONFIG_MODULES=n, it does not check the tracepoint existence. IOW,
user can specify any tracepoint name for tracepoint events. It will be
just ignored.

You can download this series from;

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/tprobe-on-module

Thank you,

---

Masami Hiramatsu (Google) (5):
      tracepoint: Support iterating over tracepoints on modules
      tracepoint: Support tterating tracepoints in a loading module
      tracing/fprobe: Support raw tracepoint events on modules
      tracing/fprobe: Support raw tracepoints on future loaded modules
      sefltests/tracing: Add a test for tracepoint events on modules


 include/linux/tracepoint.h                         |   20 ++
 kernel/trace/trace_fprobe.c                        |  179 +++++++++++++++-----
 kernel/tracepoint.c                                |   42 +++++
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/dynevent/add_remove_tprobe_module.tc    |   61 +++++++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    1 
 6 files changed, 254 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
