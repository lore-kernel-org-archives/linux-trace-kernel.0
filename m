Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEC36404D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214877; cv=none; b=ERL1cnHyd5ZEXERjF2cNtFf/ly62pYuvdFtdYEUTlEkgA2lZcbBjMLNhQILBovT6Wg/Ov63dOh16Ovcr2I+W9wyW/XWaik4WUQlqLhe2ksioFwdys+qOmGx8qTsNrZy52kHGAUW0RJAT9iGcmFRZ3JwE442sjoUarg60YcKWquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214877; c=relaxed/simple;
	bh=mBzpJrN9KrqpGSZV7OZTPURa6bHX1KPDENwsV2HGpa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUyc7BKxb3fBlS4yQzuAtFa6vZ4zqiukKOjbc9FOopZ8+I8VYJ97xNax/trzijbOVgoQ0WeyKp05xVRZ/mI4xunbUXo+xwm/BCFHxa8Xvg3D8m/dhaD8AiMrrhtnSRNSic9kqhi3E7ZkPr9etgwilB28Db26XmOOPMf3S54m7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwJzWSQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwJzWSQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779214874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DidhSSVgs6YbRMyQzDDirQnaWZ/O9mawSXYrnotJW/A=;
	b=EwJzWSQlCL0UdAZTv9b3/kI5Ms3NgKt7TvUBrHaouaIK8FFTIWa80OWgA8HzlmFovDnNT7
	wvSbRRZFLIH/M6YTQZDF6fybnh5CR/Di0usvn53dYQ7Mv0KOgeQ5u/biC7AHHGhf2l8/5B
	/HLDGGgHCUmyQM7vmL4ZKd3CyhfS5nk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-maCkV1kVNoCr8CFX5XYldw-1; Tue, 19 May 2026 14:21:12 -0400
X-MC-Unique: maCkV1kVNoCr8CFX5XYldw-1
X-Mimecast-MFC-AGG-ID: maCkV1kVNoCr8CFX5XYldw_1779214872
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-65c5afaff48so8208866d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214872; x=1779819672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DidhSSVgs6YbRMyQzDDirQnaWZ/O9mawSXYrnotJW/A=;
        b=hme7hKDvGhlSd11EXk6mPFFEj6+6sSvDtvOEkEUeA3eWRtzNOPGaEqA53+jdHj6yxD
         AkLY1CrFMNGnIOCGDalfYRCmo8+x2SlgXI2sjCe4EiJGID2Fk4hHhlfLzoy28q/mpUUj
         rPQr9U2rIdX+IwpwgTm/C2J6ovmR6EAp8MCG8CgRAIX46UJODOzNfZsZDSkiMaLvYaBm
         m/lll+11I6q7Pvdmj3k/qQYisf5bYiaCuB8/GptfZ7KXzZMgylZwkjqXHfyuRmZWTsIA
         HPwuSj38LcmkZVmC2lqcL1aoXsrfsj/TEswdYFKZqoAdPqBORhAJQ112CKOXyS8aazOr
         mdvw==
X-Forwarded-Encrypted: i=1; AFNElJ/3WoTfFdJvNEfJIF2CA1ysW9AEHc2IpRX+GOhgdG2Idj0nxNe0t7jlu+YSGjZ11XDKEIb8V57hepsWJscwpBtj39s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnhf91833+zQnw8qHt2VWLb436+NcUVEqrymQEohn6oXbqk5Ei
	LhLBXGhRPHNaa9o4x/pKDsSH1jCNfwe1e2Id53s2npCLM42wB+RpvosocJo66kHBns+AW2hRMwt
	aBeMYuka84XLzrYVtPEqAsqCKzjrlC22VU/duTLh9a6C0DtEYbdMzfA+Awk4AamoTxkaXDzgkiY
	Fib32l/Zh3IhMU/PKrWa21Khuv3q1toIGS3plZHCBBuBvVOCvQ
