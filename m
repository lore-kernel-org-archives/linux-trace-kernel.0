Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C272F12AF;
	Tue, 24 Feb 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915972; cv=none; b=nbHvp+UBqfVlgBPpDURPwzs341HUykWQmtK8i4dVOc+PV4sXXUF7ACPefsKH42T0BjNPfftjqFvLCjs6Wwpml7JuuExBBpt4pklyx97afVdLlI1BKWg4YECWVCN7GKMBxhbY0kJDD9zO9sACYQWRKU6ehc8Hw2fpwdGxgZW1W14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915972; c=relaxed/simple;
	bh=+wOG4qSFrgPQH/i7tE6iWyJ6XFGQlz0rsWZMNLfE29k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQu894JXJzKbg3IwAwJ3fd6nWF6lQpeval903+kkgdsqRXBdyOewBQSXiXFSA96lMDL9sVg3hsEboP2EJ1rZeJohLecFjw1vcb9taVF/VjBlICDjrv1cvhlUv5eF5uqNeJop8YJBSFEyFeaNskZrRdiW7zU4xfoFVDV30EOFDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxXT2RsZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxXT2RsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C78C116D0;
	Tue, 24 Feb 2026 06:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771915972;
	bh=+wOG4qSFrgPQH/i7tE6iWyJ6XFGQlz0rsWZMNLfE29k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxXT2RsZidSTvkpJKtXv/7VE/DjQSPCqKgM7xvOVS5/+A5ybgFClHynEZan59s8nZ
	 MxWaTwbtZD3y672MJPFWWRLpHCU2ZuAI8xIL2AlVJs+Ji7zHFhpAfsqCBzwXtjsePX
	 Ro9imakn9z9oeNzmNrAq8whcxkWu2sbhGKa3GYx7SNlso47cxEZotmd6Trmpb+8uM8
	 6WMRvpwPc05TJgS+jHP/e+j7S8FaeHXvqaJwRx9saNS/zr0I37+0yjlWxCdgku9r2I
	 YzkGyOoiQHboy4x3Kwkv2R31VRJJ8wqo73I3fv1ZL9pe0f6rS15yPzNz2LLY2AwlHH
	 zcE94O7LBib7g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] ring-buffer: Handle RB_MISSED_* flags on commit field correctly
Date: Tue, 24 Feb 2026 15:52:50 +0900
Message-ID:  <177191596996.435720.7165906136619645392.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To:  <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
References:  <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
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

Since the MSBs of rb_data_page::commit are used for storing
RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
when it is used for finding the size of data pages.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
   - Fix to move rb_commit_index() after ring_buffer_per_cpu definition.
---
 kernel/trace/ring_buffer.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3eb124c93d72..67bc652ba02a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -395,6 +395,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 	return local_read(&bpage->page->commit);
 }
 
+/* Size is determined by what has been committed */
+static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
+{
+	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	/* Range pages are not to be freed */
@@ -614,6 +620,12 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+static __always_inline unsigned
+rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return rb_page_commit(cpu_buffer->commit_page);
+}
+
 int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s)
 {
 	struct buffer_data_page field;
@@ -1907,7 +1919,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	u64 delta;
 	int tail;
 
-	tail = local_read(&dpage->commit);
+	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1934,7 +1946,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto invalid;
 	}
 	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	entry_bytes += rb_page_size(cpu_buffer->reader_page);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
 	ts = head_page->page->time_stamp;
@@ -2054,7 +2066,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			local_inc(&cpu_buffer->pages_touched);
 
 		entries += ret;
-		entry_bytes += local_read(&head_page->page->commit);
+		entry_bytes += rb_page_size(head_page);
 		local_set(&cpu_buffer->head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
@@ -3257,18 +3269,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	return NULL;
 }
 
-/* Size is determined by what has been committed */
-static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
-{
-	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
-}
-
-static __always_inline unsigned
-rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
-{
-	return rb_page_commit(cpu_buffer->commit_page);
-}
-
 static __always_inline unsigned
 rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event *event)
 {
@@ -4433,7 +4433,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
-		tail = local_read(&bpage->commit);
+		tail = local_read(&bpage->commit) & ~RB_MISSED_MASK;
 	} else if (info->add_timestamp &
 		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
 		/* Ignore events with absolute time stamps */

