Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBC35D5E2;
	Fri, 24 Apr 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013574; cv=none; b=lPXJkZwQUJeXgDhCp8qz4npx5quZ75BGc22cLe9JwLP2wT21zt/8rpGS2hVFCcWZBqXK4z5W/JyI2zZueUHL89ORwa8E681nq2Ywwv7kwkAmBJFpWBkFHRWCkG5HsJaY8wOHCi92fVVKqiwiSYsMFa4EVklc6yl+Gw/1IHQ48kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013574; c=relaxed/simple;
	bh=ZNLWUqzy6prqN8C2IicGEQorWhN6QWpt0ii93XNC/uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+VhHIpqsUDWhwCjhNzlv1pow3oHaxe2hA8BipdUgO5dv2yV33nI5oqxQSYKMB+gqfOOqtn3IxNS4xWm3GOBb3IC9C/YVWYEMqL5p8M8BZ4E6tce5FUk3h1ITCuuKn0SVld7NYgnF0Rkh/oMGyvGkWKRFN5tXh/FkBvXyXTcNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXbevsU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXbevsU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C6C2BCB6;
	Fri, 24 Apr 2026 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013573;
	bh=ZNLWUqzy6prqN8C2IicGEQorWhN6QWpt0ii93XNC/uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXbevsU9B9t/NRBMR7+fap/Rf+nLhzAUx9MO25V9+OFRA5xvaY5Z306Rp5KkJmzDo
	 Axf9W9Lg/b7PXrVaAa8IOLMb2pLrxYdL2LP4vg+kUHnlVbibN/f9a8SccMT+pWR5kW
	 ns2ZKusPJpVuDRBcr7pmeT12223BireSNzXjoYMm9nLTZckvbgQHJQ4EFGcVI5BrKK
	 j1LXOb9b0UIiSqXk8ujF+yDuavdirtMbiW8GzviaNBPNFbdSI900m1CCmvM8ZvjQHx
	 Mpl1fPlSur4gfwOJlbuEyOpnWyvsYcFvjejxbneCbc3ldE54tSG16O1epW9xUuzreB
	 T5k3Ij95f6Qtw==
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
Subject: [PATCH v18 6/8] ring-buffer: Show commit numbers in buffer_meta file
Date: Fri, 24 Apr 2026 15:52:51 +0900
Message-ID:  <177701357092.2223789.2924578391155511584.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
References:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v17:
 - Added NULL check for dpage in rbm_show in ring_buffer.c.
 Changes in v16:
  - update description.
---
 kernel/trace/ring_buffer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e8d2b3457d7f..de653a8e3cec 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2216,6 +2216,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2228,7 +2229,9 @@ static int rbm_show(struct seq_file *m, void *v)
 	}
 
 	val -= 2;
-	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+	dpage = rb_range_buffer(cpu_buffer, val);
+	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
+		   val, meta->buffers[val], dpage ? local_read(&dpage->commit) : -1);
 
 	return 0;
 }

