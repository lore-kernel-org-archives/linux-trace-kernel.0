Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6F21E097;
	Mon, 20 Apr 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693643; cv=none; b=CwrVpTr7v94PtegOld5DlHXvRse9ZQ21vBg4g/ErquySgc5Q6v3l1m/x74sgfg23Q4dZlvr2QCpZE7HOh03C6h/81++Ckbnrg80V+n9yKSh0cIcqJluNlY1trl5G0jZAIRjjDMlrqlYGeFH3wX8ccljYGa28WMxI4kk+zGOKn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693643; c=relaxed/simple;
	bh=EUpUcNzq8A8vwvSYgr07zfRdi8SR60OLomWmqRzpkM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dQwqu0gNKtwlWOBCtu6v3e581GJ3guxsBRH3pyBJMVfeIaX1CyyFGllOBsI/rEpJE2q2Sqs4WVAGapXzJh0egacvzqb7bz/rXPzo7zbIlp500kQZ7ZJDlcIj1Ez+uXtIw1OtC3K9WT6c5JmprLKEKrkjB1/xQSSeyZvRedKlmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa/z8iK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa/z8iK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF22C19425;
	Mon, 20 Apr 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693643;
	bh=EUpUcNzq8A8vwvSYgr07zfRdi8SR60OLomWmqRzpkM0=;
	h=From:To:Cc:Subject:Date:From;
	b=fa/z8iK65gQvK4K6BHjNjLfyBTfkUuhXokiveItEgZnfHMwfWEMKlSvnAWl6CNnps
	 qTftpRxePRs0iHnbEiiyrdA1T+ymRzgbzh5IM1cJjVObFRjy4LJ0fUoN3TX/VvLVzR
	 +gOsZTJ7IzJTeNZn+oZp9bRVEv1C2xlYE5fcaNhhlXtszaJSctqd9jzpTsAvztGDWi
	 f9RMLmVRownctRup/O+fqB34hT6O0nU7PX7IbP8BbKK+xS7Ui/P4J+xHJRGC+joX0R
	 scsPQF3I6DUIECHRS9NmTlNu5bqIydnOz9+jncITnQSTDR9CJGZ67kQ1fGfZ7XbSWD
	 usNOMooqs3lcg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 0/8] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Mon, 20 Apr 2026 23:00:37 +0900
Message-ID:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
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

Here is the 10th version of fprobe bugfix series.
The previous version is here.

https://lore.kernel.org/all/177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com/

This version fixes minor bugs. Add an RCU sync when fprobe
registration failed [3/8], call __fprobe_f*_unregister()
if there is no node on hash table even if it fails to allocate
working memory [6/8]. And fix to check "normalized" module
name in error path [7/8].

Sashiko pointed other issues[1],

[1] https://sashiko.dev/#/patchset/177644266147.584467.8179035927318998910.stgit%40mhiramat.tok.corp.google.com

- Is there a missing RCU read-side critical section here?
  -> No, it is under preemption disabled. It seems a preempt
  disabling is stronger restriction for RCU read-side critical
  section.

- Does the error fallback path leave dangling pointers in the global hash
  table?
  Yes, but it is not introduced by this, and is fixed by [3/8].

Thank you!

Masami Hiramatsu (Google) (8):
      tracing/fprobe: Reject registration of a registered fprobe before init
      tracing/fprobe: Unregister fprobe even if memory allocation fails
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one
      tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading
      selftests/ftrace: Add a testcase for fprobe events on module
      selftests/ftrace: Add a testcase for multiple fprobe events


 kernel/trace/fprobe.c                              |  472 +++++++++++++-------
 .../test.d/dynevent/add_remove_fprobe_module.tc    |   87 ++++
 .../test.d/dynevent/add_remove_multiple_fprobe.tc  |   69 +++
 3 files changed, 466 insertions(+), 162 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc


base-commit: e0a384434ae1bdfb03954c46c464e3dbd3223ad6
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
