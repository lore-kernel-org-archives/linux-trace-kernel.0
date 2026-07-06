Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0924501D;
	Mon,  6 Jul 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362865; cv=none; b=DZoO4sDKCgpDOcu3rNMc9VCGgUQV/34D65rep+3vxm+86HchGI5oWi50RRci6/YodAdngwjaS+OIEm4Tsw5xuRXy5l0atO2t1wPyr+PFOGOmdGFuUTkpUI3Mac92s7+NuZIIRcBwO4sN9MGbsIF/yw/FuKuD/mBsXLYkwrFZlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362865; c=relaxed/simple;
	bh=JbymgcRwLY0c/QHRCaQY4lGGhVW1kzAoFgEfHl7q910=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO3TP+9Z0blz+JJQ69kfEGetFE7raba3htBdFz3ZM92LAn9euJzXlapPE+kGTAHVVDY7/m7vidAEXzCLuWvIwmkRAW5Nkalb6MMYnIim7l5fBUIrddEo8Viuld/VBevizC3JlljMGppUgFW3VRqFE5heiF3Pt7I0/Y2wPxAGx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3lad+Vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3lad+Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB6C1F000E9;
	Mon,  6 Jul 2026 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362863;
	bh=vXyg4ZUkc4uNfSCtADLd0ATogR8529Lag5lnJjDA+r0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E3lad+VvgRlwue6CbHT8alWSu7Qf1xXpQvr8oSaM13Ba59bcYB0/60FFCOHbacizI
	 OzHPKaCc/zwGhxuFu8Yrsn7RX4FYJE1Rn4UC8xXTEBnsUxjzXY1tVvOyap4oYLaDYB
	 TlxI4WRjU5RdlDLKls5X7AzSGvbHRZM19xny+6eY1TqNpIH3pRn3yu9f6JmLWtQhvn
	 tLuowE8Udrws/gKBJnEJZ59oh4L6iDBeCBU2JYjpAyMnW9aX4S1St2upY5fvq40bJa
	 X7tnpmvYPGvPP92N5njqINYbfmJviNQbY6pPa7vKRgEUyCqeV8TdTr2VQJkFErOihT
	 KW5ekQHZPpqvA==
Message-ID: <ca549367-320d-494f-b47d-24d8c1ca9fa9@kernel.org>
Date: Mon, 6 Jul 2026 20:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] mm: use enum migrate_reason instead of int for
 migration reason parameters
To: Ye Liu <ye.liu@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260701061101.344679-1-ye.liu@linux.dev>
 <20260701061101.344679-4-ye.liu@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260701061101.344679-4-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/26 08:10, Ye Liu wrote:
> Replace all 'int reason' function parameters that carry migrate_reason
> values with the proper 'enum migrate_reason' type.  This makes the
> intent explicit and leverages compiler type checking.  The affected
> subsystems are:
> 
>   - page_owner: __folio_set_owner_migrate_reason(),
>                 folio_set_owner_migrate_reason()
>   - migrate: migrate_pages(), migrate_pages_sync(),
>              migrate_pages_batch(), migrate_folios_move(),
>              migrate_hugetlbs(), unmap_and_move_huge_page()
>   - hugetlb: move_hugetlb_state(), htlb_allow_alloc_fallback()
>   - trace: mm_migrate_pages and mm_migrate_pages_start events
> 
> The 'short last_migrate_reason' struct field and internal helper
> parameter in page_owner are intentionally left as 'short' since they
> store per-page metadata where size matters.
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <ye.liu@linux.dev>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  include/linux/hugetlb.h        |  9 +++++----
>  include/linux/migrate.h        |  6 ++++--
>  include/linux/page_owner.h     |  7 ++++---
>  include/trace/events/migrate.h |  8 ++++----
>  mm/hugetlb.c                   |  3 ++-
>  mm/migrate.c                   | 12 ++++++------
>  mm/page_owner.c                |  2 +-
>  7 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e9..fa828232dfcc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -154,7 +154,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
>  int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
>  void folio_putback_hugetlb(struct folio *folio);
> -void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
> +void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio,
> +			enum migrate_reason reason);

Two tabs indent, applies to all other cases in here as well.

Besides the "extern" Lorenzo mentioned, LGTM.

-- 
Cheers,

David
