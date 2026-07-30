Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A042F707
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417115; cv=pass; b=ofoFG4WuWl9TVe4ZOy7bThsueB0uXVTP2mVdD9ImPmQz1h4DmJFosxfZMOHfSXQAb5RRC+OJBz4bgb2gf2StyTFSaRhfVdCEWZApKJrSKwFS5NYbZ4ztKCgnIMbBqYFDzcU92xjMHbgBM2XuRHR4Vx+YJIGK1WQbOIBv1xPDkfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417115; c=relaxed/simple;
	bh=XHgYqQdbd6UXYLAfCM4eLJgkL7Zop9dsJ7MDxabavq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMOSVW2/kmR14Q7XAQs8qkMoVIcetp2KTXzkxwMoLNPqg9iqmMJVv0yu+ofuHWyIH3bV2C5mqtiHs+3NSa0///c+cauuNYzdqo7Gfi9IxwZLei7Zsg4e9i+4H20tabiXoX0xC7/uq6VZXBQiR+XW1gLYtgXQPPGMYyID40mBMxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loUHIMtl; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loUHIMtl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so20299005e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 06:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785417112; cv=none;
        d=google.com; s=arc-20260327;
        b=k2rcUvdq/QpTI1zmMOeekgAzgQrc64zFUXuSuZqwKDpQXZNiUQ+mUMJO1HwEXxJgy0
         9a1J6+DLjlpna/HDCI2NbsS55CpbvjvlWkCmPXSUIB+mqXEjwuVoYC/PiPMZxEfxg6nY
         uRbEQyA4UJkqbxMAtPifB4JOoThWFOk6vQttY3ZYC0o1u4V4HNMSrCYdzysu0OUWD5Ql
         Wc128dbqYVIq1NkWuppfE5n8AAh3zY+jdfFpYbCv+REl+k7GIKy4cajJbBSOS1VzsNRz
         BUtETQ27W1jHy9O0kPMUNReb9jpgsW1eH62iJV07SAEz9Ub1CrKcBG5avLQQj7RZ7Goz
         OAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZxWQFrq5yQB1yLfY/DlKbs1Vg/HpnWd2qZlXhsqsB4=;
        fh=XlyUx89AgnSqghEci0aHidtsXSekm5CGLVi4h1iZ9bs=;
        b=chjl+J8el4zKo5Pt97otmJ/06OYZdhq67qwz6agbjvosaFWMSvEUNRcd0oofCNsz4U
         o092paxenovEOW/w0w+bwKIEsbnaCV2mpPrJywm5ZKocaPoFDXpIsp1acQM5m9VQ27Jj
         ibKM87s/LeFaCARja2rqRC+hzAmSXb6TJkyfuNyQ9EfYryZqZi6IR7vdNtlqa4dRC5IF
         MFUaoWWPETHJ3AypKbJ28/Qb7n6svbe2jupdviFRrPbaf7xLGQVzutWDOKjsUt5adgvX
         EbZguZwKq3Nuk9brv+ZdE7GVEi1ish9GUggc++xd6x9Qg2qI6aYB6yw2y6Nxgl/TPdkZ
         eMgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785417112; x=1786021912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JZxWQFrq5yQB1yLfY/DlKbs1Vg/HpnWd2qZlXhsqsB4=;
        b=loUHIMtl+zQI1xPUlk7eEZeGWKbzEBToj3bbihMtFfaZijsztsPEXcVo/SCxH8VSkC
         3nzdrgBq2PuKAr9/+IJjBjRDG7B58pxYe0JuRKh5EjK/DblzLvZZ3wzLHZjtQGEiBFVj
         4FEoN6FRNE6xKg7WAJM8RyTx6CFc/LKlaaHpjl1kqgqQDy3Si+5W05w9QTrtVZZTBApx
         jZt7l6Z1U7/U1Kqmvj17RdiSBmY4ctECm91m01sSy2hmGsZTRWuiosrqO7uK8j4pfCdH
         wirMkfvQl0bUZOUpCW5ZIbFAqL7gpPoC8MmVtsE8cUrK+3miJlM3mYl6sGOKBJsJQ+ln
         0yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417112; x=1786021912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZxWQFrq5yQB1yLfY/DlKbs1Vg/HpnWd2qZlXhsqsB4=;
        b=W2/94e/DnuJ0HZ6WSKJ3Q6fq+pyJpdjCOpwUXC8JxIOdV/UW+jQjUUwuRxEdtGkca1
         0hPjJagkExzVyYwJYZ2LBv5nKssGZ5h7bkA/jvyLA//XjmNnjgm9aE1wEMIfoLCrFn01
         d9ts42qGUCnNPdXWZ5jXOvijW1gYXXknRLSGiMOOXp0n49mD6JV/7GRMGhwrxu6+HuFQ
         h+eAD0cSS/ZgKXcnsD/e/i6xdAbpRbgQAEosuNdV8pfhHbKHXhVqhIktgMtkV9dStq7i
         5VaGoXxtXBlWDJPLXCbKQG8MlwR7toQYxdx+hLy6tCjPd5jhkrGBg47KfhcXL+pyL2/F
         bjUA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7rK1ShkbQ06gmi3Z+w1+T1V0IZd8gvq8wwJR6yXy7+LSvOGFRvvvqGMg5radjYt1otbkN93lforLUq62aJ4/mtBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGf1iuV7vIPbEG3M99ZXFzw5KMIsF9X/uJ/kJADiGvanSAILnI
	neS4ZGZh73bsMP0GIRjUG9Mn323+quaYE9ECoFMac0CiMGZWMZ8DUqA0JhlmRFXuKNUeSKzKpIS
	pQQcB4uZXYoGs56s6TvQUOjfNNMRKpOM=
