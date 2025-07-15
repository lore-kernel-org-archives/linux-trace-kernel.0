Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414A42A83;
	Tue, 15 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576957; cv=none; b=G7QbC++j2dXMQ0VQApAl0mQBmbX1tXlSk+lKo13qjEYAcnnclunAZ3OgE4Z1nhlS86mCzvsLBPE3bEJFAVtDfk02DOBiW4PQ+MTDlBiHjggpGGiQS4XqWl58DYKui6ZV37g3obkantX06lyQanktioLHmSpjw6nvLAmEf75RbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576957; c=relaxed/simple;
	bh=PhbFIN8Ic5vl+KO50PpjnZaSaGXztmJ8FYFXZXo13x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUqTD0QTneKk0oRB+UXuBbQcIpyi6APT2HhFvBfds64s5wBtKtjNi7V4gaq9YJ4h1ohggjJQT5/6wEhu5lhetz7H3T2BBC8wtzvW6q2F1uhnBxeokVZW/7I3qBJdGREtLdkxDW9lE4DnryieNDtHp3wnrD4QDjRoMGSszokHrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXL2Bykr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXL2Bykr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B5C4CEE3;
	Tue, 15 Jul 2025 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752576957;
	bh=PhbFIN8Ic5vl+KO50PpjnZaSaGXztmJ8FYFXZXo13x8=;
	h=From:To:Cc:Subject:Date:From;
	b=lXL2BykrZV9kk40+468UiCn6juQqCTaQ7On+oPKRT2LsNdwdRgh8mIXIq9zl9UrO/
	 jigyPW7Cxwvpo9ju5OKxKR3eDZZxMWHnQ5w6ugByFWXFlxLsOGVMNCBLwLU1CQU1Pv
	 28v5obOQNiYF1sXkCWOiCH4xF8cRLUUvXO9KfwphWP4/bPXjdvHa5JsF/n1Z+1UK8F
	 WbafmCC0Su8wqHNVR9CqjUDAmfbuZh3m1E2eChtvkplqIYAC1EAHFJx1QbkEYcxrkj
	 Q6OYvT3vBuSyTI7kWqsLJpVteNrUwXW3Sw6mn9sJ1FhzXlWuIE0lQM+/5q5nnLbKKv
	 P7Y8fGRx0uoeA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] tracing: Fix an event field filter issue
Date: Tue, 15 Jul 2025 19:55:53 +0900
Message-ID:  <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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

Here is the 3rd version of series to fix the tracing event filter
because of __attribute__.

The previous version is here;

https://lore.kernel.org/all/175223150823.2878276.5814683250353215724.stgit@mhiramat.tok.corp.google.com/

This version merges the sanitizing process to eval_map event
fields update because of avoiding performance overhead at
boot time.

This removes the __attribute__ from the event format type string,
which can cause issues with parsing (detecting the string type).

Thank you,


---

Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format


 kernel/trace/trace.c        |   23 ++++-----
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_events.c |  115 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 112 insertions(+), 30 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
