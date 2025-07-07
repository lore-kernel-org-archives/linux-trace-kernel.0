Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B821FF36;
	Mon,  7 Jul 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887934; cv=none; b=mLqL14YZ1NAr9d5suZ3fvsuVzWi2dGyw8FWFBzSTt3sHIrawUOhFvRMakrAonBNldm+FgtpD/mh2eODJxXdGgNPhjW4PtsQVoD/BZl2wlL/W0eJjuF7whrZDTrvUMr7wK5gCao4rTIXZh3A1Ru1J+dx0IVqsmG6ZgUDHqG7Fz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887934; c=relaxed/simple;
	bh=KJ9ivJDcFfm+HtMTDVXkf8LFJkwB6s4Vcp0E0EjRA2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkG688BjzStHvNHkKqfuwnJeZnDyrPHaZp+9+S7GkDcN1g1nnXnxDyKEJy2tgT7jvQ1f8R+gCki5EtjFqEfPL/113SUVjoLboBZlkSiFcWLbeHyOtmgnDgNAC2FpuyXkZmYlctsAN96Od874Z9mYq+qSagWtFrh4iUUOwht7u2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObJ/+U2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObJ/+U2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FD5C4CEE3;
	Mon,  7 Jul 2025 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751887933;
	bh=KJ9ivJDcFfm+HtMTDVXkf8LFJkwB6s4Vcp0E0EjRA2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObJ/+U2noTTkjAYPn1YG/pdjcVIrO/IOmmZsAYxhvnAnuEEw46VjHz21QdgfI8cKT
	 +7NSFG8lrtgTjmywMa+vSb4IahbVlsmSRAt7+EOguDQ/KXOcN8yLq86WtCfj/iQqjm
	 iMnILzLyLzqgvWZ5zRVkCEoY3pLWijnv0qT9pHeJUcS4/EAG4LuQpQTCw+mOWrmedl
	 aoeDXJgFYb5adTum4hw3gLcZESV5SUWXdTax8l3IIvEL1mxa5h3565ySjNU1Le1ZWW
	 MVAlLNI7a0P/eIN7r3+qI4dWVJBoCnTb9ClSSRXMoxWDHybNjqnWeOkN0VfAVYkCjz
	 dJOZ4soLHExRg==
Date: Mon, 7 Jul 2025 14:32:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
Message-ID: <aGuwMtxsouXvdiCK@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707111102.GF1613200@noisy.programming.kicks-ass.net>

On Mon, Jul 07, 2025 at 01:11:02PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 04, 2025 at 04:49:38PM +0300, Mike Rapoport wrote:
> >  static bool execmem_cache_free(void *ptr)
> >  {
> >  	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> >  	unsigned long addr = (unsigned long)ptr;
> >  	MA_STATE(mas, busy_areas, addr, addr);
> >  	void *area;
> > +	int err;
> > +
> > +	guard(mutex)(&execmem_cache.mutex);
> >  
> >  	area = mas_walk(&mas);
> > +	if (!area)
> >  		return false;
> >  
> > +	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > +	if (err)
> > +		goto err_slowpath;
> >  
> >  	schedule_work(&execmem_cache_clean_work);
> >  
> >  	return true;
> > +
> > +err_slowpath:
> > +	mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > +	execmem_cache.pending_free_cnt++;
> > +	schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > +	return true;
> >  }
> 
> This is a bit if an anti-pattern, using guard() and error goto. Since

Good to know :)

> there is only the one site, its best to write it like so:
> 
> static bool execmem_cache_free(void *ptr)
> {
> 	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> 	unsigned long addr = (unsigned long)ptr;
> 	MA_STATE(mas, busy_areas, addr, addr);
> 	void *area;
> 	int err;
> 
> 	guard(mutex)(&execmem_cache.mutex);
> 
> 	area = mas_walk(&mas);
> 	if (!area)
> 		return false;
> 
> 	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> 	if (err) {
> 		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> 		execmem_cache.pending_free_cnt++;
> 		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> 		return true;
> 	}
> 
> 	schedule_work(&execmem_cache_clean_work);
> 	return true;
> }
> 
> And now I have to ask what happens if mas_store_gfp() returns an error?

AFAIU it won't. mas points to exact slot we've got the area from, nothing else
can modify the tree because of the mutex, so that mas_store_gfp()
essentially updates the value at an existing entry.

I'll add a comment about it.

Added @Liam to make sure I'm not saying nonsense :)

-- 
Sincerely yours,
Mike.
