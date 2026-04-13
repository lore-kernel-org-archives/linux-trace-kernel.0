Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9822256F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044335; cv=none; b=ObGVbF9Sg/ZYQp7LJEfqaOOY6/1/6mhk9wS3ELSAkmuEaHS+tnDymuwgF3Jh1UlhWs/k209qWIJcLLaM+Z8N5QoMrBn7Xeds3e1j7jnef8ItuFlaRpRbcjJxl310toX60cdpUC8nqvNTDp/99LtJ7mDBQo7knESt11ZvPu7YnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044335; c=relaxed/simple;
	bh=MeZvaQLwo1Yi3CLdD755xqS+ZA0WcntRcM3F2Oty1LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGQL4DJup7+C5oLILgl448BAbYblQrjWIepW7LUbzOnPS4BXfliYLfJCEzxEnnpHLma3Af2TUDRR+GndZsDe60GARYD2dh0l7iHl1g6L+SAWJMAZYQHGu2mZIbpD8TwA9aQzKcedMDokGtv9OD7tCajIRBiLggnNnTNIRrkqaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwI2+FSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwI2+FSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776044332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/LczZPV43VeCs6q1pNCwBA1d/W1p8xMLArqty6Nu4c=;
	b=MwI2+FScWekLMA72L/KN3PUrP1U0loOHPyDhCbyFGG4OvsM5RD7+eDzidiUBurHGH7D/TI
	WSigbJ+rqY6/a4n2UnREGQ9J/a+eKDPKxv9EIG6XUH/4dP03I/SOC7WHuf5cejWzXPtde8
	GWxiCTtJI7PlFWrBTfVIMrZkWCHSO9I=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-xc4dppGUOWST1Rrv1khxZw-1; Sun, 12 Apr 2026 21:38:51 -0400
X-MC-Unique: xc4dppGUOWST1Rrv1khxZw-1
X-Mimecast-MFC-AGG-ID: xc4dppGUOWST1Rrv1khxZw_1776044330
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7b3635ae134so6085187b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 18:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776044330; x=1776649130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/LczZPV43VeCs6q1pNCwBA1d/W1p8xMLArqty6Nu4c=;
        b=EF74YRSMaoFs6YS0u038mAkX1rPhyFy6i7gCCDP3EAevTdfyK5hp4ysKGcvS53ekvm
         4dS+8F56d8Njs7mdy15Xq5SWsYDC2T+ZpMkCxevW6MYT+wUlgH/4p6VX+f2luuHtvfqi
         Mdf1KI06kfA+EaSmMNrNDoAcEKa0bjWqMsbQT9YvqN61sMaXRDV45iKTdSC4X9ktqE6+
         rQ7DCG5HfJxqdf6kzAtQlAdEivIh7sVkTRVYMGNBk0T/Fcqvvyu4Ca0QTqrhV/XWQnpk
         NJArhGuSU9NLi9RdKnSV3nuDShKsUn8d48MD5RRH/SQAKbhpr9uOwghIamFdQ9+nzhFE
         pfMw==
X-Forwarded-Encrypted: i=1; AFNElJ9lc31hV2B060lOewLHCSMPX97K23/PXZNcF/V7jYwgbykb148TSt1upCxn/rLgMrMLey35KIgo9Bi46b42K1wF6BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrZvZBsqqgDJ6sKQNYXEDXEdkOPpDepX/ymnLIe31yLBRiJok
	dyIMs5morUAoVc7Tbc21/y/bxvz2z4AfGBYexA6bNrR3WTagJZllzN6WHx5u7RtEor03vDAGFYd
	/3QD9GFeUs6mijgS0KKI52wwcbRNBoN0yX2Lall01OY2nlXTrw15ARcf/17trrK/e17Nrerym0x
	THLb7nSF3bX/yL+hp0l+CDSp8hcMdWLdnG87Y88W4gxRX0PofE
X-Gm-Gg: AeBDiev35ecEZgnahc1IiabpvigHnU1DDpkCkXPtowauHQRVJA2PqcelP/sXwyzIxgg
	SoK/KXi8cmhBncyBm/hWYwyvz2/nmffvzfF5KM7/dJJPt2N/M3LVaH6UezTb7GRu6ZcNYl0Dvpw
	LRsLH4vm+nYZr2sXUM/qlXhxcHxzVyT+iIa1CgY/6eayFTO+XlweTekOgl/Qdxjyz9TKp66XHFK
	o3kOhYS
X-Received: by 2002:a05:690c:6987:b0:7b3:edc7:9b8f with SMTP id 00721157ae682-7b3edc7b61cmr1319347b3.0.1776044330317;
        Sun, 12 Apr 2026 18:38:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6987:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7b3edc7b61cmr1318877b3.0.1776044329838; Sun, 12 Apr 2026
 18:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226031741.230674-1-npache@redhat.com> <20260226032445.233437-1-npache@redhat.com>
 <94290ad5-f63d-4fa7-a898-dcfe6cd9998b@kernel.org>
In-Reply-To: <94290ad5-f63d-4fa7-a898-dcfe6cd9998b@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Sun, 12 Apr 2026 19:38:41 -0600
X-Gm-Features: AQROBzArl5XlylTlxjRxCzhfJiWfRtUhtNUooNt0wkSwTm8sXKprqqkTO6ix5Ns
Message-ID: <CAA1CXcDnz_7+16sDVbGJ2ZZPWxs7ta_Z0YU6x1dUe7yiSJ3OKg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 06/13] mm/khugepaged: skip collapsing mTHP
 to smaller orders
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3w4P_UmoUY6jULNrI0BfhtbBUfvCZzvrjIvmKS8KiG8_1776044330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:00=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 2/26/26 04:24, Nico Pache wrote:
> > khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> > some pages being unmapped. Skip these cases until we have a way to chec=
k
> > if its ok to collapse to a smaller mTHP size (like in the case of a
> > partially mapped folio).
> >
> > This patch is inspired by Dev Jain's work on khugepaged mTHP support [1=
].
> >
> > [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.c=
om/
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fb3ba8fe5a6c..c739f26dd61e 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -638,6 +638,14 @@ static enum scan_result __collapse_huge_page_isola=
te(struct vm_area_struct *vma,
> >                               goto out;
> >                       }
> >               }
> > +             /*
> > +              * TODO: In some cases of partially-mapped folios, we'd a=
ctually
> > +              * want to collapse.
> > +              */
> > +             if (!is_pmd_order(order) && folio_order(folio) >=3D order=
) {
> > +                     result =3D SCAN_PTE_MAPPED_HUGEPAGE;
> > +                     goto out;
> > +             }
> >
> >               if (folio_test_large(folio)) {
> >                       struct folio *f;
>
> Why aren't we doing the same in hpage_collapse_scan_pmd() ?

We can't do this in the scan phase because we are not yet aware of the
order we want to collapse to.

The scan phase builds the bitmap (if mthp sizes are enabled). I tried
to think if there were any similar checks we could perform; the only
one that came to mind is whether the current folio size exceeds the
highest enabled folio size. Is that worth checking?

Cheers,
-- Nico

>
> --
> Cheers,
>
> David
>

