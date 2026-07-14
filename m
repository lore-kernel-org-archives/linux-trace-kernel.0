Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA1280035;
	Tue, 14 Jul 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991372; cv=none; b=nKx2uAtMJs14UQoOWIdwIB8F5paGcfdvCNTsLDIjQhRqe3qbZsBSEKsViiW72JX8vwRxNKssdv75eF/5b50afE0t0iDgEa4Do6JzuOOW3+fUjgzGoLWbgyqqlXlCW2qxSbTt8o7JvqDuLLbbA4do7NcIcy4V8FHtSZKALGv3NRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991372; c=relaxed/simple;
	bh=ttWPChlhws4gGGPouKuFBLWaeK+iNDH7aJZXI3Y90Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8Dvg9IkLjKAXW99ZA0Shkq6LzehvcFHtRxaDI/ZtVk1bUKfUwLvWhUIFLkT9x6XgTEBZQmYFF8+WGnUaJS+Swv5KusPU9gq2l4Bo5as8+VphDSOgI51GnQE9YrFSBcDxt1bQCrX7bJBXSL6nXbiVDj5/3KgTxnfHXC3BkdNXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/2rjAQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/2rjAQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E061F000E9;
	Tue, 14 Jul 2026 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991370;
	bh=YcmcItxkcAWfEjWLVWpTGSQYqpjCQLZGmT/fADwoFXU=;
	h=From:To:Cc:Subject:Date;
	b=G/2rjAQQ0eJtxu3BJNGrTz/ISAU/SyfcJVGIJuehZNY1LLM87lIRi8iEBMnuNpSny
	 M9lt1C/GF9khWEOAXU9/cjcHnvwj69CcfR/nPon69Kpbnzww4YNJmq6DyA0QtmTD1O
	 aFqoVrGOn+WmPV3+kgq7EuzF/KSUc0ps1OSStKu1UsVxy4ro9XAYEc3O8O9zcF3Vx/
	 I3iGztJIJQTYgqLPUu52foHFTkz3B/eXGcivVqoeQYfKW2BHebNo2vQNjJ0UmX4tXV
	 RT7BQZ9Sggus7jYG/3H6KSNmW1+xsVqM/IEMdB/mLS6oQ1ij4KOnQlvjtI68aFPbmz
	 40RPLygydG1zQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/5] tracing/probes: Clean up and refactor argument parser
Date: Tue, 14 Jul 2026 10:09:26 +0900
Message-ID: <178399136606.27810.4469135881050354189.stgit@devnote2>
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

This is the 3rd version of the series which refactors and cleans up
the fetcharg parser in the trace_probe. The previous version is here:

  https://lore.kernel.org/all/178392766002.3229912.15711868107734330750.stgit@devnote2/

The main goals are to improve code readability, prevent kernel stack
overflow by eliminating recursive function calls, and extend the
argument string length limit to support complex BTF typecast
expressions.

In this version, I fixed to remove unused variable and add a
error log in parse_this_cpu() [5/5].


Patches:
- Patch 1: Decomposes parse_probe_vars() into smaller, dedicated helper 
  functions for parsing specific variable types ($retval, $stack, etc.).
- Patch 2: Decomposes parse_probe_arg() into static helper subroutines for 
  handling registers, memory/symbols, and immediates.
- Patch 3: Alphabetizes the ERRORS macros list in trace_probe.h to improve 
  readability.
- Patch 4: Extends MAX_ARGSTR_LEN from 63 to 255 for long BTF cast/dereference
  arguments, and introduces MAX_COMMON_HEAD_LEN to prevent regression on match
  head commands.
- Patch 5: Eliminates recursion in parse_probe_arg() using a loop and a parse 
  state stack integrated into traceprobe_parse_context. It also raises the
  nesting limit to 8 and updates the selftest scripts.

Thanks,

---

Masami Hiramatsu (5):
      tracing/probes: Refactor parse_probe_vars()
      tracing/probes: Refactor parse_probe_arg()
      tracing/probes: Sort ERRORS list in trace_probe.h alphabetically
      tracing/probes: Extend max length of argument string
      tracing/probes: Eliminate recursion in parse_probe_arg()


 kernel/trace/trace_fprobe.c                        |    2 
 kernel/trace/trace_kprobe.c                        |    2 
 kernel/trace/trace_probe.c                         |  833 ++++++++++++--------
 kernel/trace/trace_probe.h                         |  196 +++--
 kernel/trace/trace_uprobe.c                        |    2 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    6 
 8 files changed, 623 insertions(+), 428 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
