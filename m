Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD383B4E9B;
	Thu, 30 Jul 2026 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394918; cv=none; b=qk5a/1LCXNTlM/VMMdD25gEppws0AfRWqxhxTs0gdGbO1jZSpIDgrgFnKA/wSoLQGGQxTap8zHmoRSGqKmzV8m0/P7X3s+6WeKmcB+hnt73QnnwsP/Amd6ddO716Cs7tPQhOJSGFX4f+XhKBvD8KLaxW47r2E9Mpx/pRT1yrgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394918; c=relaxed/simple;
	bh=4/lmGNk8KUkikIFUgEX/Hp8fI47njE1M+n3gwumQzPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dI0My7bi0RhJlNyicrzxuifFw82DFx4ciEnRS5xwfE/+4HNLLSndbeb8hRheuW2NuX+5J34+9xlllhckduiR4ehFt1VUOyIp/RgTBnJOrZz7UImN6BTZGVews1PdPDA3pog+7xNQB7fjYbMUGosJp8oreV1nk/i0yN7DTbIlCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjI7l9rb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjI7l9rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4531F000E9;
	Thu, 30 Jul 2026 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394915;
	bh=G5ONB7WMx9hZFRFJLm6QgDyDI8LmZzbowiLf/94qXwg=;
	h=From:To:Cc:Subject:Date;
	b=hjI7l9rbGjfKTnwUzVmQZA6y50kHzgti3tZxKNayuUwq19HgnKqEY7MJIgULa+bJA
	 IXlHw7nBMG5GgkCB3MsUtfQK5gizAUR7HZaE7ZQbKfOsxhpKVqJhoNCKbOctN5b69O
	 HcWh/UNPVt0WNI0QID/+jJZpEW8qK1vaFqZNwuSGKfaP/v9HYWLd+mJy8Gc59UWTjC
	 Yix/5o28iMCInVhn7Oy63+NgqVg45Zn6lSbHKb8uCzSYptsXdbUCsRdSoBOi2WuBBt
	 IR2xjqPBmoEFipwNOybSMvuNDrRA/Dy3eoIbcGz5+QtMXX4/Qy1S05VHyt+DNHK+wi
	 SOaJqVNwYfnyA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Fix subbuf_ids memory leak in rb_allocate_cpu_buffer() error path
Date: Thu, 30 Jul 2026 16:01:51 +0900
Message-ID: <178539491147.180138.1181424244288838594.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

In rb_allocate_cpu_buffer(), cpu_buffer->subbuf_ids is allocated using
kcalloc() when buffer->remote is non-NULL. If a subsequent page allocation
fails (e.g., ring_buffer_desc_page() returns NULL or rb_allocate_pages()
fails), execution jumps to fail_free_reader.

While __free(kfree) automatically frees the outer cpu_buffer structure
at scope exit, kfree(cpu_buffer) does not recursively free nested heap
pointers such as cpu_buffer->subbuf_ids, resulting in a memory leak.

Fix this by explicitly freeing cpu_buffer->subbuf_ids in the
fail_free_reader error unwinding path when cpu_buffer->remote is set.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78d3875a47a5..03f6baf6a5f5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2599,6 +2599,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	return_ptr(cpu_buffer);
 
  fail_free_reader:
+	if (cpu_buffer->remote)
+		kfree(cpu_buffer->subbuf_ids);
 	free_buffer_page(cpu_buffer->reader_page);
 
 	return NULL;

