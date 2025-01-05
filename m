Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F34C6D;
	Sun,  5 Jan 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081260; cv=none; b=ZwOkExwYOTJuIybwFdaz3dncO7uQN8bS2hVpG0h5QD4QsC3iP0MjPn5iTpdx/zbBlFeadcVJNjckAXLB/qKXLFuT1BDux6CoU0hs2fg0cOosw2+tLQFje1IhmI+qb/MrQjX3KfbRTxYipDZ3qu92duHBR7nSUO40Y/HR5gV3CDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081260; c=relaxed/simple;
	bh=6SjFHT7wLgYWKrEYKB6+0UEGH59z5STEqAQg05x2hN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UihG0erdgQRtoluPT9koI3Pi1+MqHfxEMrRWFeP1Jb1jKA2mueE6Au8echCUx0wxwmmHgQzMdQVE0BJz6OQIBz0VQuMx2uF96NzzgrQ4lm83/437IU/vMn/7iGfkaPoxffwih9rgVATI1r9xRemzhdw6IOrjeQarPnGl7zmnZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiL59fUf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiL59fUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B84C4CED0;
	Sun,  5 Jan 2025 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736081259;
	bh=6SjFHT7wLgYWKrEYKB6+0UEGH59z5STEqAQg05x2hN4=;
	h=From:To:Cc:Subject:Date:From;
	b=OiL59fUftYktft0PRSFSQgO9gqLUnLHuh0VFDPIm+m0dNiOaNNNIq8iwkp+qIHpr3
	 8Cl//4Tt2XSX2qwy1P1H4SyuOgZmVi1sGlVprb5YROrzLJD7jesxiQ6MXQO0urmFkW
	 Q9g/fgk1gNz7mcAqvRgKb6z7iGUrhZoSMsTe5N3mtr0cEDoYbBsYSCSSa/ojhEmp7x
	 9vr8YZhfYWawKwgzIOEp6064DoVxODJImyfrSaCTqN5lmvPccOL9UWvqslLpx0+9lC
	 0OM+9QO3SYUzEhjacBwoi8JBvv3c5KFbI9IoN7Fx+6dgaz/FKl7hpxa+ofKAxcoQlO
	 jUgK+Xgls7Ewg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] tracing/kprobes: Cleanup with guard and __free
Date: Sun,  5 Jan 2025 21:47:34 +0900
Message-ID: <173608125422.1253657.3732758016133408588.stgit@devnote2>
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

Here is the 2nd version of the series to fix and cleanup probe events in
ftrace with __free().
Fix [2/6] according to Oleg's comment to check the argument and add
cleanup.h, update [3/6] to apply it cleanly on probes/for-next, and fix 
[5/6] to assign NULL to 'tk' instead of using no_free_ptr() after
registering it successfully to avoid __must_check_fn warning.

Thanks,

---

Masami Hiramatsu (Google) (6):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      Provide __free(argv) for argv_split() users
      tracing: Use __free() for argv in dynevent
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos


 include/linux/string.h        |    3 +
 kernel/trace/trace_dynevent.c |   23 +++----
 kernel/trace/trace_kprobe.c   |  127 ++++++++++++++++++++---------------------
 kernel/trace/trace_probe.c    |   52 ++++++-----------
 4 files changed, 91 insertions(+), 114 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