X-Gm-Gg: AR+sD11B7qMhC5qX3l5aK4KkTL7lLwz+xLuU7ACaOQTMUmcCXcX+bW3nzL0IHPQ9VGR
	b7Nk5YzhBw7pBMlcQFE0Fh9jFN8a96VNYIDuBm68y8+xJJC6kCU/fYVlaqxRz9tFHbUyiVIMceZ
	JwGPI5LnT5N9sCeOc5wq6ZtsLDzY6cvkssUYiSbcQiorIDiYoePl9ycN32DhNmCMzmqMOBRQLt5
	iUoAt8tT9OjGpMbtFKTaZWChZbWtBRP6S3SyZAZdUbppGh8sN5I+PegsuWdRrL1eHhc2Fv72bkD
	DzJIdXBLbuCK1BiOiaAbsUwEBZkL/J/1JepEjZoFq2/0
X-Received: by 2002:a05:600c:8707:b0:493:c182:6b08 with SMTP id
 5b1f17b1804b1-49800ed12f2mr35808775e9.36.1785417111834; Thu, 30 Jul 2026
 06:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
 <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com> <ahW7gwgaF0zIPTAz@gourry-fedora-PF4VCD3F>
In-Reply-To: <ahW7gwgaF0zIPTAz@gourry-fedora-PF4VCD3F>
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Thu, 30 Jul 2026 16:11:38 +0300
X-Gm-Features: AUfX_mwGq9AjTR5NxgyxAqgBeEwNx--Sq9pL4ych9I9IxB6UA5FR819gtzB2mWI
Message-ID: <CAOi6=wQ7CxHf8QMFXm5oyHZFc9n6BQecL45rBud=hMubmayCnA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mm: use non-temporal stores for demotion
To: Gregory Price <gourry@gourry.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
	Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, Raghavendra K T <rkodsara@amd.com>, 
	"Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>, 
	Xuezheng Chu <xuezhengchu@huawei.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alirad Malek <alirad.malek@zptcorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:25=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Tue, May 26, 2026 at 01:37:04PM +0200, Yiannis Nikolakopoulos wrote:
> > From: Alirad Malek <alirad.malek@zptcorp.com>
> >
> > Memory demoted to a lower tier is assumed to be cold and most likely ou=
t of
> > the CPU's last level cache. Additionally, in certain demotion targets (=
e.g.
> > CXL devices with compressed memory) the bandwidth can be negatively
> > impacted by the eviction patterns of the last level cache when standard
> > memcpy is used. When the feature is enabled, use the
> > MIGRATE_ASYNC_NON_TEMPORAL_STORES flag in demotions to trigger the foli=
o
> > copy path using non-temporal stores.
> >
> > Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
> > Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> > Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> > ---
> >  mm/Kconfig   | 8 ++++++++
> >  mm/migrate.c | 9 ++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ebd8ea353687..4b7a75b57f6e 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -645,6 +645,14 @@ config MIGRATION
> >         pages as migration can relocate pages to satisfy a huge page
> >         allocation instead of reclaiming.
> >
> > +config DEMOTION_WITH_NON_TEMPORAL_STORES
> > +     bool "Use non-temporal stores for demotion"
> > +     default n
> > +     depends on MIGRATION
> > +     help
> > +       Enable non-temporal stores when migrating pages due to demotion=
.
> > +       If disabled, demotion uses regular migration copy paths.
> > +
>
> Do we actually need this config flag or should we just default to this
> (if the arch supports NT stores)?
As discussed in the sync call, I was just being defensive :).
In fact the non-temporal instructions should be in all x86_64 afaict.
So I've removed this in the next version (landing soon).

/Yiannis
>
> >  config DEVICE_MIGRATION
> >       def_bool MIGRATION && ZONE_DEVICE
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index ff6cf50e7b0b..368d40dc8772 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -862,7 +862,10 @@ static int __migrate_folio(struct address_space *m=
apping, struct folio *dst,
> >       if (folio_ref_count(src) !=3D expected_count)
> >               return -EAGAIN;
> >
> > -     rc =3D folio_mc_copy(dst, src);
> > +     if (mode =3D=3D MIGRATE_ASYNC_NON_TEMPORAL_STORES)
> > +             rc =3D folio_mc_copy_nt(dst, src);
> > +     else
> > +             rc =3D folio_mc_copy(dst, src);
> >       if (unlikely(rc))
> >               return rc;
> >
> > @@ -2081,6 +2084,10 @@ int migrate_pages(struct list_head *from, new_fo=
lio_t get_new_folio,
> >       LIST_HEAD(split_folios);
> >       struct migrate_pages_stats stats;
> >
> > +     if (IS_ENABLED(CONFIG_DEMOTION_WITH_NON_TEMPORAL_STORES) &&
> > +             reason =3D=3D MR_DEMOTION && mode =3D=3D MIGRATE_ASYNC)
> > +             mode =3D MIGRATE_ASYNC_NON_TEMPORAL_STORES;
> > +
> >       trace_mm_migrate_pages_start(mode, reason);
> >
> >       memset(&stats, 0, sizeof(stats));
> >
> > --
> > 2.43.0
> >
