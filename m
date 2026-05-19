Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4D2D5925
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214896; cv=none; b=RVCdSQ5bVG9PtwPx0lgaJEAawY3NurgdILWi8KAbdmfn3L+Il3Jh8AIGEyJgc6cVoTdKHSiUzprn5ptbCYLPwfC7d4cr2ASZtNdSbqELUBndSr6vWCXR4f7ouzLovTbNpR4xo7mCkjAN41StsF9vr1rYQt8oKAJMLJz5mh72spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214896; c=relaxed/simple;
	bh=vhtcXwQD8YJQSGdo3aMKsTCwEJjn77r4Cw/82Nag1iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDRh3rKk2TRtIcELjGlVwaz5e7u/R4rWsIMVJgpZ9c0mlow1lg7HdCAAsXJMRgssz227HEO6dxQkWAcTikcnBXz8ZuZLV70xdy2MGuS8jOE8qwxPEMTaOHQJ6vju/PXbtHJTmDw7vWRryUWA2htnItHl/ZpR15Oq3TAvChSuyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gB8ktIFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gB8ktIFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779214894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxztUpQkc+oYoV60aAGxfNnNqxyt9Qiie0vehvZmWfQ=;
	b=gB8ktIFuH0r4RxuFG2QGld44EMxqaovY/4jQcgsVny7tD6ZIrA5vUpjn/1jzPTBR/kBHdZ
	KTGylB3kNohj+hkeFcFsp5H43O/HdtJ6R3wSYpfTnLX9+VuDXHCOSTaUivGeP4JosOuu0x
	s2t4my//5pasTbwKmQain0yF7Dlhi8A=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-6gn0NA3cNr-6NSs0a_MHgA-1; Tue, 19 May 2026 14:21:33 -0400
X-MC-Unique: 6gn0NA3cNr-6NSs0a_MHgA-1
X-Mimecast-MFC-AGG-ID: 6gn0NA3cNr-6NSs0a_MHgA_1779214892
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65d9e66d0e1so6963766d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214892; x=1779819692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxztUpQkc+oYoV60aAGxfNnNqxyt9Qiie0vehvZmWfQ=;
        b=ntLZWYJ/A86VPoNJ9lCG68+fpQrryJyZPa/2YpPYg6HIrPjokk+ttgFALDHxbL4+AQ
         IyHeRFi2ZwpHIFikem/gF3b+4YucKXQ2QXvuv5xXIKmXoKv6L7g+xrvFtqVTmlWtrPTU
         6hpce6M5Cq1bQ2kmrD/hMd0srCsY6xJESsTOe+ev2hjAnAlplC3pBS7cJLbBVRPyY1vx
         4HTonfCZhG6xKg2oa301VibzAdq2uL0y5wPqpf3AJAq2yRME8rO+aAJUKBVYnFBwPaME
         l/nn7ZG2Q5Ya2cWe2K9Rq2q9tpNGJVL6bOGwCOpppFq2HS0L5egMEGeo0Fy83U6KOzhl
         zvxA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZZmpjoi19mQdiqCTid8Mju9/6S+Y8jygkp+piKmYiG+8tj6Rx/oAYXhEtbzb64EezOuLFmNoA8s+pE2q6ay6Z0LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEhePE/tXQ+7rN/3abr7UXAq8YFJZr59ggnP0rTp+4Sme2V7C
	dQBCcgiuka/OwfxPGtKochkn8QPOeiY3SoSHRWxcz6ZTVBv/x7CGjnKkfqpQzsjrhMU1XtXxpL7
	P48JNuJnXcXtVevT6pOqWaWX3nxWqzeX5xgtULLByxlp2dzcTdb0c9/S0m/SSNQ5iOB0J7QoZwb
	BjtoXU24dAyWA64zHYnojQ29rKzZzhyTquNzJCgKQCtLMTyeh1
X-Gm-Gg: Acq92OGc3tnrsIZ6carWeS1GPRIfF64kZRKSIrblyDLsNEpdBjcWDuZO7uAmhkiNPNi
	T5oyZYMsEX42BKXyU66mZ7n6/6LLX3jkglLEpQMVYZNSepq7ddn5Em299WnfcwVSerAcBGJjHWD
	52HjHfOju3BP1VqNw+VApGgK4+3NzFLSKoGY2cdzVnBT3YoVecwb52UpnCrdBPSgNI+6yToFWx0
	Z9A1A==
X-Received: by 2002:a05:690e:1699:b0:65c:5b88:849f with SMTP id 956f58d0204a3-65e22893f96mr20651116d50.45.1779214892470;
        Tue, 19 May 2026 11:21:32 -0700 (PDT)
X-Received: by 2002:a05:690e:1699:b0:65c:5b88:849f with SMTP id
 956f58d0204a3-65e22893f96mr20651073d50.45.1779214891824; Tue, 19 May 2026
 11:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511185817.686831-4-npache@redhat.com> <20260512044444.71798-1-lance.yang@linux.dev>
