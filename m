Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17930E85B;
	Mon, 23 Feb 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863384; cv=none; b=bZuvWo4aj2DN/Hi0LpbdFiggrneoCbFtdHYUyxUFCkrZpbi90m3JaNhUyUHzvmhTW48kRlokb5mskOcu+hk3IRJESXv/80exoe7otk2wyI9SXjvB5jPM9FVRHtHyiM66ZOX93Evz+eGdHvUrLexe3aQku9pbodXzzLsdEt5LhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863384; c=relaxed/simple;
	bh=WuaUaL8kh298Bw59ebc4SOcvk+Y024rsIcZw1sj+q4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgHuTEs4B26WLOMwhFJDms2sDY7diTQAuCKoJ6HJsyZ5nFU08gi6JgIZdJOoiSQMQw7+VmuqQSBOrsctyq4nkipsJZe0gIxuT/MjiotIVG7BmS/LWjZhyFPPyYzLZd76R9N2xbaQd6f+CItmPdsl7uAa0Lx9l1VVK4Rmk65BWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv5eL1RR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv5eL1RR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5736C116C6;
	Mon, 23 Feb 2026 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771863384;
	bh=WuaUaL8kh298Bw59ebc4SOcvk+Y024rsIcZw1sj+q4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nv5eL1RRP9Lxf9QUjRPcZT3PbLLRfCZ8jl4mSfMMOdxz6dGJAYT7ZqBWaLN+1nNEG
	 Gsp7DmrIqHIiwG0N3xGYz3ZDJ/i6pnG6fgg04MglfzQ5RzeuwX5yMMKkRhdSdG24EY
	 SdYd2BEaBHzuaBp3wXY1L8xo9iW3Nq5yKGHPc/GlHF5S9hWuJA5Ykf8JtLBIxgQcZS
	 qzyn35xC9z+nWUDQSjuYzty2OxN/T7uJNGS3DFKbeztdLvko9mAj0dQYpzVs/6P+P8
	 AWiceUa617ONIoa0qVfSzmJebjU/3JQKIhFAGF3K/gEbt8Yj3uZiI8COBXSXEjqaAV
	 YNCeVIeza7zLA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Tue, 24 Feb 2026 01:16:20 +0900
Message-ID: <177186338032.133407.2212071928206649620.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177186335195.133407.907308822749006594.stgit@devnote2>
References: <177186335195.133407.907308822749006594.stgit@devnote2>
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

Skip invalid sub-buffers when validating the persistent ring buffer
instead of discarding the entire ring buffer. Also, mark there are
missed events on the discarded buffer.

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data. Only discard the
subbuffersa that ar found to be corrupted.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Record missed data event on commit.
---
 kernel/trace/ring_buffer.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1ef718d21796..18b0b33e1dc8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2058,17 +2058,18 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (ret < 0) {
 			pr_info("Ring buffer meta [%d] invalid buffer page\n",
 				cpu_buffer->cpu);
-			goto invalid;
-		}
-
-		/* If the buffer has content, update pages_touched */
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-
-		entries += ret;
-		entry_bytes += rb_page_size(head_page);
-		local_set(&cpu_buffer->head_page->entries, ret);
+			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, RB_MISSED_EVENTS);
+		} else {
+			/* If the buffer has content, update pages_touched */
+			if (ret)
+				local_inc(&cpu_buffer->pages_touched);
 
+			entries += ret;
+			entry_bytes += rb_page_size(head_page);
+			local_set(&cpu_buffer->head_page->entries, ret);
+		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
 	}

