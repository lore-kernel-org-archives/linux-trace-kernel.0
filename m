Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123167;
	b=mcVaSjLzA5Wi/LxLkDBtCBzHY9FegdAyns/TvRPXrNXFGmflh5sjBSmdaiQgp3PvCIKZ
	 DvMotYFbPCvd6vws8FJjXNSCcNRWTZgiiMxV8zYbtdu9UqPzE3/rMWv/ZR9edN6aCPcw7
	 d0XZg79AbglOEgkLnIk+PYyFjnkppk7NpQiHyc428Ufm+Xwj65+ikrKQuGg0mLrUIyX2w
	 TLgJUoeteN0MKYnunYzhZ5SKaTxn0vVIOoOcsHp8WMQq7uCb0itqaFIImyH+JNc5hs3bV
	 IZzsioquR3eywcE51ChZtomtYCtK65CvjKAERdFNIjpEXDolRyxKQLXvgWXWAjk8uKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123167;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=+GfcX/51FQNi3OHNcutqjorwp/kJGpMlGqqwUsSksr4=;
	b=RRMfzhfifwqnnl+zF3jpqIH17q2Wsr1EBVJXSmzQeRYlUKxfvV0Pr95VxWZxLthmZfad
	 FbaeNRYvSMmlS4K0igGZiWT5ESmRtEwWRKPXIc1e5w8mOEJt0ts+W2zivHwzAdxka+u4K
	 fqrJ1yyTpsx0Wn5smXZKjbzbL7KuGaVkUftXtEFxIvTDkBovJmr8ic+S0JRy7kPqXs0fb
	 Z+9ouDkmIc/eDA0jqJJYpnwDT/f5YLqBdCYJqTFEvjGm+7hIp2cdiDrf2jQHNdtT8M1Xz
	 /giOz+rbgqiGbqwA4gOIHO0WOZBAw+vwKKWfA/Rddw/9JVh28LxJn7wIGARbnL/f4pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RM7bNelB;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E468606A325
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 21:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E468606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RM7bNelB
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8C6AFA8B53;
	Thu, 19 Nov 2026 21:19:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id EC59320013;
	Thu, 19 Nov 2026 21:19:22 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:19:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261119161921.3144f192@gandalf.local.home>
In-Reply-To: <sashiko-outbox-224053@kernel.org>
References: <20261119152922.5a66f10e@gandalf.local.home>
	<sashiko-outbox-224053@kernel.org>
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
X-Stat-Signature: yc6ctdpfiaire3n5uxdxurz9zxx4harm
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EC59320013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18zElW6PMw9icqXH+q3oGJRH8Ddv2oX1fk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=+GfcX/51FQNi3OHNcutqjorwp/kJGpMlGqqwUsSksr4=; b=RM7bNelBzxAIE0Of9k0E8heeIXibpK9eU3iA/Rltydxz2R6M29/PLQE75vUXcqx/ie0ujbpPvkuRB6wR6PPaCHj3k5Rte82okiFcpyqQwDFsOUmjgdKL81oeWbrSDVLYzsOxtd+crQGxE3FmVS9pgwovlwB1KBqNXhNBVEdceMY=
X-HE-Tag: 1795123162-702939
X-HE-Meta: U2FsdGVkX1/qPaNiqmcD6sqrRo5Xd8qHEuYD8FI3JQecGs20BqZjUX2LLsqhJvvw4pwa8k0wXK+N6sOIIv9VqkSwg89i2hLlpsuvPhqL54zLBmfaj1Q3k/FnTN9RThVpkwUaG4vBPpDo5aDb/CKx6xRNvbP71TtoHoLiCNX6DqHQDBL3vwaU71/fbETm9VcbHhWASfWKduEjFgir2l+j8PbeMRYvC60sxLoRCEfMyRoZC5lJ/ylrWBB7Q1770HrhwPQd6vJn6/dma7h+zRhrh2tyKhXkI4nOEwx9S3//QAe5D57ZKWbRLyynRfsX/O7g30gkXiZlEJQqub2mjiLbXkIXAaWLRrzL

