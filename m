Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839957;
	b=bB6PZVcmSYCTCZ7ErwOwn4sgsi9FyqKtnL+Og9PSXxKxioFoldp0IZIm5NMygL4ey4Iv
	 eV5U1rRqO+Jqu+s2f8q6QUDNNGEy1YTLzBqtO95blbIqkMPooYEyPFl4t1E85m/+AFGcX
	 JK/Eujqk7Zp6VQLUrFCuYwcXDijNVABKubTZA0yEoKNpcwU4JigoxlgGK/VmKryFcQxVD
	 JNg/l//4cB6N2sJuzgMXWvtSBp66r8ZNvwbE1/eyenBX7SXkzZVZO9zpqQ/mCbd+q1ScD
	 +m4DnLnMqtmP46FoTkuNh4Ctj3f94IBe3ytgLG00HglnP328fh1dspLxycvLpqSf7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zaV0Mc91b6CKg4KWF+urKTxUfs1lgeRdWbePAyfuXo0=;
	b=LppS89trjOfodwzfesnUmX7RB5CvC0knPJpzPmcz6D9QnNrZt1heYlaYBUJkIGfGnSSL
	 7yirqFly8URy7vQHWjXPrCwJKWuhLyeZ7NTCUHT9fzhj9BCELjTZVEqDCKs+H9KuWVefj
	 ZcKu8HUvmSwFXpf1wG4mgF+VvdOyMO8g/kwFjeBaP3mm2U/bhlBmSvDT1YOhKkZqzeBOn
	 JtMW39Ckvgve/95nk049SE1u3IVgnx2L495v61DF+obwGnb7qEsjf9I0sJww3d1SgYN+w
	 iMbOql7LTisKZs5w+PJ0LmHpgLn4WbjFGalC8nY57AY7rQE/MB4t53gXYRz30DI4yyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaRMq2m2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017F606A323;
	Mon, 16 Nov 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaRMq2m2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5801F000C4;
	Mon, 16 Nov 2026 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839957;
	bh=zaV0Mc91b6CKg4KWF+urKTxUfs1lgeRdWbePAyfuXo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EaRMq2m2x8jWy+QEyQwyoS2VonziEIMIjWzpXQWDwpLWOJn/6DOF5tMKcwGpB0Noa
	 cKc4RmY6MsAZk6g0G6xWmKeYYu9ZA6RsEvHqXJqUyy8jKT5WpjCn5oeN2i6DS8vOep
	 muS1n3gDgb24Jja8D0CiDdJ2RO9rLtoNho73cQAfnTYaDcYnHjRY/J6jRPrRbutbZN
	 dC0GpBwgWC0Erd+9bfYNTNQmIS4CrcDZzbMh2tgBZerpm7IxNBI077/33U3a/R02Nn
	 eD3cCvMsJM7eXAUgC+LCTBg/bIu1wDOyOhz/kyqtqfANErgbwxe/2W65Nuy4ZauM63
	 HcuuRoxdJuRIw==
Date: Mon, 16 Nov 2026 14:39:07 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/userfaultfd: prevent poison marker loss
Message-ID: <avsVP96p3EeK4TBZ@gremlin>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>
 <avij463DZ_tSwgKy@gremlin>
 <02e6240c-78ac-48a2-8bf8-36a2327e9de8@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e6240c-78ac-48a2-8bf8-36a2327e9de8@kernel.org>

On Mon, Nov 16, 2026 at 03:26:33PM +0100, David Hildenbrand (Arm) wrote:
> On 11/14/26 19:40, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Nov 07, 2026 at 12:51:05AM +0100, David Hildenbrand (Arm) wrote:
> >> Unregistering userfaultfd leaves poison markers in the page tables.
> >> However, once unregistered, hugetlb PMD tables can be shared again.
> >>
> >> Further, shmem page-table retraction can discard poison markers even
> >> while registered in missing mode, and fork() can skip copying page
> >> tables containing poison markers.
> >>
> >> To fix it, add VM_MAYBE_UFFD_POISON and set it before installing poison
> >> markers. Preserve it across unregistration, splits, merges and fork(),
> >> just like we do with guard markers.
> >>
> >> Use the new atomic VMA flag to disable PMD sharing and page-table
> >> retraction, and to force page-table copying during fork().
> >>
> >> Move VM_UFFD_WP to bit 44 and make HAVE_ARCH_USERFAULTFD_WP depend on
> >> 64BIT, freeing bit 12 for the new flag on both 32-bit and 64-bit systems.
> >> Expose the flag as "up" in smaps.
> >>
> >> Losing poison markers, while unpleasant, is not really fatal, and the
> >> use case is rather a niche thing. In addition, we rely on the atomic
> >> VMA flags infrastructure ... so let's not CC stable.
> >>
> >> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> >> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> >
> > Are we looking to cc: stable or this something for newer kernels only?
>
> Per above:
>
> "Losing poison markers, while unpleasant, is not really fatal, and the
> use case is rather a niche thing. In addition, we rely on the atomic
> VMA flags infrastructure ... so let's not CC stable."
>
> We cannot really backport to the pre MADV_GUARD fixes that handle the atomic flag correctly.

