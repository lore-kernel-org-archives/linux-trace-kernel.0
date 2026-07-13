Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AA36DA03;
	Mon, 13 Jul 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927665; cv=none; b=myZIwzf3SCezMt08uCzducS9qxOw2p0zeoDCQvdrpg/2pCefpI9O5Q2ni1Rv7wbabDSnT1wobLc3jGlewqJ6qMs3JEqdjHNxHIKpqo5gzztdGCLo5bP3OlClXkSaRsEMlfGawpiqDS/wN+2Jb/Jue7ueWp0fNt1bNAM+x/bJ7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927665; c=relaxed/simple;
	bh=7Ze6QWJxbeYzeMk2di8RFP6bK54oUY/EI5wHAnDQJw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OP9Q0EgS/v8fc9Utuasgl36r4nfOtP/6b1oSDQRf5k04j8DRzIyBG09PDyOOadxyJWvAHl0rKifcDSZ7H/FM927pmiO0+ODULSrAb1CrxgoGAq9NQnOkorm07i6J5VJr6OgYy3euwHFDL/Ws/7JWjCSNHErCCIjVAJDipzxKA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbZVZ++I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbZVZ++I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A817C1F000E9;
	Mon, 13 Jul 2026 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927663;
	bh=cbBWZOX1wArkZKBGbX+gZQrzhCButI2m7s/E49Kj+Is=;
	h=From:To:Cc:Subject:Date;
	b=TbZVZ++IYS6CIvD4opJTfBkmebbznXqCTNgi3UlWDAxUhUU8/q99E428kK732PFJf
	 bkKk5aD5Jq2s598OI1RfMAUaqMVtpHoaJkSVhUCRBczR1M25U6kKY0pv5hUlep7T/G
	 EpIaunvqwWCuHtccxBGrwM3/w/Nhdji8PQ+0amll3/itluxgBtjaJkSxZtpb66KM0K
	 hMc+VUpVBObWfoKlbk1NUsSSCxIrrb3+qrRa5ZP6emz/9Ale5tBm9nc8uEB0MZ7enu
	 JIRgBHRbxoqyV/LtmuNDjZsw6DetW/LLvMaPejAaHivUDNr0nPdupLYa7Q90rWL+Ve
	 Q/7wSAU1uy5eA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] tracing/probes: Clean up and refactor argument parser
Date: Mon, 13 Jul 2026 16:27:40 +0900
Message-ID: <178392766002.3229912.15711868107734330750.stgit@devnote2>
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

This is the 2nd version of the series which refactors and cleans up
the fetcharg parser in the trace_probe. The previous version is here:

  https://lore.kernel.org/all/178386876526.3174487.5142283230157728964.stgit@devnote2/

The main goals are to improve code readability, prevent kernel stack
overflow by eliminating recursive function calls, and extend the
argument string length limit to support complex BTF typecast
expressions.

In this version, I fixed the double error log issue in [1/5], make
MAX_ARGSTR_LEN to 255 [4/5] and update patch description for clarify
this change updates the behavior (not a cleanup) and
make TRACEPROBE_MAX_NESTED_LEVEL to 8 (also update testcases)[5/5].

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
 kernel/trace/trace_probe.c                         |  829 ++++++++++++--------
 kernel/trace/trace_probe.h                         |  196 +++--
 kernel/trace/trace_uprobe.c                        |    2 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    6 
 8 files changed, 621 insertions(+), 426 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
