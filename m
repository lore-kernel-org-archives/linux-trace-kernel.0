Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB341362;
	Wed,  8 Jan 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299442; cv=none; b=XQD6iq0NwlqsehmMNvG9TCVzoSjcqksBa2NwlPgonGcoNW2+d0N7Ob9CjZtPvKCkcVCYd38dWZfBVQxjZDrymurAoGddBySoRkzB/SzXS1ai7H+P1BhZFBYPe4BN5kkkxf4qUThUKB4L0iTK9PDumds5sdwFq8SAIs/+MSsHedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299442; c=relaxed/simple;
	bh=oL7wOpdmBnt+Vkn2qKUys3dHps0ThwlI41qPf2e5kJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z97I3nWGtd+5afBzBLY57s0RdUIRLNBNpqsIJHSs9ylYLyIbfhtJcCwbfSJ4CCRIRi47mcKdQEH0w0uNl/6z3SdXJr7Rdk8tSc3GOLfH8n4HbOYeSlIHwTPPcT7ReSEtUQQ8QVYOrf/Xhq3JOu5nH8hZGqU0OfBukE5EXfudMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1COrcaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1COrcaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFFBC4CED6;
	Wed,  8 Jan 2025 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299441;
	bh=oL7wOpdmBnt+Vkn2qKUys3dHps0ThwlI41qPf2e5kJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=r1COrcaPsKf76GnaEcXxFiwesNTbi0wfWFVtog23xtIsco6buQK02ho4haOjwmj+O
	 Kx9XjOpeJuafP+KVbyrPfEqDIciuYqJlV9Qz21LB8nJNzDYGqOLZhyj2mJuBpS1Bcp
	 GsMK1WoNai8N4LVDC2Lq4dTlSqOw0uBdgY+xPA/vp8MQ9/DGzOusgAW+6I83gOp0nR
	 swF0Z5VEweSnPiOSka4gLMc20wvQs+5uL4GhrmaxykxoPq5+8XeYrLEyhlw9eGWl6v
	 NLmoLnj/gKFbCnxB23IfYsxwd2CZqSWuxcURBeg4dNxo1kPUVhzZfOTCihwjsoWn4V
	 Xq1msjOcnkjUw==
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
Subject: [PATCH v4 0/5] tracing/probes: Cleanup with guard and __free for kprobe and fprobe
Date: Wed,  8 Jan 2025 10:23:55 +0900
Message-ID: <173629943548.1450013.12412761424554510119.stgit@devnote2>
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

Here is the 4th version of the series to fix and cleanup probe events in
ftrace with __free(). The previous series is here;

https://lore.kernel.org/all/173625060316.1375434.11048027439794595989.stgit@devnote2/

In this version, I updated [3/5] and [5/5] according to the comment from Steve.

Thanks,

---

Masami Hiramatsu (Google) (5):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
      tracing: Adopt __free() and guard() for trace_fprobe.c


 kernel/trace/trace_fprobe.c |  129 ++++++++++++++++++++-----------------------
 kernel/trace/trace_kprobe.c |  130 +++++++++++++++++++++----------------------
 kernel/trace/trace_probe.c  |   53 ++++++------------
 3 files changed, 143 insertions(+), 169 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
