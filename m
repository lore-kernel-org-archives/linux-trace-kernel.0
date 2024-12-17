Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E481DB527
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424697; cv=none; b=CpJgDys9z1dDT0qkPmj1bsoNTK5zik3XJoWWMlTj1D6hofi7mbvsTODQ9vOX5l19LCQcvZzIzMRSzqPQ4gMYssvgHKz0H5u+kOMwpKqRO/9vTyCJ5us1UxGSw370GGs6frTfFLBelwR29COWCcz320BsLjT3IORXSpCZZuexQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424697; c=relaxed/simple;
	bh=+xr8sWnCI8qEFsltLM70Vtb08bauNFO0EfTc16zDmpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8V1EPyckxsAMNB6HgB/1CJWoXhVePAnPFisH40N242jXiYsRP4EUAknzSyHMugjA7ff0w2XcwPcKn9OvBGDX4Q6kmlRqUYpCGL5nLHDlC4MoJX11D+wJc4iHu92J+uaOBjCTMtrJLCpXd6byvFjkpZ0giOjSFh4Godlvy/3OFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LL3O/T+N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LL3O/T+N"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso12430475e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734424694; x=1735029494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G3KPM8ed8hc2j9AlBl7UoCxC9Q972pfVOzKp2cweF10=;
        b=LL3O/T+NXfcQrpLUJLeAKBBII8qEnOuoMCHn9/j4WwRt2JiTijXCs44CeLliGNXrfn
         d16pK41+L4dfdZQvHUceoR7DPopx3XiUYhRxX6nwqhkmcFbxeIzqOjh280VEW0oBO6/Y
         tgLPHSuTUkx3bSKOvPjryLYhsYMjzyX+lW4kFYZnLramqyHHlbBGCDWdyMzxxeQWRz+/
         atnymtF9qMcLjWLrdL7PufosI8imlIJ9nEVJSTy22RDCtc/q8F9/61hWrnFZ+hqcDPWm
         KfNZHshkCpdpwoLm4J9RoGe11BfRmG0i6SD/D2/KTLziQ+HKeDMx0dVfCoz3ezREQKgE
         21PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424694; x=1735029494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3KPM8ed8hc2j9AlBl7UoCxC9Q972pfVOzKp2cweF10=;
        b=VFNZ/Fu9emn0AEffezsTN0E7ry6jN+LsXUT7mJuXOZAo1cOyt/7nqtftElabAx3Hh0
         YwK6yYXNyyM3IZ8ymWpyDbvuLu6GzRfh7FxXZapvRzbwvTebaBJCpkQRxt0LL+q9BxSN
         I4Tz73mCESXs9P1iVbZudN6s/sA2jPRcRfsP+CVETLVcQRZ7xGNjHASyDSBePN/iP6zG
         s/w97BSkGtplSkgHNVdmoIK2vpbIgFOrAfPN86RJkuCOV/H8O3LY/PcaQiGV6YNy5SI3
         TGhkEN+OjRIIO9it0GQvEggjxnrhvrvrGylAB8WBWmLOCzqri4geTSxHhu+hRvw/QM99
         TFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmwZ90Ko8hdnaqfB9lpSgtaGSlPMvQysAjUZydqAjmpBXS77UxPJzkwVmAb7XyzGpliIcPvpeZJ+2ZgBp372S6y/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9szCZ2OM1+0CGiAyVHaqmM0fsJhPstXQ0YbWnY4rRocjMBtfl
	KdqnrQPz6NKoJiYnZHKQGND9RYkChYgbokwyoGs8AyaorxZhQlfSDu9tf2oVOA==
X-Gm-Gg: ASbGncuz1l6i1ur4dDX+RI6vcvCfuuFXVYGsXgUN6rm7pZ6Hh4yZnCAmSB8gkZOKhD4
	7F0oKm+0yHw2lsTJ6zwVWqR0euGN62KvZE1oH8xOcAy1+q4sABIjEYKeoPIzBZ+2nPB4Xt/KrEE
	8v34YlEJJijYzUFQLo85E2bq/YqlOkRijS07EQ/vBr8C8H+uPd1arVv2XsFeI//EjCEnQJOFzFv
	yrUb1RpYK0lhGX+TWPlxJj4wDLDqfVM3L1kDdXYERa+HSFEW6/QjR4Zzz7CfAoFxhLUSHhn814S
	8e83P1TR+yTpdBVxMKU+Yw==
