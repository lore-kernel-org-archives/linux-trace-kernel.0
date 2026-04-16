Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8825A2DD;
	Thu, 16 Apr 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334606; cv=none; b=Y1//OiwpZdz0ln1LmxvsQn08VEU+G3ObrnLqCXQkwa1tf6PsdJHr/aUNUStFy9t0Z68RyGvrnzJ7pJzIXztqjxpEHVlBlIlwh9jS+Ny/0L698hCKKByE50blhxl+fqjxKcIFYrPJXchl5HE4AD+SL3K/gatpRiKwAR3Pq4Qoq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334606; c=relaxed/simple;
	bh=qMtDNZElctriGH6+hXsbfmBeVtr1r5NRkbuVFLnGRso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nkh5te9sAgmd2ba6iZeTKl5r5DElW+NYitY4KkFaQ/1XfmrWTLBxfVST19gV7CAlcINr3pRmrL1AMdifbPx8JNxjqvReKMGnB6pE8wlpP+Qm8O4MCE71ZFe6h9iV93wzLl5xb2S8YtLZQkWxZlK8tx701/BgWkrIMqLZMsr5vhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+XCeR34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+XCeR34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568A2C2BCAF;
	Thu, 16 Apr 2026 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334606;
	bh=qMtDNZElctriGH6+hXsbfmBeVtr1r5NRkbuVFLnGRso=;
	h=From:To:Cc:Subject:Date:From;
	b=V+XCeR34A8utXi1qS6gXi2ezRFIWCFdhqTQtFVXA61nD4ahYN3Ff/ww5joiFHN0Uy
	 b3ehO36bx96HpdCht+ZlIzggiq+cvbYsh2BAFfJgYvHxlst4kMPjfttsql714e6B+y
	 2T6JnlSiVpN2zcK0yj9AdSfy1Qmo5WfGpft3eG6oyOKm+kSmlVWPnvJZNmACQTgZ1I
	 J9cZ67m+R8oNOFegS8Hq17MkBY8Pf+DhoB+KKAPMICjXqv9C8uUTmK9kIaO0K7khH8
	 cczUndUakkBm90DAULyeQ2PlRyBJJTx/dbYhxqO7WqcVCR3FI/LRf3tnKNR2yTFHZf
	 zuu8CR+QLBfYQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 0/8] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Thu, 16 Apr 2026 19:16:41 +0900
Message-ID:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
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

Here is the 8th version of fprobe bugfix series.
The previous version is here.

https://lore.kernel.org/all/177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com/

This version fixes 2 issues - fixes to check the return value of
add_fprobe_hash() and break the fprobe node installing loop if
insert_fprobe_node() is failed [2/8], and fixes to check
fprobe_graph/ftrace_registered flags directly when registering
ftrace_ops [6/8]. And this adds 2 new test cases for checking
the fprobe events bahavior fixed by this series [7/8][8/8].


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


 kernel/trace/fprobe.c                              |  475 +++++++++++++-------
 .../test.d/dynevent/add_remove_fprobe_module.tc    |   61 +++
 .../test.d/dynevent/add_remove_multiple_fprobe.tc  |   69 +++
 3 files changed, 448 insertions(+), 157 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc


base-commit: 4346be6577aaa04586167402ae87bbdbe32484a4
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
