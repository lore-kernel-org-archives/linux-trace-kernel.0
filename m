Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869E282F3A;
	Fri, 24 Apr 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013533; cv=none; b=JfmCLiaRJp3E/QlyV5g7Uh27IRlhBEudwlOc3rxjKkfEYiz0AxYQyQT3EK8x5XB6eouJHvpZdFoRcC+aFgAkSRJVveYsK8xjafewwWWa+7zqYfjvyPqAEWsYwGLr+gu8KV4KDSCAKp4Q/sbyoE5SO50bjTATnh9zPGXM4IgFHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013533; c=relaxed/simple;
	bh=h5zNnOePiy153/WH9cKYLW8qOY+CjSEhvKYyYDJAmoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDTcceOIPMEoRvmiM0bqIDcZnOM5PE64OAnD4CLL3nxOa1pB2ztGXUY2xaN1LOGoT5axBOmftvShFB4iE/n2d7w3lF1x8B3KuD32LTdxjUOILu1xV0nS4mDIvq6yc8QOxoWLpFHzM2ooYv54U7MonXofbQlcrOTHZB6w1zkc8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAoNMtXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAoNMtXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBF9C19425;
	Fri, 24 Apr 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013533;
	bh=h5zNnOePiy153/WH9cKYLW8qOY+CjSEhvKYyYDJAmoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAoNMtXv74hEbgNY1L1Rtu/4DdcndEZuuA+SEK+FkFDHKf/MLRN9Fh58TzP2H9Uct
	 iRr/N2gkwutKpYcRvA0R9dFcl3S5usDAdnPew+dY6L2r0CHhnSS8q5H90uVDYQVk5E
	 gMbzObb31iQhR7CkU4kmIdaYBhVoVTm39CpDfFMXijRZ3HYL5h8gzpMuxgmRnRT5vD
	 4Lv9G1Cd/xQ6rmZd3wYfYBhmyhjVp5Nls6mUUhRHxYiQighonwajMzzuEN3IEaPhVr
	 BRb0ukRGBptMi2HrSLQX+ebj1I3Sf3keRxhwUbVn+RCaQCVVzmm0G1kG7HyfyyJ+9h
	 pQ2iAgIWkoCMg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 1/8] ring-buffer: Do not double count the reader_page
Date: Fri, 24 Apr 2026 15:52:10 +0900
Message-ID:  <177701353063.2223789.1471163147644103306.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
References:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
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

Since the cpu_buffer->reader_page is updated if there are unwound
pages. After that update, we should skip the page if it is the
original reader_page, because the original reader_page is already
checked.

Fixes: ca296d32ece3 ("tracing: ring_buffer: Rewind persistent ring buffer on reboot")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v18:
  - Newly added.
---
 kernel/trace/ring_buffer.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cef49f8871d2..5326924615a4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1884,7 +1884,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-	struct buffer_page *head_page, *orig_head;
+	struct buffer_page *head_page, *orig_head, *orig_reader;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
 	int ret;
@@ -1895,16 +1895,17 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		return;
 
 	orig_head = head_page = cpu_buffer->head_page;
+	orig_reader = cpu_buffer->reader_page;
 
 	/* Do the reader page first */
-	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
+	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu);
 	if (ret < 0) {
 		pr_info("Ring buffer reader page is invalid\n");
 		goto invalid;
 	}
 	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
-	local_set(&cpu_buffer->reader_page->entries, ret);
+	entry_bytes += local_read(&orig_reader->page->commit);
+	local_set(&orig_reader->entries, ret);
 
 	ts = head_page->page->time_stamp;
 
@@ -2007,8 +2008,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
 
-		/* Reader page has already been done */
-		if (head_page == cpu_buffer->reader_page)
+		/* The original reader page has already been checked/counted. */
+		if (head_page == orig_reader)
 			continue;
 
 		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);

