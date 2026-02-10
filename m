Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F433C534;
	Tue, 10 Feb 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713018; cv=none; b=kfpagvDhoyBVi7csjjxbWGIgLZi1np3bjC2oqJdloeTkGMeQdhBA2WXVpZJIEL97ozsTWfsa1s1GbXtLjfdvrg0WkpDgP6pcvDpOaISf2eTHZAyS5PJm0uA3eur++najXjDyH/LDuwQBOJnb89o1j7MMfq9C/osk7ot+jfyIXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713018; c=relaxed/simple;
	bh=sPfczV+iQh/5YeCLjihJxq4iEgnUbU7vuVeJkK5BiRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jjp/QDL/McaKheYDhkJrZVPtpKaijLTQnmDXdb9PPr/mDSS5jViKFFtN4LyPUMNstJWQlOk7wlFUaN73bMJvoMcu0hMzqu2tx6HbtHfAgtbS7fGDYyrE6wiXqzDXln0bRGf0jX8aQSTeH/DqJYMzw/Yumh4pRHkoGNdOP/rDkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dchPzW8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dchPzW8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B7C19424;
	Tue, 10 Feb 2026 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713018;
	bh=sPfczV+iQh/5YeCLjihJxq4iEgnUbU7vuVeJkK5BiRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dchPzW8tt8rU3Gmko/LqV/ekJNo8TKBj94/zIrRP+bq/fK9UVnuT2Ss4PN/+FJ6uu
	 NvKhvo15okbhLDcGbYdRp9/p/FzWUR+iSCTRb8ElMB1gHPXo0U+zTC05IZlwPRLAun
	 pbA1ME9+284ClW0sXQYCTxg1kECIhuXAcZMUaddwO1hoPIoaFgsVMFqDcEYjoL0HQu
	 w/Nu97YGMmJDWyAvj52Y4x3btfh4kxZOeXbzKy04m5QIZojQzcequhZnJoQL3/PAb1
	 CXEPoHT/02q41yl8e8olwsaw7iepC96NGkbI8VbOf/JX3Eb2auoxfSDkLtufGcmdG+
	 Pub8d2wad+Tpw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 1/6] tracing: Fix to set write permission to per-cpu buffer_size_kb
Date: Tue, 10 Feb 2026 17:43:36 +0900
Message-ID:  <177071301597.2293046.11683339475076917920.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
References:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
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

Since the per-cpu buffer_size_kb file is writable for changing
per-cpu ring buffer size, the file should have the write access
permission.

Fixes: 21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8: Newly added.
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 845b8a165daf..fd470675809b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8613,7 +8613,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_stats_fops);
 
-	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
 	if (tr->range_addr_start)

