Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8A3DE45A;
	Mon, 10 Aug 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368368; cv=none; b=KW0zz0MBMIP9gNnMZTUXis4+T5aiQXc1LJwuTdXWAyazQZswZbenb6RuYSvUfcyYnVS5+CT4fIZi9NE63ErUN7MLxb8MvztZMtQi8Uk7sjHF+OX8qL7bHIjptkrgh1chq9dgAoOwcDVY3Qf7gHd7QFeRPjguYifnclTAIPnVNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368368; c=relaxed/simple;
	bh=9iYOJSIlQprCJWoiBvCYcI35IYgOBkEGkUwYS07skLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcFjYQUEZsTbeh5cxgqLkl5yRFVNHdsUSLpf6swO6PF0jdlLwJp42IDxUTwQpW9K/syP6LgO0Y7Mau9hkYDx6bBvmU3jgn61YaJatLQk68drmWpAQKYMVJevOnenPpcDXXUhI8G1LUuNaTnpXp3liOt4Ec1HwipCIwzv0TBHtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DD874140169;
	Mon, 10 Aug 2026 13:25:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 0CF3080014;
	Mon, 10 Aug 2026 13:25:56 +0000 (UTC)
Date: Mon, 10 Aug 2026 09:26:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/6] ring-buffer: Fix subbuf resize concurrency
Message-ID: <20260810092606.1742d25a@gandalf.local.home>
In-Reply-To: <anmDrhrSLQI3jAMI@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-5-vdonnefort@google.com>
	<20260808145854.4ff68a39@robin>
	<anmDrhrSLQI3jAMI@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zecn6y7wnq86ixhppakwwsx7gccaewsg
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0CF3080014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Of1jTNLlHKcnJpBPoMyN9+BqPyqtdmLg=
X-HE-Tag: 1786368356-175472
X-HE-Meta: U2FsdGVkX1/I8CpMsYaeAvw0tPoUBQLQXG9/8TWr0VgM9uYf3ul//1MsTrYUu2NGVjPxnSFoFF6y43ovlhSzluwdCct7mRdC3NHwdKmr/6Tr270uOU4asWNBBRuhsahdfUwVDA94qo3vvswhMD7wM1y5VPJAY4lxMzZll5cpwoxuFj2P3g6Int1veD2j88+uavY6VOpkP+pgGN94sXThuv1KxNdGubzcqjCAXdePZLz5WaNBSzP4Z0PGema6h2zjtgCglxed6RgKdpnLjgVTvtiRDbcoqjVdi5jT01C5Ok4LGAoLLIWQE9NqcT1EaHoOk7I5ZVF248wutCoFNGnAbMJaoF5ZrxVc

On Mon, 10 Aug 2026 08:54:22 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> This is probably the issue.
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c2cbdb3ef727..a64cdc925078 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3534,7 +3534,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
>  {
>         unsigned long addr = (unsigned long)event;
>  
> -       addr &= rb_subbuf_size(cpu_buffer->buffer) - 1;
> +       addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
>  
>         return addr - BUF_PAGE_HDR_SIZE;
>  }
> @@ -4123,7 +4123,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>         new_index = rb_event_index(cpu_buffer, event);
>         old_index = new_index + rb_event_ts_length(event);
>         addr = (unsigned long)event;
> -       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
> +       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
>  
>         bpage = READ_ONCE(cpu_buffer->tail_page);
>  
> @@ -5033,7 +5033,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
>         struct buffer_page *bpage = cpu_buffer->commit_page;
>         struct buffer_page *start;
>  
> -       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
> +       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);

What about just making those functions return unsigned long instead of
having to add typecasts all over. It shouldn't hurt the places it's made an
int? Although I'm not sure if bots will complain. :-/

>  
>         /* Do the likely case first */
>         if (likely(bpage->page == (void *)addr)) {
> 
> 
> I will resend a V3 dropping the 3 first patches you have applied already.

Yeah, they are already in Linus's tree.

-- Steve
