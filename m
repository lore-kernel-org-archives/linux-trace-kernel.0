Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792042153C1;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080716; cv=none; b=eLwHFmGrGBfAqhqa35YvH1MvCz/wzF3xkvjQeo0TK7RwJiZZQaSJI1t7c/prjzH7X3nCSF/RbhVUxdrD/SrsiWV3b9XBx86EB8gF+N/1UCDTov8mtRXnOD4/Z3BFVxOXst3O0QD/QNhr4219qp3Mcv+ku/plsjNP6tWHdGY0ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080716; c=relaxed/simple;
	bh=nDxsBCHCQu8MBsf5iftU3Rf3IAMDt/R09xhx4+Q+U3k=;
	h=Message-ID:Date:From:To:Cc:Subject; b=o9H69ncW1XKdobv2St8h/m/DYfzzEBYJHI+2adyLEnjt0alLQThKI2b8nv0pa1sY+noa0LwhLPm1Z2MqJfsmfUMUfnBdS7/pZso5m9MhPO4eEO/XXaC0E3F+olIrps5tDW7Zez8qHpD3t63fzTGNFBuNz0vxliZY1Xz2IKKzSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO8Wfou0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO8Wfou0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DBDC4CEF4;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080716;
	bh=nDxsBCHCQu8MBsf5iftU3Rf3IAMDt/R09xhx4+Q+U3k=;
	h=Date:From:To:Cc:Subject:From;
	b=ZO8Wfou0ALyzV29VeMxHFakPK/thVibaNxkeowmwrc6xh3x/lr76MxHWe5H+NYdkZ
	 J6tvlmFBblH2F1klWIrU10iWMS0Red033ofHwm6+KyibcSvF+GENRHyoiHKn/yFtdU
	 EwOX8Oe5/RDR0cy9O9EAprMjoCOZFQy7lLx3+8mL7dsAUBLS9zF6rEOGZBp+Sx3UKn
	 YOcyT60G4qLzGxrO1FellpACnjnfbL5BrsfBq2ZdP3s7KYq2UrWuwGtgOVCakXu7G9
	 XDFUBppkkMgYBmnZYkYQCozWNWL4lJtnocMxNtyhz+Si38G3VSyAaA6QZqWE/doq04
	 syJO6ST40cnMw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhwWn-00000007jZ4-28xx;
	Fri, 01 Aug 2025 16:38:57 -0400
Message-ID: <20250801203722.072085868@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 16:37:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] tracing: Cleanups with use of guard() and __free()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

This is a cleanup to use guard() and __free() where possible.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250801142506.431659758@kernel.org

- Do not use guard(preempt) for trace_event_buffer_lock_reserve() as that
  returns with preemption enabled between the disable and enable preempt.


Steven Rostedt (5):
      tracing: Remove unneeded goto out logic
      tracing: Add guard(ring_buffer_nest)
      tracing: Add guard() around locks and mutexes in trace.c
      tracing: Use __free(kfree) in trace.c to remove gotos
      ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)

----
 include/linux/ring_buffer.h       |   3 +
 kernel/trace/ring_buffer.c        |  16 +--
 kernel/trace/trace.c              | 287 ++++++++++++++------------------------
 kernel/trace/trace_events_synth.c |   6 +-
 kernel/trace/trace_output.c       |  17 +--
 5 files changed, 114 insertions(+), 215 deletions(-)