X-Google-Smtp-Source: AGHT+IGN1YI8GWHz++ZOwy3nrItN0Zo2uwgzrbsAh1ZerClBGgUjxx98azuCUtc2V/cxzCj23V/ZQA==
X-Received: by 2002:a05:600c:3c82:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-4364817be68mr17790465e9.10.1734424693647;
        Tue, 17 Dec 2024 00:38:13 -0800 (PST)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ec46sm165902545e9.20.2024.12.17.00.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:38:13 -0800 (PST)
Date: Tue, 17 Dec 2024 08:38:09 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, david@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: fix array bounds checking
Message-ID: <Z2E4cWMkzGqAafFQ@google.com>
References: <Z2BpY5LimG7E3LpC@google.com>
 <24508411-0980-43EE-8224-C3B81E456AFF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24508411-0980-43EE-8224-C3B81E456AFF@gmail.com>

On Tue, Dec 17, 2024 at 10:28:49AM +0900, Jeongjun Park wrote:
> 
> 
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > ﻿On Tue, Dec 17, 2024 at 01:49:30AM +0900, Jeongjun Park wrote:
> >> If there is a case where the variable s is greater than or equal to nr_subbufs
> >> before entering the loop, oob read or use-after-free will occur. This problem
> >> occurs because the variable s is used as an index to dereference the
> >> struct page before the variable value range check. This logic prevents the
> >> wrong address value from being copied to the pages array through the subsequent
> >> range check, but oob read still occurs, so the code needs to be modified.
> > 
> > Hi Jeongjun, thanks for the patch.
> > 
> > Did you find a reproducer for that problem or has it just been found by code
> > inspection?
> > 
> > As discussed here [1], s >= nr_subbufs should really never happen as we already
> > cap nr_pages.
> > 
> > [1] https://lore.kernel.org/all/78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com/,
> 
> I didn't find the bug caused by this separately, but I found it while analyzing
> the code. However, since it has been confirmed that syzbot
> has a reproducer that generates oob and uaf, this will definitely be
> reproduced.

Could you share that reproducer? Or at least the steps. As this situation should
never happen a, follow-up fix will be necessary.

> 
> The reason I suggested this patch is because I think the logic of the code
> is a bit inappropriate. Normally, a range check is performed before using
> a specific variable as an index of an array. Of course, in this loop, the page
> structure pointer that was oob-read will not be copied to the pages array,
> but I don't think it's very appropriate to read the array using a variable
> value that may be out of range as an index before the range check.
> Therefore, I suggest patching it like this.

Of course, no question about that.

> 
> > 
> >> 
> >> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >> kernel/trace/ring_buffer.c | 10 +++++-----
> >> 1 file changed, 5 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> >> index 7e257e855dd1..83da74bf7bd6 100644
> >> --- a/kernel/trace/ring_buffer.c
> >> +++ b/kernel/trace/ring_buffer.c
> >> @@ -6994,9 +6994,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> >> {
> >>    unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
> >>    unsigned int subbuf_pages, subbuf_order;
> >> -    struct page **pages;
> >> +    struct page **pages, *page;
> >>    int p = 0, s = 0;
> >> -    int err;
> >> +    int err, off;
> >> 
> >>    /* Refuse MP_PRIVATE or writable mappings */
> >>    if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> >> @@ -7055,14 +7055,14 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> >>    }
> >> 
> >>    while (p < nr_pages) {
> >> -        struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> >> -        int off = 0;
> >> -
> > 
> > I believe we can keep the struct page and off declaration within the while loop.
> 
> The reason I modified it this way is that, since this loop will always be 
> entered if there are no other issues, these variables will be used in 
> many situations, so I think it is quite inefficient to continue to declare variables 
> in a loop where you don't know how many times it will be repeated. 
> So, I think that declaring variables in advance and then continuously initializing 
> their values ​​is advantageous in terms of performance and there are 
> no other issues. What do you think?

I'm pretty sure the compiler would do the right thing here and no additional
step would result from declaring both variables inside the loop.

> 
> Regards,
> 
> Jeongjun Park
> 
> > 
> >>        if (WARN_ON_ONCE(s >= nr_subbufs)) {
> >>            err = -EINVAL;
> >>            goto out;
> >>        }
> >> 
> >> +        page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> >> +        off = 0;
> >> +
> >>        for (; off < (1 << (subbuf_order)); off++, page++) {
> >>            if (p >= nr_pages)
> >>                break;
> >> --
