Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC60346766;
	Fri, 17 Apr 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442667; cv=none; b=P/8GW4+y6IdbU2jzu0Z+E9KnGBoAgJ3A4tuv4fUftbHk4k8yyjkkMU/387nmSTto6U3zO0Gb2V1ZQNtyYolFUCCefiVMaohcPNIQqofaOrWnJJ+hJ4lt3lojDQNh/nJpMfS8GVH5E82hoYb1iAeaZ2ORXBbmmYfLdIUtAi638Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442667; c=relaxed/simple;
	bh=IMD7+3cwuMAtgVQQhO4nFCYHX9wKLVPopYFhGaxcXew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bRcZL20nImrupmC0VuXWsBbw/Sr2RJYGfOgnQFyhf5YHWkQ4eVPKRWMMZE7J9eM9+erg6WvWYKB6ms/DcbN8nPEs2zgnwoDhx3JXiygH7gm88cmgjuGGwfjQzspl01OI0mQD7sJOkAhSlbZi2MVhEp8XZ4WSm5kZpWBVi/aC5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiYApStH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiYApStH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2759BC19425;
	Fri, 17 Apr 2026 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442667;
	bh=IMD7+3cwuMAtgVQQhO4nFCYHX9wKLVPopYFhGaxcXew=;
	h=From:To:Cc:Subject:Date:From;
	b=XiYApStHNx2gz8zNqWTnmRj+YWOmFW+3iuj6ThZ48POxk7JPzHKiSzDVp7N3A0c93
	 pYgS3WDJ9gft4LNMyQdNN+j7h8iED5+tKaSotE3xTje8aAh1oh8tq3NvtZmuHynMk4
	 Z90SjqdwCtzOyTiof7VL9+SXJuI+8O1gaYLkSOGPxP+q9XbwaFRDSK4CG0ODa9A2kr
	 /ZyLFWEeYO8Mn8cWqvyOd4eyvC0d2LWwWBm0YrkPyHF0yF14EZhOdK3PqAZcIb/NrC
	 Pzu359Pj5n3E6ZNxm11RB5aA+yhY2GuXptH1Jg/H46YoTaUbqZYLQuROYlpSTIcWa1
	 tE/SuCtsDZK2g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 0/8] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Sat, 18 Apr 2026 01:17:42 +0900
Message-ID:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
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

Here is the 9th version of fprobe bugfix series.
The previous version is here.

https://lore.kernel.org/all/177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com/

This version ensures the ftrace_ops filter is cleared when unregistering
an fprobe, even if memory allocation fails during the unregistration
process[2/8] and fixed module unloading issues by removing
fprobe_graph_active and fprobe_ftrace_active to handle cases where
fprobes are removed after a module is unloaded[6/8], and update
selftests/ftrace to updated the module test to use "trace-events-sample"
instead of "trace_events_sample", added checks for module unloading and
removed the core-kernel event case, and ensures the test module exists
when unloading it in the EXIT handler.[7/8]
(Also, this rebased on probes-v7.1)

There seems RCU sync issue repeatedly reported but it is in fprobe API
level issue. Unlike kprobes, fprobe users should use kfree_rcu() or
call synchronize_rcu() explicitly by themselves, because it will
use some common resource in its handler. Tracing subsystem does that.

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


 kernel/trace/fprobe.c                              |  469 +++++++++++++-------
 .../test.d/dynevent/add_remove_fprobe_module.tc    |   87 ++++
 .../test.d/dynevent/add_remove_multiple_fprobe.tc  |   69 +++
 3 files changed, 464 insertions(+), 161 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_multiple_fprobe.tc


base-commit: e0a384434ae1bdfb03954c46c464e3dbd3223ad6
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
