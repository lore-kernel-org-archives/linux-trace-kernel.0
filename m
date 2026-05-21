Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE73090F4;
	Thu, 21 May 2026 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351545; cv=none; b=mq4cIQylE4N1MCWnBxGqfch2TbhdDEPquW1uj3tTP/EhBuutRo85akCdp4qETji9XFVqYUvWLHL/eT74cD/JiBGapbpSVou231JNSyuyz4bAZBgaIMZZuNa5iDyt2gXTB8XJfpYN3XrrL/GiszJyDWeRj2falSr8AaJgu4qkzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351545; c=relaxed/simple;
	bh=M+GMWci5EdVwDqhbcNEOI8shYlN/+A06moVjBoEVTGc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KFW9AN9cCF0U2NF3ebitFgWGEiPq4R1qMuqM0RH2og49PXIE4Gks5Pw/vILDdK4/eGJJJh/SaOz14EKo+zY6MPMuqvtTuc7Wkq5hgVTU/AwVNBzAqKSRIsmMqjmvGssEBOJNE6d4tC0n74bOWHlG1Vqa4YWcmBSKxh6/WfzjdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2bqHWUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2bqHWUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009381F000E9;
	Thu, 21 May 2026 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779351544;
	bh=TvWQqs96T0GpeZOjHVOMWxavgnLwyBMFswV91a46Ifw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R2bqHWUTfpy1AmgEwWQr/Ij/8s0VO3OVF62FFYSir5sz0ZGHSUK/cq5z58SJ2pNHU
	 uP0qpBrNE/w2dOtwBxU5IWI6Ce4df+0u9zsDvNnVAWyYpjZ57Fjbrd7PzAapqa1Nd/
	 mFlqIvKpijB8WHjPUCsows0nBsuESIZ1v/+HbAoBCxoXg40kPOnqdF1xAG4QW5M6gU
	 OBVSdzlS9ZDl82EPP4IVva56EHvefjvsEz2vdVWVSN2s7+cu+17mzkI4sXJL8iWsmY
	 QcbCWx3TaCYN0J8dWvlr2hII9xb/+1irphjvZY6HkTv1rQuTjVjcKhmbP9tDTcbKmG
	 cQmCpKqE3KfBQ==
Date: Thu, 21 May 2026 17:18:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 10/10] ring-buffer: Show persistent buffer dropped
 events in trace_pipe file
Message-Id: <20260521171859.dec135e45fb443b7bf5fb964@kernel.org>
In-Reply-To: <20260520185018.470465795@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.470465795@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:49:48 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the persistent ring buffer is validated on boot up, if a subbuffer is
> deemed invalid, it resets the buffer and continues. Have the code preserve
> the RB_MISSED_EVENTS flag in the commit portion of the subbuffer header
> and pass that back so that the trace_pipe file can show the missed events
> like the trace file does.
> 
> For example:
> 
>    <...>-1242    [005] d....  4429.120116: page_fault_user: address=0x7ffaebb6e728 ip=0x7ffaeb9d4960 error_code=0x7
>    <...>-1242    [005] .....  4429.120124: mm_page_alloc: page=00000000055254f3 pfn=0x1373bd order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP
>    <...>-1242    [005] d..2.  4429.120132: tlb_flush: pages:1 reason:local MM shootdown (3)
> CPU:5 [LOST EVENTS]
>    <...>-1242    [005] d....  4429.120661: page_fault_user: address=0x55ba7c2d0944 ip=0x55ba7c20cd02 error_code=0x7
>    <...>-1242    [005] .....  4429.120669: mm_page_alloc: page=0000000005a02500 pfn=0x12b6e4 order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP
>    <...>-1242    [005] d..2.  4429.120680: tlb_flush: pages:1 reason:local MM shootdown (3)

OK, this looks good, but I have a comment below.

[...]
> @@ -7123,19 +7132,23 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		 * the reader page.
>  		 */
>  		if (full &&
> -		    (!read || (len < (commit - read)) ||
> +		    (!read || (len < (size - read)) ||
>  		     cpu_buffer->reader_page == cpu_buffer->commit_page))
>  			return -1;
>  
> -		if (len > (commit - read))
> -			len = (commit - read);
> +		if (len > (size - read))
> +			len = (size - read);
>  
>  		/* Always keep the time extend and data together */
> -		size = rb_event_ts_length(event);
> +		event_size = rb_event_ts_length(event);
>  
> -		if (len < size)
> +		if (len < event_size)
>  			return -1;
>  
> +		if (commit & RB_MISSED_EVENTS) {
> +			printk("MISSED\n");

Is it for debug?

> +			flags = RB_MISSED_EVENTS; }

nit: block closing brace is in the previous line. Maybe typo?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