In-Reply-To: <20260512044444.71798-1-lance.yang@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 May 2026 12:21:58 -0600
X-Gm-Features: AVHnY4I0H7_VzBvKWPdyr4SDWj9fF1lT1UTvqSSOtSQqNmJ-nBt_6GnPLA5-X2k
Message-ID: <CAA1CXcD=-kia9FPK75DggewQk4x52TvzP-Wwoe-CrcMx9wTg_w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 03/14] mm/khugepaged: rework max_ptes_*
 handling with helper functions
To: Lance Yang <lance.yang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, usama.arif@linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M_yqVC9RW4_0zUYYXvat_5GJhqYg_wHbsCDKEXdYuf8_1779214892
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:45=E2=80=AFPM Lance Yang <lance.yang@linux.dev> =
wrote:
>
>
> On Mon, May 11, 2026 at 12:58:03PM -0600, Nico Pache wrote:
> >The following cleanup reworks all the max_ptes_* handling into helper
> >functions. This increases the code readability and will later be used to
> >implement the mTHP handling of these variables.
> >
> >With these changes we abstract all the madvise_collapse() special casing
> >(dont respect the sysctls) away from the functions that utilize them. An=
d
>
> Nit: s/dont/do not/
>
> >will be used later in this series to cleanly restrict the mTHP collapse
> >behavior.
> >
> >No functional change is intended; however, we are now only reading the
> >sysfs variables once per scan, whereas before these variables were being
> >read on each loop iteration.
> >
> >Suggested-by: David Hildenbrand <david@kernel.org>
> >Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> >Acked-by: Usama Arif <usama.arif@linux.dev>
> >Signed-off-by: Nico Pache <npache@redhat.com>
> >---
> > mm/khugepaged.c | 118 +++++++++++++++++++++++++++++++++---------------
> > 1 file changed, 82 insertions(+), 36 deletions(-)
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index f0e29d5c7b1f..f68853b3caa7 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
> >@@ -348,6 +348,62 @@ static bool pte_none_or_zero(pte_t pte)
> >       return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
> > }
> >
> >+/**
> >+ * collapse_max_ptes_none - Calculate maximum allowed none-page or zero=
-page
> >+ * PTEs for the given collapse operation.
> >+ * @cc: The collapse control struct
> >+ * @vma: The vma to check for userfaultfd
> >+ *
> >+ * Return: Maximum number of none-page or zero-page PTEs allowed for th=
e
> >+ * collapse operation.
> >+ */
> >+static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
> >+              struct vm_area_struct *vma)
> >+{
> >+      // If the vma is userfaultfd-armed, allow no none-page or zero-pa=
ge PTEs.
> >+      if (vma && userfaultfd_armed(vma))
> >+              return 0;
> >+      // for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
> >+      if (!cc->is_khugepaged)
> >+              return HPAGE_PMD_NR;
> >+      // For all other cases repect the user defined maximum.
> >+      return khugepaged_max_ptes_none;
>
> Nit: kernel code usually uses C-style comments. This could be:
>
> /* For all other cases, respect the user-defined maximum. */
>
> Also, s/repect/respect/.
>
> >+}
> >+
> >+/**
> >+ * collapse_max_ptes_shared - Calculate maximum allowed PTEs that map s=
hared
> >+ * anonymous pages for the given collapse operation.
> >+ * @cc: The collapse control struct
> >+ *
> >+ * Return: Maximum number of PTEs that map shared anonymous pages for t=
he
> >+ * collapse operation
> >+ */
> >+static unsigned int collapse_max_ptes_shared(struct collapse_control *c=
c)
> >+{
> >+      // for MADV_COLLAPSE, do not restrict the number of PTEs that map=
 shared
> >+      // anonymous pages.
>
> Ditto.
>
> >+      if (!cc->is_khugepaged)
> >+              return HPAGE_PMD_NR;
> >+      return khugepaged_max_ptes_shared;
> >+}
> >+
> >+/**
> >+ * collapse_max_ptes_swap - Calculate the maximum allowed non-present P=
TEs or the
> >+ * maximum allowed non-present pagecache entries for the given collapse=
 operation.
> >+ * @cc: The collapse control struct
> >+ *
> >+ * Return: Maximum number of non-present PTEs or the maximum allowed no=
n-present
> >+ * pagecache entries for the collapse operation.
> >+ */
> >+static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
> >+{
> >+      // for MADV_COLLAPSE, do not restrict the number PTEs entries or
> >+      // pagecache entries that are non-present.
>
> Same here.
>
> >+      if (!cc->is_khugepaged)
> >+              return HPAGE_PMD_NR;
> >+      return khugepaged_max_ptes_swap;
> >+}
> >+
> > int hugepage_madvise(struct vm_area_struct *vma,
> >                    vm_flags_t *vm_flags, int advice)
> > {
> >@@ -546,21 +602,19 @@ static enum scan_result __collapse_huge_page_isola=
te(struct vm_area_struct *vma,
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> >       enum scan_result result =3D SCAN_FAIL;
> >+      unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, vma);
> >+      unsigned int max_ptes_shared =3D collapse_max_ptes_shared(cc);
>
> Nit: could these be const, as David suggested earlier?
>
> Nothing else jumped out at me. LGTM!
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Ack on all the above thank you !

>