X-Gm-Gg: Acq92OGxhqlps0DGF53bylyuWwh2BfMkomvmpt5qZ60/ntFXsDaLbNWy97PDzc9qwaf
	h08oh1stVgHZ7KmV+Ww529zlXGExYp6NEdmcnITKNrQP1RU0NjeWZcwIdPxwcTCNLweJC8LJPxZ
	zEAx1dZ9ur+V33NMF20YOagZ6Ii56W+K0nS3uxQ806jq4StEGwrp9L1EN4S2v71Pxa+K+mrnvwR
	/ACMg==
X-Received: by 2002:a05:690e:1402:b0:65c:6ffb:3038 with SMTP id 956f58d0204a3-65e215f82abmr16063354d50.17.1779214871900;
        Tue, 19 May 2026 11:21:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1402:b0:65c:6ffb:3038 with SMTP id
 956f58d0204a3-65e215f82abmr16063273d50.17.1779214871174; Tue, 19 May 2026
 11:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511185817.686831-1-npache@redhat.com> <20260511185817.686831-4-npache@redhat.com>
 <4566170a-7e3d-49e4-baab-ba2790c198db@kernel.org>
In-Reply-To: <4566170a-7e3d-49e4-baab-ba2790c198db@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 May 2026 12:21:35 -0600
X-Gm-Features: AVHnY4L4MNLuHeolsP-TGGRMvsoQWuP6zfUselEJ0zRNjehB522kQizaPVIyv5w
Message-ID: <CAA1CXcCD5ooRJonAVp2LvnoCrQwcs1-NsAYomXbHTVNSe5X0cw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 03/14] mm/khugepaged: rework max_ptes_*
 handling with helper functions
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, Usama Arif <usama.arif@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UpB5TNP65F8YasmDkNdX3-iY3BRqpcL1kHkHr3a3ALo_1779214872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:30=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/11/26 20:58, Nico Pache wrote:
> > The following cleanup reworks all the max_ptes_* handling into helper
> > functions. This increases the code readability and will later be used t=
o
> > implement the mTHP handling of these variables.
> >
> > With these changes we abstract all the madvise_collapse() special casin=
g
> > (dont respect the sysctls) away from the functions that utilize them. A=
nd
> > will be used later in this series to cleanly restrict the mTHP collapse
> > behavior.
> >
> > No functional change is intended; however, we are now only reading the
> > sysfs variables once per scan, whereas before these variables were bein=
g
> > read on each loop iteration.
> >
> > Suggested-by: David Hildenbrand <david@kernel.org>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Some nits when re-reading:
>
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 118 +++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 82 insertions(+), 36 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index f0e29d5c7b1f..f68853b3caa7 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -348,6 +348,62 @@ static bool pte_none_or_zero(pte_t pte)
> >       return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
> >  }
> >
> > +/**
> > + * collapse_max_ptes_none - Calculate maximum allowed none-page or zer=
o-page
>
> I know, it's painful, but ...
>
> There is no "none-page".

Yeah I think you mentioned that last review... sorry!

>
> Calculate maximum allowed empty PTEs or PTEs mapping the shared zeropage =
... ?
>
> > + * PTEs for the given collapse operation.
>
> We usually indent here (second line of subject), I think. Same applies to=
 the
> other doc below.

Hmm tbh I couldn't find a example of what you meant here. There are
some that put a space between the first sentence and the @ list.

>
> > + * @cc: The collapse control struct
> > + * @vma: The vma to check for userfaultfd
> > + *
> > + * Return: Maximum number of none-page or zero-page PTEs allowed for t=
he
> > + * collapse operation.
>
> Same here.
>
> > + */
> > +static unsigned int collapse_max_ptes_none(struct collapse_control *cc=
,
> > +             struct vm_area_struct *vma)
> > +{
> > +     // If the vma is userfaultfd-armed, allow no none-page or zero-pa=
ge PTEs.
>
> Lance commented on the comment style.
>
> Is this comment really required? It's pretty self-documenting already.

Dropped it, thanks.

>
> > +     if (vma && userfaultfd_armed(vma))
> > +             return 0;
> > +     // for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
> > +     if (!cc->is_khugepaged)
> > +             return HPAGE_PMD_NR;
> > +     // For all other cases repect the user defined maximum.
> > +     return khugepaged_max_ptes_none;
> > +}
> > +
> --
> Cheers,
>
> David
>

