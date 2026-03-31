Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8E3E275A;
	Tue, 31 Mar 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946202; cv=none; b=pNYqzc94cMYeWI8lKFD5lNcWql0fk9b0FXskrTD8B9h+9jFJ5zrI4MY6Vw2TnIRfZcct+AgDFiCf21cbbuJHK6KAAvdCvKcmELduwoofIVB/Sw8mBkbS3NJP1G+7J3YSzxYwglW6r3uC0SPRfJ+0f0BcnAqRNXlckbjRBuQBsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946202; c=relaxed/simple;
	bh=zBvbhKuvsTDbLAa1L0owpCB16c4iKQkzIjyhvgxp+hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzupgB3GjOR9pq7exPbAQMdx3bD9GsufymjDPijKdTR2i+tPNYlKdlKyP3AlFaATyESQt9Jc8pICAt7tY4Hthno3kwQDOS1i3W5V6uVabSewztOXVopTZLZgKriTWEGXfWQ2EnHnFwAuaseOb1cBPBVUT3GeWI/l2zp/3FLTGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFN56mWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFN56mWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB3C19423;
	Tue, 31 Mar 2026 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946201;
	bh=zBvbhKuvsTDbLAa1L0owpCB16c4iKQkzIjyhvgxp+hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFN56mWC6/hjUGUjsna+ue9prq5jNncv2i0I9ar0nNDqmtbIjwhUHOJG4pIAMDcCT
	 Sf1LH6F2ppDsBAKI4xV1CQFnEXyxRlY/db1naL0ifltZThPB2qBQaewAx972ItDdya
	 pmR9pbDCwXKOetkR0Iob0cjfebPU4wbiJEbIQpH535ePy17JY0agiNPTMdhpg3EWf1
	 eFddBentttY7huy+XnpSqMBdhJKjSqqTTxYU5JHrzCVSI5AQ2v3GDHvts2PrigUnoA
	 f+R3yXeMl9nMX9IlAPL3DBT65/xZXBKcig8j32Ngqeyv5GG+APQi/pRvooV6O0XNAF
	 9pq0U/Hz8zs8w==
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
Subject: [PATCH v15 5/5] ring-buffer: Show commit numbers in buffer_meta file
Date: Tue, 31 Mar 2026 17:36:38 +0900
Message-ID:  <177494619878.71933.15471023049227398684.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
In-Reply-To:  <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
References:  <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
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
each data page in per_cpu buffer_meta file.
This is useful for understanding the current status of the
persistent ring buffer. (Note that this file is shown
only for persistent ring buffer and its backup instance)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fb098b0b4505..5b40fea6b15d 100644
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

