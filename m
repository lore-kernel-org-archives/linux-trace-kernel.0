Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55509273D9D;
	Sat, 12 Jul 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752316911; cv=none; b=lG0W8/cIknm6y7j8Z9jQb7TFGwxLCLtd0g+plzav0ESdT4QhafjWxO0GVQKN8ARyhiGwI7x2NY9G0sYwfPX1NMjzyx5Ed03oMMugktKK4TC/CtsGOaAaPs6dJCRam4uWEi6gQKbkINQo2obtpFA87mXr779SYRfc+Ob/C8qgBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752316911; c=relaxed/simple;
	bh=uhkko6lxzqS4fMuttaVaa4hYcvfET1Jjb/aEOaNG8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXuAIMKm1WO8RQZ5p54JpHQpenUobDjclgT5mcL408iuDbuBmOMf1NUs7NDmmwo7dH+Lwo3RRKm9/aFcYb7K/sOSSEOxBX6KURFXtt7LqbQHXlsRgFyiMRG8w37M+u8LsmHttIVkj86IXpTiiAKX0xh4APVs/8L79dthsCeCq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awhjzOiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awhjzOiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175EC4CEEF;
	Sat, 12 Jul 2025 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752316910;
	bh=uhkko6lxzqS4fMuttaVaa4hYcvfET1Jjb/aEOaNG8qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awhjzOiKN9yS82/DPfNPKEZBLSnG5fAeiYvYyxQpZ5Qnp379MywJtNnCU2EpXhpQj
	 HSyPbhi+X/el+Vyqy4tlgLHm2NnJYwsqFfv34zxieb5PkawZQAz8/vHf5YaNwTv59U
	 H7jT/6PVDGiwT/zKASqWLKkquco9DEWyjwUMtzQnzY6tU2852LA+Th/rxuRiODnoAd
	 d+qjtzAGaVCQg1oGgK3Us9MGFN8hEJk7GRCCZhTk4xPnLMGiy/bz407jNeuGxMjvTb
	 O5Gq9ZRNHw2P1Mj7C7dOM3+oWa5RILXuXWrHFApdBBOi0OJ0nPvpTT46tcN/uawJ3k
	 ttnwEaGIequtg==
Date: Sat, 12 Jul 2025 13:41:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 2/8] execmem: introduce execmem_alloc_rw()
Message-ID: <aHI75JXSDodh6iSx@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
 <20250709134933.3848895-3-rppt@kernel.org>
 <784081fa-0fee-4df6-b8d5-6435eead877f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784081fa-0fee-4df6-b8d5-6435eead877f@kernel.org>

On Fri, Jul 11, 2025 at 04:29:48PM +0200, Daniel Gomez wrote:
> On 09/07/2025 15.49, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Some callers of execmem_alloc() require the memory to be temporarily
> > writable even when it is allocated from ROX cache. These callers use
> > execemem_make_temp_rw() right after the call to execmem_alloc().
> > 
> > Wrap this sequence in execmem_alloc_rw() API.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> 
> > ---
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index 0712ebb4eb77..6b040fbc5f4f 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> 
> {...}
> 
> > @@ -387,6 +397,21 @@ void *execmem_alloc(enum execmem_type type, size_t size)
> >  	return kasan_reset_tag(p);
> >  }
> >  
> > +void *execmem_alloc_rw(enum execmem_type type, size_t size)
> > +{
> > +	void *p __free(execmem) = execmem_alloc(type, size);
> > +	int err;
> > +
> > +	if (!p)
> > +		return NULL;
> > +
> > +	err = execmem_force_rw(p, size);
> > +	if (err)
> > +		return NULL;
> 
> You don't need to save the error here. That, allows err declaration to be
> dropped.

I prefer to keep err = ... It's more explicit and clear this way.

-- 
Sincerely yours,
Mike.
