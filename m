Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56126BDB8;
	Tue, 11 Feb 2025 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238202; cv=none; b=PUbaxAyGaS27YHxMLRuFQXVUAC1h81RGhnf8bDGpd3lci0I2qwj4XQmZhPU9Z4BBzyiu+gZ91EWzzhPxAzPHovzP4yC3bO31pmB+kKSlsclS12Va/i4BkjteVGRVWExO3wL2zsmeEz4e8dxxqeFFwuqzqbPnsaFMqXzhj6YO1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238202; c=relaxed/simple;
	bh=BOOzlR4FTuzZwEak55fJF+4cKI6CRHwPtpJJF11ma/c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/d6YFM8CqOdvy1xkW+8NqHRGvY158j006oIBg97TkMDgWre3Wm2lVE3ae42ItRogLzmQ0KcarnTIjsP5wNNz66ie8C+NwLbJTCtboTQOKZ6lE7zDaLeIUtMP+pnzPsog2fs+Pgl2XPJMD+KytOIpmez7bZwGHifrgKSBcT0up4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGfGzebY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGfGzebY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8E3C4CEDF;
	Tue, 11 Feb 2025 01:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739238202;
	bh=BOOzlR4FTuzZwEak55fJF+4cKI6CRHwPtpJJF11ma/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGfGzebYulZBFsVyLd5DOJ3qdBtP9/VX8weyH9TDTDBPUQtO7do2AYyenUIcQDZPs
	 ZrKLx8cE++NOb8c+qz/heOePFkgMQg+ndeeCxrnNUlyBYhXBJz/j1cy2vo05ovgwya
	 chbEy4xAjwsutrgU+NMhM7ExdaCX6JfK8IpHal4Xh6YDHLkHs/pbW4qtt825tixvYA
	 /09LXv4WpL7/SaI0nWxyd/2FBrduQwV8G/BsUMdg1n7U+MPljNX5wwaNQ+cePOHfrR
	 rvCYrBY8FS5MAZ2Q9kgUAlLije0TBjFYeCeYGeJrzJBoVlJDZdPyn/BMVdCegZfUUs
	 KnSg0CLm66cbQ==
Date: Tue, 11 Feb 2025 10:43:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 2/3] mm/memblock: Add reserved memory release
 function
Message-Id: <20250211104318.7847e50326089b08222fb09d@kernel.org>
In-Reply-To: <20250210190306.6ffda2c7@gandalf.local.home>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920224789.826592.13627374781649157364.stgit@devnote2>
	<20250210190306.6ffda2c7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 19:03:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Feb 2025 00:44:08 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add reserved_mem_release_by_name() to release a reserved memory region
> > with a given name. This allows us to release reserved memory which is
> > defined by kernel cmdline, after boot.
> 
> Since Mike wrote the reserve_mem code, we should Cc him on changes.
> 
> Also, I would make patches 2 and 3 a separate patchset, as it is unrelated
> to the other code.

OK, let me make a separate series and sending Cc mm maintainers too.


> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/mm.h |    1 +
> >  mm/memblock.c      |   72 +++++++++++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 61 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f02925447e59..a7201824c1fc 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4197,6 +4197,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> >  void vma_pgtable_walk_end(struct vm_area_struct *vma);
> >  
> >  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
> > +int reserved_mem_release_by_name(const char *name);
> 
> Should be "reserve_mem_release_by_name()" and not "reserved_mem" to stay consistent.

Ahh, good catch. I confused reserved_mem and reserve_mem.

> 
> >  
> >  #ifdef CONFIG_64BIT
> >  int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 095c18b5c430..9962fbb90597 100644
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
> > +static DEFINE_MUTEX(reserved_mem_lock);
> 
> "reserve_mem_lock".

OK.

Thanks!

> 
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
> > +	guard(mutex)(&reserved_mem_lock);
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
> > + * reserved_mem_release_by_name - Release reserved memory region with a given name
> > + * @name: The name that is attatched to a reserved memory region
> > + *
> > + * Forcibly release the pages in the reserved memory region so that those memory
> > + * can be used as free memory. After released the reserved region size becomes 0.
> > + *
> > + * Returns: 1 if released or 0 if not found.
> > + */
> > +int reserved_mem_release_by_name(const char *name)
> > +{
> > +	struct reserve_mem_table *map;
> > +	unsigned int page_count;
> > +	phys_addr_t start;
> > +
> > +	guard(mutex)(&reserved_mem_lock);
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
> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
