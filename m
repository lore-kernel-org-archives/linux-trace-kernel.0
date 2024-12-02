Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1A55887;
	Mon,  2 Dec 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169854; cv=none; b=sTCyN2eG7mE4x5LojRIUMHRXrr64CAGV4HCLV+EK7AnVK7z+UZNKXajxfGewkK8vxY8qT+X4Ed/g/8P8oRZZfFtXLNki0+szRW5IgFopkGpb1tNWfT2kIZaGy55TpKzrfWc02zaBj2YHNhwNA47Ri4VW+SEqjd6qlTIimYvhfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169854; c=relaxed/simple;
	bh=RT9Pcj9xxSmFHmjqpWPodieZi3PqA6Jp/24UMnlaIdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfgVSCSUj1Q6NdYreePCN63D/QeOf+edAwVUcrKSjp3P/G32xOJQoyayY5WmIxZ1S9ucemn8zzYtnliMytSNvM08p4Tr2P3twEWXruiTeOH+vC9+3hc4T/61WqMH68xZs91fug1+Dj54LBSrll8x3skMDTa9t6JiUaFPtePHMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E267C4CED1;
	Mon,  2 Dec 2024 20:04:12 +0000 (UTC)
Date: Mon, 2 Dec 2024 15:05:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
Message-ID: <20241202150516.3cf52584@gandalf.local.home>
In-Reply-To: <Z01Vn8yZv-AlB-Z4@kernel.org>
References: <20241017113105.1edfa943@gandalf.local.home>
	<6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
	<20241201150406.17f10247@rorschach.local.home>
	<Z01Vn8yZv-AlB-Z4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 08:37:19 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> > > On powerpc I get:
> > > 
> > > 25850 pages:14 groups: 3
> > > ftrace boot update time = 0 (ns)
> > > ftrace module total update time = 0 (ns)  
> > 
> > Hmm, does powerpc support "trace_clock_local()" at early boot? I
> > probably can just switch from using "ftrace_now()" to using
> > ktime_get_real_ts64(). Hmm.  
> 
> The calls to timekeeping_init() and time_init() are after ftrace_init() so
> unless an architecture sets up some clock in setup_arch() like x86 does
> there won't be a clock to use.

Hmm, maybe I should add:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..362a125d7bcc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8588,14 +8588,23 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		return -ENOMEM;
 
 	r = scnprintf(buf, DYN_INFO_BUF_SIZE,
-		      "%ld pages:%ld groups: %ld\n"
-		      "ftrace boot update time = %llu (ns)\n"
-		      "ftrace module total update time = %llu (ns)\n",
+		      "%ld pages:%ld groups: %ld\n",
 		      ftrace_update_tot_cnt,
 		      ftrace_number_of_pages,
-		      ftrace_number_of_groups,
-		      ftrace_update_time,
-		      ftrace_total_mod_time);
+		      ftrace_number_of_groups);
+
+	if (ftrace_update_time) {
+		r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
+			       "ftrace boot update time = %llu (ns)\n",
+			       ftrace_update_time);
+	} else {
+		r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
+			       "ftrace boot update time = [Unavailable]\n");
+	}
+
+	r += scnprintf(buf + r, DYN_INFO_BUF_SIZE - r,
+		       "ftrace module total update time = %llu (ns)\n",
+		       ftrace_total_mod_time);
 
 	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 	kfree(buf);

Which should turn the above to:

  25850 pages:14 groups: 3
  ftrace boot update time = [Unavailable]
  ftrace module total update time = 0 (ns)

Which should at least make it not confusing.

I'm assuming that the module timings are zero because no modules were loaded?

-- Steve
