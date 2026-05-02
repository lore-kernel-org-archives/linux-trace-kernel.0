Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90C175A73;
	Sat,  2 May 2026 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777760246; cv=none; b=Cjfi6FIW82rpjcArdikvT33I68EQ4wWnbTCg4Sh6WrZVSmMRHoMuWHVqp2ausSrr8uOAxLAu+hZ/eAnc9tTr2eFZ5JrqulYLYSCRbZ0FTMTsiLlcQwGpYUjll3jc68F/nuMyxSg1qAXq59zduuhNLHU1b7wU5jlzlPqxz1S8RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777760246; c=relaxed/simple;
	bh=gBJbaaIGQVQb2n21mMPbuRuHh1uzGoPVGVcGZHTYWNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCzRZY7Fl57m6WXtuKXA1hiU+7bs8vgLTRtO7CnZ6PzvLsj2x9Seg5l672rtPH0Cjaf9Y4lWn11QItH2dEFt+C/XUuPw46iVeHxWwVY9sSrOpij3WhCAqhf6lxrMdNQYmWdJP0F7Gxus+NEU5Wme14dkTmVpz1cR48Z1mvmBcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2ezqMHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2ezqMHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A82C19425;
	Sat,  2 May 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777760246;
	bh=gBJbaaIGQVQb2n21mMPbuRuHh1uzGoPVGVcGZHTYWNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L2ezqMHgHwDYiGZvnjG+2o4vWYqPlEF3h93FpqyD5LhXJ8hQimsoSKKFTdc7FPF5b
	 4TbLL7lYXhJfYBk9e9PBhLZXhi8A/PIsXsIE4uSPDkIC8xj/c+Wwe/hfNT27yrskgl
	 +8Hd537OGba+L2zIm5fw+WNdxGxRNRH9c5gJjcEKYBfiCs7/gYvppGt5MxcmensuH0
	 5YuH18Ni+Vsc8l4xpIWFCC76uY7qMKIVL2JKiur69KTzI/1sGbD7LaLo3Fw/Nn3lUH
	 qjMppd+n6SAtF7tPeV/cNaic7ID4SljmYLcXCWhnKu70kP/hdIzTV8yahmOoK+hQgT
	 t8z8HQ13sv3Bw==
Date: Sat, 2 May 2026 18:17:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260502181619.7f5003dc@robin>
In-Reply-To: <20260502152304.560a5954@robin>
References: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
	<20260502152304.560a5954@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 May 2026 15:23:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Masami,
> 
> I applied your patches and enabled your ptracingtest code. I noticed
> that when there's dropped pages, the trace output is not in order:
> 
>  # trace-cmd start -B ptracingtest -e all -v -e '*lock*'
>  # taskset -c 5 echo c > /proc/sysrq-trigger
> 
> On reboot, I ran:
> 
>  # trace-cmd show -B ptracingtest > /tmp/trace.out
> 
> Then executed the attached perl program:
> 
>   # ./read-ts.pl < /tmp/trace.out
> 
> And it errors our:
> 
>  30.212495 < 30.213534
>            <...>-1048    [005] d....    30.212495: irq_enable: caller=irqentry_exit+0xf5/0x710 parent=0x0
> 
> That is, I think the zero timestamps may be messing with the order.
> 

Ah, I think I found the problem. The iterator needs the same logic you
added for the consuming read:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7bfbed0ac90c..90a7fa772fe3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6105,12 +6105,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
+	int max_loops;
 
 	if (ts)
 		*ts = 0;
 
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
+	max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
 
 	/*
 	 * Check if someone performed a consuming read to the buffer
@@ -6133,7 +6135,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	 * the ring buffer with an active write as the consumer is.
 	 * Do not warn if the three failures is reached.
 	 */
-	if (++nr_loops > 3)
+	if (++nr_loops > max_loops)
 		return NULL;
 
 	if (rb_per_cpu_empty(cpu_buffer))


I'll test this some more, and make a proper patch.

-- Steve

