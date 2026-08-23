Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91402286D4D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515754; cv=none; b=tPkwbKbG6YvEKgvA/ty6Px8zEojwIEgklIUN0hehkg4SPK8Wy1DzDhPmGFJ96b2dkKXzS14dZk1DFxfhBFYhYApKMsu1z2eZ/vnPbZWCG6jzZ2Aq8eQ5w3Le9CbX/0f6ksA+KGBriMYnId0iTSe1CufZuta09gz1OTjcx0tllTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515754; c=relaxed/simple;
	bh=5JJguNi60BYfFeAY3XZIzmSM/Fm13LC2qSz3Q/xD02k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF4zFDLsDoFc7Yl1BpL90rLDQ9n2vr9CL382eH+7LZqhOSOc8AfpL2ixE7/df21hWpPf4ZV8SHmBsoOL/SdG0/TGWthTEcGnezA4GhqgigiXggQI1piMolacsfe/5aRBGUU4t1vMIuFuCjVSx6csmriCJIrKpgyP5VRqlC1jmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3e93RRh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3e93RRh"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1335988f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787515751; x=1788120551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DQ1pHRJnyAKgX9nD7lusA/x7XVWjax+ECExfQRR5q+0=;
        b=O3e93RRhm85uwp58XxbNo8T3RfLmwhBjWCJ+hGj4QhfkHEjg3uCf/5ZjMB0IQRU1tn
         KU8VE7tdkaLi7Zktoi9fp9PCwiKTAAC0GVdPvv6DPbGQgJ92O92agSRh2a+iu5s2RPuL
         G3fogy8QBve8JF71xsX5dww+UP5vcC3P+J44upXYDBjqNEXNeoGVyTpU2p0hWCpsw7me
         /dktZbtVx+nytxOTt5rVBE8rYrY5F/E/N4Qweiprh1r3bK/gMnvJXj+1EgTOiz/OcSVd
         hiNUMjRna8e/yh1O6ym25II/YhDgng0DNjo2o3WUYR8Vquoez8wxZtFiCxIkzmD2yqDI
         0R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515751; x=1788120551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQ1pHRJnyAKgX9nD7lusA/x7XVWjax+ECExfQRR5q+0=;
        b=CksniH2IA8f0YfuxV1+6VW8W41C0VdKv1QKpOnPxdQhxhQRqnB7RnDtMKQKHjdlWiH
         xQPBtKjdD2SGWjGEWFY0Nvag03KixFhe07G4BvsIPacEdVUNUo9xY63G4q+FPnlqx0kl
         sTLVcG26zrXRCMJ7Qn2ggi9Q6JJfsFfWapa1HdA29C3gfu9/5mlOiWvLW+nYVKPSLhd4
         nPplTw664HfpGHemVRwhOiYJl2S6MX1IgXYHzWQNDCpCN6rSDKJSf+ctv204ysA/UIR7
         sfCOrlbIJjPdVGLzGJTJiS4ZbSP9mdU//GDSDtFl08tF0LDdTLzpuMLf5gr+dy6VcOF4
         jYoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDpH4q0rCXVMpVn9RTSQebYQaXpszhSMjx5XRyrvGs5qz6PWsX9OiXetexCvMWZx+bQAJhClk4296CwtTe/y0ICaU=@vger.kernel.org
X-Gm-Message-State: AFuF++mUNBsuDWCPmYAr9o3H0l7g1oWpLW4x3nhIfWbRC7BveTXYRnj7
	WF4eaMmWmoYONgSbSUkNhh8C1k1D7NtGvBs19y/v45t9sqfDN6+cK5FYUbRBGIDJ7Q==
X-Gm-Gg: AR+sD13PiHNZfKD9vE0CjW7QWDKvi1btbNpF+R+SY4q/FIKBkVD+huijJsi0Cg6gaOU
	kH3WHHB+IxYnd6pe8UTJeHGUvUXApQWJtAyaTacJknWfHvVIKor4hrXdJICx5kyQFmcDFYm3xwD
	TdR0AZbi9LJ/wV8ZYAs1z5rgJBQ8KgAKtBr+vuiNSctEpCLtkhzyuNTlGW8T4GZQ5iNO/XxwBAY
	OUgPTKjEkgO9j2sRkzFpCbD4nYSFtNDHyZi9QzJQcBeIeDJeEtPeTxMCLwOpBPHf2WpdV3fBDh2
	pzzLXv9rRSW3aisrpXCW0q68rEk2fB1QP8xFEDhC6E/fW2vB1UFnt9DZoN6txzOJKO4xfhdZlwY
	PDbJAiOwQMYNIrmg9y68VzqHNQ61aSNaBGCMICjGddZ+Hp50eNbMu1t/hvZB9eHOODA8U20U7zD
	U2BICNvF2m8w9V0I2KNyJ1IX33rMIubLfcz75rCL4B5g93ky7L8rE55wU0Ynv0b7PmabzivGRV1
	BfgZ5+fSYBqCLSCcuNh3zwxyRJ0h5VM
