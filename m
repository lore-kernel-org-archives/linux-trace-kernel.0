Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10412B94;
	Wed, 11 Mar 2026 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192744; cv=none; b=fhKMvvoSnsRIOIUnBP3F/MxO+YSrpNYbK8unR3BA+ShTSuc+9GCRXwcVZ6khYNNkWVKPQYV5FfJfEk96N67YkiUlGvjRFvOi6+a7HS4w5nravp3rMWXP7n10v3QA23bxQ2CvdFsHYubKjHQE9NLbs3yB1J0WOia60PjXKnM1IzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192744; c=relaxed/simple;
	bh=Z2G83oBH5vx8KCsX/GwG5z6coID67lhhovuf7Wvz6FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyOxdgCArKaioZsv5t9ceCPx6IaVbcC4Nn81K+sdjUpn+XnLqzA9Vy0cxUED6Xm4I5QSWUvGSrPjHENJJ9W/FHfFdXl2hBr55vPwtPgHIW6IJ1KYp/KhKYzQhpoTH4bAmtKvXCSzfzTgfRa5ORycw6FPqYg/1RUWoks5GtRfLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzj5RLK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzj5RLK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC016C19423;
	Wed, 11 Mar 2026 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773192743;
	bh=Z2G83oBH5vx8KCsX/GwG5z6coID67lhhovuf7Wvz6FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hzj5RLK0g6MoZ0Hn5PdtIZla5E5hHE2TCy/cvT1eUKj2qdqxBAYxDbLur5a8wN32d
	 OnoiEEHhFmLi4OqzIYGQr5hextXlLPl1apKeMCSy36pWfJM8yL8VwybveXTZe4Xf06
	 JDBmDbiPZ92sOSihwlrxdUJPRAnI/T2g7jqTyP1UH6DotXjZwUzcVXeQGo2faGgqJQ
	 wAlNIqD8fJW21VjoOuN0JAuy2gQgMhyn73cvxSlJmQBxLa+3sdDdy2AvugEviXY8fK
	 Xx8xQ+PK28MCRbbf3P89s8cKaJuNVCA+BpDx3B2lCvklbQTAH0z7YCLtQn/0ljGUFL
	 9OLXdzcwxvyYQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v9 1/4] ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
Date: Wed, 11 Mar 2026 10:32:21 +0900
Message-ID:  <177319274126.130641.15502329149412118852.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To:  <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
References:  <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
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

Since the validation loop in rb_meta_validate_events() updates
the same cpu_buffer->head_page->entries, the other subbuf entries
are not updated.
Fix to use head_page to update the entries field, since it is the
cursor in this loop.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..353a5aa1b612 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2053,7 +2053,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+		local_set(&head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
 			break;