On Thu, 19 Nov 2026 20:50:02 +0000
sashiko-bot@kernel.org wr
> 
> [Severity: Low]
> Does probe_mem_read() in kernel/trace/trace_uprobe.c need the same
> memset(dest, 0, size) on error?

Probably.

> 
> kernel/trace/trace_uprobe.c:probe_mem_read() {
> 	void __user *vaddr = (void __force __user *)src;
> 
> 	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
> }
> 
> trace_uprobe.c includes trace_probe_tmpl.h, where
> process_fetch_insn_bottom() now ignores the return value of
> probe_mem_read() in stage 2 and relies on it to zero dest on failure.
> When an unaligned multi-byte read faults across a page boundary,
> copy_from_user() only zeroes the uncopied trailing bytes, leaving the
> initial bytes from the first page in val and causing stage 2 to
> dereference a truncated non-zero address.
> 
> > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > index 8db12f758fdae..8be14c00d66f9 100644
> > --- a/kernel/trace/trace_probe_tmpl.h
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -127,7 +127,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  			   void *dest, void *base)
> >  {
> >  	struct fetch_insn *s3 = NULL;
> > -	int total = 0, ret = 0, i = 0;
> > +	int total = 0, ret = 0, i = 0, offset;
> >  	u32 loc = 0;
> >  	unsigned long lval, llval = val;
> >  
> > @@ -135,25 +135,28 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  	/* 2nd stage: dereference memory if needed */
> >  	do {
> >  		lval = val;
> > +		/* Prevent dereferencing NULL val pointer */
> > +		offset = val ? code->offset : 0;
> >  		switch (code->op) {
> >  		case FETCH_OP_DEREF:
> > -			ret = probe_mem_read(&val, (void *)val + code->offset,
> > -					     sizeof(val));
> > +			/* Do not dereference NULL pointers */
> > +			if (val)
> > +				probe_mem_read(&val, (void *)val + offset,
> > +					       sizeof(val));
> >  			break;
> >  		case FETCH_OP_UDEREF:
> > -			ret = probe_mem_read_user(&val,
> > -				 (void *)val + code->offset, sizeof(val));
> > +			/* Do not dereference NULL pointers */
> > +			if (val)
> > +				probe_mem_read_user(&val, (void *)val + offset,
> > +						    sizeof(val));
> >  			break;
> >  		case FETCH_OP_CPU_PTR:
> >  			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
> > -			ret = 0;
> >  			break;  
> 
> [Severity: Medium]
> Should FETCH_OP_CPU_PTR also check if (val) before calling
> this_cpu_ptr()?
> 
> Now that stage 2 continues after a failed or NULL dereference, an inner
> dereference in an expression such as this_cpu_ptr(+8($arg1)) or
> this_cpu_read(+8($arg1)) can reach FETCH_OP_CPU_PTR with val == 0.
> On SMP kernels, this_cpu_ptr((void __percpu *)0) evaluates to
> __my_cpu_offset, so subsequent instructions will record or dereference
> the current CPU's per-CPU base address + offset instead of zero.

Yeah, I'll update it to not do the per_cpu assignment if val is zero.

> 
> >  		default:
> >  			lval = llval;
> >  			goto out;
> >  		}
> > -		if (ret)
> > -			return ret;
> >  		llval = lval;
> >  		code++;
> >  	} while (1);
> > @@ -161,19 +164,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  
> >  	s3 = code;
> >  stage3:
> > +	/* Prevent dereferencing NULL val pointer */
> > +	offset = val ? code->offset : 0;
> > +
> >  	/* 3rd stage: store value to buffer */
> >  	if (unlikely(!dest)) {
> >  		switch (code->op) {
> >  		case FETCH_OP_ST_STRING:
> > -			ret = fetch_store_strlen(val + code->offset);
> > +			ret = fetch_store_strlen(val + offset);
> >  			code++;
> >  			goto array;
> >  		case FETCH_OP_ST_USTRING:
> > -			ret = fetch_store_strlen_user(val + code->offset);
> > +			ret = fetch_store_strlen_user(val + offset);
> >  			code++;
> >  			goto array;
> >  		case FETCH_OP_ST_SYMSTR:
> > -			ret = fetch_store_symstrlen(val + code->offset);
> > +			ret = fetch_store_symstrlen(val + offset);
> >  			code++;
> >  			goto array;
> >  		default:
> > @@ -181,27 +187,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  		}
> >  	}
> >  
> > +	/* Prevent dereferencing NULL val pointer */
> > +	offset = val ? code->offset : 0;
> > +
> >  	switch (code->op) {
> >  	case FETCH_OP_ST_RAW:
> >  		fetch_store_raw(val, code, dest);
> >  		break;
> >  	case FETCH_OP_ST_MEM:
> > -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> > +		probe_mem_read(dest, (void *)val + offset, code->size);
> >  		break;
> >  	case FETCH_OP_ST_UMEM:
> > -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> > +		probe_mem_read_user(dest, (void *)val + offset, code->size);
> >  		break;
> >  	case FETCH_OP_ST_STRING:
> >  		loc = *(u32 *)dest;
> > -		ret = fetch_store_string(val + code->offset, dest, base);
> > +		ret = fetch_store_string(val + offset, dest, base);
> >  		break;
> >  	case FETCH_OP_ST_USTRING:
> >  		loc = *(u32 *)dest;
> > -		ret = fetch_store_string_user(val + code->offset, dest, base);
> > +		ret = fetch_store_string_user(val + offset, dest, base);
> >  		break;
> >  	case FETCH_OP_ST_SYMSTR:
> >  		loc = *(u32 *)dest;
> > -		ret = fetch_store_symstring(val + offset, dest, base);
> > +		ret = fetch_store_symstring(val + offset, dest, base);
> >  		break;
> >  	default:
> >  		return -EILSEQ;  
> 
> [Severity: Medium]
> Does setting offset to 0 in stage 3 still dereference address 0 when val
> is NULL?
> 
> finalize_fetch_insn() converts the final FETCH_OP_DEREF or
> FETCH_OP_UDEREF of a dereference chain (such as ->pgd in prev->mm->pgd)
> into FETCH_OP_ST_MEM, FETCH_OP_ST_UMEM, FETCH_OP_ST_STRING or
> FETCH_OP_ST_USTRING in stage 3.  When val is 0, val + offset is 0, and
> stage 3 still calls probe_mem_read(), fetch_store_strlen(),
> fetch_store_string() and their user counterparts with address 0.
> 
> On CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE architectures, 0 <
> TASK_SIZE is true, so probe_mem_read(), fetch_store_strlen() and
> fetch_store_string() redirect the NULL kernel pointer read to current's
> user virtual address 0, faulting on every NULL pointer or reading user
> page 0 if mapped.  On s390, where address 0 is mapped to struct lowcore,
> copy_from_kernel_nofault() succeeds and copies lowcore bytes into the
> trace buffer instead of zeroing dest.

Yep, works as designed!

> 
> [Severity: Medium]
> What happens in the FETCH_OP_LP_ARRAY loop below stage 3 when val or
> lval is 0?
> 
> kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
>     ...
> 	if (code->op == FETCH_OP_LP_ARRAY) {
> 		if (ret < 0)
> 			ret = 0;
> 		total += ret;
> 		if (++i < code->param) {
> 			code = s3;
> 			if (s3->op != FETCH_OP_ST_STRING &&
> 			    s3->op != FETCH_OP_ST_USTRING) {
> 				dest += s3->size;
> 				val += s3->size;
> 				goto stage3;
> 			}
> 			code--;
> 			val = lval + sizeof(char *);
>     ...
> }
> 
> Because stage 2 no longer returns early on a dereference fault, a NULL or
> faulted array base pointer now enters the FETCH_OP_LP_ARRAY loop with
> val == 0 (or lval == 0).  On the next iteration, val += s3->size or
> val = lval + sizeof(char *) turns 0 into a non-zero value (such as 8), so
> val ? code->offset : 0 and if (val) treat it as a valid pointer and
> dereference i * elem_size + code->offset for the remaining array
> elements.

Ah, I probably should have it short circuit here too on val == 0.

-- Steve

