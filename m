Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE559323417;
	Mon,  6 Apr 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471101; cv=none; b=WKnj1ygfLEHAlwGrIc/wPH0rha/8gbEwt7Ed3bdOn6sa2KNmCvlKhAdcQzVeTtvcsD7JPQGifi+JAPOCjo8sFRaP3TrtP5/hVNw5JVrB7kDL6cW1fykXfZ05xo5ie6RakpLNR7t5ASAN7AY//gkzWydqMqvrVU4pjLYo7NgQlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471101; c=relaxed/simple;
	bh=04xzV7B6C0nmMB8kee/matN9EpL075hjg5Q3i9FX6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKr6zczrA/lIg5gR6w8HcXWDk3T1Oatj2eSpZnMQHQhDU9uIsN/mxXLZukcJys7bn0jV6Lgcp6dTQJVusBT5i2BxyjCRAfM/ZhbRyG+TTt8mqBDJLaI/kJxhF7mIy6HKyMCka8PhUmB3axHcQrjH5kP9VBewYgaD6U33Hn0/A9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1IclHoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1IclHoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C97C4CEF7;
	Mon,  6 Apr 2026 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471101;
	bh=04xzV7B6C0nmMB8kee/matN9EpL075hjg5Q3i9FX6OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1IclHoMlFg67kG65rpRpLwRfbHVTs5ZkORk+pxRgxrLE6xWaZaEK9qubaRpMj65P
	 f/OGyw/MgKXaG/NFtYfRFiXZSwjDWcYVsIG/W30FztV9pX+BujkcJgacqOKk9NFeJ7
	 VFegw/3cISJgzNviEx5LSCxie7aeaQyyJeOr0mue+XQ2Mpc6AXovhmQYHS9uuy88Oc
	 an5emKPHvsbwKKBTayqWiBQJ74vzoQwMwrNOWtU/2knEHFuy7sA4/siCeR8IT2iNPS
	 myVuTBER+U4H3MW5DsJsI639seQ5ueHXEbCJn+KQnooRbEu+itgjW/wsCYUop3L54D
	 iqAc6CTjWzMNQ==
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
Subject: [PATCH v16 5/5] ring-buffer: Show commit numbers in buffer_meta file
Date: Mon,  6 Apr 2026 19:24:58 +0900
Message-ID:  <177547109851.259641.2033773321493831101.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To:  <177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com>
References:  <177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com>
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

