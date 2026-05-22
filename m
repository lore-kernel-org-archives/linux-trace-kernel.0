Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36247B403;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469829; cv=none; b=ogeFoPLW3YfHPMSzV04Yk+7vz38CNaHys7NGAOfhpUnuJCvCl8lyxRckL/Sh/zRvOdrYj40WuRcu92S1M6SwGR8s3FwykCmHPTzEe/xdPzJuVwbKYWS9YNMbEH7sZ6u3V7CQ2scJpm2WdKaZ0kwTK+L39/VELYNKNluDOW5iSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469829; c=relaxed/simple;
	bh=fiI+Qb/R5diVg4en3BTV+lA+2Z6MKD51ZvQsxbbPAdw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Bv8Oc8tc7N8+uDm+0Zclx4iqpj6z5FvX61vlDboxlGnLYvxrNnmBSHoMxLr0NoeBPE1RTaHUK9M/ZJJ9HKIiW+htN9xwzAQsR5oy+W2zaAEzKOcHAYgsOVMJjWH6jeJQZHn1a/6np9gVSkmd8F2/AKlpnsxHNFfjOZhCylas94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLPYZYWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLPYZYWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E6B1F00A3E;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=KD3f7fDpW0DpT4/8zRZPuN8IgZvs1RrC8lIQVJazhE8=;
	h=Date:From:To:Cc:Subject:References;
	b=NLPYZYWeho52kOY0B4lZ5+P7IRmZeEHPLXEvxH6Y6U3NaLUErzp3X4trXqNG/dYPh
	 G5Bf1aezUJnWuNONHfuVi4s7u7LsB1ilfnHtqJwyF/YHq69JpcCnTqUgCcmHNmgwWw
	 41e/Tw3hDFajtNveCvlgb5goe0nKPLABRbZGkQBT7ydBOdDk05+Qfz/KYXJtkv1VoJ
	 mrra28Puq6ivluSlD3elMuMUikhAdKY/hBQXoJESzcEkbtj456M6i2k/am5Ze0oesh
	 C4SHYm3zlStG7FfKLAHSnAQKdnlv5Ohkp7VyYK1nABH/hTlg087CEB92MkB4vLUApk
	 uorxfnYGE1U7A==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BVu-2LdN;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171051.424411323@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 4/9] ring-buffer: Show commit numbers in buffer_meta file
References: <20260522170857.263969486@kernel.org>
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
index dc603d9c9414..88e613e78632 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2231,6 +2231,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2243,7 +2244,9 @@ static int rbm_show(struct seq_file *m, void *v)
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


