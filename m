Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031A429024;
	Fri, 31 Jul 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507411; cv=none; b=cRAKHcULKUjwKMzXHbBcxS/pj9o9rPFN1IoCbWFSzK4acdEU27jWUj7bX5EvKU1F0Z7GIrcDV+TqHd2axUcvYzg8J7tPGLPZhoyi98nevdvIJj+rIcgZlGZLKqLLrmvc+v16KQk/lyfHDS8dBrXjrkBQPVVW5z2vJIFjiyXa5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507411; c=relaxed/simple;
	bh=Q4LsN0WPKn5IcTNospy8sf0czReHouqj5lNks2zQVTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9gf76wisKS77Av5RIB/GE9sLUWkmgv7kAE2sr8hhAHpp6xXNeE/IYqGqvs88+XniV/Pjcv2hlUJwO3zwm1jug3m/55vtswVJlS+IQjx6MK6sxGyOI+VD+myz1Q/oUm6LqGeFpRrM0roV4+o6060hado8YYY5XIpf+JJ39GHdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdbQZXtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdbQZXtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99CD1F000E9;
	Fri, 31 Jul 2026 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507410;
	bh=vgQZdLEZ/wYpCPOFr+CYifEqGKh4bJxdN71qg0JLbNI=;
	h=From:To:Cc:Subject:Date;
	b=XdbQZXtT+p6Ye+2g8YrrlzePeFwpKbxKWx3Qs50Qaq27xhCSxwPUtxaBtdgcG5h9H
	 oLeN3IdRERkmFRwvuSjY5731/R2zdeQNfS6oHnah3UgJeWnSp6yO+xUhWzU/ekmmgj
	 zcVLwSPq7gQiTK1TznzYth/xCnaUUsSTZv3p650L0/kS8M+dnYnJQBWqBmBIf/NTgp
	 ZPqxZoIgQdwJFPCqIFmZwtKyHl2QQFE6+HTqSz+q93PDuYrVANn4MZbV9onKNwuycG
	 IY6eEwtOKVjh5gMGYXyO6e6epDZVnspyD5N/gbMrhwTCQInTtJjWgnv+Oc96OxbD3x
	 l/mG3jvUe88tQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH v2] ring-buffer: Fix subbuf_ids memory leak in rb_allocate_cpu_buffer() error path
Date: Fri, 31 Jul 2026 23:16:46 +0900
Message-ID: <178550740672.380917.6067449683620196150.stgit@devnote2>
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
 Changes in v2:
  - Call kfree(subbuf_ids) unconditionally because it should be NULL
    if !remote.
---
 kernel/trace/ring_buffer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78d3875a47a5..8e2485bb3aa8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2599,6 +2599,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	return_ptr(cpu_buffer);
 
  fail_free_reader:
+	kfree(cpu_buffer->subbuf_ids);
 	free_buffer_page(cpu_buffer->reader_page);
 
 	return NULL;

