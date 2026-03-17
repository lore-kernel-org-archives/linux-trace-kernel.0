Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D83346E7E;
	Tue, 17 Mar 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745340; cv=none; b=t0FG5gRaQOuDh8V7tkFqgLA26dJ/6IZzSYIOwoFi9dioXRdjy1jlLyKKLTyvgDh0Z4PpwYrk/H+WqDe5EWB8owH/vHEQ4mkoB5FXpAJHHv8wxOzQW6hJKTFWSZzw25gvVOLHCIKM9Hg46yvShfAoZWSQYtmtdRwsk1lNBkuQ23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745340; c=relaxed/simple;
	bh=7pNtVaYk9Ht11PmZVgXbirYPaKxs9q7pW4hlidbNWtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw5HPmgN12z0KxyL6gLaVWARaMcVbHRY8cgmItTmygqdfv+xUQJOwcX7twVgZXBAPEzKuivgFqkKmyYFonnEdFZZgXqtaBEu8pqKgmTF20R1NH0MZlnSIiaaN+Nomm605n6twyI+GKeOTMEjtMqfA+nU37/ChB3JWpoy1iiSuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmzXuF4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmzXuF4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F7CC4CEF7;
	Tue, 17 Mar 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745340;
	bh=7pNtVaYk9Ht11PmZVgXbirYPaKxs9q7pW4hlidbNWtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmzXuF4F/76aNqv1PxafOhcYYTx6Tlbg6QMApB2+RakacIV+syWu/7WnZ4Vo8q6o4
	 8odC1qE9jew10xJxGX0KZBvhYGWX/u3erT6XVXi7IAiuOF75pnxEpFeslDc2/J2fxZ
	 I51tEwDWj2rQNlo98Fu5hhxsBStu0p4uFnPgNwaV8cnKlU35qBLacGFckiS82T+Lrp
	 zADhWE0SLK2SShkUGX4YQvOlJMJQTUGvxXhcPvv78vkuRhguRlvPKT8w1NJgOkzhyi
	 7mUkBfhWeyTA1Sh0A2Mp7dfIBajHL5ZPVYhG/PoEcsnqoI3HnXz2y7PgSiKc4/XFwz
	 8rTAdO7GfplMw==
Date: Tue, 17 Mar 2026 11:02:17 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH mm-unstable v15 13/13] Documentation: mm: update the
 admin guide for mTHP collapse
Message-ID: <638caee3-af71-47c7-bdc8-a905d3143387@lucifer.local>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032706.234519-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226032706.234519-1-npache@redhat.com>

On Wed, Feb 25, 2026 at 08:27:06PM -0700, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidance on how to utilize it.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM, but maybe we should mention somewhere about mTHP's max_ptes_none
behaviour?

Anyway with that addressed:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 48 +++++++++++++---------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index eebb1f6bbc6c..67836c683e8d 100644
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
>
>  process THP controls
> @@ -264,11 +265,6 @@ support the following arguments::
>  Khugepaged controls
>  -------------------
>
> -.. note::
> -   khugepaged currently only searches for opportunities to collapse to
> -   PMD-sized THP and no attempt is made to collapse to other THP
> -   sizes.
> -
>  khugepaged runs usually at low frequency so while one may not want to
>  invoke defrag algorithms synchronously during the page faults, it
>  should be worth invoking defrag at least in khugepaged. However it's
> @@ -296,11 +292,11 @@ allocation failure to throttle the next allocation attempt::
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
>
>  	/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed
>
> @@ -308,16 +304,19 @@ for each pass::
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
> +allowed in the 2MB region. For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1)
> +are supported. Any other value will emit a warning and no mTHP collapse
> +will be attempted.
> +
> +A higher value allows more empty pages, potentially leading to more memory
> +usage but better THP performance. A lower value is more conservative and
> +may result in fewer THP collapses.
>
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -337,6 +336,15 @@ that THP is shared. Exceeding the number would block the collapse::
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
> 2.53.0
>
