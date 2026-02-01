Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F61F936;
	Sun,  1 Feb 2026 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916542; cv=none; b=kV8AFp8TVnVfqAozqRSuc8Xf870fKgozkwbdDSnKpaF+BE7BV9Z+scYbVY0uJjGkk36kD0apZcZslwGFi3KWW0dcDWSc/ZsLE6xik04lDzOJ3h/07xm6Ciw8GrgQFsyHV0VcDZloUSLngMWGfRLTrxziFMlm1qIbTZ6rmW6KR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916542; c=relaxed/simple;
	bh=sRSsbVAU2jHT9Lu218mRZmdmCqJFblDQ7vdKAsXv+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIPEtZdVHZMf9AHDEEsdYJGmFltwYXRqRL9DdLodAojhsai6Sp1/IPJ7kpqz2tm2d7h49iuDeXAah7YJEzq9NMpD15Jq7MxG5WBmJpKcPt6N668GcxAb6PFrL/Y4b2wsQsjDOEc0/wtyK8CNpcdP+bQ44P/yUC5g9CStlBuMlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUrVpG8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUrVpG8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D4BC4CEF7;
	Sun,  1 Feb 2026 03:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769916541;
	bh=sRSsbVAU2jHT9Lu218mRZmdmCqJFblDQ7vdKAsXv+w0=;
	h=From:To:Cc:Subject:Date:From;
	b=CUrVpG8bYvbK0e2AhqVhpevvgzI4dTw0+US4Z1lmd+4Gitgs/y9YOgdUWs4anz0u+
	 xL8r8aVSQGfMEJyhV6rYDSW4NbFCNPjBmTkeS2a5DyTI79aUENUZCC6siXlYJWVBlv
	 KFLIE2cJHwaJFuYjI5l5CSEP9C5zTTdevNp9JQA+2kEqcHySKBWDmMN6Zknlw1gsXL
	 2XyYVWZ3lAZYO38860b/Z+LGt8JXYGIQ1j4Oh3wgPRfMGTeHSupuBGkzn18JjCTl5+
	 ZcbJfjXum9O6WxtiIQmfgutmcUqyRHbJ2LCI86lwtkjmhtDkxN7BRTHrmA5hExjzs6
	 yfOqnYGnHvWEg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] tracing: Remove backup instance after read all
Date: Sun,  1 Feb 2026 12:28:55 +0900
Message-ID:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
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

Here is the v6 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com/

This version cleanup code and fix typo, according to Steve's
comments. Also fix to init autoremove_wq only when the readonly
instance has been made. A major UI change is that the tracing_on
file is also removed from readonly instance.

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
 kernel/trace/trace.c              |  162 ++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h              |   13 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   76 ++++++++++-------
 5 files changed, 209 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
