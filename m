Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174D3932C8;
	Tue, 25 Aug 2026 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654266; cv=none; b=pmIj5nMwqz7n5XcpJIPwwzeDlP+z3+ALUtH2JKtxyA3CLgF8mEBDEVn+tXOvi2p67VDdm4JwV85wYZCahyyls++oAMU+ma0c7sX/Okkcv863GePvSb6fMokl0dUBY3A/Z+/vkp+QifO2y1OaJuKP3T8nLye7sAkVKj2mv7CVJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654266; c=relaxed/simple;
	bh=6wM71OktoHpoNMwnvS4y5Ps47GC3beCdecG1N+mXMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbdnpBfK44XznCC1NJMsO1ruPg94OihR9ZN3qk6dVsI3V4x5Zuvw/BUXCllE0YZsq1EPpXooIVRXIxFb2DoXF61XW18/V5PGoV3GxlH5/+Xh9pSrhS5KX9kXqmP30ZLqeFFm2yjslYthatIe8Rgpel6TWtHHcgGd7KAXugHionM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBdrmQL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBdrmQL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D788D1F000E9;
	Tue, 25 Aug 2026 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654264;
	bh=VlrD/QAeSxGpKzZmYIBSyb0ejvsuQwHLEbsOamW6WOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBdrmQL99+j2LXsw9s0xPLciJ2E/I2z+Gr4SojHcMBhz1QUD9dzjGPthOkVvY6Oxc
	 177CwdrzU/aU+5tVOPw/SVnbst1ZAAyvPMvY+JkAL0Bkbinj46KhuzpTP43sGrQ9nW
	 /Hb4CgTn/sT1Rlo8sGRLQW0/cnGFbXzoX1UknZY2DoAmTfC2sgb64vcrVWGNq/spuv
	 MWAsgIxfIZC/kzdgk5PUmfTy1XJHDn6F/CN5ZyLEDWAU8KAVfaGguZW7yY/ztfHmmQ
	 7PAQFcZVZqXy5+R+WXQyFRo47k6MCK8CMonD1iX33XXR2k7GpExAUQgVddyB9IyYu3
	 rMCaMoa2soSkg==
Date: Tue, 25 Aug 2026 13:37:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Message-ID: <ao1waln1lklfk8th@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <aoxm4jUrmL1eQlCJ@gremlin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxm4jUrmL1eQlCJ@gremlin>

On Mon, Aug 24, 2026 at 05:28:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sun, Aug 23, 2026 at 03:17:42PM +0300, Mike Rapoport (Microsoft) wrote:
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
> > +	USERFAULT_MISSING	= BIT(0),
> > +	USERFAULT_MINOR		= BIT(1),
> > +	USERFAULT_RWP		= BIT(2),
> > +	USERFAULT_WP		= BIT(3),
> > +};
> 
> Hmm your commit message says uffd_reason, uf_reason makes me think of the
> character Ulf from House of the Dragon. But not uffd. So as per David let's
> rename it :)
>
> I'm also not sure if an enum is the right thing for flag values?

I'll ask LLM why it chose it :)
 
> Anything that is parameterised by enum uffd_reason that combines flags will
> break any switch statement in there and yada yada.
> 
> I wonder if better just as #define's + unsigned long or something?
> 
> Or you could do (and this leads to nicer stuff later):
> 
> 	enum uffd_reason {
> 	     USERFAULT_MISSING_BIT = 0,
> 	     USERFAULT_MINOR_BIT = 1,
> 	     USERFAULT_RWP_BIT = 2,
> 	     USERFAULT_WP_BIT = 3,
> 	};
> 
> 	#define USERFAULT_MISSING BIT(USERFAULT_MISSING_BIT)
> etc.

Looks over-engineered to me tbh, if we drop an enum, I'd just 

#define FLAG (1 << SHIFT) 

and call it a day.

Also see below about aligning with uABI flags.
 
> > @@ -168,9 +168,9 @@ struct uffd_msg {
> >
> >  /* flags for UFFD_EVENT_PAGEFAULT */
> >  #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
> > -#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
> > -#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
> > -#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is VM_UFFD_RWP */
> > +#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is uffd-wp */
> > +#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is uffd-minor */
> > +#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is uffd-rwp */
> 
> Is it worth retaining the same bit indexes as the reasons?
> 
> Reasons:
> 
> 	Bit number
> MINOR	0
> RWP	1
> WP	2
> 
> Page fault flags:
> 
> 	Bit number
> MINOR	2
> RWP	3
> WP	1

If we go this way, than it must be

#define USERFAULT_MINOR UFFD_PAGEFAULT_FLAG_MINOR

so we won't need to keep them in sync explicitly.

With a caveat of USERFAULT_MISSING that is expressed as "no flags in
uffd_msg" :)
 
> > @@ -2607,7 +2607,7 @@ static inline void msg_init(struct uffd_msg *msg)
> >  static inline struct uffd_msg userfault_msg(unsigned long address,
> >  					    unsigned long real_address,
> >  					    unsigned int flags,
> > -					    unsigned long reason,
> > +					    enum uf_reason reason,
> >  					    unsigned int features)
> >  {
> >  	struct uffd_msg msg;
> > @@ -2629,11 +2629,11 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
> >  	 */
> >  	if (flags & FAULT_FLAG_WRITE)
> >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
> > -	if (reason & VM_UFFD_WP)
> > +	if (reason & USERFAULT_WP)
> >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
> > -	if (reason & VM_UFFD_RWP)
> > +	if (reason & USERFAULT_RWP)
> >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_RWP;
> > -	if (reason & VM_UFFD_MINOR)
> > +	if (reason & USERFAULT_MINOR)
> >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
> 
> With matching flags and unsigned long you could do
> 
> 	msg.arg.pagefault.flags |= reason;
> 
> I think?

Almost:

	msg.arg.pagefault.flags |= (reason & ~USERFAULT_MISSING);

And define USERFAULT_MISSING as (1 << 0) with a comment why it's fine.

I don't feel strongly about it, but my preference is to define reason flags
independently of UFFD_PAGEFAULT_FLAGs and keep the ifs here.
 
> > @@ -2793,14 +2793,14 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> >  	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
> >  	 * resolve the fault.
> >  	 */
> > -	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
> > +	if (!pte_write(ptent) && (reason & USERFAULT_WP))
> 
> I wonder if you could actually
> 
> You do this quite a lot and they read a bit horribly with the && and & on the
> same sight-line. With the changes to the enum proposed above you could do:
> 
> 	if (!pte_write(ptent) && test_bit(reason, USERFAULT_WP_BIT))

I find && and & perfectly readable and adding _BIT defines looks really
excessive to me.
 
> > @@ -2835,7 +2835,7 @@ static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
> >   * fatal_signal_pending()s, and the mmap_lock must be released before
> >   * returning it.
> >   */
> > -vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> > +vm_fault_t handle_userfault(struct vm_fault *vmf, enum uf_reason reason)
> 
> Hmm what was the 'reason' here before? The flags? Maybe more reason (no pun
> intended) to keep the values the same?

The 'reason' before was a VM_UFFD_SOMETHING, we really can't keep the
values the same, but we surely can keep it unsigned long.
 
> --
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
