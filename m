Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD41459E3;
	Thu, 11 Jul 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699635; cv=none; b=siMLL2M6BpCZCwCEsQVUsDLymTsdIM+zldn/PPWQYeDX9UB7ob2Ep0Dq4JvyBDTtIwVHiMOrRJ3rhimVgHdxiqV3Pkn7dhGb43w/al4n0nw7zdKUXgRChyzQ5sejgaK9YG3U6u8GEwEJF4/CAwQnhODdpQvjvYTCPFvFcbvqMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699635; c=relaxed/simple;
	bh=lLMLnjBynYhZUXz+S4tKFZLOvZPOmoclTxjeDESK5Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxpC3dbTgBKMPXJBkwaktZmuRtToad+MFivLf8V+Yt3/Fe4S6vX26h8qz0+zQw84Z/xEApMNnjeFWMLyK8GwnJ+j0zmiHlo7jXwVHzW/DHWqDbG8tEhBWDYVanFIk5rigpsQMng+qSoO6geLVpRgMlmASfX447XfyasWK2WSGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jPpuFEBS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jPpuFEBS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sq/HVJ4Fr4lluTVPg3YHH5DQYCCk9RTZxt3ePPZVqgE=; b=jPpuFEBSUjKGbjh+lYHn7+fKWm
	cZ5V0IPiBp8MWYmRMoE2MOsHTtXNyJAEPYK1nZZ0R6HDInzzSSJV7dG5iiVVvHFkz5LVRzgPeFJ2W
	ZRAcV05NiuazxGfPdejtdZ4FS84WjVr+4OpP3larWFc97t1Vfng/atEB9jQ8qOsJvWMZcYVBgisKt
	cljVOlPVAwGUq0V5LNbMveZPLG3qOernLEFdl01/3eKROV+QXIyh45yytIyl532qENyQlOebdDMo2
	g0BrzSnU7kntB1QNWQr2rIZ+9a+d/V+WOBdDW41kbcupPQKqaO4WcbUMUxL9A2atPatJzT/NL2vWr
	U+Exxc+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsZo-0000000166m-1bHt;
	Thu, 11 Jul 2024 12:07:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0172930050D; Thu, 11 Jul 2024 14:07:07 +0200 (CEST)
Date: Thu, 11 Jul 2024 14:07:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 01/11] perf/uprobe: Re-indent labels
Message-ID: <20240711120707.GL4587@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110400.309670567@infradead.org>
 <Zo_IzLWMXOzu34pT@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo_IzLWMXOzu34pT@krava>

On Thu, Jul 11, 2024 at 01:58:04PM +0200, Jiri Olsa wrote:
> On Thu, Jul 11, 2024 at 01:02:36PM +0200, Peter Zijlstra wrote:
> 
> SNIP
> 
> > @@ -1159,7 +1159,7 @@ static int __uprobe_register(struct inod
> >  	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> >  		return -EINVAL;
> >  
> > - retry:
> > +retry:
> >  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
> >  	if (!uprobe)
> >  		return -ENOMEM;
> > @@ -1468,7 +1468,7 @@ static int xol_add_vma(struct mm_struct
> >  	ret = 0;
> >  	/* pairs with get_xol_area() */
> >  	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
> > - fail:
> > +fail:
> >  	mmap_write_unlock(mm);
> >  
> >  	return ret;
> > @@ -1512,7 +1512,7 @@ static struct xol_area *__create_xol_are
> >  	kfree(area->bitmap);
> >   free_area:
> 
> hi,
> missed this one and another one few lines before that ;-)

Bah, _ isn't in [[:alnum:]]. I'll go fix.
