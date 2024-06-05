Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5984154445;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619225; cv=none; b=lQQqhIdf2YF+O5CLEd5wGAbiiDiNXgVfc1bAN1tqnkzNLwN+3I5chbZbhlBAgDENmYBToUljScf5vJXAVhiBxGHcBRz57kwkBRhiUNnRNlmXIS2m5DTYn5sz+T4R1tZRLF7lPlNl2Bp0/HHRD2rn8dgbwICCAq7lTbi4gqtA+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619225; c=relaxed/simple;
	bh=Ejy9t+9B9l4+LvUjFjqmk9FevAUUDEqnH5OJiJwzdnc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=rpMOiVSSSdlVwOVaMOA8oLSMZfuJcKUk3Upd5wO22ItpVb/SKWU8uD4vMHBWQswqd4CBUjyQZJOWQsvr0akvrLK59qPod39g9wQo8t9TVpOstgu9UEQZScksVjh7cqbML28vETgjKla+uN9lJGWvqhTFSWbVbysAE6oYof5YsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C53C2BD11;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDw-00000000i6Q-15gK;
	Wed, 05 Jun 2024 16:27:08 -0400
Message-ID: <20240605202644.293295925@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/6] ftrace: Minor fixes for sparse and kernel test robot
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Recieved some minor bug reports from the kernel test robot. First I started
cleaning up some of the sparse warnings. There's many more, but most changes
are not really helping anything, but just quieting the warnings.

But the reports from kernel test robot need to be fixed.

Steven Rostedt (Google) (6):
      ftrace: Declare function_trace_op in header to quiet sparse warning
      ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
      ftrace: Assign RCU list variable with rcu_assign_ptr()
      ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
      function_graph: Make fgraph_do_direct static key static
      function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not enabled

----
 include/linux/ftrace.h         | 3 +++
 kernel/trace/fgraph.c          | 4 +++-
 kernel/trace/ftrace.c          | 4 ++--
 kernel/trace/ftrace_internal.h | 9 +++++++++
 kernel/trace/trace.h           | 1 -
 5 files changed, 17 insertions(+), 4 deletions(-)
