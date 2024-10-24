Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D591CACEE;
	Thu, 24 Oct 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762153; cv=none; b=PI+PCzANDPnq/jvLTriycO821BN4yQMsvpK6GqD02FWtOr3T8xyBE7AlsxOe3hAuJ1nahbaX8eoVYX8pFpjEMUpnADkkwHdsKG3dccJhlKckxv17F22Z052wh2JoAuYpiyi0H1fZVJZG91N0Yzk1r0//WnATktaj/GySJV7gFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762153; c=relaxed/simple;
	bh=j6hfF0gOzzET4btMqPde8TLqaSjcQ2Hs3JKhVhyX4I8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=X6MOvDYL9zp5pCwuYajJ/RsKvlfWa288XsPFxqQdB6TT+IR8FI6bofl065h96CDA66SVm7zGPPRvnXhhp+ZAXiXD9xMI5q/xT5KjvG6nGy8i6v/IiK3+CfndeM399IzmIXAydQzMl3Tk3rH1FdLwoGGRb0MMSniJBPbIK9mX+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11966C4CEE4;
	Thu, 24 Oct 2024 09:29:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t3uAC-00000004n6w-2BKE;
	Thu, 24 Oct 2024 05:29:52 -0400
Message-ID: <20241024092723.817582319@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Oct 2024 05:27:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] fgraph: Free up function graph shadow stacks
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Since the start of function graph tracing, shadow stacks were created for
every task on the system when the first instance of function graph was used.
But they were never freed due to the shadow stacks holding the return
address that was hijacked for the function graph return trampoline. The
stacks were only freed when a task exits. That means once you use function
graph tracing, your system has PAGE_SIZE stack for every task in the system
that was running when function graph was happening. That's a lot of memory
being wasted that's not being used.

This series addresses this by now freeing shadow stacks that are no longer
being used. This can be found by checking the shadow stack pointer on the
task structure.

When function graph is finished, it will free all the shadow stacks that are
no longer being used. For those still being used, the freeing of them is
delayed until the funciton graph return is called by the task and it pops
off the last return address. That will trigger a irq work which triggers a
work queue to do shadow stack clean up again. A static_branch is used so
that this check doesn't happen during normal tracing as it's in a very hot
path.

Note this patch series is based on my ftrace/urgent branch merged with my
ftrace/for-next branch (and some patches that havent been pushed yet).

Steven Rostedt (2):
      fgraph: Free ret_stacks when graph tracing is done
      fgraph: Free ret_stack when task is done with it

----
 kernel/trace/fgraph.c | 150 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 15 deletions(-)
