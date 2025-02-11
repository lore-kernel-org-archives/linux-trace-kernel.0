Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F127291F;
	Tue, 11 Feb 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317184; cv=none; b=nIACAXEAMG4tKLEDdc+Lo4KdDNxgKUP73i+PjET/PGXfO4gQMZXLkOyCefvYWMtl3j6IdHjFlfu0OxlTL5Bx90EgZC3hiLGEVus/nl6N0RaDzR4V0CXBbnmxQ15w736mMdIe3fH6OzspXSXJh8D7bmUwUa9qh6oLA6yfPs39Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317184; c=relaxed/simple;
	bh=KmZZdjl6ZufzH7ljJKE+F1Ax+O9hFfz9th1qlIB6io0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K+Byi9cEOdL1b2RtMQTIjXXQa5i3ElCsokAkWICaklPU/pLkSP1zjD91dDHqYSiNurPHdFrsLs1KqwrKCp+WQnPchvcajh+3CSRFEMJ2kZsserv6r34tVcXo3JOXQt0yVl2Ltll2E8BgztCOmc0A2otIqGOJ9XmnAMHNFmLXa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqZw8H+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqZw8H+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734CEC4CEDD;
	Tue, 11 Feb 2025 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739317183;
	bh=KmZZdjl6ZufzH7ljJKE+F1Ax+O9hFfz9th1qlIB6io0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqZw8H+YK+HmXZ8Q98zirAJfh43qwJBjqC4G10PCMijbs7MHLqHyy8ij2y9JrFp4Y
	 PCHqizlhN6EpikrsQQe5FdsUTHhsOTGGW834POt56J95wj2IetWFq/La6qE5s7qIWD
	 lFtPuvJXA/j/mOsGzP0dkecwjTfjg+XXZoj2ZEHjV83V1j8ROlQO7rRak/uiOvJA7+
	 GC46whdgpIU6Xvnq5Jmy7ioG0f1iei8TH/XPQR2gdUyKJoF+trlW/z4vs9bTYwZCWE
	 T73a/s3i3elPvGLGZuYHDZfYAQU6mW966xT7NDg9TdS7wXkHBwEM2UGTspNCS6kcLL
	 pMQbYYW9qSPGg==
Date: Wed, 12 Feb 2025 08:39:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release
 function
Message-Id: <20250212083940.8a88be7b1f9cf68a2cb8465b@kernel.org>
In-Reply-To: <20250211125211.1ce892a5@gandalf.local.home>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
	<173928522350.906035.5626965043208329135.stgit@devnote2>
	<20250211125211.1ce892a5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 12:52:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Feb 2025 23:47:03 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add reserve_mem_release_by_name() to release a reserved memory region
> > with a given name. This allows us to release reserved memory which is
> > defined by kernel cmdline, after boot.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: linux-mm@kvack.org
> 
> Hi, can we get one of the Memory Management maintainers to ack this patch?
> 
> We will be having devices going out with the reserve_mem option to perform
> tracing in the field. But that only happens if the user grants permission
> to do so. But the kernel command line does not change between users that
> granted permission and those that do not. We would like to free up the
> memory for those devices where the users did not grant permission to trace,
> as then the memory is just wasted.

Thanks Steve for explaining, I missed Ccing the background information.
Here is the covermail of this series.

https://lore.kernel.org/all/173928521419.906035.17750338150436695675.stgit@devnote2/

Thank you,

> 
> Thanks!
> 
> -- Steve
> 
> 
> > ---
> >  Changes in v2:
> >   - Rename reserved_mem_* to reserve_mem_*.
> > ---
> >  include/linux/mm.h |    1 +
> >  mm/memblock.c      |   72 +++++++++++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 61 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f02925447e59..fe5f7711df04 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4197,6 +4197,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> >  void vma_pgtable_walk_end(struct vm_area_struct *vma);
> >  
> >  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
> > +int reserve_mem_release_by_name(const char *name);
> >  
> >  #ifdef CONFIG_64BIT
> >  int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 095c18b5c430..c8d207ebb93c 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> > +#include <linux/mutex.h>
> >  
> >  #include <asm/sections.h>
> >  #include <linux/io.h>
> > @@ -2263,6 +2264,7 @@ struct reserve_mem_table {
> >  };
> >  static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> >  static int reserved_mem_count;
> > +static DEFINE_MUTEX(reserve_mem_lock);
> >  
> >  /* Add wildcard region with a lookup name */
> >  static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> > @@ -2276,6 +2278,21 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> >  	strscpy(map->name, name);
> >  }
> >  
> > +static struct reserve_mem_table *reserve_mem_find_by_name_nolock(const char *name)
> > +{
> > +	struct reserve_mem_table *map;
> > +	int i;
> > +
> > +	for (i = 0; i < reserved_mem_count; i++) {
> > +		map = &reserved_mem_table[i];
> > +		if (!map->size)
> > +			continue;
> > +		if (strcmp(name, map->name) == 0)
> > +			return map;
> > +	}
> > +	return NULL;
> > +}
> > +
> >  /**
> >   * reserve_mem_find_by_name - Find reserved memory region with a given name
> >   * @name: The name that is attached to a reserved memory region
> > @@ -2289,22 +2306,53 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> >  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
> >  {
> >  	struct reserve_mem_table *map;
> > -	int i;
> >  
> > -	for (i = 0; i < reserved_mem_count; i++) {
> > -		map = &reserved_mem_table[i];
> > -		if (!map->size)
> > -			continue;
> > -		if (strcmp(name, map->name) == 0) {
> > -			*start = map->start;
> > -			*size = map->size;
> > -			return 1;
> > -		}
> > -	}
> > -	return 0;
> > +	guard(mutex)(&reserve_mem_lock);
> > +	map = reserve_mem_find_by_name_nolock(name);
> > +	if (!map)
> > +		return 0;
> > +
> > +	*start = map->start;
> > +	*size = map->size;
> > +	return 1;
> >  }
> >  EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
> >  
> > +/**
> > + * reserve_mem_release_by_name - Release reserved memory region with a given name
> > + * @name: The name that is attatched to a reserved memory region
> > + *
> > + * Forcibly release the pages in the reserved memory region so that those memory
> > + * can be used as free memory. After released the reserved region size becomes 0.
> > + *
> > + * Returns: 1 if released or 0 if not found.
> > + */
> > +int reserve_mem_release_by_name(const char *name)
> > +{
> > +	struct reserve_mem_table *map;
> > +	unsigned int page_count;
> > +	phys_addr_t start;
> > +
> > +	guard(mutex)(&reserve_mem_lock);
> > +	map = reserve_mem_find_by_name_nolock(name);
> > +	if (!map)
> > +		return 0;
> > +
> > +	start = map->start;
> > +	page_count = DIV_ROUND_UP(map->size, PAGE_SIZE);
> > +
> > +	for (int i = 0; i < page_count; i++) {
> > +		phys_addr_t addr = start + i * PAGE_SIZE;
> > +		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
> > +
> > +		page->flags &= ~BIT(PG_reserved);
> > +		__free_page(page);
> > +	}
> > +	map->size = 0;
> > +
> > +	return 1;
> > +}
> > +
> >  /*
> >   * Parse reserve_mem=nn:align:name
> >   */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
