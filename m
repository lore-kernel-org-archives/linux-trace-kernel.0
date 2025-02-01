Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481B74068;
	Sat,  1 Feb 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738451293; cv=none; b=XUSWa+mBNuks+7UD1jK15xlGidnFwwdi/KojatQ+t9OChVep0aB7C+H/hdhrwexrxLalormJOjuwCdn8gz4tDetcuf4gDzmG/UGH1v5NvlwBEPGQoHoAS1CydRzgNZ6bwHG4R/8apNcUVArM3rA1Fk6GwfC2rUJ2aW0gTkuy/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738451293; c=relaxed/simple;
	bh=K1t7R0gOuW//7zECubiJAkbFzLVpWhiU4LTqxBe/9xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xqtm+Olbf/uQD6B3T2Ee2GlCj0sWdFCpB6crFVzQMFbSZJA5zvrCw+K/SYNmDHnhZjjo3gSOn1jq1Bib4WvmpDvEYJ5RFYqQpj4Qk8ihKJA4PLV6hoO+alSjae96/KKmvc3cB+ypT4VOwrgsueYTIVPkqcL7tCmH505x2Chs1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9345C4CED3;
	Sat,  1 Feb 2025 23:08:09 +0000 (UTC)
Date: Sat, 1 Feb 2025 18:08:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ankur
 Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Clark Williams <clark.williams@gmail.com>,
 bigeasy@linutronix.de, daniel.wagner@suse.com, joseph.salisbury@oracle.com,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250201180810.1faf4906@batman.local.home>
In-Reply-To: <e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 15:35:13 +0100
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-01-31 23:58, Steven Rostedt wrote:
> 
> [...]
> 
> > @@ -148,6 +160,18 @@ struct rseq {
> >   	 */
> >   	__u32 mm_cid;
> >   
> > +	/*
> > +	 * The cr_counter is a way for user space to inform the kernel that
> > +	 * it is in a critical section. If bits 1-31 are set, then the
> > +	 * kernel may grant the thread a bit more time (but there is no
> > +	 * guarantee of how much time or if it is granted at all). If the
> > +	 * kernel does grant the thread extra time, it will set bit 0 to
> > +	 * inform user space that it has granted the thread more time and that
> > +	 * user space should call yield() as soon as it leaves its critical  
> 
> Does it specifically need to be yield(), or can it be just "entering
> the kernel" through any system call or trap ?

No it doesn't need to be yield. That just seemed like the obvious
system call to use. But any system call would force a schedule. We
could just optimize yield() though.

> 
> [...]
> 
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index 9de6e35fe679..b792e36a3550 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -339,6 +339,36 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >   	force_sigsegv(sig);
> >   }
> >   
> > +bool rseq_delay_resched(void)
> > +{
> > +	struct task_struct *t = current;
> > +	u32 flags;
> > +
> > +	if (!t->rseq)
> > +		return false;
> > +
> > +	/* Make sure the cr_counter exists */
> > +	if (current->rseq_len <= offsetof(struct rseq, cr_counter))
> > +		return false;  
> 
> It would be clearer/more precise with < offsetofend(struct rseq, cr_counter)

Ah yeah, thanks!

-- Steve

