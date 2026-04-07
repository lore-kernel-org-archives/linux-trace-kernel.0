Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234031DE2A5;
	Tue,  7 Apr 2026 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524368; cv=none; b=HEuIqwzqvgLU8q17RjHkoXgR/3ddLNdCfg+oitdm2Y+48JKVxxF+Ql0QAh++KcawrLlFWU7Y/dF28qwgoO+NubjhKaFMx3BgAgBM4UDnLHfp492BWzMjIB/BBf6xPPRb6E8c9JpA6MzL44fAvZ2y7Ah700xIIokj0C5hrBlpvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524368; c=relaxed/simple;
	bh=04xzV7B6C0nmMB8kee/matN9EpL075hjg5Q3i9FX6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcWSUBr/IiNhBV16ZonKOqJGIxss0jGllTiyEpsGcRIALKQRyJSC4Y08radModSNu4s8RxBzN6Y7MKTMBLuWT291bCHmC3XHQmDH4dQmsHzjvJ1WTpT1fVyzJd0OOUP/zyHkxA0s+/5BJQLXDYEB7VAxqWfe6ula/AB1u/8KRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O95rq4om; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O95rq4om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEEBC4CEF7;
	Tue,  7 Apr 2026 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524368;
	bh=04xzV7B6C0nmMB8kee/matN9EpL075hjg5Q3i9FX6OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O95rq4om1pTH7pZC7zwsk3J2bF91ArIo789zWNkO7ht2PLm82OGs+1LnfEhtJX4mR
	 LOH/dCNzSLpA4nBzF1dRvBogx8iOaoVTrKkK04y0fmn/NSNVpZFuUWTzURvYg0DZP5
	 hMShlNtxbJ2xpMe1d3xKOrpArq+qDRY2pg15pffyLD1cl7E1LQieFTyGjrV3JRu+7I
	 aEzRcyWFn7gh/QtB0uVXf33y7sODc1EQjniNJEHvKXQU1eEsKbiQR8cvbeNfvbhx2j
	 52Gf+Rrjzqhfo+F8lN4uvVSzKzPeBo6HWCbuqGQxjH826/vyNm1X3RfcpOD4R+Qwmf
	 EafK0o3CcUtBQ==
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
Subject: [RESEND PATCH v16 5/5] ring-buffer: Show commit numbers in buffer_meta file
Date: Tue,  7 Apr 2026 10:12:45 +0900
Message-ID:  <177552436513.853249.11847302364667074886.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To:  <177552432201.853249.5125045538812833325.stgit@mhiramat.tok.corp.google.com>
References:  <177552432201.853249.5125045538812833325.stgit@mhiramat.tok.corp.google.com>
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

In addition to the index number, show the commit numbers of
each data page in the per_cpu buffer_meta file.
This is useful for understanding the current status of the
persistent ring buffer. (Note that this file is shown
only for persistent ring buffer and its backup instance)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v16:
  - update description.
---
 kernel/trace/ring_buffer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e56fe9dcc7d7..4bf83b7805da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2209,6 +2209,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2221,7 +2222,9 @@ static int rbm_show(struct seq_file *m, void *v)
 	}
 
 	val -= 2;
-	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+	dpage = rb_range_buffer(cpu_buffer, val);
+	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
+		   val, meta->buffers[val], local_read(&dpage->commit));
 
 	return 0;
 }

