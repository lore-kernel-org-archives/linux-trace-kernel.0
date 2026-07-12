Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9EE571;
	Sun, 12 Jul 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868771; cv=none; b=N1fvtkqZN4O5qPSHyf951RKfnJ1qwosbmdTAIYHlw4E1OHIokYUtMXgDu5TOdKFje/U/bG95JRII9QWqgz43K00RMJavafFBtCypo8OIYocXXx7A2+x1l+QW/e0wfd3T0UR94abdrD1B2QRA3g0HjQ8Tl9DUJ82Jl6BOoGQfhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868771; c=relaxed/simple;
	bh=VGopf73H9uqAXmAMqFk2LuaMYsb22YkF17tv/i4hBLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VPCUxkzxP6L87Wszm++rDAZCBMHXopz5S0+dOO+4m+twl2kFqsyfurpsSzzFXkqcDrk13J8O1ZTucuibuXSdbHD96revARNWzyUg+cnLrk42ZOfhYgGIR50DV4egnz5a3EITT+7leiKzkB3HZ0PhXE6iHKLaKt92U2+Eh+zDf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfun3ID2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfun3ID2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A901F00A3A;
	Sun, 12 Jul 2026 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783868769;
	bh=6KslKZnUZBgY/tcRhda+JGqBK+mVKpqlAJXsgjnbxDA=;
	h=From:To:Cc:Subject:Date;
	b=Gfun3ID2lvmHQ++lOzVrYIndIbR9oZ6FUmsxuawM3u76hThkh1Kb6nCXQvz/E3Yo8
	 pnEBW4vCQ3U+Ehxk2HJLFb4Euf2EdR9aTygV54QcdGF196oZo6t6uYDviRAgKj8Ri0
	 2sG4MOCd45GtbArTzIKBwDiojMxvL9YHYIYKSCLtMkjirT1stVHvto+poeGXLMmAgu
	 HFyeCj7kSqyOjcnUpYsCm/cLuyqKJU4cTl/aieUsnwaTrTelPzczBJa1WjrwgHvGMg
	 /mgF5+rgeRmVJVWEOXb8G5f9P2qgmLjcZjE89z1Way+ILXtZkt94iy+kiFU6Ba/UuP
	 e5l2kj2xK9Waw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] tracing/probes: Clean up and refactor argument parser
Date: Mon, 13 Jul 2026 00:06:05 +0900
Message-ID: <178386876526.3174487.5142283230157728964.stgit@devnote2>
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

This series refactors and cleans up the fetcharg parser in the
trace_probe. The main goals are to improve code readability,
prevent kernel stack overflow by eliminating recursive function calls,
and extend the argument string length limit to support complex BTF
typecast expressions.

Previously, parse_probe_arg() recursively called itself when parsing
nested dereferences and typecasts. Since the kernel stack is limited,
deep recursion is undesirable. The [5/5] eliminates the recursion
by converting the nested argument parsing into a loop-based
implementation utilizing a parse state stack. To prepare it, the
[1/5] and [2/5] cleanup (decompose) the parser functions.

Additionally, this series increases the maximum nesting depth from 3
to 4, extends the argument length limit from 63 to 256 and updates the
associated ftrace syntax error selftests.

Patches:
- Patch 1: Decomposes parse_probe_vars() into smaller, dedicated helper 
  functions for parsing specific variable types ($retval, $stack, etc.).
- Patch 2: Decomposes parse_probe_arg() into static helper subroutines for 
  handling registers, memory/symbols, and immediates.
- Patch 3: Alphabetizes the ERRORS macros list in trace_probe.h to improve 
  readability.
- Patch 4: Extends MAX_ARGSTR_LEN from 63 to 256 for long BTF cast/dereference
  arguments, and introduces MAX_COMMON_HEAD_LEN to prevent regression on match
  head commands.
- Patch 5: Eliminates recursion in parse_probe_arg() using a loop and a parse 
  state stack integrated into traceprobe_parse_context. It also raises the
  nesting limit to 4 and updates the selftest scripts.

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
 kernel/trace/trace_probe.c                         |  843 ++++++++++++--------
 kernel/trace/trace_probe.h                         |  196 +++--
 kernel/trace/trace_uprobe.c                        |    2 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    6 
 8 files changed, 635 insertions(+), 426 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
