Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C011E48B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893184; cv=none; b=lGTBJMRkpvckdZ709dhXeUPPGdCnG0p7utCICDQ7eessVC/kuqlpVoq7s39hNr9RpS+RR7vp2De6pDHjp0ZA+ZUY90w5G8U1DQLXz2MV+FzNyrSODkJ4bLizXwT/isMMHVTd0QLCD/Ag7dFPTQ9kTmV4JrpRuNRWOge5ohz640U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893184; c=relaxed/simple;
	bh=abQgNmtRulhb91gD2TsheJQ4g1bpo785JUq7/ZYZy3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5zygtQvww6ihAAfIO0cvp5kN3IJOQseYLwmmyhVfEITZ6Atd2xQgV0R3jtxwHfeLnhBtC8AWyKEHr23kadFf02bS4EDaaiyi8ECLkUPn5YhDOcY8x8rCbRtKfqlI9r7pcPztTjdHYBB9nS2ZdJ9wWXOVyFZ3oSJNaj1VsVgWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IALLc9V5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IALLc9V5"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8ef63714cso519660a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718893182; x=1719497982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv+xOEqws+KjvoyS4k7q1BnMnYne+DLlcGkvkV1YXWI=;
        b=IALLc9V5imLL7VTfHVbdkAz17yrVjApMNA4Yzu9ztPzdX8aJsLf8axFimeA5ZhKQrj
         NJM/Fv4oue15cbHdrAIS7zppPSHzcfFajPSu+rCLKe1J8YyvnkEuj2WUj0NjCb/TfZpv
         gvmzDlyrwKSaxfmUY/vbzeO4DRe0OSbe/o0pQ2QOHxVmoFTRtZpN92iFfWPrFRoshWBc
         w4pvcBXKebElc+prOPf+UESE5+GNeP4WTuk8MzpAqtOpH0CYkGNNDSlPK+VfdRhVjody
         1GggdzEoi+aSMPEYZKrP0ap+HFc5mzrYi8xaVz1HLrUZwbi1MR8++WNfGSq6ia0HbLj5
         MENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893182; x=1719497982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv+xOEqws+KjvoyS4k7q1BnMnYne+DLlcGkvkV1YXWI=;
        b=njcn+Wgg8XwrEWgktZNv6c1b64bMjBYE8ZHglSModK921dvrwvGsk7VkssqQfNOPVL
         cKt6vgCgiLFOO9j7hpJx8WYprtkMbs1qkuuKPKQ76RtutuzjkGh2BddORnl8nbG0b578
         Q2pSxa+uOVnssYHNMeLs1nskIC9BAUPrJrEd4PswGYpwn9cqEAF2vXxuxvOaBpWRMPtd
         nDZv5iPPwmvAtDtyBewCcrKmqMX/oCTs7jmTsjb3JVqZKarEj2AzM6dAA7qxOAB37ZwR
         lC2B7Jhcp+khlA2b/p18ywG/yA4u5Jz/pk6Gd3Vi2JjpA1Ho2Xxob8JW2R7JWmK1FH7N
         O+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUFPCsSVMfuDXLHl+EjYRnKd5Xd77Mj2L/GBT87hiAJ1GTvwj2DvGFymb0DCLIYJ7D2Mb+XBVHvmrFaBEaLvYkIxs6jJTQUOqee9/tL87bAfjWI
X-Gm-Message-State: AOJu0Yy9NZWVH4M0zMMxfr5LNf6WuOhkKinShaAYnxpcl+YvRfVKQQi1
	RPP+deMNMt47QIdCpUmyFNm9CnhbxNl7aioHtJE6VoBgLUyTLdYYUcz1o8pv+tjS5bc0PIGac1I
	dl3SG3C2ZL6ImkLsLFOCOeAIMW2VJEC7aaOBN
X-Google-Smtp-Source: AGHT+IE09fsEZr9ZoSHdbUKHBdTeeBAjnGuixlRzRpM0AHsB+sO1SZNTjr1raJ9+9DFih0kA9gjaCoNKe5irm0Thh/4=
X-Received: by 2002:a9d:5f14:0:b0:6fd:591d:9e21 with SMTP id
 46e09a7af769-700771e7dc8mr6110157a34.33.1718893181456; Thu, 20 Jun 2024
 07:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-37-iii@linux.ibm.com>
 <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <f6ab5d6e0aa90ad85e239a2da9252930ca9a70c3.camel@linux.ibm.com> <CAG_fn=V-_8q2FDEDtvcNmS3rizPEM-RX+vHPrus4ECNx6AZfGg@mail.gmail.com>
In-Reply-To: <CAG_fn=V-_8q2FDEDtvcNmS3rizPEM-RX+vHPrus4ECNx6AZfGg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 16:19:04 +0200
Message-ID: <CAG_fn=XcDDFBAxq_0pij0VFU7ODJ6cUKd3AqBD-EgkbfnSLJNg@mail.gmail.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the architecture-specific functions
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:18=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Thu, Jun 20, 2024 at 3:38=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > On Thu, 2024-06-20 at 11:25 +0200, Alexander Gordeev wrote:
> > > On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:
> > >
> > > Hi Ilya,
> > >
> > > > +static inline bool is_lowcore_addr(void *addr)
> > > > +{
> > > > +   return addr >=3D (void *)&S390_lowcore &&
> > > > +          addr < (void *)(&S390_lowcore + 1);
> > > > +}
> > > > +
> > > > +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool
> > > > is_origin)
> > > > +{
> > > > +   if (is_lowcore_addr(addr)) {
> > > > +           /*
> > > > +            * Different lowcores accessed via S390_lowcore
> > > > are described
> > > > +            * by the same struct page. Resolve the prefix
> > > > manually in
> > > > +            * order to get a distinct struct page.
> > > > +            */
> > >
> > > > +           addr +=3D (void
> > > > *)lowcore_ptr[raw_smp_processor_id()] -
> > > > +                   (void *)&S390_lowcore;
> > >
> > > If I am not mistaken neither raw_smp_processor_id() itself, nor
> > > lowcore_ptr[raw_smp_processor_id()] are atomic. Should the preemption
> > > be disabled while the addr is calculated?
> > >
> > > But then the question arises - how meaningful the returned value is?
> > > AFAICT kmsan_get_metadata() is called from a preemptable context.
> > > So if the CPU is changed - how useful the previous CPU lowcore meta
> > > is?
> >
> > This code path will only be triggered by instrumented code that
> > accesses lowcore. That code is supposed to disable preemption;
> > if it didn't, it's a bug in that code and it should be fixed there.
> >
> > >
> > > Is it a memory block that needs to be ignored instead?
> > >
> > > > +           if (WARN_ON_ONCE(is_lowcore_addr(addr)))
> > > > +                   return NULL;
> > >
> > > lowcore_ptr[] pointing into S390_lowcore is rather a bug.
> >
> > Right, but AFAIK BUG() calls are discouraged. I guess in a debug tool
> > the rules are more relaxed, but we can recover from this condition here
> > easily, that's why I still went for WARN_ON_ONCE().
>
> We have KMSAN_WARN_ON() for that, sorry for not pointing it out
> earlier: https://elixir.bootlin.com/linux/latest/source/mm/kmsan/kmsan.h#=
L46

Apart from that:

Reviewed-by: Alexander Potapenko <glider@google.com>
