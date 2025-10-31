Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406391EF09B;
	Fri, 31 Oct 2025 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878770; cv=none; b=MhQNJLlmJNTxytTEIcb4/tOkly8olR1o0D9Ha8wtYOz+Ss75lQr4Piah9BVdjRaVtXgaL+SdvVdzefrxjHAMqCtDQkOd/meFFLmIt/qgwWdz/S3478uL58EEqUtDXeugQsS2swecyMpu84Nanoe7ERx8Ovz0umvWGmcDhXNisF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878770; c=relaxed/simple;
	bh=NvxzqeF4uE4mI4zxdKyMy4g/6M3+bsTf/7vTppVhSCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gcT0NIL9WABtsU8/1JMJ2B+scJ2l6AVN79A5045m/b92mRrsFQHoqzXQd3W1FVWYtb4nS7q67pE2xECZ5/kNVtsxnkjo2AaI98rBps8Fd3dEGpiSsjAALzSFnx22umsMdS+jognTls2zq5EN6jpc03bYxzljjWQC9esed0uE6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p89FLzix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p89FLzix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A41C4CEF1;
	Fri, 31 Oct 2025 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761878765;
	bh=NvxzqeF4uE4mI4zxdKyMy4g/6M3+bsTf/7vTppVhSCo=;
	h=From:To:Cc:Subject:Date:From;
	b=p89FLzixty2F7NQAIjBVSCow3v5xwfqsvu6+juPBizYhk5p1c/50vr7EJCkDnPdmm
	 pPlna0VvAnfwYQk8tDL4UmqsajxNk6YL85KxC12WZf98pwVxhhZoM3o5rtxFqVOkYe
	 CkqpxYL36YC0hwglf2V3QZFC2yxsLXH6OUckDZoLT2XEhrn3ikpX9743s7x+9TlLsn
	 2FzOGVdubgi6alohHR8a8NS9rIxIFrXhG8Lb6G2/8mUCf9npq92sNuTEgtglgLJBc6
	 rxP+5jxVMO09xiogoqdIX/p5NvV0fSIe2lD9ycr3uCJrt5WuuR8chnP1raN93udH9r
	 KqD2DqS5SILtw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Fri, 31 Oct 2025 11:46:01 +0900
Message-ID: <176187876133.994619.14047043856461447890.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

This series implements an option to show symbols in _text+OFFSET
format instead of symbol name in the function profiler.
This is the 7th version, the previous one is here;

https://lore.kernel.org/all/176179500583.960652.5730113001091388258.stgit@devnote2/

This version is rebased on top of v6.19-rc3 and introduces wrapper
functions of seq_print_ip_sym() for showing offset or not.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler


 kernel/trace/blktrace.c              |    6 +
 kernel/trace/ftrace.c                |   26 ++++++
 kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
 kernel/trace/trace.h                 |   40 +++++----
 kernel/trace/trace_events.c          |    4 -
 kernel/trace/trace_events_synth.c    |    2 
 kernel/trace/trace_fprobe.c          |    6 +
 kernel/trace/trace_functions_graph.c |   18 ++--
 kernel/trace/trace_irqsoff.c         |   30 +++----
 kernel/trace/trace_kdb.c             |    2 
 kernel/trace/trace_kprobe.c          |    6 +
 kernel/trace/trace_output.c          |   18 ++--
 kernel/trace/trace_output.h          |   11 ++
 kernel/trace/trace_sched_wakeup.c    |   24 +++--
 kernel/trace/trace_syscalls.c        |    2 
 15 files changed, 196 insertions(+), 153 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
