Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CF2D7DEA;
	Wed, 13 May 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703037; cv=none; b=Vt+al0QMMtKJSJ6bePb0wiiazhzFYFMX5p3pgLZRsnyOoTpHSuEIREeZwKY/RHwcrk6MUJtwcjPXVG2BOUQ0c8Bz0eYFcoyQ7BgU+Ff7Br2AHDGOLdZVUkLyQ/n3AfqiWvZIVrK2UHmB4pO3P1tt2sQGuf+K4evnKUwJX1IMzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703037; c=relaxed/simple;
	bh=Ev9k3KiPdRHS9B+BjW0upluVxxYhTSv2oMebgkf2ShA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNrDDHzBNCQr/C+BhLE+l6+eLec7JjxB0lBqCzcTWwZARGhJIYy3IhWgf8mqurYFGILPxN6pczinFO27O8nLoAxkrClC0YR6tXBZ6AMxTYjfBoljHaH6JOCaIKhOqU7Gqpqpa59HwNrVqA01vsM+YmQx8f6y8HoidxquDs5Igdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGkHuXDR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGkHuXDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D228FC2BCB7;
	Wed, 13 May 2026 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703037;
	bh=Ev9k3KiPdRHS9B+BjW0upluVxxYhTSv2oMebgkf2ShA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGkHuXDRaCCU0nxxAGDBnblzSQhRReUx8USwaVA4cvDWXfAWRJpj0D8zQ7E51S0FJ
	 e6g8K2kvYVF5vIGWc+rZN2qdyA/Rd+zRQwumJWggxdG7DyPFiF5hArQdO+2mn8/jEV
	 sto0NYy8btd7x9JTg1K3aon0WvP431UqSg4CG8zlzefdF25D6wx0rYcyLvqBohNReD
	 vwzEaWe2IITv4KV/YxDWpkPDlj9SLQLYFnNsw8Db3Evl7pmEWPVvwFlspehx4+84hJ
	 olL/EQFbF3OPJdclgiGsF2k4/KRiFdBeNYL6cZ+Zz/fAgY+Q5d1eW6bgqP3ODAN0rY
	 7LULys9D6hHng==
Message-ID: <5712adbc-b2fd-49fd-9827-cace47eff9ad@kernel.org>
Date: Wed, 13 May 2026 22:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
To: Breno Leitao <leitao@debian.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
 <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 17:39, Breno Leitao wrote:
> The first entry of error_states[],
> 
> 	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
> 
> is unreachable.  identify_page_state() has two callers, and neither
> one can dispatch a PG_reserved page to me_kernel():
> 
>   * memory_failure() reaches identify_page_state() only after
>     get_hwpoison_page() returned 1.  get_any_page() reaches that
>     return only via __get_hwpoison_page(), which gates the refcount
>     on HWPoisonHandlable().  HWPoisonHandlable() rejects PG_reserved
>     pages, so they fail with -EBUSY/-EIO long before
>     identify_page_state() runs.

You should clarify why they are rejected. There is no explicit check for
PG_reserved in there!

> 
>   * try_memory_failure_hugetlb() reaches identify_page_state() on
>     the MF_HUGETLB_IN_USED branch, but the page is necessarily a
>     hugetlb folio there.  The first table entry that matches a
>     hugetlb folio is { head, head, MF_MSG_HUGE, me_huge_page }, so
>     they dispatch to me_huge_page() before the (now-removed)
>     reserved entry would have matched, regardless of whether
>     PG_reserved happens to be set on the head page.

See hugetlb_folio_init_vmemmap(): we always clear PG_reserved for hugetlb folios
allocated from memblock.

> 
> me_kernel() never executes and the entry exists only to be matched
> against by code that cannot see it.
> 
> Drop the entry, the me_kernel() helper, and the now-unused
> "reserved" macro.  Leave the MF_MSG_KERNEL enum value in place: it
> remains part of the tracepoint and pr_err() string tables, and
> follow-on work to classify unrecoverable kernel pages can reuse it
> without churning the user-visible enum.
> 
> No functional change.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memory-failure.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 866c4428ac7ef..49bcfbd04d213 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -992,17 +992,6 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
>  	return false;
>  }
>  
> -/*
> - * Error hit kernel page.
> - * Do nothing, try to be lucky and not touch this instead. For a few cases we
> - * could be more sophisticated.
> - */
> -static int me_kernel(struct page_state *ps, struct page *p)
> -{
> -	unlock_page(p);
> -	return MF_IGNORED;
> -}
> -
>  /*
>   * Page in unknown state. Do nothing.
>   * This is a catch-all in case we fail to make sense of the page state.
> @@ -1211,10 +1200,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  #define mlock		(1UL << PG_mlocked)
>  #define lru		(1UL << PG_lru)
>  #define head		(1UL << PG_head)
> -#define reserved	(1UL << PG_reserved)
>  
>  static struct page_state error_states[] = {
> -	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
>  	/*
>  	 * free pages are specially detected outside this table:
>  	 * PG_buddy pages only make a small fraction of all free pages.
> @@ -1246,7 +1233,6 @@ static struct page_state error_states[] = {
>  #undef mlock
>  #undef lru
>  #undef head
> -#undef reserved
>  
>  static void update_per_node_mf_stats(unsigned long pfn,
>  				     enum mf_result result)
> 

Yes, I think this should work.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
