Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477137FF4E;
	Wed, 22 Apr 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874631; cv=none; b=Fjhgo7LzKiuvtxZ3uKssv6c1ZixAHLM9rJK13cnnYV7tQh2COt96bHFBbQX2zMTHlgWdrJWGk4JyRfEVJmCBLcUhRiN12LjJy83VSubvLOwbEE1j5UGzFOGBX4s0MaOEbGZzstmSFE55glD4qRzNL8lmbRr4ocwOB17dpAuQ/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874631; c=relaxed/simple;
	bh=c7iBYZRpOtWPvLcFtw1dd9PzPthaeOLO/ie+Zfx/ByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C442JBzt/YwR46ABDBlfINkgSPZGxK5kHfHb6spErTABeSTnHQRasn5ajlzMADeQDYNLvTrrt+6EjnJhOXOBspQ6hmQmiTi6ekloB3Vwmsc9OupSisKhNe3MZSmA3JoJ3dGqMuZmCVcdnXOfUrV9Pbj54xFEaMvGWrTchLIDW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtN5BZ6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtN5BZ6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3D6C2BCAF;
	Wed, 22 Apr 2026 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874631;
	bh=c7iBYZRpOtWPvLcFtw1dd9PzPthaeOLO/ie+Zfx/ByQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtN5BZ6FQTsY6ccim/pco0ZmKP9wp8NZSXFDAFHf5PqLX8+EFcWD92MAhe+/O4fPW
	 GiDYi5I6C1l206Q4fGFFgxoiyfdZls/04p2tAU+KgDLEPeNqg00EhOkmeHPBUKSMtA
	 FsKw8/Xe0DsppJZ2cB6W4ESUNrAySe+RjROXZnT/zJNlLuANX/AaVKW4IM05Ycqx+F
	 Vn7ACFEVeZ5LxpdxOxBesF2BgnnW/l/o1TfBh4xn++sW7XVxl324J65Czhwqvpwyx3
	 dfSlFESonGFjoFY0G/LxIvzc8M6dZEg8CzHbCGZVxdp/JSTcO0MlN6tkqVeJEXBe0X
	 TTStuH0SJjalg==
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
Subject: [PATCH v17 5/5] ring-buffer: Show commit numbers in buffer_meta file
Date: Thu, 23 Apr 2026 01:17:06 +0900
Message-ID:  <177687462643.932171.4169785470864985964.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
In-Reply-To:  <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
References:  <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
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
index 31448c5ea791..15dcbf554d49 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2215,6 +2215,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2227,7 +2228,9 @@ static int rbm_show(struct seq_file *m, void *v)
 	}
 
 	val -= 2;
-	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+	dpage = rb_range_buffer(cpu_buffer, val);
+	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
+		   val, meta->buffers[val], dpage ? local_read(&dpage->commit) : -1);
 
 	return 0;
 }

