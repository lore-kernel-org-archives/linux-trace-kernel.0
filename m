Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA53203B4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221138; cv=none; b=ieaf2BllXOiQE7djyzIi1wOx9MaQYv3qtN+6PUVWJsa5pLHETfrefSgv2C8pCUX50GqRt4S8P4WkNBz+83D3P6P4wbBUNeMhRqI1DqA2KCRR9WOfstAwMYBgxG25maldBknGQowP7RDIXaXy/k+qe+5djFxZ4BwNdp0yzmSlP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221138; c=relaxed/simple;
	bh=OKx7ZDYj7SAZpoBy3rn8owt1iUaI62/RmSFsa8I59mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VXbi/ykPKAxTHnbUFnHRidSnW4yjgc3D58RiuGGQFjXSK0oOMwDTirm2T43cltzH6yNNAFbaURXBrmQZbYa8IgmyYsSbc5X/gDXigm4KevNmLvqUBf9ehxveFTVEVB8GAFwVSIAI5+ofmrONqUs8BtA9sqgm6EBUfHEElgHOG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnMGoEuy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnMGoEuy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782221135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjzcbOUH/JYV0AOYsdrx/GdOx3eRULAHiB6tLZrDBX4=;
	b=fnMGoEuychYiHloo+k2kafLpm7FfHKx3K75+mW7SSJRHScQZNH7bIvB3rM7nV6h0CnMg/z
	MnRuC6L51ZlTPdS9VAWGAUsHUVZ24nJkPUkCWUUGF5VHUM+AQZ/MXVG8FUVaYAILMf/3dK
	ck4T0W8Hx8c37rNInv8mapSmXf5qrZs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-dfvzV4kiNZSf5zZLeWTgvA-1; Tue,
 23 Jun 2026 09:25:22 -0400
X-MC-Unique: dfvzV4kiNZSf5zZLeWTgvA-1
X-Mimecast-MFC-AGG-ID: dfvzV4kiNZSf5zZLeWTgvA_1782221117
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B97C1955EAC;
	Tue, 23 Jun 2026 13:25:17 +0000 (UTC)
Received: from fedora (unknown [10.44.49.10])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F2C863653A;
	Tue, 23 Jun 2026 13:25:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jun 2026 15:25:16 +0200 (CEST)
Date: Tue, 23 Jun 2026 15:25:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Windsor <dwindsor@gmail.com>, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated
 CALLs
Message-ID: <ajqJNju6MY3B0S2F@redhat.com>
References: <20260622183109.1137245-1-dwindsor@gmail.com>
 <ajqBkKE8TpQL1mIG@redhat.com>
 <20260623125725.GW48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260623125725.GW48970@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 6CzuLFG4RPGEe_skhOpFKuL0oLuvkPXUJ02HperybBs_1782221117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/23, Peter Zijlstra wrote:
>
> On Tue, Jun 23, 2026 at 02:52:32PM +0200, Oleg Nesterov wrote:
> > On 06/22, David Windsor wrote:
> > >
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
> > >  		long correction = utask->vaddr - utask->xol_vaddr;
> > >  		regs->ip += correction;
> > >  	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> > > +		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
> > > +
> > >  		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
> > > -		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
> > > +		if (emulate_push_stack(regs, retaddr))
> > > +			return -ERESTART;
> > > +		if (shstk_update_last_frame(retaddr))
> > >  			return -ERESTART;
> >
> > Well, if shstk_update_last_frame() fails after emulate_push_stack(), we should
> > probably return another error, so that the caller handle_singlestep() will kill
> > this task?
>
> Makes sense, the other user has a force_sig(SIGSEGV) on failure.

Offtopic question... both shstk_update_last_frame() and shstk_push() are only
used by arch/x86/kernel/uprobes.c. But they are not symmetric in that
shstk_update_last_frame() returns 0 if !features_enabled(ARCH_SHSTK_SHSTK),
while shstk_push() returns -ENOTSUPP in this case.

That is why the users can't just do "if (shstk_push(xxx)) ...". This is really
minor, but perhaps it makes sense to change shstk_push() to return 0 in this
case too? I don't think -ENOTSUPP is actually useful...

Oleg.

