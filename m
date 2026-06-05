Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D89364943;
	Fri,  5 Jun 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683656; cv=none; b=CF9I/kwi5h68YyeOmdehSR+cpdaSXnBL6zzVRjZRarqI2dppRSEr51m4adHACacPjGiwuEe/LxSGYN/u/VMzD4aQLNocV5vGrtGIxYABjemMglZLtWA0edQqtP5ZkpEBABkWjsK8Y9kgkXuqjZxK/MlKcE58l9oA2mtZEHcGIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683656; c=relaxed/simple;
	bh=8MwjOW3aZfQ2HC6b4nVOV0ubMj3kgzdNsqYnQbYJ32I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJjPfUpDPmHRqw4hbQJG/dX2vzmR1xunkt0SdD9wRMG6N5ZbDd3ypY/+yuGzJKxx6VVxnyWaaPaGfRiJiozelvCAvsu6a0IOekbFjIBbo9Y6Wq22rTQDS6T8o8q+Sd+UWn6WasWRb+3wMFfgiSdTiTD07N6xXDmJ4wUihC7Bfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6j2xosM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6j2xosM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5771F00893;
	Fri,  5 Jun 2026 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780683654;
	bh=r+zVvdL1dXafGmhtKQIc5JAjS1cg9OS8KCtGRJH3gyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G6j2xosM+nK/vGyDuiWC5HPu28msvGJihCctYNYSbrCCHx1W1zU91cb6B/2sv+Iyj
	 3MooWXDSODBUEZz/OdfZz0wBnlFUcrGt4t85nSG9XiYqnNUvrDFsEGLTjZqXicf8e6
	 pbE1JeALaahtaOQEIowFTXyapGPdBr01DWTmU93N4gI/NpqxbRdLHCoTHKJyraRWsY
	 +Uh+y7hIFgMLZub0+5lnSjn5InOrwj/Ho3bUI1zqkQgGoZx+o2qCDusTxCt6ZCdp7F
	 jFt8tLKKLB72G2kraakYZOgYrx8jslacyh/sJuoKirFoV2UhxyAfMKvizJhkvNdPZC
	 eRe0tKBIY0Irw==
Date: Fri, 5 Jun 2026 19:20:39 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH mm-unstable v19 14/14] Documentation: mm: update the
 admin guide for mTHP collapse
Message-ID: <aiMTFl2vvns1_dn3@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-15-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605161422.213817-15-npache@redhat.com>

On Fri, Jun 05, 2026 at 10:14:21AM -0600, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidance on how to utilize it.
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

This is completely fine, and no blockers, but just a couple tiny things
below Claude brought up for a possible trivial follow up.

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 49 ++++++++++++++--------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index b98e18c80185..23f8d13c2629 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,8 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages of either PMD size
> +or mTHP sizes, if the system is configured to do so.
>
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -219,10 +220,10 @@ this behaviour by writing 0 to shrink_underused, and enable it by writing
>  	echo 0 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>  	echo 1 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>
> -khugepaged will be automatically started when PMD-sized THP is enabled
> +khugepaged will be automatically started when any THP size is enabled
>  (either of the per-size anon control or the top-level control are set
>  to "always" or "madvise"), and it'll be automatically shutdown when
> -PMD-sized THP is disabled (when both the per-size anon control and the
> +all THP sizes are disabled (when both the per-size anon control and the
>  top-level control are "never")

Claude was very pedantic and said we need a full stop here :P

This is not a blocker, obviously...!

>
>  process THP controls
> @@ -265,8 +266,8 @@ Khugepaged controls
>  -------------------
>
>  .. note::
> -   khugepaged currently only searches for opportunities to collapse to
> -   PMD-sized THP and no attempt is made to collapse to other THP
> +   khugepaged currently only searches for opportunities to collapse file/shmem
> +   to PMD-sized THP. Only anonymous memory will attempt to collapse to other THP
>     sizes.
>
>  khugepaged runs usually at low frequency so while one may not want to
> @@ -296,11 +297,11 @@ allocation failure to throttle the next allocation attempt::
>  The khugepaged progress can be seen in the number of pages collapsed (note
>  that this counter may not be an exact count of the number of pages
>  collapsed, since "collapsed" could mean multiple things: (1) A PTE mapping
> -being replaced by a PMD mapping, or (2) All 4K physical pages replaced by
> -one 2M hugepage. Each may happen independently, or together, depending on
> -the type of memory and the failures that occur. As such, this value should
> -be interpreted roughly as a sign of progress, and counters in /proc/vmstat
> -consulted for more accurate accounting)::
> +being replaced by a PMD mapping, or (2) physical pages replaced by one
> +hugepage of various sizes (PMD-sized or mTHP). Each may happen independently,
> +or together, depending on the type of memory and the failures that occur.
> +As such, this value should be interpreted roughly as a sign of progress,
> +and counters in /proc/vmstat consulted for more accurate accounting)::

So Claude said maybe it's worth mentioning that the per-mTHP counters are only
actually exposed through
/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats/ and maybe worth
mentioning here too?

>
>  	/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed
>
> @@ -308,16 +309,21 @@ for each pass::
>
>  	/sys/kernel/mm/transparent_hugepage/khugepaged/full_scans
>
> -``max_ptes_none`` specifies how many extra small pages (that are
> -not already mapped) can be allocated when collapsing a group
> -of small pages into one large page::
> +``max_ptes_none`` specifies how many empty (none/zero) pages are allowed
> +when collapsing a group of small pages into one large page::
>
>  	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>
> -A higher value leads to use additional memory for programs.
> -A lower value leads to gain less thp performance. Value of
> -max_ptes_none can waste cpu time very little, you can
> -ignore it.
> +For PMD-sized THP collapse, this directly limits the number of empty pages
> +allowed in the 2MB region.
> +
> +For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. At
> +HPAGE_PMD_NR - 1, we collapse to the highest possible order. Any intermediate
> +value will emit a warning and mTHP collapse will default to max_ptes_none=0.
> +
> +A higher value allows more empty pages, potentially leading to more memory
> +usage but better THP performance. A lower value is more conservative and
> +may result in fewer THP collapses.
>
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -337,6 +343,15 @@ that THP is shared. Exceeding the number would block the collapse::
>
>  A higher value may increase memory footprint for some workloads.
>
> +.. note::
> +   For mTHP collapse, khugepaged does not support collapsing regions that
> +   contain shared or swapped out pages, as this could lead to continuous
> +   promotion to higher orders. The collapse will fail if any shared or
> +   swapped PTEs are encountered during the scan.
> +
> +   Currently, madvise_collapse only supports collapsing to PMD-sized THPs
> +   and does not attempt mTHP collapses.
> +
>  Boot parameters
>  ===============
>
> --
> 2.54.0
>

Cheers, Lorenzo
