Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5E3DB303;
	Thu, 27 Aug 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821768; cv=none; b=NYh2pJaA7EcCVIljUfqk1CwIs0INS1KhcRQTBAojMhy/ReULMdAiEk3q9lFk1vmle2695uJXLwONmuNu8mYyBdXEtg5gRHFFCAgv5D2fFtraYtzj3zSsLqLrB7LCkutOz0vNtDesrtuUiQS3cDrrxfxjvHxC5QpbCFsDstczhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821768; c=relaxed/simple;
	bh=nj08DtLLOo31GmcfAdM92lCdx6IL9ddHq0eaPzUjsRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4VhZsMiuVyCid2xcsyOS1hSaL6nGUZyUkR4s4w/E7bZ4W/qVm8X+xhsiCVoZQUT5wne9vEgwInlytdf+m2x3O3kCrUmslrVJgq2t09ie7xzP1cZWRprqgE8/eXEnyWdnHj8S2jWcxbTu0Ip7sBpAnsff+lZoW95VMDisC0KTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFiuJ2aK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFiuJ2aK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F71A1F000E9;
	Thu, 27 Aug 2026 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821767;
	bh=RpGiMBMHM5Gzcxil2Rgh4TexxSKnGvufNkrztx+joGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZFiuJ2aKTkIPolcpnhdNN4ZOC0buG+VC/7mPcURAZVx/F9rT2gBbpwQJJXMWr4Nlm
	 1dgzM4NJthTfp3ZG7NLeYjCPkvVydK8hJGR/4IK8wGTlJzncBIIYNfAQLG/51lIvXC
	 WMPvsWYMUx4LbdLfjkLSrm0Mg7lcmXd/3bno4cSpOVcUV3xFXnsrjcBpI/S3A/Pk5T
	 DEI6NaSXhOUwM2JtYiy92dwxr9GQ0NxWs4OWexmA6ILGV6dkBoG25PiEh1voDngCNg
	 vcrw2JJZ9sFm7WbCEXq2CW/pdL8ShXEkZpNx2fo17ugyLZqOTIj21OCni6H+Xf2fb/
	 h1pUsqwaSmLFw==
Date: Thu, 27 Aug 2026 12:09:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] userfaultfd: decouple fault reason from VMA flags
Message-ID: <ao_-uZrrsVX9lzbz@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <5bb86e34-6196-4b50-b553-be2ff7c1fa32@kernel.org>
 <ao_sCh5zP0IC9H2S@kernel.org>
 <e8aaddde-0a07-4197-9874-5ca0ea8af43f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8aaddde-0a07-4197-9874-5ca0ea8af43f@kernel.org>

On Thu, Aug 27, 2026 at 10:10:24AM +0200, David Hildenbrand (Arm) wrote:
> On 8/27/26 09:49, Mike Rapoport wrote:
> > On Mon, Aug 24, 2026 at 04:46:14PM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/23/26 14:17, Mike Rapoport (Microsoft) wrote:
> >>> Introduce enum uffd_reason to define reasons for user faults rather than
> >>> overload VM_UFFD_* VMA flags for that.
> >>>
> >>> Using a dedicated enum makes the code clearer and decoupling the fault
> >>> reason from VMA flags clears the way for moving the uffd mode bits out
> >>> of VMA namespace.
> >>>
> >>> No functional change.
> >>>
> >>> Assisted-by: copilot:claude-opus-4.6
> >>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> ---
> >>>  include/linux/userfaultfd_k.h    | 16 ++++++++++++++--
> >>>  include/uapi/linux/userfaultfd.h |  6 +++---
> >>>  mm/huge_memory.c                 |  6 +++---
> >>>  mm/hugetlb.c                     | 10 +++++-----
> >>>  mm/memory.c                      | 10 +++++-----
> >>>  mm/shmem.c                       |  4 ++--
> >>>  mm/userfaultfd.c                 | 30 +++++++++++++++---------------
> >>>  7 files changed, 47 insertions(+), 35 deletions(-)
> >>>
> >>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> >>> index 45355bdb4ec7..f401623f315d 100644
> >>> --- a/include/linux/userfaultfd_k.h
> >>> +++ b/include/linux/userfaultfd_k.h
> >>> @@ -9,6 +9,18 @@
> >>>  #ifndef _LINUX_USERFAULTFD_K_H
> >>>  #define _LINUX_USERFAULTFD_K_H
> >>>  
> >>> +#include <linux/bits.h>
> >>> +
> >>> +/* Fault reason #PF handler passes to handle_userfault() */
> >>> +enum uf_reason {
> >>
> >> Can we just call this "userfault_reason" or "uffd_reason" ? Maybe the latter is
> >> actually what we want?
> > 
> > userfault_reason sounds better to me.
> > 
> > It describes what kind of user fault we are handling and the 'fd' part has
> > nothing to do with it. 
> > We do use uffd as a short name for the subsystem, but still most if not all
> > userfaultfd "external" APIs use userfault_ prefix.
> > 
> > uf_ was an attempt to make it wee shorter :)
> 
> Yeah, I got that; while uffd is a known acronym, the uf_ not so much (and also I
> wouldn't suggest it to become a thing, lol :) )
> 
> I've been wondering for a while whether it really should be called
> 
> 	handle_userfault()
> 
> And not instead
> 
> 	handle_userfaultfd()

The 'fd' part here sounds really weird :)
 
> Or maybe even better
> 
> 	handle_uffd_fault()

That's somehow tautological, but maybe using uffd_ as prefix would make it
a "subsystem namespace", so tautology won't be as blunt:

	uffd_handle_fault()
 
> And then have
> 
> 	uffd_fault_reason

Could work, yes. No strong feelings between this one and userfault_reason.
 
> ... but just a thought.
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
