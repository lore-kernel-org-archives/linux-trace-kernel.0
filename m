Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1972264CC;
	Thu, 30 Oct 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795011; cv=none; b=lUxKCjn32AbCYwUE9ezm+QO5HurCcxTqunFwSbwjPyqSE5WBJDDddICjjZJKLA8rwehtctzIhPC5XRWINaoVLj6B2P92KaC19Hf3Ee29Wa4RmgxgWwva8sSQYYmc00oNEgFnupQTBKvEFohOBViVKBe9aBVckCNdtknTfbld8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795011; c=relaxed/simple;
	bh=3J40deEdpHMA/CyI3moIIEYn6usFyZwtuLOaYv4VsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCO1G7BdYhm2wZ6Mm+GU+dX++0tyhOV2lfuGVG0fWTPqisyqWcI0tiBWnfxHEIFgEVgFoeYEWOjL4nZ4C7qADFEkbERwyVD6DubTboBYHopAoboG3CFIjs6DIb0WSAkNeT5588rywI05qS1Il5sX3h7WernhtPoJQV3oVH9+E1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etfIfSRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etfIfSRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3880FC4CEF1;
	Thu, 30 Oct 2025 03:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761795009;
	bh=3J40deEdpHMA/CyI3moIIEYn6usFyZwtuLOaYv4VsQg=;
	h=From:To:Cc:Subject:Date:From;
	b=etfIfSRBo2WVDyRnawV7lYevDepN5XptnQcPoKhaJ3oZHq7UyPJ/b4YzEpKeYphj/
	 /MPEWlMcJ8TmhQgx7bR5Xa2IZXvYSf9MzyAuGIb0XrgNPpmoH+c1mqKMYOTT9iEAgF
	 GeLbb8S5tB1/wkubPNPU5ghZyjnTfczAD5gOXTrK6G777pS4yH7QuzReogbAxea3xV
	 HD6muZLtiCIH+AFjK730QIxdww6vliz1IfGaq01hbqp8yGPMNZLGTQyehU1Qx+VCLV
	 gyukLmrAixXNba9KA2ekxQpY2aKZXQ1fJaeZhv/PYhYvODk2+KUEXksK2umL+XVcIZ
	 XmP/EvwRgA+EA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Thu, 30 Oct 2025 12:30:05 +0900
Message-ID: <176179500583.960652.5730113001091388258.stgit@devnote2>
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
This is the 6th version, the previous one is here;

https://lore.kernel.org/all/176114747153.315239.6863821259073466010.stgit@devnote2/

This version is rebased on top of linux-trace/for-next branch
and modify offset format to hex.

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
 kernel/trace/trace_syscalls.c        |    4 -
 kernel/trace/trace_wprobe.c          |    2 
 15 files changed, 187 insertions(+), 155 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
