Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63D29DB64;
	Mon, 14 Sep 2026 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354083; cv=none; b=kMKGuD2ySnvc5Wzjw69j0Kfr8Br0/V540iGQ5pksqiB//M9Qyk2IN0NPLnqAGVcsmJRZ36LHlNVbTCQzicM+eGOXgbN6DF4M/1zxD1Ai1bFusq4q/fyO9ziZrJLz7pmd/z/6rFTeJkbPa6IH4298eCJ9AgohNCg56ykBPtWwsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354083; c=relaxed/simple;
	bh=IAJ6fPDFQagSBdd1b89WAP4SrwNCphxleFJBLrYbSl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cAsT7/DyKM/aAUXOVKaYyjobPjp/CtBPTuY0yXewzNbvXOQ/HiEvAtqYqRKfFIgaXBdMOqz2S0yKG2QStpXSxqlvHFzxVFt0+nICAB2CCGw3U+bQyzr+Ncnajbh7IQH+B3MAaBORlhDac3QhV5llVlbJ2JrxeUGRFfa6wrmyRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUYWUEkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUYWUEkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EF1F000FF;
	Mon, 14 Sep 2026 02:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789354081;
	bh=AXLI3k9/pMTK/BtsjTVMEyDksi2gFy8I9idpjBEt+8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUYWUEkwRAc/MPD1E8wD6u4bTIsbzSq0kvntl9FVDaEATIYAy4I4sIHXFRhg9t4Yz
	 04T63Uk3AKoDRg5NkaKSEjHUhOI2lbC8ikAkEKvl4oLWjLlij9tg1sMybkHau92g4w
	 i3lIV7y5nDKFszslBx9YR0befexyZn9Vr1fRxtdL1d8YPb2I927c60O5OWDxlgwQWC
	 iLso1LRAbVRq0e23KFOTaH+/kqOtLqBi3rSyUQuZVP+dNpzy+Hg3aD3BwD7OI5jIoU
	 CW38fNAoU1X6qNgr88GSJx29l8IxFbmBXdbF6TD/ns1HI3wJQltPrXO1+RIlLwDk4I
	 VHxM1iKtfDtGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] mm/page-flags: remove PG_private
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Zheng" <qi.zheng@linux.dev>, "Lorenzo Stoakes" <ljs@kernel.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Kairui
 Song" <kasong@tencent.com>, "Alistair Popple" <apopple@nvidia.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Gregory Price" <gourry@gourry.net>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "David Hildenbrand" <david@kernel.org>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Dev
 Jain" <dev.jain@arm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Michal Hocko" <mhocko@suse.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Zi
 Yan" <ziy@nvidia.com>, "Muchun Song" <muchun.song@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Barry Song" <baohua@kernel.org>, "Nico Pache" <nico.pache@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Jan Kara" <jack@suse.cz>, "Baoquan
 He" <baoquan.he@linux.dev>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Masami
 Hiramatsu" <mhiramat@kernel.org>, linux-fsdevel@vger.kernel.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Dave Young" <ruirui.yang@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260913-remove-pg_private-v4-16-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-16-848550f7574e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:47:59 +0000
Message-Id: <20260914024800.087EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent memory leak of folio private data due to missing check for =
leaked `folio->private` data when a head page is freed.
--

commit ebe4dd474a496c46897e3f790e03a43cc0508eaf
Author: Zi Yan <ziy@nvidia.com>

mm/page-flags: remove PG_private

folio->private !=3D NULL indicates a folio carries private data, replacing
PG_private. All PG_private users are converted. Remove PG_private and
reserve the space as PG_folio for future use. Unused PG_private functions
are removed too.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 08988877331ba..10f4ad075ea48 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h

[ ... ]

> @@ -105,7 +101,7 @@ enum pageflags {
>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>  	PG_arch_1,
>  	PG_reserved,
> -	PG_private,		/* If pagecache, has fs-private data */
> +	PG_folio,		/* Do not use: reserved for folio identification */

[Severity: High]
With the removal of PG_private, does the free path for head pages fail to
validate whether private data is leaked?

Previously, the memory management subsystem checked for PG_private during p=
age
freeing (via PAGE_FLAGS_CHECK_AT_FREE) to catch filesystem leaks, and issue=
d a
bad_page() warning if it was still set.=20

While tail pages are explicitly checked for leaked private data in the free
path:

	if (tail_page->private) {
		bad_page(tail_page, "nonzero private");
		...

The head page's private field appears to be unconditionally zeroed without
validation in __free_pages_prepare() in mm/page_alloc.c:

	page_cpupid_reset_last(page);
	page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
	page->private =3D 0;
	reset_page_owner(page, order);

Can this silently mask bugs where filesystems leak private data (like an
un-detached buffer_head)? Should we add a check for page->private !=3D NULL
for head pages before unconditionally zeroing it?

>  	PG_private_2,		/* If pagecache, has fs aux data */
>  	PG_reclaim,		/* To be reclaimed asap */
>  	PG_swapbacked,		/* Page is backed by RAM/swap */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-remove-pg_=
private-v4-0-848550f7574e@nvidia.com?part=3D16
