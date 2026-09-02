Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C94AA59E;
	Wed,  2 Sep 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369814; cv=none; b=VAz/cql547sFTttoAARWmgRdLgss71+FB6mqYgwLwB1cmu9u5xyOttv1krTTfoQMUQohZVZnXcGL+kFZTaLq6W+FJ9TZxptQIq7ZzgS4zvfZtpKtFjeT4e5WnKjt4IKz4vxOFHBcxRhJSVFNYydOATKDeOgVYOb/rGu/Jc9vY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369814; c=relaxed/simple;
	bh=YVgUIxC4qvnn0Vv9lVwgjAu8cVfniffOqE/RSreBVFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAQ/idqwNPrubeneWBrD6UwrhX4FzJ+FG8CLbd3DMs0VyHSSDpI8oQblZ30lZ0DxA7gbvzN6qy5JZ7I5P7FAWW2g1E8haHR8PQezg8x6DBY8GWO8D3kaXQ2UC6+Nx+F00fp7wdhneTMB2iqxG09qVYfrTj0C/kpt8fCQEtgVDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ/e64IL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ/e64IL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B05C1F00A3A;
	Wed,  2 Sep 2026 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369812;
	bh=XmNQ6WKBMzr8oIBSZDnJlW7h+ZrhoZOuFj83Jzmbsfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQ/e64ILDN1pnMgED8ssh6q9/0rLdHgxDHqnOBlzw92WYCiWJaT5cTvF+TPGYNpsX
	 MX3S60psaFTPn+grPZ3LvrWhFEpGNfvppk5aC/ydk2gk7hv3FHidWSHch5Tghbqtnt
	 BLiitH1a1HWIYSaP7P14oDJzjpjM2XT6PYZw4KxZrFOErwOxMcfQxwIQk56lhejnjk
	 qv0z3nBoKeZH/L4lNhlM/6jirLe1WCUqP2JogwSOPRgGzo3aYZq8Nas0eyO455mxcs
	 jJv1M6Zjvwe/9CiiQzd8B8PuXrz3OsZgV0HQNShSz7a8MGhj6HQElRLPKoLifUjQH1
	 rGVz9fCVKnzcQ==
Date: Wed, 2 Sep 2026 20:23:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
Message-ID: <aphbiuSzIrM6vhJt@kernel.org>
References: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>

Hi Ard,

On Sat, Aug 22, 2026 at 03:53:22PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The arm64 module loader has to deal with a couple of corner cases that
> may occur when .init.text is placed out of direct branch range of .text:
> 
> - ordinary direct branches from .init.text into .text may require the
>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>   only that additional PLT entries need to be allocated for
>   cross-section calls, but also that .init.text needs its own PLT
>   reservation, as the one in .text will be out of range as well;
> 
> - dynamic patching of the ftrace handler into .init.text code needs its
>   own dedicated trampoline as the one in .text may be too far away.
> 
> - recent compilers may omit BTI veneers for static functions that never
>   have their address taken, and so additional veneers will need to be
>   added to .text in case cross-section direct branches from .init.text 
>   require a PLT entry (and therefore a landing pad at the target end).
> 
> This is unfortunate, because it is actually somewhat unusual for .text
> and .init.text to be so far away from each other: only when allocating
> either of them (but not both) exhausts the 'near' (PLT-less) module
> region, the other will be allocated from the spillover region, which is
> not in direct branching range, and therefore requires PLT entries for
> cross-section calls.
> 
> This series addresses this wart by allocating both of them as a single
> chunk, and freeing the .init.text part along with the other init
> sections at the appropriate time. This ensures that the two regions will
> never require veneers for cross-section calls, allowing the arm64 module
> loader to be simplified.
> 
> Ard Biesheuvel (9):
>   mm: execmem: Add API to split an existing execmem cache allocation
>   mm: execmem: Allow huge vmappings to be avoided for execmem caches
>   module: Place MOD_TEXT before MOD_INIT_TEXT in enumeration
>   module: Allocate MOD_INIT_TEXT from the MOD_TEXT ROX allocation
>   arm64: mm: Permit permissions changes on huge vmappings
>   arm64: Enable the execmem ROX cache for module text
>   arm64: ftrace: Revert "fix unreachable PLT for ftrace_caller ..."
>   arm64: module: Combine init and core PLT entries again
>   arm64: ftrace: Simplify PLT handling

I can't say I like the idea of tying the single chunk allocation of
modules .text and .init.text to the ROX cache.

The goal of the cache is to have executable code mapped at higher page
table levels. Letting it use base-page mappings completely dismisses it.

I'm not against having execmem_split() or something along these lines, but
it should work without the ROX cache as well.

Another question I had is did you consider splitting the area on free
rather than on alloc?

In this case it could be execmem_shrink() that immediately frees the
.init.text part.
 
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/module.h     |  2 -
>  arch/arm64/include/asm/module.lds.h |  3 -
>  arch/arm64/kernel/ftrace.c          | 13 +---
>  arch/arm64/kernel/module-plts.c     | 63 +++++---------------
>  arch/arm64/kernel/module.c          | 20 +------
>  arch/arm64/mm/init.c                | 19 +++++-
>  arch/arm64/mm/pageattr.c            | 13 +++-
>  include/linux/execmem.h             | 11 ++++
>  include/linux/module.h              |  4 +-
>  kernel/module/main.c                | 22 +++++--
>  mm/execmem.c                        | 47 ++++++++++++++-
>  12 files changed, 124 insertions(+), 94 deletions(-)
> 
> -- 
> 2.55.0.860.g4b6b3295ed-goog
> 

-- 
Sincerely yours,
Mike.
