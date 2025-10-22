Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6C34B1B9;
	Wed, 22 Oct 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147477; cv=none; b=iMvGF1e3GMzpf8yPLZQQz+ALEu9ZBmdZhpcS94CVOWcdedul5ywZzt2S59hoaEZF8Epy6orL52XILM0cu0aDWZ+Gaoy5LKEUBkA45R1ys1H8Hw7c8/Khn0DZH4IWzwJOm11K6CCs/ds5FQ3K7cY5Zi2b+Gyl41N45M9OVVlB058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147477; c=relaxed/simple;
	bh=jI6dcZtxyFt42f+IXIVCYLjP86ufsKVa2QjGx7tVqno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8SBiTyxXpyvaAPjeM3l3fuLMnGEpBR4baCdaZeIgilP8S2+BPweaX6vOI562uIl3Ls2+kqWBJIAzzjipMSKAT5uHleq5nP+/z/Hv65ZPPNzFXSyob9N7wlc6h36tTzKXlAhbfTCLboNxdcg1PuZ7AB0dllU/kNQ4Zh/U9J1Bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjfB7p84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjfB7p84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1980C4CEE7;
	Wed, 22 Oct 2025 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761147476;
	bh=jI6dcZtxyFt42f+IXIVCYLjP86ufsKVa2QjGx7tVqno=;
	h=From:To:Cc:Subject:Date:From;
	b=HjfB7p84nmCKYzvJBwLrUL+F/WVAP0mCvtFhCYZqtJ7nLjz4BQsjFUt+NTZ74GQ/a
	 VHJH51mRHFMdPXUtblZyHkvIjmqYXImgtJHjZKMB0N+07d06oXvbpBaJjNSqomIBoX
	 bKMrkWm6W2OSpGJyEFAsmrux25nE7waDE0kmg1rS7AsD++W2rbI82kcm3ScS9hl39q
	 6s7QpOGXV0TJ5AtlPZTu2nC0orGMfgiJyRsdXon3TbQubPf0O6ymDf5ln1sGMBFAw+
	 3THt1JxO0vlsNvNeA11dm5emg4J7NquYXjJtYjbLCEQ9lA/Y9NVwP5jwVEMbTuXw1b
	 ckzAERbGARNSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Thu, 23 Oct 2025 00:37:51 +0900
Message-ID: <176114747153.315239.6863821259073466010.stgit@devnote2>
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
This is the 5th version, the previous one is here;

https://lore.kernel.org/all/176071773144.175601.17884676964675287059.stgit@devnote2/

In this version, eventually I repaced TRACE_ITER_* enumalation
symbols with TRACE_ITER(flag) macro. If the flag bit number is
-1, the macro becomes 0, which is for a dummy flag.

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
 kernel/trace/trace_sched_wakeup.c    |   24 +++--
 kernel/trace/trace_syscalls.c        |    2 
 14 files changed, 185 insertions(+), 153 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
