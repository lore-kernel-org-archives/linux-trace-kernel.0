Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC49389E08;
	Fri, 27 Feb 2026 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184047; cv=none; b=FiCNjT5HBBMIBo/T5lydVgkTevLcGKEvee260J3mdRlSVL1GG8Ak/wP6mNW9UAeTDEuVSZgGMj3susbAhzj0XnMxlgjPtCiEXneMVPrUQysEpnx3TN7yL8zsFxH36EixlEZXiyymWOU8QQdPezgZnL3ysWJg0xiiCAr1VrLKBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184047; c=relaxed/simple;
	bh=ZTL7VPKVQGVb3mxnY4WJUpcItV/URobGB8/uJRCEKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1TgMY+G6ySXnsn1e9ZqYdh5hTuJInOs/aOV4zUtNoPpdnSSPY29JKg6flcDBIxKNmE4HL7fitfcPI2MEGjJuoRszmqnwba6hVrWpMS0lbtp3cCHC4abNld7Ay6d4R+ZmhfdlVVTh1jSnmsKEY0Ei60hpXZsXvOHx54IV9XUVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9pMerfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9pMerfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339CDC116C6;
	Fri, 27 Feb 2026 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772184046;
	bh=ZTL7VPKVQGVb3mxnY4WJUpcItV/URobGB8/uJRCEKlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9pMerfKswr0hHKAn5o/v71ErzjF4QvBCgIJhGImB5WuJoyO/gVx4IRt+bWiM74+i
	 nyXwpV9463Os7y5gdk2r2c2w3WG1zysfkPM04MINJzD+Imxj6D5IEY2Ir61hxzt83T
	 KZP9/IPX3Y6aH0q3kpqV2NBBP+i9YQuIWzEzwH45XAyylrIUnBafvSG9zO4lc2vZY+
	 o4YyBcps1YmKcjWoRAwLhDaJVvCNKT2pNXWQihkcYwJLur3hl3ul7i0wyEu6llimf5
	 SucBWGUUvVAc2RmzUaCWG5JMYjNzaeSeQoREWu/APa5HOWf9LzHYhP9JPbDii46mma
	 Od+ltdrT4UFzA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Fri, 27 Feb 2026 18:20:43 +0900
Message-ID:  <177218404280.1988514.11324224211296559513.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To:  <177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com>
References:  <177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com>
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
  Changes in v6:
  - Show invalid page detection message once per CPU.
  Changes in v5:
  - Instead of showing errors for each page, just show the number
    of discarded pages at last.
  Changes in v3:
  - Record missed data event on commit.
---
 kernel/trace/ring_buffer.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 87d6958e9656..5838ee897aa3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1928,6 +1928,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	int discarded = 0;
 	int ret;
 	u64 ts;
 	int i;
@@ -2054,19 +2055,22 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
 		if (ret < 0) {
-			pr_info("Ring buffer meta [%d] invalid buffer page\n",
-				cpu_buffer->cpu);
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
+			if (!discarded)
+				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
+					cpu_buffer->cpu);
+			discarded++;
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
@@ -2080,7 +2084,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, entries);
 	local_set(&cpu_buffer->entries_bytes, entry_bytes);
 
-	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
+		cpu_buffer->cpu, discarded);
 	return;
 
  invalid:

