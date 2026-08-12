Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B547F77F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554920; cv=none; b=q0ETLPraAvekm5MVYceLGwpaHMsYRAf3E4NbUdmNzUL555+79mBK/LbHJXWFC9LMpwVKO4SlHknJjqcxI0QKXOAsoVuFcrFtpFSZx54f5WOKJFUDmfwR0Ep0tNOfJ0LQH5H3ewJV75xOT5hsUR23APr5Y54ruehcaLkFJ9UX9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554920; c=relaxed/simple;
	bh=2I7/RT+0aSe0m2OkCvjXvgILtrPojrAcU8m8Y6nvhvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/25X7wsZAaq5OhhTAyyT3gUAUjmfsyDaJM1jOP52Irp3dFuiXAISW80s+keGZBg/dh0K4WbgI/+33ZzMJpaQhl8HZkp3a8FJPq+PU3WqpgVOTsvjZcvbT40gq3Wn+o29mDi4zFCMKh966stlkOOBfcxzjgtW1QD9LATnOmzthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLoprpSc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLoprpSc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49802c418b5so11572355e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786554916; x=1787159716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjqqgSClxaAJzslKdXPIOBgkFcej7/XVCPbk7KbHCKA=;
        b=gLoprpScyC6+sHmTBVekaiIJ3bFR9uNXRDsVqqGSNsY3S51HuJX+ph8AvrnGTB4XMw
         UoCxkNXSL1EOoYeF0ppHsm1snL3MDwerfZ7NMGq/W5w76SQho7WmXIFMau4o40acOxAD
         Rwhcpe0q0u8ooORHxERGOYSwPE2wtBu/pJ45xW+MMr7RnzRQo7XlU2A8uCcCu0z3XV5p
         Y+xC2U571RnNThWRRUReFFRh9fn6fXlYz7fn1ZJnpxB8LWFGTUc05NxNBAEW06f+KOdl
         fQdXO4WTP4W8Cvg7VV3YNHPrudvCSpo17U7DUIvQ0yUUL90NdfXZRDH2aeAW1jXnD8Or
         +HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786554916; x=1787159716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tjqqgSClxaAJzslKdXPIOBgkFcej7/XVCPbk7KbHCKA=;
        b=a5gzYOTEc+AjRKu3/Y8Or4tRWA+ETpw5mNtCvXK6V9dKIktdGQhCCKcEzq0Oryonag
         ntMP01xSVB3uDYXVcfTB8LJAxzHLTXGKyRX8BPg54l51830ef96q2TxegiyVjb7qkz+E
         vN6xTl5lQvO8eK/qVFCIkvyUDITfNVQVhi6zc4PJbGXrTcSDUgY4hY64nHy9BIxPBPGx
         KcplO7rbdp87z/wUHX3w5C2ihIOpemovzYDJR3i1sr0BB8OBeIOu853K4Q7JKP3EH+YB
         jRvB79k0MexM1PN/6CZuy3LASSIQ49zZ6hUNmOMxjJpc0btKB5zj8A1Q2zpLaNc95ifr
         dbnw==
X-Gm-Message-State: AOJu0Yy5qF38A+Ex6sSKrKkXrir9I/byn+nWu6IYE4MN/DtU9us91F42
	w2OS1JsJdZJ/TyBijqMBrvT74ZCZkd3ZZzBqWw6SaRguDzzMaO5kNQkVICVsxylODA==
X-Gm-Gg: AR+sD10bQcAa1c7rofB4/b43WSeJr49g+fd9aa0jyOUPjucEZh3d0lKyG+ya5k8JArZ
	Da8XdumVPXCZuj/G15JavCwEQ8t7Tn06y57wK1Py98wTziIN+2P6IvwbPWRo3G0sGT4KUbXjlDj
	vg4U0OHMZQwHUEAnK4RJpeRGiEycRhJ2e5JZ2GRhL4P9ReRUAGPnNzJ1U0OTb5iQxvD95TpSUox
	hepSAcFuufLMikBu+bUtTZErutesgOEgGF861UYcYhLp7fK9vXnhXzuCMc528EKtIFZWb925dCU
	T8xmAuOR0ScdmDxAatnhV2dLFLjwb4Wt3O0WCcVeJj0Tz9j8Jj+f4/J6lTrmDe5ClmIcflzNjXF
	V5OB28WEihtF7LJHlFY+YGYHma4bESBxmbVJ1zbxmR9S9tWcwnXl1o+okduQsvmd0cOa3kx/fbu
	WxyBJVn0ILLY/zk61c4KSsDj+ULGyHalKP9AwtQyrxa+I4PP0YzAi2wScVPYmolBYmcgYruN75g
	/wP9ZtUL2FrD11ghoCSAGCjLw8MxHL+
