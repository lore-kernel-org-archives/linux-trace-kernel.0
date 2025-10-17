Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025C285056;
	Fri, 17 Oct 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717736; cv=none; b=QmZUmloWkHt44AHrlkJ1z3q22GYbzY9M24rrZe6FBPpno+9AKJLm/9kIFVN0pRF+jghpvzApD3QPr/ifEGon4QJTVa8OOyropb4fdflLY73O6FDEl3fWSNnp9TB857lhEwy4neXPyIYuAppfR4eVGLzLTjuP+FUQ8+ykC+ux+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717736; c=relaxed/simple;
	bh=aGGZ//okTKDB+kPqszxalCvpXi9w07+WW802VCZakQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2nTT5g7ZPyTIfH1UBqN8RY+YsCwG7IIz0kn5+54iWLXp94MUm66rwBjEBfp34ufz15z6GZf1QQlmks2DhqDdfpDsdxALP2ennNahgJ63kBDBDl4WMEmAbuh13KOxW4hkPi9soqUq6Z0gOYt7A5QlwTReOXTs75KwkP0uhhYZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpF5G5qJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpF5G5qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09299C4CEE7;
	Fri, 17 Oct 2025 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717735;
	bh=aGGZ//okTKDB+kPqszxalCvpXi9w07+WW802VCZakQs=;
	h=From:To:Cc:Subject:Date:From;
	b=bpF5G5qJ4cZAaZmDoci6T6kJry9Glo0vXpXsY/sIPcppGAGvL3YEI2CNppik2nZSu
	 GjdlU6vwU/rSha5wkr1R3hHUi7n9DkZXb2d/hk0jU1nM726wYVNTRZyah43W9f2PuP
	 1qNcclGXphjkfvwoXvAI2i6pZV4YLC0+CTBLcUoPfWnV/p7NImDxwEfB8nexuuyNxq
	 Mp1ZvzbZ6MzO0RblclVDNrgqrDFy6URrPyYMcS/2kqrJtlMcnzDqfm7uR1fZLaazxn
	 sM4SVgJuMEqqcG7oY1hY3V5s6pe4BjjMgPAOG1+TtV5kFzhfJWjeOqCHa0DrAycwB6
	 0DQOg7pW0iF2Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Sat, 18 Oct 2025 01:15:31 +0900
Message-ID: <176071773144.175601.17884676964675287059.stgit@devnote2>
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

This series implements an option to show symbols in _text+OFFSET
format instead of symbol name in the function profiler.
This is the 4th version, the previous one is here;

https://lore.kernel.org/all/175918528341.65920.10238038992631012350.stgit@devnote2/

This version uses enum ... : type {} syntax [1/2].

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler


 kernel/trace/ftrace.c             |   26 +++++++++++++++++++++++++-
 kernel/trace/trace.c              |   22 ++++++++++++----------
 kernel/trace/trace.h              |   25 +++++++++++++++++--------
 kernel/trace/trace_irqsoff.c      |    2 +-
 kernel/trace/trace_sched_wakeup.c |    2 +-
 5 files changed, 56 insertions(+), 21 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
