Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAC367B65;
	Mon, 24 Aug 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583818; cv=none; b=rJegAFUQTDke+xiex4pIGpZN4cUVqPQs0yiQTzYrSQSc/6kYLSqgFweaxCoK9Tqp1mNdVolIrWYuPk/z8af7hAlTXM+UTIu3JQ+EjiKeOeUisDANnELuF0rtP2yrroeuwK5GLy0EsmfA4lLWHYdi9SIYn5gHref2+GhuECOEYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583818; c=relaxed/simple;
	bh=nCOLP+pUnNDn8FZg6i8N2Ia0JL+HQa7bBLFp4M6nYSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHshu/j5wC/p4ymisGiV28VZV9Pu7wxd5MrMtCAMGL3znInC8GYRuq94Dv7kj9uNBL+azLmfI4ZKw3Zys0MIxlUUssti3lZomSo8rThTbkd66+7KNiKSuW4lYd/1Lh9e2eulZx9dsui6+zCNpdMblLnLH2kAQ+aVUe66X5/TxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI0vHaFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI0vHaFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33F81F000E9;
	Mon, 24 Aug 2026 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583816;
	bh=1N4Dgg6M9ZUavS0An6jb6rtj/L03r3LLP7KAMFYdsrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KI0vHaFKs2iuJuLBxJTIK9hzpbfb70XWVZdAMV9ZNmSB1s5dX3EODo6iK2rwMvff3
	 o1zo4uNkOUy09uxeY227ljEze1a3rJTOdghr5kYtStFuCASrN68C5wXq15sm38+bAT
	 Ws7tjHRZmtjHfxUXLJR7Yuwo/17LwBS6i/9QuCr3b4J8f6QnJnCtXixlT8ArO6Iz1s
	 Om22oh+E7kYUjI76NqdsR4QjPcwMNRS1j/ASCgkr8ipXbaMycJ7ls7Hc1vaozvBhem
	 V9GLPj4tNytQrv1bFOrJFpWnbWNOhms6MCk2QEG6JzFO7PgXOtlsfOddDdj7QhxkAg
	 YQKYaFLUEoNJg==
Date: Mon, 24 Aug 2026 16:03:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
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
Subject: Re: [PATCH 2/6] userfaultfd: constify VMA parameter of
 userfaultfd_*() helpers
Message-ID: <aoxcY5n99-Pzlw_b@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>

On Sun, Aug 23, 2026 at 03:17:39PM +0300, Mike Rapoport (Microsoft) wrote:
> userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected() only
> read the VMA.
>
> Make their vma parameter const.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM and compiles GTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/userfaultfd_k.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a4351cffc60c..3396d270b159 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -204,22 +204,22 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>  					VMA_UFFD_MINOR));
>  }
>
> -static inline bool userfaultfd_missing(struct vm_area_struct *vma)
> +static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
>  }
>
> -static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> +static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_WP);
>  }
>
> -static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> +static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
>  }
>
> -static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
>  {
>  	/*
>  	 * Callers gate PAGE_NONE usage on this; PAGE_NONE is a BUILD_BUG()
> @@ -230,7 +230,7 @@ static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
>  	return vma_test_single_mask(vma, VMA_UFFD_RWP);
>  }
>
> -static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> +static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
>  {
>  	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
>  }
> @@ -353,27 +353,27 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  	return true;
>  }
>
> -static inline bool userfaultfd_missing(struct vm_area_struct *vma)
> +static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
>  {
>  	return false;
>  }
>
> -static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> +static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
>  {
>  	return false;
>  }
>
> -static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> +static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
>  {
>  	return false;
>  }
>
> -static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
>  {
>  	return false;
>  }
>
> -static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> +static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
>  {
>  	return false;
>  }
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
