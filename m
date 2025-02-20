Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FE1CA84
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064244; cv=none; b=tcr5dIiotEDCJcfT4NoZXmq5SAfKSES9YIsBVAKaUuKkHjPGCq7KwoygFlljf1kCyZSCv2X07zGXyV1tLcjYBv5qndaZ3YOLCVcD8Rl5T37n+nEQoC32X5A4KXjCsTBeZURk3W6GM4lVU1AAimsfkjWoPg39ZtpMzdrKZ1NeOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064244; c=relaxed/simple;
	bh=tuxr5J5QbbrqSOXcckZN6ltOCV023eNnsIXatLFcDuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lm8tVU7ASyY5/rtKY22sL+1IUYf41ikshd+LRK1HzpdZ4BnqaOXhma7uRYzcpQFFaZB/W6tIgfOxl4iXoNDNlO911UZOAZzB8L21szZtrjJYIITWyAHGuz+QyQwdn4NCBWshHmIc0UgofKIIf/2toS96Q9LMiHSyIys5aa94hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+EYLMNH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+EYLMNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740064241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aiEFS+y4NTwt/6dvbOAWT0yBuG7StG/tr6ib/rj/FkU=;
	b=D+EYLMNHYT7XDsKtQMhG0VazblV9b3cQv7fcWbYlIxgbifzbAhCjB/J3Rk1Eyd5mgrsAfG
	UeT+8N2KrS/9YXwF8EpNuP/xkKO7QZdfe/K+zHe01Q1zv5rDtBb1XSm7UtOEX/5OjcEYmA
	RbMJDIIFn/8AjZ9KhW0KngnuSTAsgtk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-uYqPI6lVOrmw7KDftBITrw-1; Thu,
 20 Feb 2025 10:10:37 -0500
X-MC-Unique: uYqPI6lVOrmw7KDftBITrw-1
X-Mimecast-MFC-AGG-ID: uYqPI6lVOrmw7KDftBITrw_1740064236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9307B19783BA;
	Thu, 20 Feb 2025 15:10:35 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E81B8180035F;
	Thu, 20 Feb 2025 15:10:31 +0000 (UTC)
Date: Thu, 20 Feb 2025 12:10:30 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ftrace: Correct preemption accounting for function
 tracing.
Message-ID: <44ymxgot422oetab62w55rth5tqrzseyhwirxg2ho7vzvvkaud@qiada52ckt25>
References: <20250220140749.pfw8qoNZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250220140749.pfw8qoNZ@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SePruJDZo5I_JHaOkBYFih7KAVzUJitvJ4SREUk8eIg_1740064236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2025 at 03:07:49PM +0100, Sebastian Andrzej Siewior wrote:
> The function tracer should record the preemption level at the point when
> the function is invoked. If the tracing subsystem decrement the
> preemption counter it needs to correct this before feeding the data into
> the trace buffer. This was broken in the commit cited below while
> shifting the preempt-disabled section.
> 
> Use tracing_gen_ctx_dec() which properly subtracts one from the
> preemption counter on a preemptible kernel.
> 
> Cc: Wander Lairson Costa <wander@redhat.com>
> Fixes: ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I haven't been ftrace for quite some time if I got the fixes tag right.
> 
>  kernel/trace/trace_functions.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index d358c9935164d..df56f9b760109 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -216,7 +216,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  
>  	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
>  
> -	trace_ctx = tracing_gen_ctx();
> +	trace_ctx = tracing_gen_ctx_dec();
>  
>  	data = this_cpu_ptr(tr->array_buffer.data);
>  	if (!atomic_read(&data->disabled))
> @@ -321,7 +321,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	struct trace_array *tr = op->private;
>  	struct trace_array_cpu *data;
>  	unsigned int trace_ctx;
> -	unsigned long flags;
>  	int bit;
>  
>  	if (unlikely(!tr->function_enabled))
> @@ -347,8 +346,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (is_repeat_check(tr, last_info, ip, parent_ip))
>  		goto out;
>  
> -	local_save_flags(flags);
> -	trace_ctx = tracing_gen_ctx_flags(flags);
> +	trace_ctx = tracing_gen_ctx_dec();
>  	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
>  
>  	trace_function(tr, ip, parent_ip, trace_ctx);
> -- 
> 2.47.2
> 

It now reports the preemption count correctly:

    kworker/0:5-88      [000] b...3   211.972885: e1000_check_for_ack_vf <-e1000_write_posted_mbx
     kworker/0:5-88      [000] b...3   211.983386: e1000_read_posted_mbx <-e1000_reset_hw_vf
     kworker/0:5-88      [000] b...3   211.983389: e1000_init_hw_vf <-igbvf_reset
     kworker/0:5-88      [000] b...3   211.983390: e1000_rar_set_vf <-e1000_init_hw_vf
     kworker/0:5-88      [000] b...3   211.983390: e1000_write_posted_mbx <-e1000_rar_set_vf
     kworker/0:5-88      [000] D.Zf2   211.983391: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
     kworker/0:5-88      [000] .N...   211.983396: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
  irq/63-ens14f0-1122    [000] b...2   211.983399: igb_msix_other <-irq_thread_fn
  irq/63-ens14f0-1122    [000] b...2   211.983399: igb_rd32 <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983400: igb_check_for_rst <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983400: igb_check_for_rst_pf <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983400: igb_rd32 <-igb_check_for_rst_pf
  irq/63-ens14f0-1122    [000] b...3   211.983401: igb_check_for_msg <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983401: igb_check_for_msg_pf <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983401: igb_rd32 <-igb_check_for_msg_pf
  irq/63-ens14f0-1122    [000] b...3   211.983402: igb_check_for_ack <-igb_msix_other
  irq/63-ens14f0-1122    [000] b...3   211.983402: igb_check_for_ack_pf <-igb_msix_other

(Except in line 6 where it show 'f', which seems to be an unrelated issue)

Tested-by: Wander Lairson Costa <wander@redhat.com>

