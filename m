Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBB306775;
	Thu, 27 Aug 2026 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816985; cv=none; b=K8TNBarMgtBsMPAKdta/ImXk9cmvHTAHsQhv8KocWetnY6VDfbvgR95qbqsldE8aB5MGc+eQ7Z82jFkrY5LZzEu8PcNi46x0MxBndWnbQOCHRZaAxVXEiQfvVGa/rbyKAJOqv7uu/loVkOtb/DYBpDLkw4xSitO7I/qtCp2CCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816985; c=relaxed/simple;
	bh=rydCR8oMmRj25kCWFiF8JjPsK1p8C9eCD8o7nMiXdDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGrxDBt26qpy86b+rtHCg+WxEwUJry7JFgIgvyfvg1UVKrP/C/GTmPpa9oq6zoY+g/SGrqQV0GszNeO3/jY1gehDSHwAz3eMZ6KeT1mzkU3XMlJgsnLEvuKaPUBouH41PVx91oAZavboq/drbf3Kkd926TEFrd4QPemODgQDjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP5GUoKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP5GUoKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFB1F000E9;
	Thu, 27 Aug 2026 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816983;
	bh=pXKPSGKEnYpUCi4b1Zk1PpaxxASDBVDKKvWhbUsQzzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XP5GUoKscwLfu7Wd9nUZA5nENI+S/18k7abGqbbmVOSzWIZOZFrV9h7aPu5Asmf7U
	 OwJFJSoNI9m1vYcI4QoNpM5xvoy8mOk6jaM1Q97ewpFzcC1YTjN1uSUpnYNCOKnOwk
	 6j7TJRULs5vWsgaNPseFCq3o9vlEli8peP2xq6qfnlFJ60vivszWc0cYPoskntdmIv
	 +q4aMFrl0i+M+oKTIqkT1+z5EdtxBtdRNeTn9qouluLVwxVfm7s09i/032hvBQHd+D
	 d/tiFEHJfC3XWiDyJzXWpQM4SBVsoSAqHACxmgKU+e97L6OVESE17Qpvxy508ZLpxM
	 mF/83rFlBH63Q==
Date: Thu, 27 Aug 2026 10:49:30 +0300
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
Message-ID: <ao_sCh5zP0IC9H2S@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <5bb86e34-6196-4b50-b553-be2ff7c1fa32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb86e34-6196-4b50-b553-be2ff7c1fa32@kernel.org>

On Mon, Aug 24, 2026 at 04:46:14PM +0200, David Hildenbrand (Arm) wrote:
> On 8/23/26 14:17, Mike Rapoport (Microsoft) wrote:
> > Introduce enum uffd_reason to define reasons for user faults rather than
> > overload VM_UFFD_* VMA flags for that.
> > 
> > Using a dedicated enum makes the code clearer and decoupling the fault
> > reason from VMA flags clears the way for moving the uffd mode bits out
> > of VMA namespace.
> > 
> > No functional change.
> > 
> > Assisted-by: copilot:claude-opus-4.6
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/linux/userfaultfd_k.h    | 16 ++++++++++++++--
> >  include/uapi/linux/userfaultfd.h |  6 +++---
> >  mm/huge_memory.c                 |  6 +++---
> >  mm/hugetlb.c                     | 10 +++++-----
> >  mm/memory.c                      | 10 +++++-----
> >  mm/shmem.c                       |  4 ++--
> >  mm/userfaultfd.c                 | 30 +++++++++++++++---------------
> >  7 files changed, 47 insertions(+), 35 deletions(-)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 45355bdb4ec7..f401623f315d 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -9,6 +9,18 @@
> >  #ifndef _LINUX_USERFAULTFD_K_H
> >  #define _LINUX_USERFAULTFD_K_H
> >  
> > +#include <linux/bits.h>
> > +
> > +/* Fault reason #PF handler passes to handle_userfault() */
> > +enum uf_reason {
> 
> Can we just call this "userfault_reason" or "uffd_reason" ? Maybe the latter is
> actually what we want?

userfault_reason sounds better to me.

It describes what kind of user fault we are handling and the 'fd' part has
nothing to do with it. 
We do use uffd as a short name for the subsystem, but still most if not all
userfaultfd "external" APIs use userfault_ prefix.

uf_ was an attempt to make it wee shorter :)
 
> -- 
> Cheers,
> David

-- 
Sincerely yours,
Mike.
