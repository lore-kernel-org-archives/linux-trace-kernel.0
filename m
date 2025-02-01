Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E80A935;
	Sat,  1 Feb 2025 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394586; cv=none; b=MKMoQBlSryR3n/e1kVG8xBS+Kwi0HszoRHE3IKA42iVdchhgSK+KG3G6RmkeCdov4hKrcwRQQjHeHWdrHdFt8D30JxJv/cCRnscBdwXH2eaNC6aJWXJuwT+vka26urYvdPxYxBI/vuE167EzGvYXWJToeWfsSpjLJlJ8q9Bs9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394586; c=relaxed/simple;
	bh=Bw6zEIvwBS1md1QcsSs+l/VCAnNG/P2sUBn8/0QbnrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pmjJS9Q8L2O7Wv8DqL0v3gqVjOC3LhzfY/2od5FGlHorBbKpQe+8BgxS9TOt0jU232fFlexuKXh9EzUoYBlMf6wJg/nZiX2TB8GMXcEP4FW8tyGNcokZC01m1hby2Qn69XnX51M0IDeb5NEldKw/3EUTmMJSfv/6GWl10FTNPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABlxxDWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABlxxDWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA57C4CED3;
	Sat,  1 Feb 2025 07:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738394585;
	bh=Bw6zEIvwBS1md1QcsSs+l/VCAnNG/P2sUBn8/0QbnrM=;
	h=From:To:Cc:Subject:Date:From;
	b=ABlxxDWwthL+zhVkSahvybhum4JPn9ELgp0/+AB6+w/bUCTTHtt0JZLAybTuQqVbv
	 SXdd773zOhFO5EPorlAHl9Vri41+OHqBmgUVc9yEl3CZL1SfYbkTXPnw/gqw2V8F82
	 Ib5mmQN3xxj1df/dIAWK3ZfiCGqh6z0QyHnvzL8cOFhdBJNLvcgA+XvA7x57zT3rwm
	 4l2wFl41aMOpL9hWy+zdSkhs+OlFN4yfEdte2dPBDYC03Yy3ZhM92SYs7/fibspvvc
	 yR0Mu+nVGWZANuFhUrqEO7RMHpexf10FkSxJyLWlNYbzjsfnlXGdkiq1polWwSJjBj
	 FeGFHqhk4jBbw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Date: Sat,  1 Feb 2025 16:23:00 +0900
Message-ID: <173839458022.2009498.14495253908367838065.stgit@devnote2>
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

Here is the 2nd version of adding relative stacktrace for tracing.
The previous version is here;

https://lore.kernel.org/all/173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com/

In this version, I changed the idea to only use the first 32bit of
the build_id of the modules instead of using live hash/id to identify
the module. Also, save the offset from the .text section for each
module instead of using the offset from the _stext for the module
address. (For the core kernel text address, keep using the offset
from _stext.)

This brings the following benefits:
 - Do not need to save the live module allocation information on
   somewhere in the reserved memory.
 - Easy to find the module offline.
 - We can ensure there are only offsets from the base, no KASLR info.

Moreover, encode/decode module build_id, we can show the module name
with the symbols on stacktrace.

Thus, this relative stacktrace is a better option for the persistent
ring buffer with security restricted environment (e.g. no kallsyms
access from user.)

 # echo 1 > options/relative-stacktrace 
 # modprobe trace_events_sample
 # echo stacktrace > events/sample-trace/foo_bar/trigger 
 # cat trace 
    event-sample-1622    [004] ...1.   397.542659: <stack trace>
 => event_triggers_post_call
 => trace_event_raw_event_foo_bar [trace_events_sample]
 => do_simple_thread_func [trace_events_sample]
 => simple_thread [trace_events_sample]
 => kthread
 => ret_from_fork
 => ret_from_fork_asm

Thank you,
---

Masami Hiramatsu (Google) (2):
      modules: Add __module_build_id() to find module by build_id
      tracing: Add relative-stacktrace option


 include/linux/module.h       |    8 +++++
 include/linux/trace.h        |    5 +++
 kernel/module/Kconfig        |    3 ++
 kernel/module/kallsyms.c     |    4 +--
 kernel/module/main.c         |   29 ++++++++++++++++++++
 kernel/trace/Kconfig         |    1 +
 kernel/trace/trace.c         |   50 ++++++++++++++++++++++++++++++----
 kernel/trace/trace.h         |    3 ++
 kernel/trace/trace_entries.h |   18 ++++++++++++
 kernel/trace/trace_output.c  |   62 ++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug            |    1 +
 11 files changed, 175 insertions(+), 9 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
