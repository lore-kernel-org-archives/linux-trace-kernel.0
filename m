Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD5204681;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938715; cv=none; b=oiWEGuIw0ajEGN7lgBZpm5NeVwdLmO+FkNYOwKKB29azvuUSEXB1Z/eE6oHSlCG1Z/WtTyoZqj5UvpV74sLRXVMudKGaSsp9yRBAebG1A3NU8FKekt3HW7xw10AtTzEXgsIYvB5cRzPQ2htkborFMAu6PhLm24idXeUG4RgVpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938715; c=relaxed/simple;
	bh=Fsz/iCJM+tlzFX3YDF7GF/dBylcbsJGYtYV7/BOdpnc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=orExqLLvy0cd+HCtaxzDMSSXxDG+6xVcOKRV8T/DvhBxCIjTfh0hetNhTxOHi0PpRsaOm3ayepOWMCiRo65N5eiddOctCzwJxVaKXzWpNi+ohE13oD6vYe22kmaIDCAeynyXzKABNvmnwszjsx/UzWe0YsrqtZ9wdlrdLzmTN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A607C4CEE9;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txBzT-00000002Ve6-1nzC;
	Tue, 25 Mar 2025 17:39:19 -0400
Message-ID: <20250325213845.844200633@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 17:38:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/4] tracing: Have function tracing and events handle module addresses
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This is based on top of Masami's patch:

  https://lore.kernel.org/linux-trace-kernel/174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com/

As it requires the function trace_adjust_address() for both kernel text
and modules.

This updates the function tracer as well as the pointers used in events
to be updated via the trace_adjust_address() function.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250304231545.708806702@goodmis.org/

- Rebased on the latest code

- Some minor updates to the trace_adjust_address() to print original
  address if not in kernel proper.

Steven Rostedt (4):
      tracing: Update function trace addresses with module addresses
      tracing: Show function names when possible when listing fields
      tracing: Only return an adjusted address if it matches the kernel address
      tracing: Adjust addresses for printing out fields

----
 kernel/trace/trace.c        |  8 ++++++--
 kernel/trace/trace_output.c | 46 +++++++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 18 deletions(-)
