Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA08407CC2;
	Wed, 20 May 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303003; cv=none; b=ikXzCI04cAdqe2/iDDIcl2fHAQ7eyLYdINCM1oY0e0rH1YvtW4AX84Wyj4mIzV7u9OKejOdW8EsWoEt3ElYA7Nhj8+RWW/2MGDwZyDo9VzzhkDo+OTIL2ZT3WdaIspi//+ZF4MAUhwAxE33P8Vri+QJj38UeV2J8U6Uk9F1ychY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303003; c=relaxed/simple;
	bh=z5SVxvOPWouWAEsykNXiPrhwQD4I2e6zBCMpbO6NQ9A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tcDxdO4J8mUX1sauIcaTRkh9vFpXUiUlmkaVJoC2z253LtoKzNcm6gOA4jgYmfGHcHyyUWhjzLVue6u4wXJeNpOSMJmDUUEdhu5VWrqozu/0Zdu5TWDMWW6L8Gf9r21qdVJIizIPmfbBiiuf0B/msqffWk+ZDrv56wE0fW371lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozSb5z9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozSb5z9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF1C1F00896;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302998;
	bh=+qxY6XO6xH+KHvQWKy6geEKa64zKIpoMCS+55NWFVSc=;
	h=Date:From:To:Cc:Subject:References;
	b=ozSb5z9q16eUCBHQB6MbRFTNnaxfl/aNu8zF1u4eFQD0k0p/rz3LQnVg2ezUINV08
	 Se0JfWZd/eXjEbvPKD4B2u0sZCGN6M/kyhQZneP4uYyRPOdkKj14oKp+DuZiXhaKKZ
	 SXfXtrwkPBAYHnGAMEmFH/CkwVcrAPCyX7B90/XoGH6MSS3+tRA9QtV5F9FNZLj6F7
	 eX/Ywb5DTfnQVpHBBaEm2LrAdpWNPbZvOZ+kWBV7E71oCBipETqV9ITVoOQPW2KJon
	 rxOJZTSwBBmAM1mnon9Z1DBzXWAjuA2eWI985d/RltgDIMOjK3vCUduUwSLPRnpZJq
	 izxLZllN+jNDA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzl-00000004qSK-32du;
	Wed, 20 May 2026 14:50:17 -0400
Message-ID: <20260520185017.589985000@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 04/10] ring-buffer: Show commit numbers in buffer_meta file
References: <20260520184938.749337513@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In addition to the index number, show the commit numbers of
each data page in the per_cpu buffer_meta file.
This is useful for understanding the current status of the
persistent ring buffer. (Note that this file is shown
only for persistent ring buffer and its backup instance)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ce645ca8425d..695398d72fbb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2224,6 +2224,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2236,7 +2237,9 @@ static int rbm_show(struct seq_file *m, void *v)
 	}
 
 	val -= 2;
-	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+	dpage = rb_range_buffer(cpu_buffer, val);
+	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
+		   val, meta->buffers[val], dpage ? local_read(&dpage->commit) : -1);
 
 	return 0;
 }
-- 
2.53.0


