Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A8449995;
	Tue, 25 Aug 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662822; cv=none; b=YzMsT6QON6LQsv+fYO5/8hyXJHsx1DD+/+8mT+4UFONxWKN+ICbKpDT1Vzh4GL8c5/lTwEA2M+MFahCCZSkhnPGNSMSQ834ADTfbOmRAtOa9Td/98G+TPsLwC3Z5HNKhvGlV4bdRbiBgYxwyWfKRhiOaON3jaP9xnScq8F6RIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662822; c=relaxed/simple;
	bh=BsvO6iTTWjQrVrOL1twl57tQIEsJO8nfjdVXKHpEbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flnShUOiTb0UyWcSHo9VXujUKP1kxgJytloGL8W+dRSHkauaP/doHfaAo+syHPzxK4Skb6XslhqRSijqjiqGYqs4vJEUkxGDSG2HEIkRsS/Lc6rrmjtZ0FlMf5yc9kv111S3+kIer0Mt3WiPTMvEyFFrQTv+OVI2GYsvWhA1K5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0UvnAEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0UvnAEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B46A1F00A3A;
	Tue, 25 Aug 2026 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662821;
	bh=qfOKtnng6T1xYEK1VgxhBRbh9ravAjHw+w2ofwHQs5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l0UvnAEG/Zo8r3CykoUrq6NAVJZam1+zHgtTNyKABeLMTMIn3AIjlQxS8M8WsJ3Dk
	 OSjtXy9nbuudzP9xJ2PWeC3iuoN3WW/WOQmRorbeMBpHg/vRGoNZselhTAkK5a2Xru
	 0wjZvaiuiIp2XOI70jbATNae62Vr6YUBTZiA4fIHh3ftqnj6+vPzfRYnF0aJ1j1kSa
	 iMuGLEinc55lHWlqbfHEMdnNMQ5YlymbIAoid0plZN8erqJxxUnh7lROb2Nt+m2V+c
	 Qe5Z/t9+ljxpA9/shQurYfAeS85rvU/UZg+g36P5gF3TedFNFenR4d/NRIEIcseHfN
	 aw52iDMO8oUGw==
Date: Tue, 25 Aug 2026 14:00:10 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] userfaultfd: decouple fault reason from VMA flags
Message-ID: <ao2Qk87AKnMKuNvg@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <aoxm4jUrmL1eQlCJ@gremlin>
 <ao1waln1lklfk8th@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1waln1lklfk8th@kernel.org>

On Tue, Aug 25, 2026 at 01:37:30PM +0300, Mike Rapoport wrote:
> On Mon, Aug 24, 2026 at 05:28:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sun, Aug 23, 2026 at 03:17:42PM +0300, Mike Rapoport (Microsoft) wrote:
> > > Introduce enum uffd_reason to define reasons for user faults rather than
> > > overload VM_UFFD_* VMA flags for that.
> > >
> > > Using a dedicated enum makes the code clearer and decoupling the fault
> > > reason from VMA flags clears the way for moving the uffd mode bits out
> > > of VMA namespace.
> > >
> > > No functional change.
> > >
> > > Assisted-by: copilot:claude-opus-4.6
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  include/linux/userfaultfd_k.h    | 16 ++++++++++++++--
> > >  include/uapi/linux/userfaultfd.h |  6 +++---
> > >  mm/huge_memory.c                 |  6 +++---
> > >  mm/hugetlb.c                     | 10 +++++-----
> > >  mm/memory.c                      | 10 +++++-----
> > >  mm/shmem.c                       |  4 ++--
> > >  mm/userfaultfd.c                 | 30 +++++++++++++++---------------
> > >  7 files changed, 47 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > > index 45355bdb4ec7..f401623f315d 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -9,6 +9,18 @@
> > >  #ifndef _LINUX_USERFAULTFD_K_H
> > >  #define _LINUX_USERFAULTFD_K_H
> > >
> > > +#include <linux/bits.h>
> > > +
> > > +/* Fault reason #PF handler passes to handle_userfault() */
> > > +enum uf_reason {
> > > +	USERFAULT_MISSING	= BIT(0),
> > > +	USERFAULT_MINOR		= BIT(1),
> > > +	USERFAULT_RWP		= BIT(2),
> > > +	USERFAULT_WP		= BIT(3),
> > > +};
> >
> > Hmm your commit message says uffd_reason, uf_reason makes me think of the
> > character Ulf from House of the Dragon. But not uffd. So as per David let's
> > rename it :)
> >
> > I'm also not sure if an enum is the right thing for flag values?
>
> I'll ask LLM why it chose it :)

I mean you then introduce the same flags again seemingly with different
names as #define's in the next patch... having several sets of flags with
subtly different names seems unwise.

It seems there is a 'mode' and a 'reason', maybe I missed something but
that just seems overly complicated.


But in general I think the objection to using an enum for flags is because
the compiler will treat a switch() {} of the enums as the only independent
values and possibly in other places too.

That's super theoretical but it is an odd thing to do potentially. I got
(annoying) push-back on using an enum for flags on a series in the past, so
I guess here I am paying it forwards ;)

