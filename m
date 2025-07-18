Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7A21FF28
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878112; cv=none; b=f4//hs0GyiDGZ9BLtDPX51spfqg4oY9tH+4goOFs96gS3LozyLHdARo41NHnjOLINQSJVqyiUgYDjMsBuGGf6RZ+k+whvTlQCdGRK0a4y39ZGzCtSdWW89/fXwIkCKmRnYjIwHoGOZO5lPtl2ERJaU/7prP08ZmZPdOrC6+2hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878112; c=relaxed/simple;
	bh=tkPTSQAd9h2DNl7pRHlG+8OmpNzmu5y8PbLNUmZaSpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWQT4P7CAOYv78di8iA8hJ3T8HsTU9nIUeGqPdScFsY9mLrb71k7y9lQ80S/VSOk9oR3umPwALmsm4GW+89piostTVu8lYVsapVNf19qrNfe2/4ECzFHhYccpq+WURHfS6Omi8mBdPVDQjtWgIHbuI8reAglgt0bsjndUih+34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUGBRMlC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUGBRMlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752878108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeNgxF5UCBfEjQZZt/3dunIhv4OxleQp/vJtVa2lu7w=;
	b=HUGBRMlCCvBJy//AKU6OvHH23iZ9rOFU3ndmrSw/LJR9Jghz0ao+f8CLqeVvgOOGjkSm1Q
	krfCrMmzbbj0fsyj6Ekl30gGJ38wTw2vJfoYDyLSs5/zWvjWTpXOzfL2xqn1Md0xHlagMn
	mQEp3yhNpdv0mSNCbRNxO50OOaps1o0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-ZQ5gQ1S3PzeWf-CF6jrG3A-1; Fri, 18 Jul 2025 18:35:07 -0400
X-MC-Unique: ZQ5gQ1S3PzeWf-CF6jrG3A-1
X-Mimecast-MFC-AGG-ID: ZQ5gQ1S3PzeWf-CF6jrG3A_1752878106
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-711a46ce053so33547757b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878106; x=1753482906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeNgxF5UCBfEjQZZt/3dunIhv4OxleQp/vJtVa2lu7w=;
        b=wXaNoSwbrDcq/gmye7VKwSLK7ABW4JnfBhyaXf9ybjOrbzivlXuabMZl1isWE6bWRM
         pVcBFDBKSHBY4ARp2YYaTJ4jZeLtHbLbjgDRd0wFc6sYyBzXKmfWd1D9MAUf0LiAhAtT
         ju8P/cpGKPwilN3FzV9hCCWmcJSFWY+pNZx7Ikp4t7WQBNJHsTMXnbZIMjLDz1MbGneP
         DS7fCToVFIuNMcpS/gJpU/sOe+uKpTLI1Z9JafsWNijetxZA5mVtdOCQHAE3DeNQS9/G
         DDlOhHR1NnBDC3kHL0Wm9X9lZiDnsqdbLamt0o3LSoLXWALMG54uj2uDuGZVRlB+3fAk
         D0JA==
X-Forwarded-Encrypted: i=1; AJvYcCWBRmGU97fNvGsHaBVxKFrJiWs+7bEJMSl+pfIEKJOuEVkozSC0r6xpnsiv+l7Ip2LylnspZaOZH/lzHFr6oW+ZyCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+NUkP6JQYyy276pfRX7X+JebSIWVgzo792532JZUqxuwtu6w/
	aay0fnL3y6laFloSQbT7+CSTULOp0krH0wF9vbmUAKmpSM3ZjNxU574mnCsb64NgSxLmSfm/YE7
	ogJo3r1DjLi488o4KbIpbXATJLJxadJNEuHEKrKdZZmJQgmSCFX6llL4VFgZAWxwERn/mBXAl9U
	RBjgs2QBBuvndkFgdvbaIOdGZd5a/ytpFAy2SFgfWnOgM7buo0
X-Gm-Gg: ASbGnctQYHRwHIyxt6ilhDzpBzpWevwsKUjL0QIg0Af4TU74NnYq7xJ04cOi6PZudEj
	jtDUdaexSTz6Veq0KPqVfNQ3Ju0/yjhC+lt8DCD+3XrT4V3J2TYJi0cfrDewJcAn3jJBY7nSRfg
	eXzGZUjt2kpeXR1V8snY3oXMk=
