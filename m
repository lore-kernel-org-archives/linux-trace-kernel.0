Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7F3B47F5;
	Mon,  8 Jun 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928164; cv=none; b=bkV3I3C55szyqsG//V6YttbDo49h29m0XAXKPe4VGdjw7tdEPlngv1LoQ+H7lWmjgD8tVMTU00CX4t1fr8yw+DMNxWud1+AMVEuLMRJ5fwBJy2jEcfVXPavI4wNgiZvncSUIYJ/0Oqrl89dnCP3hIqZSmTZYk2x37/UQwFLgOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928164; c=relaxed/simple;
	bh=pt96TZWEliQKGg6Bis/dp/4XN7B5sL3aYQDr1GdD0Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6TliYCM+Xdq1w1uosRuYJFt/bXlhACr2GLCTLpd+c+yjOB7m51wkkxwi4rbSlFKJ015JdgY+u5oHQ1RNZr2OaEXXRrFxwHMpwoUOLVqWD36KE5NxRlSSV1eDK1wkIQEWdda8DO9WLtEsb4iig1mZEPJnZMwRPmjxN6hPAbVHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a6tRNfOm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a6tRNfOm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BoptLYrQ/yGEg1kcudHiCfX9+RB6G6nAL273PX8CPRc=; b=a6tRNfOmAflmUrPXXCxKRgWVru
	iNPc/WKDKmTh/dwpZxhTjUQw7yU0VkULPq7LRnfMgRO1+ytdZGjyX9Kieq5r25zoaET0BSP17OF8u
	dBmTPnOWf/2MK+5f3L5mkHsvLWa4ATBctZwb267FWUCoU33MZzXgJy5D1bnuFkCSRzzHLaSrBtVin
	DxtQeWnFL5GfOYbObu+dCu+s8JhX5MtJDcpk68rYjVzKeT4LCzWJpZ6DaOhnUsvUFfCXVqS84juWV
	3xav5eB+GMchWt48uXiSx4JJ02Yn6c1b+wXGSccYNFe2ob5a9AZru2f1wKewsycQOzTHXlv2EJRk8
	ERPucmkg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWalX-007gH8-2v;
	Mon, 08 Jun 2026 14:15:48 +0000
Date: Mon, 8 Jun 2026 07:15:40 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <aibN4osY_QF1Rejh@gmail.com>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
 <19f968f5-1289-f573-4406-e5c91dcd8923@huawei.com>
 <e3d023f1-ab6e-4424-b304-55f1294480c3@kernel.org>
 <33ef8821-c809-b7d1-ea77-6e8a07a6e784@huawei.com>
 <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
 <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
 <aiKXrovzrNN-gExm@gmail.com>
 <f1a742be-80cb-4256-b1f9-e50a0f83cb15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a742be-80cb-4256-b1f9-e50a0f83cb15@kernel.org>
X-Debian-User: leitao

On Fri, Jun 05, 2026 at 11:42:53AM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 11:35, Breno Leitao wrote:
> > On Wed, Jun 03, 2026 at 10:33:04AM +0800, Miaohe Lin wrote:
> >> On 2026/6/2 17:41, David Hildenbrand (Arm) wrote:
> >>>
> >>> Races are fine. We might miss some pages, but that can happen on races either way.
> >>>
> >>>
> >>> I'd just do something like
> >>>
> >>> if (PageReserved(page))
> >>> 	return true;
> >>>
> >>> head = compound_head(page);
> >>
> >> If @head is split just after compound_head. And then @head is freed into buddy and re-allocated as slab
> >> page while @page is still in the buddy. We would panic on this scene as @head is PageSlab. But we were
> >> supposed to successfully handle @page. Or am I miss something?
> > 
> > You're right that it is racy, but I think it is an acceptable race here.
> > 
> 
> I mean, any such races can currently already happen one way or the other?
> 
> Really, the only way to not get races is to tryget the (compound)page,
> revalidate that the page is still part of the compound page.
> 
> I'm not sure if that's really a good idea.
> 
> But my memory is a bit vague in which scenarios we already hold a page reference
> here to prevent any concurrent freeing?

No, we don't hold one here in the case that matters.

HWPoisonKernelOwned() runs at the very top of get_any_page(), before
try_again: and before __get_hwpoison_page(). The first refcount taken in
the whole path is the folio_try_get() inside __get_hwpoison_page(), which
runs *after* the short-circuit.

So get_any_page() itself never holds a reference at the check -- the only way
one exists is if the caller passed MF_COUNT_INCREASED (count_increased ==
true).

So on the MCE/GHES path -- the one this panic option exists for -- no
reference is held when HWPoisonKernelOwned() does its compound_head() +
PageSlab()/PageTable()/PageLargeKmalloc() checks.

Given that, I'd rather keep it racy and take no refcount than add a
tryget + revalidate purely for this check. As I've said earleir, an operator
who enabled it has chosen to crash rather than run on corrupted memory;
mis-attributing one such rare, genuinely-poisoned page is within that contract.
