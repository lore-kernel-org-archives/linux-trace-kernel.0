Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2B18B47C;
	Sun, 16 Mar 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127677; cv=none; b=XdY5sM/IjyvKfgIj9TA/r2gfzsNlES14zknlWbyflKTrLbUljpKVY2x3y/rN7GsxwltHbSDru+Iztq++pRwlrRB7TbOgbcbDjbriSkUrMv0A1Z8RAwGPRGV8ZTk5rmhZTecTupFWHibWBlf6eN62ZQyoZsmgyKYVVIiwiiVWivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127677; c=relaxed/simple;
	bh=W2OkIEi39GX/fR6DCB0o4tZ+Vrqb9UET0xeVW4IpWOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=laQ6bhVwpDV4k0qFBrOa8w+4h0+7OJgHUEvh9DMadGFLUZLFc94xKrqdnglwftngkZXjFBtlvqoc9YymaiIqN+1s/NEO1VwIWAW5zr3BcrKtTt7XOMWdj9kasI7qkhYR599j8ToVtswTcTEJidEciQ6bF/32880xXtozPV5rZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXroWUst; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXroWUst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D559C4CEDD;
	Sun, 16 Mar 2025 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127675;
	bh=W2OkIEi39GX/fR6DCB0o4tZ+Vrqb9UET0xeVW4IpWOM=;
	h=From:To:Cc:Subject:Date:From;
	b=AXroWUstdF0B5zuHpYrQDc3Qs4KAJXrXBbRfkmxBh1SrGL6e7IRkReyqzU9DgX4rv
	 piM/lVRhU0RQtAniccY/Eybfp7TiVWsCjiZfgP/qZrb74v2ZZj+0cpoTp2X71YSTb+
	 pn1I2llxduLlz76vgiYCThcV0DcevZNAWBMzVNUvxELv2VYyNSqW6sH7rJDs8ro086
	 ajiX6oANqrLVxz5qiF5jLgvQvPIILvDrqoiaSWmDibewQ+5p9Zd9PhOlktZt27lJeg
	 1yNltNq670xeHdr7nSE9xJGCPoOZs0ygqBVa7KNKwJfO63JUOy4TLEpypRN/7rHhXr
	 F5m5/uDSn6P8Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing: fprobe-events: Register fprobe only when the event is enabled
Date: Sun, 16 Mar 2025 21:21:11 +0900
Message-ID: <174212767109.348872.18231451508464729427.stgit@devnote2>
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
Here is a series of patches to register fprobe only when the fprobe
event is enabled. Steve suggested the fprobe-events are always
registered when it is defined, even if it is disabled and that makes
system overhead. This series registeres the fprobes only when the event
is enabled.

NOTE: tracepoint has a AB-BA locking issue[*], so it is still enabled
when the event is defined. That should be eventually solved, but it may
need more complicated change. Thus this series focuses on registering
fprobe when the event is enabled.


(*) AB-BA lock if we enable tracepoint when enabling tprobe event:

[event enable]
__ftrace_event_enable_disable() ----> event_mutex
  __regsiter_tracepoint_fprobe()
    find_tracepoint()
      for_each_module_tracepoint() ----> tracepoint_module_list_mutex

[module loading]
prepare_coming_module()
  tracepoint_module_notify()
    tracepoint_module_coming() ----> tracepoint_module_list_mutex
      __tracepoint_probe_module_cb() ---> event_mutex 

I have an idea to defer fprobe event enablement when module loading
so that we can avoid taking event_mutex in
__tracepoint_probe_module_cb(), but it needs to introduce another
list of tracepoint_user and another mutex.

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing: tprobe-events: Remove mod field from tprobe-event
      tracing: tprobe-events: Support multiple tprobes on the same tracepoint
      tracing: fprobe-events: Register fprobe-events only when it is enabled
      selftests: tracing: Enable fprobe events before checking enable_functions


 include/linux/fprobe.h                             |    8 
 include/linux/module.h                             |    4 
 kernel/trace/fprobe.c                              |   29 +
 kernel/trace/trace_fprobe.c                        |  490 +++++++++++++-------
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   30 +
 5 files changed, 362 insertions(+), 199 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
