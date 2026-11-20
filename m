Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133419;
	b=QM5/0S4nWREETpXBjIQAiSvegcHiWHSRcrYseWpodLk7ZWzxMfwIcL7FV1OzaooMNPF2
	 pJTpXSDqC5JNsxksQ4QYM2BCosKhw8qbcPGFCU7h8BaVOHbz4IvpE27Au/B3F8mUO3JI6
	 pFQCQcwc6De/smyzA7So5hoUgtRy+n85A3x5AqQpRZQlo2QYI435cLEEj1UHeZ3jGo8rf
	 iRETAz3AaBxnybuB9D0wQbFS2SLe7U/ECxYV9Ft9M2nyCLVjRY2i+RdAaOF2O49D3iq2U
	 AdHuhFrvzpGSS8czKxosc2qmL63z5F6SYJqlEB0BE8NUfZz54CDtWosBuP0l9p+qgQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rVNmw09ganF9VV84Wfo8FeI3b6WupwzMqcfHQhjoHj4=;
	b=kifrife/7MKIr++a0Q0Pj9tsDRWXcKSCsaOT1as3Vq/SSW0/3Oc8BCH/Wwske48gItDP
	 YWSPR24TN5V+r4lvMxwre4xjrjpMHWK7HkcMzue/cxA6iV9qq5hUeEizHgRQTfkAGma+7
	 tXLCaHdGy5ucNfofE5CpAnhDLU3KMaOCrhzv4QBbnFxg65VNsFApS3jJg0gTQC7STOsUD
	 CWWYBDk9ohbZgbcU7uJVSNGNHzI1pJFa8ch04XY3P2L3FnooIIkZdMQkc2pXOXqfWj7wF
	 mopiNU4NGr+9+CjDEeQNmNCeL5Y/gggiyPOb0yHEnAQnf4PgeIIK1mpG3KbgoldsbuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9cEAP0V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA360A2619;
	Fri, 20 Nov 2026 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9cEAP0V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304641F000CA;
	Fri, 20 Nov 2026 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133419;
	bh=rVNmw09ganF9VV84Wfo8FeI3b6WupwzMqcfHQhjoHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9cEAP0V/aAfsY7vzrUE6dg3LhoUVb0OWdourfC6tW8t4BPfvUO0tR8l4LwQ7lBn1
	 pLjI1rzvgPzdIr99CNk/Qtqb9QKuG2EzdDrBodKBMnV3ItHGhs+U8q2L/2ND21w6gP
	 zj6VN1fxEviOcjKljONQoki+OudzCkJv+D2asnSNa2JUXzCEFC8B44ecxn+B9gbwiC
	 JUhr5aQG5PeaHfEp6xptaLqeWod+kLMLx8up+Y2Ju2JAzZCbmBwPaO2Cc3InnEo2lR
	 bHxW5COg/a1PGGzJdM84CYehPjL3rtbSmYk9ZaA19ECCd2X5SkgWCFPuCEDHfKjSuU
	 ztnlemM3Jl6qw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing/probes: Zero out faulted dereferenced fields
Date: Fri, 20 Nov 2026 09:10:16 +0900
Message-ID: <undine-1795133416148475326-9e1b14a2a209b019@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261119161921.3144f192@gandalf.local.home>
References: <20261119152922.5a66f10e@gandalf.local.home> <sashiko-outbox-224053@kernel.org> <20261119161921.3144f192@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 16:19:21 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 19 Nov 2026 20:50:02 +0000
> sashiko-bot@kernel.org wr
> > 
> > [Severity: Low]
> > Does probe_mem_read() in kernel/trace/trace_uprobe.c need the same
> > memset(dest, 0, size) on error?
> 
> Probably.
> 
> > 
> > kernel/trace/trace_uprobe.c:probe_mem_read() {
> > 	void __user *vaddr = (void __force __user *)src;
> > 
> > 	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
> > }
> > 
> > trace_uprobe.c includes trace_probe_tmpl.h, where
> > process_fetch_insn_bottom() now ignores the return value of
> > probe_mem_read() in stage 2 and relies on it to zero dest on failure.
> > When an unaligned multi-byte read faults across a page boundary,
> > copy_from_user() only zeroes the uncopied trailing bytes, leaving the
> > initial bytes from the first page in val and causing stage 2 to
> > dereference a truncated non-zero address.
> > 
> > > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > > index 8db12f758fdae..8be14c00d66f9 100644
> > > --- a/kernel/trace/trace_probe_tmpl.h
> > > +++ b/kernel/trace/trace_probe_tmpl.h
> > > @@ -127,7 +127,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> > >  			   void *dest, void *base)
> > >  {
> > >  	struct fetch_insn *s3 = NULL;
> > > -	int total = 0, ret = 0, i = 0;
> > > +	int total = 0, ret = 0, i = 0, offset;
> > >  	u32 loc = 0;
> > >  	unsigned long lval, llval = val;
> > >  
> > > @@ -135,25 +135,28 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> > >  	/* 2nd stage: dereference memory if needed */
> > >  	do {
> > >  		lval = val;
> > > +		/* Prevent dereferencing NULL val pointer */
> > > +		offset = val ? code->offset : 0;
> > >  		switch (code->op) {
> > >  		case FETCH_OP_DEREF:
> > > -			ret = probe_mem_read(&val, (void *)val + code->offset,
> > > -					     sizeof(val));
> > > +			/* Do not dereference NULL pointers */
> > > +			if (val)
> > > +				probe_mem_read(&val, (void *)val + offset,
> > > +					       sizeof(val));
> > >  			break;
> > >  		case FETCH_OP_UDEREF:
> > > -			ret = probe_mem_read_user(&val,
> > > -				 (void *)val + code->offset, sizeof(val));
> > > +			/* Do not dereference NULL pointers */
> > > +			if (val)
> > > +				probe_mem_read_user(&val, (void *)val + offset,
> > > +						    sizeof(val));
> > >  			break;
> > >  		case FETCH_OP_CPU_PTR:
> > >  			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
> > > -			ret = 0;
> > >  			break;  
> > 
> > [Severity: Medium]
> > Should FETCH_OP_CPU_PTR also check if (val) before calling
> > this_cpu_ptr()?
> > 
> > Now that stage 2 continues after a failed or NULL dereference, an inner
> > dereference in an expression such as this_cpu_ptr(+8($arg1)) or
> > this_cpu_read(+8($arg1)) can reach FETCH_OP_CPU_PTR with val == 0.
> > On SMP kernels, this_cpu_ptr((void __percpu *)0) evaluates to
> > __my_cpu_offset, so subsequent instructions will record or dereference
> > the current CPU's per-CPU base address + offset instead of zero.
> 
> Yeah, I'll update it to not do the per_cpu assignment if val is zero.

Ah, thanks for updating! That sounds good to me.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
