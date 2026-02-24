Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E755304BB8;
	Tue, 24 Feb 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915980; cv=none; b=nsy484Dc6tCpzzuAOUcFm8NReClv14FDYk0rlqzrSG0u3HWFkC4vsu1MtIiCgxS9qnCqYM2MmC0qJirpO5P9laR3ZGc/IKw5yPlMXiVUsh7zFB37/rdKXOx42uAvL7N0INWljoWpmvmBv9QFFl4AkiTNa08IH7XpS30U34xCONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915980; c=relaxed/simple;
	bh=Qf0TU7ksxuW8tRJJFNoCuCSkFLx0TOuA2b8MEfyqkSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+YFdxrFXte46gZtK4pepsJSil72UGDzi0DdDX8nPOec3sdY1Gz11N6Pe0jJW/1FLJ0eOcEN5a8nfgkZhQLJ22No7BjhiQyK1JBY5fe767M4GQepqV1WzpN9+lpSg5yACYJIUMkVvm5qhhmzfEFCnOEOlf+CavgkQ5MKZfVbjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFL05vay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFL05vay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E8BC19424;
	Tue, 24 Feb 2026 06:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771915979;
	bh=Qf0TU7ksxuW8tRJJFNoCuCSkFLx0TOuA2b8MEfyqkSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFL05vaymAs0oUIjDCK9I5a/TiH4cBJWl8tp5ZgXpS3szcxNqd4Nenvs3LDq7yDuJ
	 tWpsSyP3fy5z7m2VPWqi83Fi+jKbKcaNiUOaFlKoVJ86ic/0PIOY0ri8ITHnAEgVRe
	 N+4hLiRG7ovnIUZ6zlGzxmXkJfOxVfJvTWvFNWIO91764YpBjRmewRY8b5oxWO0OFU
	 sxqSj0tNAqEOqFCDcdm+3cRuVO3V3/AXPCmrzjn28GnZkVprEcEwj4ZsyrfgTfNeS9
	 YlbPM9IUaDDf0D1PhkWPy8f2oC4OykXZpPI7QdvivlxAKRkofKnMD5VXNmwwRMNeN+
	 0ur4uvvvYhORQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Tue, 24 Feb 2026 15:52:57 +0900
Message-ID:  <177191597760.435720.2484229987964512451.stgit@mhiramat.tok.corp.google.com>
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
index 67bc652ba02a..72f82e2e6740 100644
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

