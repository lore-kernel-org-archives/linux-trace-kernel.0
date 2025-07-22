Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AD450FE;
	Tue, 22 Jul 2025 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221691; cv=none; b=nqMYy+96R5hLUSoT4vEdoMLTLUZAwYj1kIkWHo+SPUXUTdICPcJJdULQyDyJSKMY7UBrm3x2vvdHvGi71qG7+WGBQk9LbscnCkszqrFs7lfZmQ/F+MMjvRu0ZZNNaSLE16LWfNPDoPfiO0I/04QnIknetcukzg4C4X/RWNQu7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221691; c=relaxed/simple;
	bh=ifmMJEKhhX7G+A9Gpxpd7HAHs6VMQ4pPLI2Io3T31KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSDELLATWrTSKXT02ccEd/9iAkfGfIW4UVL755ZYdRKROD/46yTP67Z1CV3m73axrQZP9RICX/hieTL94eeoxS5E8dqKcP3Sjj+2tJm49gDOmeNOihrvhec97nItzlBckprSmkC8mjACVcjRVfPqPieP81Peq6iPvEAhvUEZts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LztN/nK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LztN/nK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFB5C4CEEB;
	Tue, 22 Jul 2025 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221691;
	bh=ifmMJEKhhX7G+A9Gpxpd7HAHs6VMQ4pPLI2Io3T31KU=;
	h=From:To:Cc:Subject:Date:From;
	b=LztN/nK7FxDNd2vv/1+PUv0m/AGEWoyK4Okt85LJumrB+mRFdk3zPBCLchztYFXx4
	 0iu75KSe9YFHEVHo3V6Z+uvX1aZnmbRUKd1uIJAxtYy8k5vcyoxkP7ew1ls/7OSsi6
	 iAO/Vf5Rk/MTh7WQedpk1cNaDVkedxjkwQ6zVUigzkjN7Je/abk2ahv0IlaocIvLfU
	 C+Jk+DdbGFz4JX78NBYfeGwU4xcmvmbEu8AapdpBhOSkK/+7m0fXVT9BWZGQ1jevMd
	 3ZITdK39WNhS3fPNOPNZ1uliBM9gukYSLo+Bq6r1GiHRVHAgiWBXSsFIEbmN7oxb4m
	 yMw8ys96rZs8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] tracing: probes: Use heap instead of stack for temporary buffers
Date: Wed, 23 Jul 2025 07:01:26 +0900
Message-ID: <175322168606.44400.9155291012158349647.stgit@devnote2>
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

This is the 3rd version of the series of cleanup patches which allocate
temporary buffers and objects on heap (slab) instead of the stack.
The previous version is here;

https://lore.kernel.org/all/175299249728.418723.17799706394466693180.stgit@devnote2/

This version splits the sorting #include part as the first patch and
adds Steve's reviewed-by for [5/7].

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
 kernel/trace/trace_probe.c  |   19 +++++++++++++-
 kernel/trace/trace_probe.h  |   26 ++++++++++++++------
 kernel/trace/trace_uprobe.c |   53 +++++++++++++++++++++++++---------------
 6 files changed, 168 insertions(+), 82 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
