Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BCF2153FE;
	Mon, 31 Mar 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435331; cv=none; b=YRZDr05f4ymuUEaJW0zO+WlWaH9YQlyHsQKklBtg3JjAPOojHqphoCV974yWLP2ZdTLxf1BmeUnLg4Uqx3jkdyNpg1svx/qSVkhmi8oc3qKI+Dfm4RnR3cSSZAiVZ+Vvj5sjMGjGqSACJF8vCeHfntZ6SMc3O64NJZfqbt8A+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435331; c=relaxed/simple;
	bh=RZ8MhEDbNJNetm5coGFBi6WxtiT8BY4yxO0ULjAJ78U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOb6qMJAG/FPUb+15lB0ezBwINgvWJfTE0TZAr9nGdIK5WRXlhn4Er0ZArEo7dt122J61uvl+RLZWCr0u9RxAb9DMo2TVtuUlxasxdDaZYJ96IAYxS/XNMemX5Z3onTrUUrhxp9822+nnygHPr+91PEWbp/lyTTob/MAyHbLmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CodPJ0FZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CodPJ0FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431C6C4CEE3;
	Mon, 31 Mar 2025 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435330;
	bh=RZ8MhEDbNJNetm5coGFBi6WxtiT8BY4yxO0ULjAJ78U=;
	h=From:To:Cc:Subject:Date:From;
	b=CodPJ0FZlhKmAbD9CUzE2OGdSseisV8YIJ5xfEd1WZ6zXFIvnQppAZicmSojFOG01
	 b3Mw2YA/cKlEt8EecCGRB6P4prgXarJSvvyHA83LuZYZa5tGvOwpYJH2lzh3yJB6Y/
	 hpTRcGfBs1tE/UfWhHWEvP/jc3q69gpAqHEZWQMVrLe4h73AAcuP+t9CQ4Xew1n+Az
	 57VRkSa/na+hb6bBYbaEmRmefKVlmNK2l7D5zCfMTpBibk9IBKFnKG8q0iXZuR0EsL
	 ahcvY3MtDclz7Lc9KIyPI53XSSaN3dOhaIZDmbPvSE7jgFlXpBV1jUGTQhcdipP4cD
	 fhqHBdBx22c8Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] tracing: fprobe-events: Register fprobe only when the event is enabled
Date: Tue,  1 Apr 2025 00:35:26 +0900
Message-ID: <174343532655.843280.15317319860632975273.stgit@devnote2>
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
Here is the 2nd version of the series to register fprobe only when the
fprobe event is enabled. The previous version is here;

https://lore.kernel.org/all/174212767109.348872.18231451508464729427.stgit@devnote2/

In this version, I added fixes([1/7] and [2/7]) related to module
unloading ([1/7] should be handled separatedly) and updates
according to the previous thread.

Steve suggested the fprobe-events are always registered when it is
defined, even if it is disabled and that makes system overhead.
This series registeres the fprobes only when the event is enabled.

Thank you,

---

Masami Hiramatsu (Google) (7):
      tracing: fprobe events: Fix possible UAF on modules
      tracing: fprobe: Cleanup fprobe hash when module unloading
      tracing: tprobe-events: Remove mod field from tprobe-event
      tracing: tprobe-events: Support multiple tprobes on the same tracepoint
      tracing: fprobe-events: Register fprobe-events only when it is enabled
      selftests: tracing: Enable fprobe events before checking enable_functions
      tracing: tprobe-events: Register tracepoint when enable tprobe event


 include/linux/fprobe.h                             |    5 
 include/linux/module.h                             |    4 
 kernel/trace/fprobe.c                              |  108 ++++
 kernel/trace/trace_fprobe.c                        |  593 +++++++++++++-------
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   30 +
 5 files changed, 531 insertions(+), 209 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
