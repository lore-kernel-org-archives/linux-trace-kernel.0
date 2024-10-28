Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689818FDDA;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=F8a0tCeYFy6CyrqyJZR3Sfu8OoJYqUOJ9yu7RTCLxrjrliQv5uk6pxbR1vwjo/afUq+5kMNRWaVATUARNt4KjL45c0ssiTnAViMZE0IZIA3Se0vhHWphIc3EPDX8Ng7SrLDnsZb0wl0jC3TAyeJVm9dSBXAa1q5ySI1OuY5ayaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=dd513gsoM8FbsDPw1AeTg7ZjDcG+eXQyfPhkUC37C/4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mbi+U7PXmoqI/LhRCRZddcRydHce1YhER/D327aL6RRwCaabv248sKFEDwLj8ZXvdgu2Wgqw3DuCREf/GSBCXAlyo/O6dsK1bDBf5aHocZr084G37nB20hL0plw/1kK39+mIj711h68X7PrmThe1bqXZBoL4KDDs6zU08gNSFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1163FC4CEC3;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw3-000000053CL-37Ft;
	Mon, 28 Oct 2024 03:13:07 -0400
Message-ID: <20241028071228.575900713@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] ftrace: Use guard to take ftrace_lock
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The ftrace infrastructure uses ftrace_lock to protect several critical
paths. But the functions have that take the ftrace_lock has error paths that
require the lock to be released. Use the guard() helper to take the
ftrace_lock in theses functions which simplify the early exit paths.

Steven Rostedt (5):
      fgraph: Use guard(mutex)(&ftrace_lock) for unregister_ftrace_graph()
      ftrace: Use guard for match_records()
      ftrace: Use guard to lock ftrace_lock in cache_mod()
      ftrace: Use guard to take the ftrace_lock in release_probe()
      ftrace: Use guard to take ftrace_lock in ftrace_graph_set_hash()

----
 kernel/trace/fgraph.c | 10 ++++------
 kernel/trace/ftrace.c | 53 +++++++++++++++++----------------------------------
 2 files changed, 21 insertions(+), 42 deletions(-)