X-Received: by 2002:a05:6000:310f:b0:47f:f4b9:88b7 with SMTP id ffacd0b85a97d-482c0b58818mr25873682f8f.1.1787515750301;
        Sun, 23 Aug 2026 13:09:10 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfc383sm5796131f8f.23.2026.08.23.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 13:09:08 -0700 (PDT)
Date: Sun, 23 Aug 2026 21:09:05 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <aotTYT0zE5LNik06@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-2-vdonnefort@google.com>
 <20260817140812.2C7D41F00A3A@smtp.kernel.org>
 <20260822110424.346fa3c8@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822110424.346fa3c8@fedora>

On Sat, Aug 22, 2026 at 11:04:24AM -0400, Steven Rostedt wrote:
> On Mon, 17 Aug 2026 14:08:11 +0000
> sashiko-bot@kernel.org wrote:
> 
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index 395238b2b715c..737922b236d46 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c  
> > [ ... ]
> > > @@ -7128,7 +7116,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> > >  				    iter->cpu_file, 0);
> > >  	trace_access_unlock(iter->cpu_file);
> > >  
> > > -	if (ret < 0) {
> > > +	if (ret == -EAGAIN) {
> > > +		goto again;
> > > +	} else if (ret < 0) {  
> > 
> > [Severity: High]
> > If ring_buffer_read_page() returns -EAGAIN because the subbuffer order was
> > updated but cpu_buffer->reader_page->order hasn't been updated yet, this
> > branches back to the again label.
> > 
> > Since the loop does not yield the CPU or call cond_resched(), could this cause
> > a hard lockup if the reader and the resize thread are on the same CPU?
> 
> Hmm, this looks legit. We should at least have a way to break out if it
> loops too many times.

Can this happen only on !CONFIG_PREEMPT systems?

I can add a cond_resched() here though, I believe that would make sense: if an
order modification is pending, writing is disabled anyway and we are about to
loose the stored events.

Additionally I can reduce the window where buffer::subbuf_order differs from the
reader page order by adding an "order" argument to __rb_allocate_pages() and
only set buffer::subbuf_order later in ring_buffer_subbuf_order_set().

WDYS?

-- 
Vincent

> 
> > 
> > >  		if (trace_empty(iter) && !iter->closed) {
> > >  			if (update_last_data_if_empty(iter->tr))
> > >  				return 0;  
> > [ ... ]
> 
> > > -		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
> > > -		if (IS_ERR(ref->page)) {
> > > -			ret = PTR_ERR(ref->page);
> > > -			ref->page = NULL;
> > > +
> > > +new_read_page:
> > > +		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
> > > +		if (ret) {
> > >  			kfree(ref);
> > >  			break;
> > >  		}
> > >  		ref->cpu = iter->cpu_file;
> > >  
> > > -		r = ring_buffer_read_page(ref->buffer, ref->page,
> > > -					  len, iter->cpu_file, 1);
> > > +		page_size = ring_buffer_read_page_size(ref->rpage);
> > > +
> > > +		r = -EINVAL;
> > > +		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
> > > +			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
> > > +			if (r == -EAGAIN)
> > > +				goto new_read_page;  
> > 
> > [Severity: High]
> > Similar to the read path above, this catches -EAGAIN and loops back to
> > new_read_page.
> > 
> > Because goto new_read_page executes continuously without releasing
> > trace_access_lock() or yielding the CPU, can this permanently deadlock the
> > system during a resize by preventing the resize thread from acquiring the
> > necessary locks?
> 
> This also looks legit.
> 
> -- Steve
> 
> > 
> > > +		} else if (!i) {
> > > +			/*
> > > +			 * If the first iteration fails this is an invalid userspace input.
> > > +			 * Otherwise, this is because the subbuf order has been modified. Do not
> > > +			 * report an error and finish the read.
> > > +			 */
> > > +			ret = -EINVAL;
> > > +		}  
> > 
> 
