Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370392F8BF1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314125; cv=none; b=Do/8QTEiBupuDjeAEKCA9Ayb7DFky+UOkjpyEfeAY14XaXx3AiUW+4KVqUxL2FJlNhH2gdpMxosk833lOZX/74fKZBpbNYenCcm58ZxXrqxfTfLFFVm1oH4vscQcVVu4G3HrLQxKaWmB/3/yGe2hnfuuookV8OGpebE/lY++E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314125; c=relaxed/simple;
	bh=K2dIAtOUUWvG/eBKWjjuLXcfuya+SsNU788uetQyZls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu2yAE8fZ0TbchVEn7hNH8m9pUSIYjLBztGDvD8U/38qW4D2/Gd5H+qU+uv5Ek95dN7NRKJsBPppETy/xnXLBhxWKN8MOx20n5jFIqtDPBEgi/631htg2xtMHbA3xLBTWJ1DEl9qqTw3rR/kYdN/REhm0BcvfYZaJtK7zyizI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgolRFh5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgolRFh5"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-431d824c8cbso171255ab.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761314123; x=1761918923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2dIAtOUUWvG/eBKWjjuLXcfuya+SsNU788uetQyZls=;
        b=CgolRFh5StPMjne6il3OZQlxjVfJxpHd7cz3RgMbGROmHNEliJauP6zcSn8W91UnO9
         hIsnXo6sZ3XQeuwiqtsxkR8X6magh9ZkS/G7eu67Txt8HOcHJwX8oBG4mG8MBUUSfpJI
         GxS2N8zMV2OzasKy5WRBl6p82rk4oVJvzOs74DwtWXzqFA27Bm6Yv3Cy5EuHsc2SL3ko
         pObqDu3oNon/u9/tACmEZqETEohZeGhHVKLVmGn157JFaW2xGNzI+IheyDbLryzpGCJV
         VXDQNGjsX+Ov965dDM4xv26n7/WhLOFSjZD2Go0c+FvOdr6UIzL9iDC4qAXKV98A9duT
         jG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314123; x=1761918923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2dIAtOUUWvG/eBKWjjuLXcfuya+SsNU788uetQyZls=;
        b=RZ166Hlbx3pKTXlTL9AWEQNT9Jy3Ilf6gtJYCGRoUxLB1du4kxJsrgfDmvsCIELcWE
         UfQ2n0yOpXJkCFo5BHoW7+NPuUy9UkDF368MWLBBMe6pIewMkTc7tigvGmqduQonk5U3
         1rClvFFNpYTDwTsMLsqIlPzcIouuIntyoUAEypooLy9aUUmOeZBRjdeeuYzV59Vo2pMO
         zVPXi+yG11Tp5ltgrkwTFgqNsumooFQ/r/0Hrp9d1dq1Ckqi+0jJ+g64n5Je6OLvO+Jg
         bvHugP+EJe3QgV6qs/7qs48IphjXMUphEw5NyRuXWRek5BT2zyzGnWsQDDFkotqEf/Y8
         2YRg==
X-Forwarded-Encrypted: i=1; AJvYcCVmXrk/UHuzpfzhZv9BJJhGCVfgX03Xi+MG7O7N15uP7+ih1MJxauTMswv875g3D9WiUqLkwvCtLshblSfz1i2K2YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGP/o49SD/5hnwD7jzX3MARahQvWM3WtEJTUEYxqsXx95fVIj
	ZQZMcoPURmezifvpFmjzQ1UGRfp5OkKC75qPdhy61k48xWlidN56WlM1sup91mJb8ehFkKKOGAh
	ZWMRmFamzd+qZ6MOPiffMzaTIu/iuCbc30soEFmb/
X-Gm-Gg: ASbGnctU+/G6h8JVQLLvV/5kurf+oFjX8TLjuYAxuiH49RjrgZTMH+NrBhAJt6OACx4
	Xj5b1AWvtnpxNuRe7S2d7Z8ROxZaoQ13xrRFvibUngBvPZNCHYSiviPwsn56AF44AfKA5MOC06H
	OxJ8y9yO+8fVrKP+hPKk0wPZtMyfIGN8kgBL3iQxd5gkOfGrGNej/4jcQkx4vHTvZ/5bu5EO0RW
	L1qHAzat9mQGDh93R1dSCZ2xnyBtWLdNhkflfOSMlobbRdmiy/4MGEOqNIgyg==