X-Received: by 2002:a05:600c:16ca:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4997c0f207emr63429955e9.5.1786554915703;
        Wed, 12 Aug 2026 10:15:15 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981d9dfe1sm70595e9.0.2026.08.12.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:15:14 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:15:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] ring-buffer: Make nr_pages unsigned int
Message-ID: <anyqHwaEwIxapzTV@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-10-vdonnefort@google.com>
 <20260812154712.1B1751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812154712.1B1751F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:47:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Integer truncation of `nr_pages_to_update` allows a massive buffer resize to bypass memory allocation checks, directly triggering an out-of-bounds page removal loop causing a critical kernel Use-After-Free (UAF).
> - [High] Multiplication overflow in `subbuf_size * nr_pages` evaluates as an `unsigned int` when allocating huge persistent ring buffers, destroying trace data isolation.
> --
> 
> --- Patch [9]: [PATCH v4 9/9] ring-buffer: Make nr_pages unsigned int ---
> commit cb1365ebdbbed7daa3a685ae1d6be7a4167052dd
> Author: Vincent Donnefort <vdonnefort@google.com>
> Date:   Wed Aug 12 15:33:10 2026 +0000
> 
>     ring-buffer: Make nr_pages unsigned int
>     
>     nr_pages is an int or unsigned int almost everywhere already. Also, all
>     the meta-data ring_buffer_desc, ring_buffer_cpu_meta and
>     trace_buffer_meta allowing to share information about the ring buffer
>     are already capping this value to 32-bits.
>     
>     Make ring_buffer_per_cpu::nr_pages unsigned and align all the users to
>     it. As a side effect, this makes ring_buffer_per_cpu slightly smaller.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 990a904cefe85..2fccb950e593c 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> [ ... ]
> > @@ -561,7 +561,7 @@ struct ring_buffer_per_cpu {
> >  	struct ring_buffer_remote	*remote;
> >  
> >  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
> > -	long				nr_pages_to_update;
> > +	int				nr_pages_to_update;
> >  	struct list_head		new_pages; /* new pages to add */
> >  	struct work_struct		update_pages_work;
> >  	struct completion		update_done;
> 
> [Severity: Critical]
> Could this type change lead to an out-of-bounds page removal regression?
> 
> In ring_buffer_resize(), size is an unsigned long and can be quite large,
> resulting in an unsigned int nr_pages near the maximum 32-bit value. When
> calculating nr_pages_to_update:
> 
> ring_buffer_resize() {
>     ...
>     cpu_buffer->nr_pages_to_update = nr_pages - cpu_buffer->nr_pages;
>     if (cpu_buffer->nr_pages_to_update <= 0)
>         continue;
>     ...
> }
> 
> If nr_pages is very large (e.g. 4294967286), subtracting the current nr_pages
> (e.g. 10) results in an unsigned value that wraps into a small negative number
> when stored in the 32-bit int nr_pages_to_update (e.g. -20).
> 
> This would bypass the allocation checks and trigger rb_remove_pages() to
> remove more pages than exist in the buffer, causing it to loop past the end
> of the list and free pages that are still in use.

That would mean 15 TiB for a single CPU right?

> 
> [ ... ]
> > @@ -2773,7 +2773,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  					 struct ring_buffer_remote *remote)
> >  {
> >  	struct trace_buffer *buffer __free(kfree) = NULL;
> > -	long nr_pages;
> > +	unsigned int nr_pages;
> >  	int subbuf_size;
> >  	int bsize;
> >  	int cpu;
> 
> [Severity: High]
> Will this type change cause a multiplication overflow when allocating large
> persistent ring buffers?
> 
> Later in alloc_buffer(), the pointer is advanced for the next CPU's buffer:
> 
> alloc_buffer() {
>     ...
>     ptr += subbuf_size * nr_pages;
>     ...
> }
> 
> Because subbuf_size is an int and nr_pages is now an unsigned int, the
> multiplication is evaluated as a 32-bit unsigned integer. 
> 
> If the buffer is larger than 4GB per CPU, this will overflow before being
> added to ptr, placing the next CPU's buffer inside the previous CPU's buffer.
> 
> Previously, when nr_pages was a long, this math was safely performed as 64-bit
> on 64-bit systems.

This one is worth improving though!

-- 
Vincent

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=9
