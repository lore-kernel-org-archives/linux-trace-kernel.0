Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962576;
	b=XQyExLGBCOmDICDuhRxJ/hc8ryhjivPirERXWivcCOWeXBFIUxtKLf/Tz4FGEogwpDG4
	 Q95K/nu6LsuxwRwnuU7868XDQ34Fv/LoHxRUJ6xFe1CEsOsRiWkeQPZC4VsNvn7yb3rTb
	 NDwVbmeiHa9akz+ukLb2urmPnIEqSK04AMgQbyQ57wUIwPxHSfPZ8/d4RK+oKo/v4QOKt
	 QvQrhnIthis311CFY/is4ipGUr5tjQE16KyG18IR4wMsX0Yx/v16dfQg4SAk31nZKGTxo
	 itoOSAIjcHcOATSzokb6+6o64b9wjbwPKzEEGOA78FeN1xz82YGZFS9p68q3/b/ucKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962576;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=RH0/x1kblDbGH1251KrGJAtZ1HLR8bWlOc9Jz3/AIvs=;
	b=lJDBELEGyt+ILj75KYJVsXexTg/LAz24NJE+upRwpNbvttmkjhhJc66Pa63/Rkxo77V5
	 e67Oo6ouYVNDqp/K97yJ7nLSjsnZlYpYpkAUsxAnZTJ0qA8ODjpGa2RITX1O636iYU3Mr
	 mTdlC+8fufHGHKCVt9DiDfNJeBUAfo7lKPppf2wgwyzoE2kS63Y9xqaU2ZK+Vlq/GglFc
	 ryFBABgmVSlrfgsnn26GCo9O+UiOt6YIO8NXCY5ko/Quto+wKSpzUgjq7xsuuHl0FfjI/
	 kKN0ZWB2Zwq8Qm6GxhHCGVVAIJ9TpqlziK1VfV4914OtCuaBOxImxj7l6ovVyfyQolg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=BEcRk+UL;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C769606A8BC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 00:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C769606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=BEcRk+UL
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C6C83A8218;
	Wed, 18 Nov 2026 00:42:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2B17C2000F;
	Wed, 18 Nov 2026 00:42:49 +0000 (UTC)
Date: Tue, 17 Nov 2026 19:42:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] fgraph: Read the task->ret_stack with a
 smp_load_acquire()
Message-ID: <20261117194248.5ec75a33@gandalf.local.home>
In-Reply-To: <sashiko-outbox-219864@kernel.org>
References: <20261117193007.6ee9f605@gandalf.local.home>
	<sashiko-outbox-219864@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2B17C2000F
X-Stat-Signature: doti1s3dnk9nhxxz6t4fez3nwaobmewf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/K/SeXTPk/zDV35uMt659ToiXkze9Fx5A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=RH0/x1kblDbGH1251KrGJAtZ1HLR8bWlOc9Jz3/AIvs=; b=BEcRk+ULilNo9yiltWDysjIWbU+Mi06dEDAwck8Ci9ryCxfQ3iGDDZk+4+4r6ZLlZ5sgZFJtgIncpSnCf7YXn6MEnO2pHADgbQcrHEf0bLcfNfI8oy331O/+Na4Yd74R4aft+BNCwgVKGmherZQeEWF3F+G2O2tYyv0UiZTRZ9k=
X-HE-Tag: 1794962569-294797
X-HE-Meta: U2FsdGVkX18YYnwASP2Jkz1Mi+USmHHuFMvxa9RkWIskRTkTgqeUuurXU/+OeuK75Ip06+CrQo7W94TwYR/cDknk8fWvomhoZV70t6doAdi7wtTR156BbTyrwDE1EaHPT9ngiG3tOwdbw3fK3QcBN4b2hahW4FYFeeMeIHJB42f2WvaT6DrmFtkhDf3f1N88wjEbifxEUt7HsbxCXiUSfefO20DHul1QNjJdUrt+UvKGYT6fvEfphVVNo55lQVr8cm8nOOW+/DIunDzIKbgDp1XK7a7HqgYKZGge3E4kiQ0EbZzm+Rkj9BluUQRnTS69CCjeMZLdp7Z7aWJIMkBbKrQc59CJC/kUcPt9QE0HOOzTxCS8bTGDpr/QfwONCJebVpOVKt0N3NN8MyFsbao7sg==

On Wed, 18 Nov 2026 00:40:05 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] fgraph: missing smp_store_release() conversion for
>   task->ret_stack writers
> --
> 
> commit b7c8f41f039b807327203effc627ecc71bfa14c8
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> fgraph: Read the task->ret_stack with a smp_load_acquire()
> 
> This commit replaces the plain read of current->ret_stack and subsequent
> smp_rmb() in ftrace_push_return_trace() with smp_load_acquire().
> 
> Link: https://lore.kernel.org/all/20261021174406.2891598-2-vineet.gupta@linux.dev/
> 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index ed455b53513be..eaa8d6aadb0e8 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  	if (unlikely(ftrace_graph_is_dead()))
> >  		return -EBUSY;
> >  
> > -	if (!current->ret_stack)
> > +	/*
> > +	 * We must make sure the ret_stack is tested before we read
> > +	 * anything else (See alloc_retstack_tasklist()).
> > +	 */
> > +	if (!smp_load_acquire(&current->ret_stack))
> >  		return -EBUSY;
> >  
> >  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> > @@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  	/* Set val to "reserved" with the delta to the new fgraph frame */
> >  	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> >  
> > -	/*
> > -	 * We must make sure the ret_stack is tested before we read
> > -	 * anything else.
> > -	 */
> > -	smp_rmb();
> > -  
> 
> [Severity: Medium]
> Should alloc_retstack_tasklist() and graph_init_task() also be updated to
> use smp_store_release() when assigning t->ret_stack?
> 
> The commit message notes that setting task->ret_stack was switched from
> smp_wmb() to smp_store_release(), and the new comment points to
> alloc_retstack_tasklist().  However, both alloc_retstack_tasklist() and
> graph_init_task() still use smp_wmb() followed by a plain store to
> t->ret_stack:
> 
> kernel/trace/fgraph.c:alloc_retstack_tasklist() {
> 	...
> 			/* Make sure the tasks see the 0 first: */
> 			smp_wmb();
> 			t->ret_stack = ret_stack_list[start++];
> 	...
> }

This is fixed by the patch that I have the Link tag pointing to.

> 
> kernel/trace/fgraph.c:graph_init_task() {
> 	...
> 	/* make curr_ret_stack visible before we add the ret_stack */
> 	smp_wmb();
> 	t->ret_stack = ret_stack;

Ah, I'll update this one too and send a v2.

Thanks,

-- Steve

> 	...
> }
> 
> Without converting those writers to smp_store_release(&t->ret_stack, ...),
> the store side remains an unmarked plain assignment when racing with
> smp_load_acquire(&current->ret_stack).
> 

