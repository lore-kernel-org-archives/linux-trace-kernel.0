Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3FEEDE;
	Mon,  7 Jul 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901157; cv=none; b=l2d2/pt6RfQzWNYTbCla62LC6TNMNUs0cAdxy6CIQXvZ0Ee1rIHkJDwQshGt5WYuImoEItwViDF6J1XtG8pKObljTvm+VyRmho9ChYsdR4TvXXm4Hepvvkdy8r4Jk+VYo9XEPCuKdylIQGlSPLib7Dondj0oF7lW3hQfzcZg6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901157; c=relaxed/simple;
	bh=86jv6TqQn5yuh5DalX835vrMiMFE7du1E1IFZ2wdSCI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeMdI9iMUgWrbpOUTodFHsh60/asOWIef1v7EIV6cDxK+rWr02DX3tqMXFiKFosDd2Xp3lyi03r+0UT2XlWwYE+drnFCjHO1YTOkkSqWuSPjHbY8eFeFTyv5usbi3yePJK1qCJ1m9mufvE82X7+eLTObyBDojG0skziZUCuYYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r96uYTz0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r96uYTz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E95C4CEE3;
	Mon,  7 Jul 2025 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901157;
	bh=86jv6TqQn5yuh5DalX835vrMiMFE7du1E1IFZ2wdSCI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=r96uYTz0WB9wY3LKuWZK6rlfZqhyqdaLQusdcI2E+FktIkUIJmnKPaFAbCDBXs5HD
	 44gRL3Y8HZwj3DulGdYnLzZwalxcgGYc0uiO7l/go6sCjEbIoQpGSzvAVwmYu+yUMp
	 yDgS7q2BDW3oAoI2gqkPxwGOix6TYp5XJjfPxPG6NyQhHhYHhFb3pzvBfBs7mKrjhs
	 tjKc9VEAPk/70oUF3roMlpayKy595b+PlgE1XSM58B+cpgfyep6F2jMnTroqSNYq0P
	 DifSAle8BcSNfrVK62xhqfX8JOjErV7PDTrnrLGa5UrAQPvUZlOBy4jmPt/fmOOxRP
	 yI53p7unEOKrw==
Date: Mon, 7 Jul 2025 18:12:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aGvj2gUHntuuOp4H@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
 <aGuwMtxsouXvdiCK@kernel.org>
 <oez2aoegd2dfq4h4fg2on2rsgwp36aumpedmobxkj7dlmaoeyr@sqz27uhgf3f7>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oez2aoegd2dfq4h4fg2on2rsgwp36aumpedmobxkj7dlmaoeyr@sqz27uhgf3f7>

On Mon, Jul 07, 2025 at 11:06:25AM -0400, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [250707 07:32]:
> > On Mon, Jul 07, 2025 at 01:11:02PM +0200, Peter Zijlstra wrote:
> > > 
> > > 	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > > 	if (err) {
> > > 		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > > 		execmem_cache.pending_free_cnt++;
> > > 		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > > 		return true;
> > > 	}
> > > 
> > > 	schedule_work(&execmem_cache_clean_work);
> > > 	return true;
> > > }
> > > 
> > > And now I have to ask what happens if mas_store_gfp() returns an error?
> > 
> > AFAIU it won't. mas points to exact slot we've got the area from, nothing else
> > can modify the tree because of the mutex, so that mas_store_gfp()
> > essentially updates the value at an existing entry.
> > 
> > I'll add a comment about it.
> > 
> > Added @Liam to make sure I'm not saying nonsense :)
> > 
> 
> Yes, if there is already a node with a value with the same range, there
> will be no allocations that will happen, so it'll just change the
> pointer for you.  This is a slot store operation.
> 
> But, if it's possible to have no entries (an empty tree, or a single
> value at 0), you will most likely allocate a node to store it, which is
> 256B.
> 
> I don't think this is a concern in this particular case though as you
> are searching for an entry and storing, so it needs to exist.  So
> really, the only scenario here is if you store 1 - ULONG_MAX (without
> having expanded a root node) or 0 - ULONG_MAX, and that seems invalid.

Thanks for clarification, Liam!
The tree cannot be empty at that point and if it has a single value, it
won't be at 0, I'm quite sure no architecture has execmem areas at 0.

 
> Thanks,
> Liam

-- 
Sincerely yours,
Mike.