X-Received: by 2002:a05:690c:3381:b0:710:f39f:4d43 with SMTP id 00721157ae682-718370eebf5mr151640877b3.7.1752878106348;
        Fri, 18 Jul 2025 15:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtDqNhAwLC/pZ0SZYm/yFdraL0W/1wyk988LFZ3cFbmaM2zMi6HIsy7NS2kuQoOaJh3+sk3INvjvbsCfYcvCw=
X-Received: by 2002:a05:690c:3381:b0:710:f39f:4d43 with SMTP id
 00721157ae682-718370eebf5mr151640437b3.7.1752878105985; Fri, 18 Jul 2025
 15:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-10-npache@redhat.com>
 <85b2cfd8-4aeb-4e98-8065-b6594783de62@linux.alibaba.com>
In-Reply-To: <85b2cfd8-4aeb-4e98-8065-b6594783de62@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 18 Jul 2025 16:34:40 -0600
X-Gm-Features: Ac12FXxkomg9g29JxE95wSIPOgeRNYVw8gHZYEJGmZnbAnxw2JgSYGWV08AFQqU
Message-ID: <CAA1CXcCk5VTTs+cYtWSo_UC4eDBuUCa_2wrkiexDAS6HvvXiuA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] khugepaged: avoid unnecessary mTHP collapse attempts
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sYYb8c_1Xtf4YWBpdH_i5L0C85yZRel_TDe882Ia30s_1752878106
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:15=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/14 08:32, Nico Pache wrote:
> > There are cases where, if an attempted collapse fails, all subsequent
> > orders are guaranteed to also fail. Avoid these collapse attempts by
> > bailing out early.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index a701d9f0f158..7a9c4edf0e23 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1367,6 +1367,23 @@ static int collapse_scan_bitmap(struct mm_struct=
 *mm, unsigned long address,
> >                               collapsed +=3D (1 << order);
> >                               continue;
> >                       }
>
> After doing more testing, I think you need to add the following changes
> after patch 8.
>
> Because when collapsing mTHP, if we encounter a PTE-mapped large folio
> within the PMD range, we should continue scanning to complete that PMD,
> in case there is another mTHP that can be collapsed within that PMD range=
.
>
> +                       if (ret =3D=3D SCAN_PTE_MAPPED_HUGEPAGE)
> +                               continue;
Ah good call, this patch is meant to be an optimization to the formal
approach-- meaning there are cases where trying ('goto next') to
collapse to lower orders is pointless, but I didn't fully consider the
cases where trying the other items (sections of the PMD) in the stack
are viable (ie continue). I'm going to spend some time confirming all
the potential return values that can come from collapse_huge_page, and
which ones belong in each group (goto next, continue, break). This
will probably be turned into a switch statement.
>
> > +                     /*
> > +                      * Some ret values indicate all lower order will =
also
> > +                      * fail, dont trying to collapse smaller orders
> > +                      */
After reading this comment again, i realized it's rather confusing...
it makes it seem like these ret values are the ones that indicate that
we should not keep trying to collapse to smaller orders. I'll clean up
that comment too.
> > +                     if (ret =3D=3D SCAN_EXCEED_NONE_PTE ||
> > +                             ret =3D=3D SCAN_EXCEED_SWAP_PTE ||
> > +                             ret =3D=3D SCAN_EXCEED_SHARED_PTE ||
> > +                             ret =3D=3D SCAN_PTE_NON_PRESENT ||
> > +                             ret =3D=3D SCAN_PTE_UFFD_WP ||
> > +                             ret =3D=3D SCAN_ALLOC_HUGE_PAGE_FAIL ||
> > +                             ret =3D=3D SCAN_CGROUP_CHARGE_FAIL ||
> > +                             ret =3D=3D SCAN_COPY_MC ||
> > +                             ret =3D=3D SCAN_PAGE_LOCK ||
> > +                             ret =3D=3D SCAN_PAGE_COUNT)
> > +                             goto next;
> > +                     else
>
> Nit: the 'else' statement can be dropped.
>
> > +                             break;
> >               }
> >
> >   next:
While i'm at it i'll change this to next_order to be more clear.

Thank you !!
-- Nico
>

