Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE665227E89;
	Wed, 11 Jun 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632232; cv=none; b=R2MCh09Q8T/3+zh2/j27wurlCreof53x2mq84i9uBxEiCCwOJ4LNNIMJEljuqw+w+9v3v+Q2j103iAu2KYDjt7XhB7ijy9ui7AHFnp4nl1DfISuTrvtdIEDI+tLGJESVZgyoxW9VgraEUau6Au06HS0NFJ5p92an2hzV5r7rZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632232; c=relaxed/simple;
	bh=okRb+jpW5D0E91oWQVVeKHSrMMNUpIBRDxJa/aXt66Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLtX8+YihJnwSACyGTSis0qpKhfScjYsiiMHp6Xy5jOpVT3cHDOluTpBLiBDe1iCVY7o6+q3HJBqj1whUN8BLsS0aHwQ0YjRtqTTyJwfHoTviP06hbZE4dlZPvSz/CWb7MoUoo4RZuXzBtpb4Uu++B9MFsYH506+SFnydlQmL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmjV8ZPI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmjV8ZPI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so44708195e9.0;
        Wed, 11 Jun 2025 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749632229; x=1750237029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hK5p+aM5p9zTdGEnYk9xc8yZpbtJix3a1Tf3VuioEy4=;
        b=gmjV8ZPIHVyGQl1BJ98zkqTf7GX8GgFF4zcaPjTzXs9mzJj/KnFNKVQ/K/ecBslV/0
         +Stmp3LbQFyeJLaasQKgiUeBUznRQWzW/R/zI8yTNHRLPEC0ukhamFMfQfjXHw1cjdPb
         lz/s35O0wfGd4QJdNdXjpZTYn768qFLBf7H4j3H/+nPwit6CaejBcvPCLK7p3aQ3QKfe
         95KnwjYS1Z13BUUS7naZ84NBHEfjushKY8+qMWi2ORSDhDOKKt4AhJYRQjE5Uivjiikj
         3WOSmkOboX524YJMDMvzN4I9pJc/h67Wl/NIX//tLi5xb5g0bqLfWfYb9ENiArf3ggDr
         rV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632229; x=1750237029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK5p+aM5p9zTdGEnYk9xc8yZpbtJix3a1Tf3VuioEy4=;
        b=E2dYLEQm9vg8I88hrWp8QdQBRrvo3t/znIdGYwIRx35m9U5BCLr1BNvoiWK4XT3SVS
         fp2AdHH1tcJHcJEFgY6tPh6pEmal0X2ylw4Nv0a4SHbeuAsFTKn9FZCFrcKMtNjI8rnE
         JDVDrpuCtxgqUeexmWgh7VYVCYnPqqHm+CstMulFuD+zaDDHxFIsq6HiCLhEt2VTwmEd
         c6P0KcxDvq52BgSdpJFExDtfjLaCqBfkyolykpA8isAf0bnptGbM0kfBN/pDSINF/Kdo
         wzQeHmsJsG/4JUxWbH/vYjix8hSKrSlQs6m+2Cq4txisnD+V3rRPIkNhHiQ9iN9M04et
         s0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUFtLG3nkgL3e0TG+CZsk7vOjoAMcFqMjG+gvDbMnlGg/vX+zmaEUVmVjITm7Yg96AymKxcgC5B/0dfS7I15EtUJHYZ@vger.kernel.org, AJvYcCX8v6N4IXYXgfAB/f2W7qFhdSs6A1/zwP4vqaBc4mNGhnm7nV7qklhOrEKWydp4gEgaNQf/etkM6sSd/jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvjBgMsOmfW/TkthU6CoI8HARMjcLf+xmkZo/IaOG2Lkn7gUr
	KRptSoyFniE8rYnCIhswSGZIVKbSaBj6vLIYNvasrT9CPe+BDCTBrOyn
X-Gm-Gg: ASbGncuke6OzzqQMf05i/WDBNhNl4F6ohJvgrbIKpC2ol/OzF3liJQzuYZ/0BBljKGI
	pKHFVUQr8q+U/75JzgCFuV7+45KHJIj1+8tO0Nz4MPPfSZYlaoQ50CEgHO6aCZcodx/WYYZlB+/
	e8IqkbzUYyI+V/zVJClBqN1cOlFPgfSBQHara8d+/rsvE/6Yj76lTrD2H+BtK88b6DQ12i2iU8r
	MLy92JBzwZl4HT5/NU8qhiXviEyobRlOomBttUgdnHkltDJOTbsgbhMNg924Y9X5fwfQgo3FpYZ
	jB++JivXzrdp9epI3nk8PTuUX62uJBimflI=
X-Google-Smtp-Source: AGHT+IGByvgBwv+VNZh8jCpcrqDFKuoReMI8rJVrw6jtzmtTeyre3bwD7REwXew+cg/aQW00obZrtw==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:ef00:a7b9 with SMTP id ffacd0b85a97d-3a5586dcd53mr1558301f8f.12.1749632228815;
        Wed, 11 Jun 2025 01:57:08 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::42b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5322aa3c0sm14429994f8f.22.2025.06.11.01.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:57:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Jun 2025 10:57:06 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aElE4r21ZYhLWTZz@krava>
References: <20250514101809.2010193-1-jolsa@kernel.org>
 <aECseBOkQynCpnfK@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aECseBOkQynCpnfK@krava>

hi, ping ;-)

On Wed, Jun 04, 2025 at 10:28:42PM +0200, Jiri Olsa wrote:
> On Wed, May 14, 2025 at 12:18:09PM +0200, Jiri Olsa wrote:
> > From: Jiri Olsa <olsajiri@gmail.com>
> > 
> > There's error path that could lead to inactive uprobe:
> > 
> >   1) uprobe_register succeeds - updates instruction to int3 and
> >      changes ref_ctr from 0 to 1
> >   2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
> >      is changed to 0 (it's not restored to 1 in the fail path)
> >      uprobe is leaked
> >   3) another uprobe_register comes and re-uses the leaked uprobe
> >      and succeds - but int3 is already in place, so ref_ctr update
> >      is skipped and it stays 0 - uprobe CAN NOT be triggered now
> >   4) uprobe_unregister fails because ref_ctr value is unexpected
> > 
> > Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
> > which is the case when uprobe_unregister fails (int3 stays in place),
> > but we have already updated refctr.
> > 
> > The new scenario will go as follows:
> > 
> >   1) uprobe_register succeeds - updates instruction to int3 and
> >      changes ref_ctr from 0 to 1
> >   2) uprobe_unregister fails  - int3 stays in place and ref_ctr
> >      is reverted to 1..  uprobe is leaked
> >   3) another uprobe_register comes and re-uses the leaked uprobe
> >      and succeds - but int3 is already in place, so ref_ctr update
> >      is skipped and it stays 1 - uprobe CAN be triggered now
> >   4) uprobe_unregister succeeds
> > 
> > Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> hi,
> I can't find this in any related tree, was this pulled in?
> 
> thanks,
> jirka
> 
> 
> > ---
> > v2 changes:
> > - adding proper Fixes tag and acks
> > 
> >  kernel/events/uprobes.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 4c965ba77f9f..84ee7b590861 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  
> >  out:
> >  	/* Revert back reference counter if instruction update failed. */
> > -	if (ret < 0 && is_register && ref_ctr_updated)
> > -		update_ref_ctr(uprobe, mm, -1);
> > +	if (ret < 0 && ref_ctr_updated)
> > +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> >  
> >  	/* try collapse pmd for compound page */
> >  	if (ret > 0)
> > -- 
> > 2.49.0
> > 
