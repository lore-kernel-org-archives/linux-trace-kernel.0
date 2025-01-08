Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E017E900;
	Wed,  8 Jan 2025 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302242; cv=none; b=f63bywLu5WaDxf5gaw46OQsStMFKz2eNJXDX0PVxMQJXQEsEqkQsZeh7ajGsBEHir8xdeZT+flsxgKinaBFO4SiFsywW41VVEXcGtHAQBogM45ei6BKSZvGHPuJbFictSprje5jVBkPVIwYdeC0iTdFH8VBM8KTeNeg741TAejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302242; c=relaxed/simple;
	bh=MFBZ/hXVMbCK3VThPuo6NsrP50jEGAsWutpEtgdbjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKJKRPRQ+yPj9SuFa0ZhArTbqb13cU0+xEuRtu2LH4PspALEusLwE7GZ0O3JNL0XKsRqjnpu6nInFRuEslYh9BSrkAwHoKZuCknUOjzuQFhJNpv9WGaWB1krO65LscpVqXr040tZCazLPBc362tH2poODEBpFsq3pPLrpyq1Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgvSo7db; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgvSo7db"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE28C4CED6;
	Wed,  8 Jan 2025 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302240;
	bh=MFBZ/hXVMbCK3VThPuo6NsrP50jEGAsWutpEtgdbjM0=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgvSo7dbx845rKTQB6QNoD7V9YvZbd2HAL7wuj+zU0Itx3UmPRB+N0KlZVxU8I1rw
	 3yhGGIK1AVC6iE5PmktgTVEr1yoJfXNpgVlgSMNExjD0AmhyXVyVF+Bst9clvO3N7i
	 In/V07TDS2FHuhy4UweK/R1mTvWVrdAwwdFNFReuRKUL4q2tpPyd8yRo1UzYIknZI8
	 FIWC+LhOBisCkbnT2ilayjTVV2plgYa6EztWcqVRrN/nEOEmT56/SVT+34VXAXCtJj
	 4PdVnkMS3fgXqgzslUWu1lepu8qB0lASV8TfL5l2rYxOD+Yr4N3EHRIjVmxrTa7s4V
	 36ESKj1iCtMwA==
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
Subject: [PATCH v5 0/5] tracing/probes: Cleanup with guard and __free for kprobe and fprobe
Date: Wed,  8 Jan 2025 11:10:34 +0900
Message-ID: <173630223453.1453474.6442447279377996686.stgit@devnote2>
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

Here is the 5th version of the series to fix and cleanup probe events in
ftrace with __free(). The previous series is here;

https://lore.kernel.org/all/173629943548.1450013.12412761424554510119.stgit@devnote2/

In this version, I updated [3/5] according to the comment from Steve.

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
 kernel/trace/trace_probe.c  |   51 ++++++-----------
 3 files changed, 141 insertions(+), 169 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
