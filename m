Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D531225417;
	Tue, 23 Jun 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219456; cv=none; b=fAIiFlviftD94p7/W44f+m/GaUWNlmAhBMbPBYDY//sxtFyXXLQrkmmVkTIcbiRbyrDdv2duSi1fsmJQbQlfvy0vhCBJJiOaRJ78IypVNycMXF3wEyMghsTl8EHl61r9SqHtWWTlo/YYAPNkaN1Xjz30QUu5E1aEQdAMHS3tpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219456; c=relaxed/simple;
	bh=Or5VK38lfVelYWar004Pr2kU8Q1uBbCUlIoXaVcAV28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxeMkpSX25nhsVo6AnO5snMnTeFsJIqX/LQXtdcn7NThHEuLqIkVepKEraXWMn+68yBk1A6QpBqIMQou25XNwa2L6TWzyMf823LPX5J43p/Q+rQZt8bKnk5BMRi/y30LQt7wDAg+mIXhQlEwK0TVtpBFK1l3em0kSROTIFDPV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TkUIbhmC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkUIbhmC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t0rBbmGN0jRYFNsQbJwZuLMhIEAqKZqECY99aCijJ6w=; b=TkUIbhmCIURpPCeryTmHRCbX3j
	t15EmS/3wileyjxHthZsFnd7OB3BkYqFDEjkqBvD4aL7guPNPmMcQb5DCegMIvXRZUiW4NeeV9Rar
	o5rMQVd/59tl/9FyVe9CqR9QwrFn4UR2zauvd46ERZSirLu2xXuB7VxtQhbV46HZM8Oe+0B2oh/et
	78VoMoTOIuHEh+8ofLESOlDZD2ZyRp24cedNFvado4OKa40kVNzMutlbt6zMpjoECQQ5fMuQP0ai2
	LNJ6XzzZ0qczui7NxbJ9ZW0sg15PhdwQmYfokUzrGt7+NhGCsUc8pAUnB6mStNvUhRDrtuyd1t+BT
	4houNKMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wc0gw-000000017wt-1UNt;
	Tue, 23 Jun 2026 12:57:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52ACE30324A; Tue, 23 Jun 2026 14:57:25 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:57:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Windsor <dwindsor@gmail.com>, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated
 CALLs
Message-ID: <20260623125725.GW48970@noisy.programming.kicks-ass.net>
References: <20260622183109.1137245-1-dwindsor@gmail.com>
 <ajqBkKE8TpQL1mIG@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqBkKE8TpQL1mIG@redhat.com>

On Tue, Jun 23, 2026 at 02:52:32PM +0200, Oleg Nesterov wrote:
> On 06/22, David Windsor wrote:
> >
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
> >  		long correction = utask->vaddr - utask->xol_vaddr;
> >  		regs->ip += correction;
> >  	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> > +		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
> > +
> >  		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
> > -		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
> > +		if (emulate_push_stack(regs, retaddr))
> > +			return -ERESTART;
> > +		if (shstk_update_last_frame(retaddr))
> >  			return -ERESTART;
> 
> Well, if shstk_update_last_frame() fails after emulate_push_stack(), we should
> probably return another error, so that the caller handle_singlestep() will kill
> this task?

Makes sense, the other user has a force_sig(SIGSEGV) on failure.
