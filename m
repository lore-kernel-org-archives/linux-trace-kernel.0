Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD33B52FA;
	Tue, 28 Jul 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243018; cv=none; b=tSiWCuxSSFGkh0HMBcAEYIXfXDgjsp6Ix7G0RPPJniaODuXMIbjzSzKPrYe4ZMnMUttjvRB8Np8tmK3clRqKeh+BVhpnjGoG33r5ZMKeZpt8H+Q4JjvYTTe2ydKP7YqlSh818raxyD/bBuCYgYI949d1BhxFJ4fIVAPXT/N/qqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243018; c=relaxed/simple;
	bh=n9Dgea7oJkU9D/Dgw36l5wt9ZLcQA0Wy0frCUtmv9rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvfIOrpGZQ6JPNqQJh6I1kDN0ITxcuot3tuVx95LADVUGgVcI+aJ7HaFBLx27BGQ9k2MjrO+y2LuqvAqwQ7ROd+FG2RjuW7I+egYYeJYnuduGQijtH7X6gVh0mYqviZNusksGudiipr42gp/ha0uvj+ZBtnMRlnNOpZFSh7WTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg7TbQwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg7TbQwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D3A1F00A3A;
	Tue, 28 Jul 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785243014;
	bh=hq4UWoi+hc5z18Sl/9fgWCQVQlYUBSaNGgbu37s5NPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cg7TbQwzJbmR7TdB4ZjdCYwcc0d9puOhufXVpxNhqfIN1zKonDH1L0GgvvIXu5qO7
	 3wD/m6+ZYRxc0DQ/Omu+PdcJyrutHwxoz96DYIL4N0BawKCSF0+1WyoxVl/W1rV6QM
	 CHXmrbmfvNYuc21DT/Yqm6D7pdxQb+nB5XJxHkSNSP5Zw5AcmKNIKVWi7ZmbjrEhCR
	 7xnsAF1ye2/dNrAUpIFdwowpOkSntPD2Aq28PxVBGaiwz8d+CpJ4+Iusg+Dof8N3Zi
	 r4SgTQLjEtukaqMsiPC2TmhvwT2YhVR81X9icenCozEgk+Ky5O07QnNxwRkmHrDHS7
	 5O1m5TVMfNF9A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing/mmiotrace: Use trace_assign_type() in mmio_print_mark()
Date: Tue, 28 Jul 2026 21:50:10 +0900
Message-ID: <178524301013.56416.9116249028160618790.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178524298182.56416.7520852015178187644.stgit@devnote2>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In mmio_print_mark(), a raw C cast (struct print_entry *)entry is used to
obtain the print_entry pointer.

Use the standard trace_assign_type() macro instead, matching the usage in
mmio_print_rw() and mmio_print_map().

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_mmiotrace.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index df8692c2dea8..77120d467e11 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -244,13 +244,16 @@ static enum print_line_t mmio_print_map(struct trace_iterator *iter)
 static enum print_line_t mmio_print_mark(struct trace_iterator *iter)
 {
 	struct trace_entry *entry = iter->ent;
-	struct print_entry *print = (struct print_entry *)entry;
-	const char *msg		= print->buf;
+	struct print_entry *print;
+	const char *msg;
 	struct trace_seq *s	= &iter->seq;
 	unsigned long long t	= ns2usecs(iter->ts);
 	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
 	unsigned secs		= (unsigned long)t;
 
+	trace_assign_type(print, entry);
+	msg = print->buf;
+
 	/* The trailing newline must be in the message. */
 	trace_seq_printf(s, "MARK %u.%06lu %s", secs, usec_rem, msg);
 

