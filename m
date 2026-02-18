Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638633E357;
	Wed, 18 Feb 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409678; cv=none; b=uMpcqJSjFp4ZRl9022IIWZqpteTU//1MuRVVJzA1W0d/34+hG5d341XpbBrRQUIM7zRWsEHw/iMeUsNIGV4vbG4dM29LWBPPVuJPcTe2HklUmW4Xf8u0aUoydW7BxY/PqLCXpaTjMIJcO0rfShqNGzK5j9Gy1pnYudhN4t0Ld/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409678; c=relaxed/simple;
	bh=eIWLO1dJaLUjIfZPhLAdmQRaOb4jn6+I7ly1t3RxCn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWEbF04QlI61PbiMxMGsEcq5C9wpjSn/okYUqaJkBg5c6BeA+wZULY/S3HUXBkgVzLtwXYc71VI1rrXil31XyPDkad34HU0kcEcWAvUP6awhne6Qr9XKXblLuiheYXa2tp4KF7LC9kDRzf5kgq4dTKcIBPUo7MEAciTOB8AwwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHKecuBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHKecuBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61717C19421;
	Wed, 18 Feb 2026 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409678;
	bh=eIWLO1dJaLUjIfZPhLAdmQRaOb4jn6+I7ly1t3RxCn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHKecuBYxm0EV2jQwZi1K3xYVYBjFz2mOXnI52LOgMjYqw7v+r9sLEzNPHgVp9ivD
	 9yzcK5OF8RiEkmDO1jot+s91DUx4CDt25UfQGVfjuhif8882rToc2adLJBsl9dWgCI
	 HL9CegwW+1C84i5rgsA2Lr67fLiEz3MIsqqmpt5gL22gIp3yNNa7c1LIg01DM+2c4r
	 U2whfkbDBUQl2KzsZbKmDIYzdS/qG4acLPsdLBZH2q6SN6msu2qhG71Ju/RMN302f8
	 O4ubfky9SrDYPlacYqYwphZy6nclqsPu/Z/60Yf/5E6fFr+AhU82SkYX6Z7rnS7VyT
	 pdrKDFyqSUdyQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Wed, 18 Feb 2026 19:14:35 +0900
Message-ID:  <177140967567.1537493.7265236420134382381.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
In-Reply-To:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
References:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
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
instead of invalidate all ring buffers.

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data, allowing usersto
recover data from the corrupted ring buffer.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d2b69221a94c..0ae2a5ad8c3e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2045,17 +2045,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
-		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+			/* Instead of invalidate whole ring buffer, just clear this subbuffer. */
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, 0);
+			/* TODO: commit an event to mark this is broken. */
+		} else {
+			/* If the buffer has content, update pages_touched */
+			if (ret)
+				local_inc(&cpu_buffer->pages_touched);
 
+			entries += ret;
+			entry_bytes += local_read(&head_page->page->commit);
+			local_set(&cpu_buffer->head_page->entries, ret);
+		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
 	}