>
> > Anything that is parameterised by enum uffd_reason that combines flags will
> > break any switch statement in there and yada yada.
> >
> > I wonder if better just as #define's + unsigned long or something?
> >
> > Or you could do (and this leads to nicer stuff later):
> >
> > 	enum uffd_reason {
> > 	     USERFAULT_MISSING_BIT = 0,
> > 	     USERFAULT_MINOR_BIT = 1,
> > 	     USERFAULT_RWP_BIT = 2,
> > 	     USERFAULT_WP_BIT = 3,
> > 	};
> >
> > 	#define USERFAULT_MISSING BIT(USERFAULT_MISSING_BIT)
> > etc.
>
> Looks over-engineered to me tbh, if we drop an enum, I'd just
>
> #define FLAG (1 << SHIFT)
>
> and call it a day.
>
> Also see below about aligning with uABI flags.

See review on 6/6, I'm confused actually why we have several sets of these
flags...

But in general it seems like these flags (in one form or another) are being
repeatedly referenced, so it's not really over-engineering I don't think to
abstract some of that.

Maybe can be in wrappers that make it nicer. But really the issue is the
duplication in modes/reasons/flags...

>
> > > @@ -168,9 +168,9 @@ struct uffd_msg {
> > >
> > >  /* flags for UFFD_EVENT_PAGEFAULT */
> > >  #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
> > > -#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
> > > -#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
> > > -#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is VM_UFFD_RWP */
> > > +#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is uffd-wp */
> > > +#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is uffd-minor */
> > > +#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is uffd-rwp */
> >
> > Is it worth retaining the same bit indexes as the reasons?
> >
> > Reasons:
> >
> > 	Bit number
> > MINOR	0
> > RWP	1
> > WP	2
> >
> > Page fault flags:
> >
> > 	Bit number
> > MINOR	2
> > RWP	3
> > WP	1
>
> If we go this way, than it must be
>
> #define USERFAULT_MINOR UFFD_PAGEFAULT_FLAG_MINOR
>
> so we won't need to keep them in sync explicitly.
>
> With a caveat of USERFAULT_MISSING that is expressed as "no flags in
> uffd_msg" :)

Ugh.

>
> > > @@ -2607,7 +2607,7 @@ static inline void msg_init(struct uffd_msg *msg)
> > >  static inline struct uffd_msg userfault_msg(unsigned long address,
> > >  					    unsigned long real_address,
> > >  					    unsigned int flags,
> > > -					    unsigned long reason,
> > > +					    enum uf_reason reason,
> > >  					    unsigned int features)
> > >  {
> > >  	struct uffd_msg msg;
> > > @@ -2629,11 +2629,11 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
> > >  	 */
> > >  	if (flags & FAULT_FLAG_WRITE)
> > >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
> > > -	if (reason & VM_UFFD_WP)
> > > +	if (reason & USERFAULT_WP)
> > >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
> > > -	if (reason & VM_UFFD_RWP)
> > > +	if (reason & USERFAULT_RWP)
> > >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_RWP;
> > > -	if (reason & VM_UFFD_MINOR)
> > > +	if (reason & USERFAULT_MINOR)
> > >  		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
> >
> > With matching flags and unsigned long you could do
> >
> > 	msg.arg.pagefault.flags |= reason;
> >
> > I think?
>
> Almost:
>
> 	msg.arg.pagefault.flags |= (reason & ~USERFAULT_MISSING);
>
> And define USERFAULT_MISSING as (1 << 0) with a comment why it's fine.
>
> I don't feel strongly about it, but my preference is to define reason flags
> independently of UFFD_PAGEFAULT_FLAGs and keep the ifs here.

And also modes... Again I think fixing that mess somehow is the better way forward.

>
> > > @@ -2793,14 +2793,14 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> > >  	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
> > >  	 * resolve the fault.
> > >  	 */
> > > -	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
> > > +	if (!pte_write(ptent) && (reason & USERFAULT_WP))
> >
> > I wonder if you could actually
> >
> > You do this quite a lot and they read a bit horribly with the && and & on the
> > same sight-line. With the changes to the enum proposed above you could do:
> >
> > 	if (!pte_write(ptent) && test_bit(reason, USERFAULT_WP_BIT))
>
> I find && and & perfectly readable and adding _BIT defines looks really
> excessive to me.

Discussed in sub-thread. We'll agree to disagree I suppose.

>
> > > @@ -2835,7 +2835,7 @@ static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
> > >   * fatal_signal_pending()s, and the mmap_lock must be released before
> > >   * returning it.
> > >   */
> > > -vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> > > +vm_fault_t handle_userfault(struct vm_fault *vmf, enum uf_reason reason)
> >
> > Hmm what was the 'reason' here before? The flags? Maybe more reason (no pun
> > intended) to keep the values the same?
>
> The 'reason' before was a VM_UFFD_SOMETHING, we really can't keep the
> values the same, but we surely can keep it unsigned long.

I notice the 'mode' which is not the same as the 'reason' is an unsigned
int in 6/6...

>
> > --
> > Cheers, Lorenzo
>
> --
> Sincerely yours,
> Mike.

--
Cheers, Lorenzo
