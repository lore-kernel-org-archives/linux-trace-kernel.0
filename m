Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297A125B2;
	Wed, 28 Jan 2026 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558983; cv=none; b=aDikf1lmzrKqC8p+mTfngvsS3kWuhbTkqHAD+QYdKjgc3ZcbkMeO4Ome81BSDR0Hy9zdRccSXZGIH9U2zYSXVsiTFjHoH3LawtnkJ9FvvwADUUBQ7DwB7+tKhw3J2VEu8nKpLu+UwSnn/LFQ2GJSqHmNJGN4i2+ZLEQKgaBa8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558983; c=relaxed/simple;
	bh=pnbh6Z4PFNlKc5mVdMtgryhnqFnzzMI4KDPqVE6jBaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBY31RgfRg+yjTgvLfzc2RQcFWmkhQ/gshAItftHiJmT062IVlaApDY/Zgay4GlCu+AYI5pY4kZAzvh9/6JnYnFYSZUxHGEPjv3Fb5mmbSBYhc/y9cJGT7Y4tPTvrfoicguadV3XBDBeewBzJgDhV2egeLWzAM7WTT/cnD1ZxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTIp+geB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTIp+geB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B65C116C6;
	Wed, 28 Jan 2026 00:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769558983;
	bh=pnbh6Z4PFNlKc5mVdMtgryhnqFnzzMI4KDPqVE6jBaI=;
	h=From:To:Cc:Subject:Date:From;
	b=lTIp+geBZSNZx2r6o1I2ZkFJqRY7i340HQa2eBcmFSMxmBW1rGTC2g1AVDiIYZl8f
	 ivZlMFfHRVaaY8gaELARia6RPYC5wv7eJ94Tm5Hl6RuW7QzPR1osQ9pkTRBs/1xbK9
	 uaiWgkCq4+mz85J+a+RkwU/nUOZU1xW+VbUalEogMfaHpYsmeeXYbQLiBqRNInSeE0
	 Berpm65MBqrO/4ntdp6MklmLCTStSI+wMSRjWQmnkKr9Z12/4MrdNuyfxb9oZHYS31
	 QtiZQk9QF2I5+DnflRKS1MtdZ2uu4G5bNpgjlpJz5v7bJ3g+8IHSnd3nzx2ppXkWL3
	 cj51YKKSxQuCw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] tracing: Remove backup instance after read all
Date: Wed, 28 Jan 2026 09:09:37 +0900
Message-ID:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

Here is the v5 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com/

This is just rebased on top of the latest linux-trace/trace/for-next.

Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [2/4] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [3/4] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (4):
      tracing: Reset last_boot_info if ring buffer is reset
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 ++++
 kernel/trace/trace.c              |  164 ++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h              |   14 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   80 ++++++++++++------
 5 files changed, 221 insertions(+), 61 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
