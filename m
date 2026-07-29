Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25A1862;
	Wed, 29 Jul 2026 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284874; cv=none; b=PbcPWne4a8gIod4+Tyqobe/xoKTdMun6WF3JH9MawrsUhtDag+cBZR7oOp3qjMZx+k537Z6vB74B0rD4i3Fq3/amM4jTLWH/vTEN0fxnTWe246wcdh7xo2u+tkAIqVKUfBfEPpKZA88DeiafWMsESW7S4TCUMQ7un14dSpoIbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284874; c=relaxed/simple;
	bh=PJSBr318qZoCe9fpE3j33+dfvan2uki0MYc5fDD99O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6leSp3Mz5HIxqUQ0QeyIgFMspyN+MNv/RbYo6jbv+P/YucYwDkdKVZG/AFc+PM37U/ZcbLOy/sM6AE4qcVO9O3zA69BlZZ8sDpSt24ZnOYhYHzCYYvEyLqe2FfybTztpsHlBYsMw43RjSAm/UxN/asbY1Ym1/IqDLEkjA6+tH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX/DkIwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX/DkIwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA6B1F00A3F;
	Wed, 29 Jul 2026 00:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785284873;
	bh=dugb+cXE7wTrbedBQnGE+DMURr3VpIisg6Lbmlq2Opo=;
	h=From:To:Cc:Subject:Date;
	b=ZX/DkIwXVN1l32wiZvsmbICMp5M/0/FEa1yMKlSHZdB0LgoGbAsiUGPHpX7GGuYJb
	 a2oVApJ21KMyDJ2mxhiEM+F5UXeR6aTq1yT/ot3iLYv5ku9KoUfHTkNOize7YEjMSZ
	 mdTcKGMC0z206kJTMMuwDDUVZo5iZnJ1OXcxnTr9d+ldh/k/neYkTD4g61jVClEIyI
	 7yMl/83yb4aiSVdu9frZQnHeDseMT6vWJsLxx703NYTEkCFJ1vAPDBwm5hnSm4Gn3s
	 yHo3DS0QB/yqjhBcOCbntd63YurzAbB3zYlwM/3uZW9w5rTqP8REdukWexvtE1eknI
	 D9zC2tdm6VyFw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix a UAF and regex bug on trace-event
Date: Wed, 29 Jul 2026 09:27:49 +0900
Message-ID: <178528486942.124250.10437463913796837242.stgit@devnote2>
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

Here are a couple of patches to fix a use-after-free bug in a
error case on registering events in a module, and regex match
problem.

Thanks,
---

Masami Hiramatsu (Google) (2):
      tracing: Check return value of __register_event() in trace_module_add_events()
      tracing/filters: Fix false positive match in regex_match_full()


 kernel/trace/trace_events.c        |    4 ++--
 kernel/trace/trace_events_filter.c |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
