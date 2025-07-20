Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190F4A0F;
	Sun, 20 Jul 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992502; cv=none; b=LXK/ELteEUQTmICV06seu0DaLuphUHhg3Qw4XQFFV+er05k7xxG+T6AEju07gb+l73diDlmsTWlJ3LOiY6WnpVvcNg4cMqQWDa2y9RTt74mcAr97BK+vDoj7ryWSiitYeqCyquLR0Whcch4z/8SNY1fIQiWAITgvknehHA2Zscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992502; c=relaxed/simple;
	bh=raTVbh07vkP2p7xZEMpeqFzyrEzwaeU5gWD5n/1bXLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WLulEFR60w4/i1LEWf0bfDDOuCBy2xaYgGSuNnJEytyo6ywrQXaK7vKOjbZmj1qo0MjJ0f28c26jaf53u1j9iG1sy0NwhVZ9LOU0fHYZSmEIj0YkF76Pp7UaiEgJ1/VtZSg2iOMUSXfje3Qb+NjrOQQTFLHsYFbhkYamFrUziNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYyzKuz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYyzKuz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E376C4CEE7;
	Sun, 20 Jul 2025 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992502;
	bh=raTVbh07vkP2p7xZEMpeqFzyrEzwaeU5gWD5n/1bXLU=;
	h=From:To:Cc:Subject:Date:From;
	b=WYyzKuz5ibUcwb+JzyI/n5WKujkvrIB/0xIY+5SLwJnToAnh6dVtVVbzQYpmDvGGp
	 fnf+D8it4TOtFXyThBe8/AxKcOh51+o3NaPpb05UDV7w/VhZD1xtwOe0LZMcP5Vw5t
	 UVpmXnU+6j3T/SxqCXxhFI1Wm+6bjfYfSKCOwdtfEZJGLSc/s5OJWfQCIEhEoPMAYq
	 tx1jpF56HYCbeojp4VWsiMqPx2f30kMdnz6aLKkrYLB8Ad7sqvk7SwgjTlOkUF4qlg
	 hvIkkwZMw0tINxAhWv3Cc+AXo2QWRJL+2/uPOS1HDTzx+tXxWesQ3D6UEwBe3yTUDi
	 QiXOlTr7kUbXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] tracing: probes: Use heap instead of stack for temporary buffers
Date: Sun, 20 Jul 2025 15:21:37 +0900
Message-ID: <175299249728.418723.17799706394466693180.stgit@devnote2>
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

This is the 2nd version of the series of cleanup patches which allocate
temporary buffers and objects on heap (slab) instead of the stack.
The previous version is here;

https://lore.kernel.org/all/175283843771.343578.8524137568048302760.stgit@devnote2/

This version updated patches according to the comment, also sorts the
#include alphabetically. Also add a kerneldoc for
traceprobe_parse_event_name().

---

Masami Hiramatsu (Google) (6):
      tracing: probe: Allocate traceprobe_parse_context from heap
      tracing: fprobe-event: Allocate string buffers from heap
      tracing: kprobe-event: Allocate string buffers from heap
      tracing: eprobe-event: Allocate string buffers from heap
      tracing: uprobe-event: Allocate string buffers from heap
      tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()


 kernel/trace/trace_eprobe.c |   40 +++++++++++++++++++++++---------
 kernel/trace/trace_fprobe.c |   52 ++++++++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c |   49 ++++++++++++++++++++++++++--------------
 kernel/trace/trace_probe.c  |   17 +++++++++++++-
 kernel/trace/trace_probe.h  |   26 +++++++++++++++------
 kernel/trace/trace_uprobe.c |   53 +++++++++++++++++++++++++++----------------
 6 files changed, 161 insertions(+), 76 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