True!

>
> We could easily backport to stable kernels that have it.
>
> Thoughts?

Yeah, I think it's fine not to cc: stable on the basis of the above, but if we
do we can limit to ones that have that fix.

OTOH this is adding an entirely new thing (new atomic VMA flag etc.) that
probably isn't best suited to a stable backport anyway.

So I am fine with it not being cc-stable at all, thanks!

>
>
> [...]
>
> >>  #define VM_LOCKED	INIT_VM_FLAG(LOCKED)
> >>  #define VM_IO		INIT_VM_FLAG(IO)
> >>  #define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
> >> @@ -502,13 +508,17 @@ enum {
> >>  #endif
> >>
> >>  /*
> >> - * vma_flags_t masks for the userfaultfd VMA flags. The two high-bit modes are
> >> - * gated on the same configs as their VM_* flags above -- both of which imply
> >> + * vma_flags_t masks for the userfaultfd VMA flags. The three high-bit modes are
> >> + * gated on the same configs as their VM_* flags above -- all of which imply
> >>   * 64BIT -- so an out-of-range bit is never fed to mk_vma_flags() on a build
> >>   * whose bitmap cannot hold it.
> >>   */
> >>  #define VMA_UFFD_MISSING	mk_vma_flags(VMA_UFFD_MISSING_BIT)
> >> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> >>  #define VMA_UFFD_WP		mk_vma_flags(VMA_UFFD_WP_BIT)
> >> +#else
> >> +#define VMA_UFFD_WP		EMPTY_VMA_FLAGS
> >> +#endif
> >
> > Could you just move these up to the block above to match the convention here?
> >
>
> Did you have the following change on top of my changes in mind?

Yes LGTM thanks!

>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6cd9d86f7adac..fa56d9e9f3ebd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -410,8 +410,10 @@ enum {
>  #define VM_MAYBE_UFFD_POISON   INIT_VM_FLAG(MAYBE_UFFD_POISON)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  #define VM_UFFD_WP     INIT_VM_FLAG(UFFD_WP)
> +#define VMA_UFFD_WP    mk_vma_flags(VMA_UFFD_WP_BIT)
>  #else
>  #define VM_UFFD_WP     VM_NONE
> +#define VMA_UFFD_WP    EMPTY_VMA_FLAGS
>  #endif
>  #define VM_LOCKED      INIT_VM_FLAG(LOCKED)
>  #define VM_IO          INIT_VM_FLAG(IO)
> @@ -508,17 +510,12 @@ enum {
>  #endif
>
>  /*
> - * vma_flags_t masks for the userfaultfd VMA flags. The three high-bit modes are
> - * gated on the same configs as their VM_* flags above -- all of which imply
> + * vma_flags_t masks for the userfaultfd VMA flags. The two high-bit modes are
> + * gated on the same configs as their VM_* flags above -- both of which imply
>   * 64BIT -- so an out-of-range bit is never fed to mk_vma_flags() on a build
>   * whose bitmap cannot hold it.
>   */
>  #define VMA_UFFD_MISSING       mk_vma_flags(VMA_UFFD_MISSING_BIT)
> -#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> -#define VMA_UFFD_WP            mk_vma_flags(VMA_UFFD_WP_BIT)
> -#else
> -#define VMA_UFFD_WP            EMPTY_VMA_FLAGS
> -#endif
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  #define VMA_UFFD_MINOR         mk_vma_flags(VMA_UFFD_MINOR_BIT)
>  #else
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index b8b7cc2f00388..75c3e9270b62a 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -201,7 +201,7 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>
>  static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  {
> -       return vma_test_any_mask(vma, VMA_UFFD_WP);
> +       return vma_test_single_mask(vma, VMA_UFFD_WP);
>  }
>
>  static inline bool userfaultfd_minor(struct vm_area_struct *vma)
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