X-Google-Smtp-Source: AGHT+IGzc6PICLpjn7p5NLgSZidgmsbQwDaACcRVkIv0mBWbrME7xDhdRFUQJbQIQQlqdF4IvQBdVfldvdcu5sVwfbE=
X-Received: by 2002:a05:6e02:3046:b0:430:ab7b:d920 with SMTP id
 e9e14a558f8ab-431eb297a82mr6053455ab.2.1761314122159; Fri, 24 Oct 2025
 06:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-16-npache@redhat.com>
 <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org> <ed0887eb-6124-44ab-9d1f-1e87e9640e14@redhat.com>
 <666ee834-396d-4a7c-be89-96c58b5c2ea8@lucifer.local> <c62m3tyr6co7jqdrwhtp7exnewhogxtife7g6yh4gve7gqecz6@b5xpocyvifxp>
In-Reply-To: <c62m3tyr6co7jqdrwhtp7exnewhogxtife7g6yh4gve7gqecz6@b5xpocyvifxp>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 24 Oct 2025 06:54:44 -0700
X-Gm-Features: AWmQ_bmYc3wxdngLfQ6jZCDpaFrV3lO1QrUvKg58p5eJGm6dxJta1c107ifDhio
Message-ID: <CAAa6QmQBmZ-82PwzLao=gO-+1u=GFyPogmVOjAFQ-esVdo9tYQ@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 15/15] Documentation: mm: update the admin
 guide for mTHP collapse
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	"Christoph Lameter (Ampere)" <cl@gentwo.org>, Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, jglisse@google.com, 
	surenb@google.com, hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com, 
	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:44=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Thu, Oct 23, 2025 at 09:00:10AM +0100, Lorenzo Stoakes wrote:
> > On Wed, Oct 22, 2025 at 10:22:08PM +0200, David Hildenbrand wrote:
> > > On 22.10.25 21:52, Christoph Lameter (Ampere) wrote:
> > > > On Wed, 22 Oct 2025, Nico Pache wrote:
> > > >
> > > > > Currently, madvise_collapse only supports collapsing to PMD-sized=
 THPs +
> > > > > and does not attempt mTHP collapses. +
> > > >
> > > > madvise collapse is frequently used as far as I can tell from the T=
HP
> > > > loads being tested. Could we support madvise collapse for mTHP?
> > >
> > > The big question is still how user space can communicate the desired =
order,
> > > and how we can not break existing users.
> >
>
> Do we want to let userspace communicate order? It seems like an extremely
> specific thing to do. A more simple&sane semantic could be something like=
:
> "MADV_COLLAPSE collapses a given [addr, addr+len] range into the highest
> order THP it can/thinks it should.". The implementation details of PMD or
> contpte or <...> are lost by the time we get to userspace.
>
> The man page itself is pretty vaguely written to allow us to do whatever
> we want. It sounds to me that allowing userspace to create arbitrary orde=
r
> mTHPs would be another pandora's box we shouldn't get into.
>
> > Yes, and let's go one step at a time, this series still needs careful s=
crutiny
> > and we need to ensure the _fundamentals_ are in place for khugepaged be=
fore we
> > get into MADV_COLLAPSE :)
> >
> > >
> > > So I guess there will definitely be some support to trigger collapse =
to mTHP
> > > in the future, the big question is through which interface. So it wil=
l
> > > happen after this series.
> >
> > Yes.
> >
> > >
> > > Maybe through process_madvise() where we have an additional parameter=
, I
> > > think that was what people discussed in the past.
> >
> > I wouldn't absolutely love us doing that, given it is a general paramet=
er so
> > would seem applicable to any madvise() option and could lead to confusi=
on, also
> > process_madvise() was originally for cross-process madvise vector opera=
tions.
>
> For what it's worth, it would probably not be too hard to devise a generi=
c
> separation there between "generic flags" and "behavior-specific flags".
> And then stuff the desired THP order into MADV_COLLAPSE-specific flags.

Yeah, this is how I envisioned the flags to be leveraged; reserve some
number of bits for generic, and overload the others for
advice-specific. I suspect once the seal is broken on this, more
advice-specific flags will promptly follow.

> >
> > I expanded this to make it applicable to the current process (and intro=
duced
> > PIDFD_SELF to make that more sane), and SJ has optimised it across vect=
or
> > operations (thanks SJ! :), but in general - it seems very weird to have
> > madvise() provide an operation that process_madvise() providse another =
version
> > of that has an extra parameter.
> >
> > As usual we've painted ourselves into a corner with an API... :)
>
> But yes, I agree it would feel weird.
>
> >
> > Perhaps we'll to accept the process_madvise() compromise and add
> > MADV_COLLAPSE_MHTP that only works with it or something.
> >
> > Of course adding a new syscall isn't impossible... madvise2() not very =
appealing
> > however...
>
> It is my impression that process_madvise() is already madvise2(), but
> poorly named.

+1

> >
> > TL;DR I guess we'll deal with that when we come to it :)
>
> Amen :)
>
> --
> Pedro
