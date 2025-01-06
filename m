Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8550285;
	Mon,  6 Jan 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179380; cv=none; b=X7kje8UdF7XuTN8/CByDbqvFUfHJYHWeqaw3Hulsyjwih1sHeldgC0/SVe/mhuT4x1SgZ8uv4nzRXxgmxgfTMH7RikRRTiQfoIhzjAU4m85+fcC0Tyn4+UlEYOtvBHY/z0iwy/2sgBCVrY71gVy3GqB0Ni+5rMrb22jY8gNs5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179380; c=relaxed/simple;
	bh=OW4E9aaGM/92asDD9dT4iwAwcfuoWcft6DCb/xar2zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdH7smkz5eRzdb50oOBUvIDIRhvKEGRmsfimwW3u29EpC22uhWxk7Y6xjUQy1MDDtX+7IL+cqczJsp2dXiI6M5jr6GQhmh+m7gaV+GguoGTPdLma4x8Un7UhsiguIs8dkzsdsgH/mAjwq0aEWdKf/t8PdHDAZkdJSYAx6fwQq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVLnV8lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVLnV8lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC091C4CED2;
	Mon,  6 Jan 2025 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179379;
	bh=OW4E9aaGM/92asDD9dT4iwAwcfuoWcft6DCb/xar2zk=;
	h=From:To:Cc:Subject:Date:From;
	b=UVLnV8lpqAFVZ9Ht8CpFbVptuW1YjyFYD3nnkwAFy0cFzjgpqi91LLB/8mxejHgXs
	 tIUMRJ5VVIL+KooUe6lSsJR84kh17tg22PuqUcqM4Nh0hXGWuaxfoAX21qCwp8KUls
	 FTlmQdKAqXIQ3BUQykXC3BqataZvOPUd4Ti67YhgKuGCpl78X7qmsyvvlOJwqMIL3t
	 3G+dA8iQAblRZUXDnw56n4bXV2+qGZHnsLatmJ256mcUwHYcz8nrbhKcTOQR6ssjec
	 76wZBePKVQkD+JU0bmXI0oZBmk1KucvinbxfC4GZex+sxoP/254GD6Xu7Fka45rogB
	 SktZBsPn2l6Tg==
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
Subject: [PATCH v2 0/7] tracing/probes: Cleanup with guard and __free for kprobe and fprobe
Date: Tue,  7 Jan 2025 01:02:54 +0900
Message-ID: <173617937395.1366315.17590944219163017504.stgit@devnote2>
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

Here is the 3rd version of the series to fix and cleanup probe events in
ftrace with __free().

In this version, I fixed some issues[5/7] and update DEFINE_FREE() tag
name to specify freeing function name so that reader can understand it
easily[2/7].
Also, I added trace_fprobe cleanup with free[7/7].

Thanks,

---

Masami Hiramatsu (Google) (7):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      Provide __free(argv_free) for argv_split() users
      tracing: Use __free() for argv in dynevent
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
      tracing: Adopt __free() and guard() for trace_fprobe.c


 include/linux/string.h        |    3 +
 kernel/trace/trace_dynevent.c |   23 ++-----
 kernel/trace/trace_fprobe.c   |  129 ++++++++++++++++++----------------------
 kernel/trace/trace_kprobe.c   |  133 +++++++++++++++++++++--------------------
 kernel/trace/trace_probe.c    |   52 ++++++----------
 5 files changed, 156 insertions(+), 184 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
