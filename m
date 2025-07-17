Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFB2192EA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736928; cv=none; b=n9XGCjxKzjEDaxc3Ip3ZXQIRDZqNgL5qIxeo1K8zFvUCfbi0o5VyciozBedRDeKZFZIhHJMBMlVhD212UAsc4fRadZALIVxvlv7Q6zGcIJtTCtKXi429o+u34w7JjniWUVFZYJTELpnZi+RufhJzh2PmSG9TGIxfHlvZUg6tV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736928; c=relaxed/simple;
	bh=tWDmCspVYb9wK2NOfdDGtxHX3NGRXaIDB6oxJ+Ggx2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N49GciB0TED4uwgBphlBW9kpurjuFTC4uoxAITYxJiysHy/MQDEVYv3FbOztgoilHqy8srQrkjy7yq+BfGW5APSCPavha/xM6pe3QeFDD5Tn3mByWYf2TCjx0iJGSPs4PR1twRy2BcKoicPKxlHV3ppSHc/dN2xv6ZK1YYFwXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcoO2U6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcoO2U6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752736925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ39Fnx/vbGSljAimxTrmnp3D5hf3R4yTB7vGUtkUcY=;
	b=VcoO2U6nrbF3P6BwrQivz/l+yjiYZJ7Y8AX71XgXSshcSK4CQNKK6yT3jSqC29e29ZG1K/
	804YPCpvbNQ1IxW4DRDzN+ZWomXMrCEsyewG/bzZWPOrC5uVkx4HpEFui4h7L4NjWog/0x
	rrJf72WVSwUIW/bC1biSyT2XUZ9bEQQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-V9MSlrQIPV2lii0GuOKxig-1; Thu, 17 Jul 2025 03:22:04 -0400
X-MC-Unique: V9MSlrQIPV2lii0GuOKxig-1
X-Mimecast-MFC-AGG-ID: V9MSlrQIPV2lii0GuOKxig_1752736924
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7183dc67fc4so9638417b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752736924; x=1753341724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ39Fnx/vbGSljAimxTrmnp3D5hf3R4yTB7vGUtkUcY=;
        b=AjJB1raNodGdXW0j4OR4enFeBZOv6eO/F/G1yD23H2BFSz75IFM0jZdoTC6gi70ZvY
         PjTNPGHFXXvCD3QRdsRfq0Z0upNoNmxTaKegLkJZv6+6Mc/gx61A9HQbhy5BiIP2CABy
         dwIQQYPAKdw81idpyHz4XQKwS0TcJMxDicfs49pV+IeMCFu38i8SxF5hkXPV5jB0BnD7
         KaV7mULjyKMJhQkKIyzy2aMDNAxNthgYDtTej8pBOHzRIjNhDYom4vF99DhaB+fEdK3m
         TLITnhzQWf9kWi1IOT321mBWL4xJLcwxuWVwrSdjnjO2jziHz2MC1jmCcZfny+AwihOr
         ycKw==
X-Forwarded-Encrypted: i=1; AJvYcCXVjVuxKN0EDc9Z1VqxQi4+K33zPSf5DspLDgVtdyOO4jOlfGYHEr4vnYDf/iHOi2NfnsBQ0fP8TxhuQrNdUTjDX7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiwu3bGz6ulg1WibCfQaKPyRNWQ+EOZdCd7gxV0jFYgc2NANnb
	JHv6cxFyXjkDv3h3Xr3CbyNt6uFnHdzhPIndFITeSfl6d1Tff/GvpwIpkBPi0Gk02/UI6QGTSZa
	hoji0KOgV/KtW/Jpx39wWoKjTbm/vJAI2ZR5stfv2ljk/foSBvOLiwCTAAbEa6ioXeYbWOJF630
	lxZ7OOF/7XWxoLLkH/XmJlXHW7tKov1gf3fvyFoXR+oNnpY0Cd
X-Gm-Gg: ASbGnct3V5to+5WLZTmHPaO4ZWuIJw+uVhtcEU/j0oFZxLNUcYmZOLB4aCVqSV1Gb+s
	ok2lVz0UKt3UG9kesG7bldUWjYVwIfkA/OcGrqw0XseLuil+WKLrcByewu+YCqSNTZs0c4PnWUQ
	iURUeZ5UpMta7qEmntKaM8nsU=
X-Received: by 2002:a05:690c:7006:b0:70e:82d6:9af2 with SMTP id 00721157ae682-7183519693bmr85546927b3.34.1752736923772;
        Thu, 17 Jul 2025 00:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFulp94zzqufWxgbn/qqUK0u8D80QwhjnNGORTCxK8HgNdkob8Z42M9OX9p9UcMtp5qaidEXGBGcHvo62zvmAU=
X-Received: by 2002:a05:690c:7006:b0:70e:82d6:9af2 with SMTP id
 00721157ae682-7183519693bmr85546287b3.34.1752736923365; Thu, 17 Jul 2025
 00:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-2-npache@redhat.com>
 <qgcvsfhoq3pnvxhdn73dopbtvi75oghbaydg27atqfp556u6sa@ixwdwi73lgkl>
In-Reply-To: <qgcvsfhoq3pnvxhdn73dopbtvi75oghbaydg27atqfp556u6sa@ixwdwi73lgkl>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:21:37 -0600
X-Gm-Features: Ac12FXxi7mHJAWB-d7W3oMKlvMwZbeUXqKMgcsTZqrDy3LQaENgncw19n5KwkQU
Message-ID: <CAA1CXcAmkembYSSYwRq6avfQN6TJnp8=f99MDv1kkEaL-huczA@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to collapse_*
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g4Jl0QL2KLEHv0DOF8ZJ7xD3KtyRHdWr7m_rMH4_qqA_1752736924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:30=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Nico Pache <npache@redhat.com> [250713 20:33]:
> > The hpage_collapse functions describe functions used by madvise_collaps=
e
> > and khugepaged. remove the unnecessary hpage prefix to shorten the
> > function name.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
>
> This is funny.  I suggested this sort of thing in v7 but you said that
> David H. said what to do, but then in v8 there was a discussion where
> David said differently..
Haha yes I'm sorry, I honestly misunderstood your request to mean
"drop hpage_collapse" not just "hpage". In a meeting with David early
on in this work he recommended renaming these. Dev made a good point
that renaming these to khugepaged is a revert of previous commit.
>
> Yes, I much prefer dropping the prefix that is already implied by the
> file for static inline functions than anything else from the names.
>
> Thanks, this looks nicer.
I agree, thanks!
>
>
> > ---
> >  mm/khugepaged.c | 46 +++++++++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index a55fb1dcd224..eb0babb51868 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
> >       kmem_cache_destroy(mm_slot_cache);
> >  }
> >
> > -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> > +static inline int collapse_test_exit(struct mm_struct *mm)
> >  {
> >       return atomic_read(&mm->mm_users) =3D=3D 0;
> >  }
>
> ...
>
> > -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > +static int collapse_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> >                                  struct collapse_control *cc)
>
> One thing I noticed here.
>
> Usually we try to do two tab indents on arguments because it allows for
> less lines and less churn on argument list edits.
>
> That is, if you have two tabs then it does not line up with the code
> below and allows more arguments on the same line.
>
> It also means that if the name changes, then you don't have to change
> the white space of the argument list.
>
> On that note, the spacing is now off where the names changed, but this
> isn't a huge deal and I suspect it changes later anyways?  Anyways, this
> is more of a nit than anything.. The example above looks like it didn't
> line up to begin with.
I went through and cleaned these up, both on this patch and future
patches that had similar indentation issues.
>
> ...
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Thanks for your review!
>

