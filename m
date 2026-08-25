Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8D3DE427
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646375; cv=none; b=rUCqqaSxYrlKYGJVIv1/k8ZY7Sa1d9oQ4aPfS/g/qg5A+OAGKsxHU7gcRsauZcrtCDRJ1sS0YeucaiTzCOE8pEn+rCHJv1nTJRPECRsU8M3/dkbQxtlLpa1pWREyJdpUOU2thmyoYcFncVvGOFr+qoxvalvYb1g7n81adat9ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646375; c=relaxed/simple;
	bh=P8dDe9WGJaB5/v6G6RAFPTJUDTZnGgg0DTzE8KtbvoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6MACdaEZAwjCcMv/hX3B8RwghfNfk2jbMKLRVokh73VD5fFGxSVpqhwzCcm7Ws+nX361SyEFc/lWuxrM2IxBdHj/havbpZa336SJ1ca7mIORITVQfvTbfxIQmsQEcZTpyhd0SamjpBXhLb6dz4FO9iZdVkQuj/CUcZBY4+eJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRtMhUh5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRtMhUh5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so40228095e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787646372; x=1788251172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LX5TxyIQ51uP9mPCb4WWu473qdFXpXWJJ9AlVry9ycg=;
        b=vRtMhUh5kHN3hAQE+vTat/GApD9b8FSZAhm/b/1/WqjneBJjZKd9lERkmQp98OIhoL
         X5iFTous0PDppt/INnSeruIChqgBUPOUYJEqYlgD0X6fQ8LDTWXPTyB9xCVPQtgiEk27
         /FOaa34phGeZhLNgoLfBe4bKFOpMvc6fdwLOU/ub7vt7Kk28Jbe1zSXSfWen9NgNrK+e
         xoK6BqZCivrHsLWlBBfn5S3h0FuGvHK+eCloQPBCr+6MU97QNfVaefDaq/fQ5xgt2otj
         ikj+1y1cZohiu2ko0Zgk2tVlvPz1ntMBaB9TkFq402icnE94ClqHZewQLiEyIabQpIzJ
         InyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646372; x=1788251172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LX5TxyIQ51uP9mPCb4WWu473qdFXpXWJJ9AlVry9ycg=;
        b=PryBS7UzDEs08JmYSlD4NF9oKiY9vVLBliQD6LbSFv/d8DVoLRdLHmxztkFu1oSZt6
         t519jlnfZxPBiaLCkOe1hmzS3WTs7sgB+KRg1ctMJQw70WCrcH7lwv8wlYOs8lS1YpjE
         7T4H34Y7l5saUq9DtWKwBpN/SoVDugbGbcPjlyLGEFjgozwggBH5SQV5pNOaKjOYwOwj
         ANPpMF/EN85kLAhO5DHg3Y/Jlxck+l3BiFGv0p1ttjOp4FB/UkOH6mAHbH0aXup8v6bk
         XYjB4zj4keAg+9kDz75+3zMcQtvf5EpFS+Cy0uF6izYTBkMbH34a65qY5LTxkQLo1tnu
         kMSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1UO6+v7HmM66A3UTk/WQneZ5akVL9VKuy/J2kgRSy0Q0YJJQxcea8rn297o/93QZHR0RnthYot42X118ISh0Jsgo=@vger.kernel.org
X-Gm-Message-State: AFuF++lE6m4itEWuzPrFT6Y4VpR4iY4xQNYe7toDAMuYpBYH7X41MinC
	RjCmlTwLM3t+ghMByFGjCysVvx47/p5PGot9w7fEL3BpVqAY1Y/eaq7Pfme1dcE5VQ==
X-Gm-Gg: AR+sD12nGtInIUCapspnaNfGxHaEOEZvCdWMJq6XN+JBKdYgGAR67cnsea6UvX5E7dF
	GiE4yI+Eo2kbOEDb4+6XyZ5xemXLjV5p/aAlHbZj5L048yjj+T2cLYLC5+EbQoxuLb/GtwigQgn
	FJd1qS/ubyFWWup+giDWa+Lmd6TyijBHgmxWy5v0tuT5b8P8v2G9Af5W1SJT6BvattdpjR01CiL
	/cOQrpzRIhh8F1jKu8uXD7buH27nRT5IGUw7dhXnTeNiUDwXI7xtCIJoP02u1gEiTwAYLOWpGnD
	toe0gEw8kiKh47LksXN6cfAGl8lJpuCLk1scXyG+7s8cqk+h9voq81rfDjOoizyVCL6h5EPGSHE
	pqNNovROJ9QBhNskau1tKl+fz7LYJ7Zmrtr/b3VvRzV8HLFON1ee91eA6/Xd+fBfN+NqCO66dud
	KjGx7QH92qQbC7C6GIEJgCTl5eCS64gm0NEyYH/T+Waj6uJl6ezizZxEBVQnp5agEYKuLYAvDz6
	0mAdPH6G2BKhk7iLcJ/IoUyA9W/kvBffXjY+g==
X-Received: by 2002:a05:600c:3b9f:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-499d652362amr52626925e9.12.1787646371723;
        Tue, 25 Aug 2026 01:26:11 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d633506bsm21294465e9.3.2026.08.25.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:26:11 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:26:07 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <ao1Rn8ZKr5XafWRZ@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-2-vdonnefort@google.com>
 <20260817140812.2C7D41F00A3A@smtp.kernel.org>
 <20260822110424.346fa3c8@fedora>
 <aotTYT0zE5LNik06@google.com>
 <20260824105315.27377f30@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824105315.27377f30@gandalf.local.home>

On Mon, Aug 24, 2026 at 10:53:15AM -0400, Steven Rostedt wrote:
> On Sun, 23 Aug 2026 21:09:05 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > [Severity: High]
> > > > If ring_buffer_read_page() returns -EAGAIN because the subbuffer order was
> > > > updated but cpu_buffer->reader_page->order hasn't been updated yet, this
> > > > branches back to the again label.
> > > > 
> > > > Since the loop does not yield the CPU or call cond_resched(), could this cause
> > > > a hard lockup if the reader and the resize thread are on the same CPU?  
> > > 
> > > Hmm, this looks legit. We should at least have a way to break out if it
> > > loops too many times.  
> > 
> > Can this happen only on !CONFIG_PREEMPT systems?
> 
> It can happen with RT tasks as they don't yield. If this task is of higher
> priority than the one resizing, then it will loop forever even with a
> cond_resched().

Ha yes of course!

> 
> > 
> > I can add a cond_resched() here though, I believe that would make sense: if an
> > order modification is pending, writing is disabled anyway and we are about to
> > loose the stored events.
> 
> For RT tasks, cond_resched() wouldn't be enough.
> 
> > 
> > Additionally I can reduce the window where buffer::subbuf_order differs from the
> > reader page order by adding an "order" argument to __rb_allocate_pages() and
> > only set buffer::subbuf_order later in ring_buffer_subbuf_order_set().
> 
> I'm wondering if we even care if data_page->order != cpu_buffer->reader_page->order
> and should change it to being a force copy instead.
> 
> If the reader_page is bigger than the dpage, and only copy what the dpage
> can hold. It would also update the read value of the reader_page which
> would allow another copy to get the rest. If the data page is bigger, then
> just copy everything.
> 
> It's not like this will happen often.
> 
> -- Steve


That sounds interesting... that would get rid of the -EAGAIN. Let me try.

Do you think it is still worth to reduce the window of discrepency between
buffer->subbuf_order and buffer_page->order?

-- 
Vincent
