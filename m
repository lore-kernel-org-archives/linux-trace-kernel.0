Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B644D681;
	Fri, 22 May 2026 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463038; cv=none; b=ZxWx5Crrv03anxPPW1NGDgRejA38JXbsPzI5v2mgRfCPido1sA7BRbi5QtyLR84IIwxBZwWsQkxfgjyDDFdAveyoOgTaODMDVlWUikPM2U7WMu8DjYQv36TTC0WruAKYu9xi8qObHnhcZI22hA6+r+wXC/BtR58MwPW/51D3WMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463038; c=relaxed/simple;
	bh=IBsvFhUx7DS38QNIm3xpHJAHnKglEvOlaw57vqv6PFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj+7zk8dLVPqQQvt5LnayIJed0zv50aN1TYUxPCvl+eWRFnLlQW8aUntgbpn0YE7x9bC5Yecp47XIGXePLyvsgMvU6XppY3AGnOPtAglZ8daOKS4sSXfkQ1GB4vXHeqb5nEZM5lM4rZGAnipHkGbZsP8gYZr2qAnUJU5xtl0FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPFVnJV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPFVnJV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F5F1F000E9;
	Fri, 22 May 2026 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463030;
	bh=IBsvFhUx7DS38QNIm3xpHJAHnKglEvOlaw57vqv6PFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NPFVnJV2aGaaQ7+gUElo5SjZoXRihKPy13sFa36i3fOouejoHK0Jj3X/OoG+3IKQB
	 w6PBonP+kRBXydLxpJX6HHG15vaVqRY5iES7/+nv42Dn4qnqgiuoGDULeX2ZOtEII7
	 HwTDUw3Ir73SHqdpMIZDCMU6/ngtdFjB3UEIWN5CJV4UdSZckRyaKuI/wEAkgUGcaA
	 PPqwJOKQ6N+k3PuIAjBeqwjUyNzYgyTPzFo4sZaHTiQFXeCWpqqAahpKXPiF1i47Wr
	 wRgxjS4N1mttbsjv6e0BTtBb25f4AxpKcxOtHjJISYWseXSvTGff3gYuTIMlIHllek
	 26357kKMZzdkA==
Date: Fri, 22 May 2026 16:16:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
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
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-ID: <ahByO_HWn6MB8z-u@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>

On Fri, May 22, 2026 at 09:07:29AM -0600, Nico Pache wrote:
> Whoops I manually changed the coverletter subject to reflect that this
> in on mm-hotfixes-unstable but never updated the others...
>
> Hopefully that is ok. Just a small mistake. Base commit is referenced here.

It's not ok, this isn't suitable for a hotfix in any way shape or form?

As you know, because we told you :) May has been difficult because of
conferences, holidays (and in my case burnout recovery).

And unfortunately the series seems to have needed quite a bit of review again
(my suggestion to you would be to ensure you don't make major changes, only
small incremental ones on the basis of review feedback).

So this isn't viable for 7.2, and we'll have to target 7.3. Therefore there
was no rush.

Also please don't spring a respin on this series on us without discussion
first, with people away and (frankly) the amount of work involved here,
you're going to have to accept the pace that workload/availability permits.

Adding spurious hotfixes tags doesn't help anything :) please don't do that
again.

Thanks, Lorenzo
