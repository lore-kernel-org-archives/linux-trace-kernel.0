Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5019CC3D;
	Wed, 23 Jul 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234242; cv=none; b=ZLFPGNP1mHlbCOTRrcNbwaEb72we4i1UHKp7u25npwx415EzGg51T60jfzfo8cw8z8VKiCf62hMy1a7PXu0mXaOzc8zioB3F3dAXOn+V8XJwTonRWR63nOJRJCaI3KOBhbwpUvmiHDqzawooDRne9wqwLjV/dAW0qWSPgMDp8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234242; c=relaxed/simple;
	bh=Dg+0MWLgMa4HF+SA6Ddc7+wPdrB2SszPd4/pix+doQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YgM8+vcPqaTrCWZMJ7p5eMOufR70WyiRK02+8t2HUZyvjUHQm8XQfQe7EmP2JYeZ754uqllG1q1z+Ymt6j1SnU5kmEEYD51m11giChwZOY79DBico3eDWGwt09KrmNmkT0tbFkCDbNHBCvegGIQKY8FnTFd+6m6BS0q1KdNm+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2hFCPeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2hFCPeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB404C4CEEB;
	Wed, 23 Jul 2025 01:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234241;
	bh=Dg+0MWLgMa4HF+SA6Ddc7+wPdrB2SszPd4/pix+doQU=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2hFCPeAjVoNcsSv0DBuwXea1fqUIld71EiPuLTr0c+azfUNrly3ayOxWqfgoo7gs
	 PllHYq93Fdc/4Ou+vWUDWzWmyduZGJlaP2wUoHY+ohcdn2vCyADAY+klbmnLMsLSoq
	 4z9/h8Dv4uMImEfRua9h3zrH3yJIyGJRzB4Q93aCi6w7LzHStz5B6knKv+ZdHJoCnS
	 D17iadiiDKBzhwTwK31x8RbCdOb3+uIIRsUHkEUxfWAbMLgdl06KnHTIZdpDLJY6JU
	 WjRo57bzXk2hsPv7CQspOsYe3l1gDt4KJcUZTZ5vhaewcoX5LRUr+kOiWUSpFqeCwO
	 4StJFGRHsO1oQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] tracing: probes: Use heap instead of stack for temporary buffers
Date: Wed, 23 Jul 2025 10:30:37 +0900
Message-ID: <175323423662.57270.14650807176845939538.stgit@devnote2>
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

This is the 4th version of the series of cleanup patches which allocate
temporary buffers and objects on heap (slab) instead of the stack.
The previous version is here;

https://lore.kernel.org/all/175322168606.44400.9155291012158349647.stgit@devnote2/

This version fixes kernel-doc stlye and moves longer description of
parameters to Return section in [7/7] and adds Steve's reviewed-by
for [2/7],[3/7] and [6/7].

Thank you,
---

Masami Hiramatsu (Google) (7):
      tracing: probes: Sort #include alphabetically
      tracing: probe: Allocate traceprobe_parse_context from heap
      tracing: fprobe-event: Allocate string buffers from heap
      tracing: kprobe-event: Allocate string buffers from heap
      tracing: eprobe-event: Allocate string buffers from heap
      tracing: uprobe-event: Allocate string buffers from heap
      tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()


 kernel/trace/trace_eprobe.c |   40 +++++++++++++++++++++---------
 kernel/trace/trace_fprobe.c |   55 +++++++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c |   57 +++++++++++++++++++++++++++----------------
 kernel/trace/trace_probe.c  |   22 +++++++++++++++--
 kernel/trace/trace_probe.h  |   26 ++++++++++++++------
 kernel/trace/trace_uprobe.c |   53 +++++++++++++++++++++++++---------------
 6 files changed, 171 insertions(+), 82 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
