Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25915AF6;
	Fri, 29 Nov 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898863; cv=none; b=U2a1yiAfHlKvy8PYzy4C5mFclJxdpUrUUlVAhecQH4SGqoO4NGSAw5SR0/sS0JFoENF0OKemxpR7bvSKcFOd5fVxyv8sfUnWTpDLHwJyamOoIVb4M55xp/kyXzkgaVDPOzoBFa0nFFbTvy6abVZADDz0L6XA/JrbSDrWghxp4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898863; c=relaxed/simple;
	bh=1VzCoTLC0Pz31/d/Qw7tNE40swBkiAq4aNmyuonnwVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oAyP1EQDM58K1ZcgNE1OdXqVJ5ncANHakgaSZPeEF9x9b6sYok7wbGOlHXWMj6GJ1YD1SD3PkN0DlqEd+Ch+GdqDSoOHI8kkj/eC7Kfv+joeYC7AYjBmSgbbGrZAjRREhK+1YxDElGox7SvrriHovTlQMPO1vOyGHr7jdMJCMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM6AOiJs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM6AOiJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CDDC4CECF;
	Fri, 29 Nov 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898861;
	bh=1VzCoTLC0Pz31/d/Qw7tNE40swBkiAq4aNmyuonnwVM=;
	h=From:To:Cc:Subject:Date:From;
	b=nM6AOiJsayv4Oir4nGjvpAvOuvEM+rwwVtPG+/lxCQHvJBLQpyVOgYKi9aiw895cA
	 E82jNg6Bl5crwerMUhRLqPS066a5375QuDyBT383L3iYSKAAeOXce4fcZawXhpyH6O
	 LTh0W5OopTVWblzSzEH7BOlNpBB/Poc/8oYWxF5ImPktYbvs+d2ZD80G6brbEFfKVT
	 l/rUuxc32pCeNn3zbKbnibLcF1kThgXwe2mh/FCHZ4RpR8HkAq4GFAvNkpVSo76Iz1
	 mEFeggTT8UAAHGfNdTm1IqTfF++RshMeVI8ZPSp4J+QN9ULw0oRsH/PV8/TK1auwfF
	 VxKKfNdEaiBFA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] kprobes: tracing/probes: Fix and cleanup to use guard
Date: Sat, 30 Nov 2024 01:47:36 +0900
Message-ID: <173289885627.73724.13632317993038475335.stgit@devnote2>
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

This is the v2 of the series to fix eprobes and cleanup kprobes and probe
events in ftrace to use guard() and scoped_guard() instead of pairs of mutex
locks.
In this version I fixed mixing of gurad and goto in the same function by
using scoped_guard.

Some locks are still not using guard(). We need some more work to complete.

Thanks,

---

Masami Hiramatsu (Google) (6):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event
      kprobes: Adopt guard() and scoped_guard()
      tracing/kprobe: Adopt guard() and scoped_guard()
      tracing/uprobe: Adopt guard() and scoped_guard()
      tracing/eprobe: Adopt guard() and scoped_guard()
      tracing/dynevent: Adopt guard() and scoped_guard()


 kernel/kprobes.c              |  205 ++++++++++++++++++-----------------------
 kernel/trace/trace_dynevent.c |   35 +++----
 kernel/trace/trace_eprobe.c   |   31 +++---
 kernel/trace/trace_kprobe.c   |   18 +---
 kernel/trace/trace_uprobe.c   |   15 +--
 5 files changed, 133 insertions(+), 171 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
