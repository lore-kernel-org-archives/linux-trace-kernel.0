Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34CB15252D;
	Fri, 11 Oct 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658119; cv=none; b=C/mB2xqFyKEPHlO3YFPW9k/9S0I6PVRcvKZKM3GJIzsZ2lvaZZguGShTGkEyfsOz57/vzrStZITkSZW8nQrlx5byRTO/wUZFTY2SAYkA+LWpRd+Pp/2hBAvOqe25gPzdBAhG5jy1H0EuMIBZ5kZP3/SngqaJ8SGobewWSVNYqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658119; c=relaxed/simple;
	bh=fGD/tH0N2aRmgZKwCYVkMSllh0evjj+jicK2300HS/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPu/4hTdSt+WEqulToJJhSt4BvXLRwLaVfx4xeh5tb+76+XplzKdpje3X0KYjGF16QRDTgIkm21ZvW+2OWj4+2uwMo8iN0hTU3IvXDufIDDKVHJ66t4eBvB+xzgp6ijR2v/41HgFDiMcMFcW3UiP+S15DCyXQx8GQoBtzOCyUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86508C4CED0;
	Fri, 11 Oct 2024 14:48:38 +0000 (UTC)
Date: Fri, 11 Oct 2024 10:48:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
Message-ID: <20241011104848.7f5b180b@gandalf.local.home>
In-Reply-To: <20241011100132.456f903a@gandalf.local.home>
References: <20241010195849.2f77cc3f@gandalf.local.home>
	<1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
	<20241011100132.456f903a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 10:01:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Sorry for not replying to your last comment on my patch, I was ill.
> > 
> > The member ring_buffer_per_cpu.cnt is intended to be accessed under the
> > reader_lock, same as the pages pointer which it is tied to, so this
> > change shouldn't be strictly needed.
> >   
> 
> Right, but there was one location that the cnt was updated outside the
> lock. The one I commented on. But instead of adding a lock around it, I
> decided to just make it an atomic. Then there would be no need for the
> lock. Hmm, it still needs a memory barrier though. At least a
> smp_mb__after_atomic().

Hmm, I don't like how the update in ring_buffer_subbuf_order_set() is
unprotected. I think this is the proper patch:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 696d422d5b35..0672df07b599 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6774,6 +6774,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+		unsigned long flags;
 
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
@@ -6800,11 +6801,15 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 						     struct buffer_page, list);
 		list_del_init(&cpu_buffer->reader_page->list);
 
+		/* Synchronize with rb_check_pages() */
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
 		/* The cpu_buffer pages are a link list with no head */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
 		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
 		cpu_buffer->cnt++;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 		/* Clear the new_pages list */
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);

Even though it's also protected by the buffer->mutex, I feel more
comfortable with this.

-- Steve
