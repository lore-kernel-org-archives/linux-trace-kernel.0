Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1E169AD2;
	Tue,  7 Jul 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432572; cv=none; b=taYumzN6lpCIo3QakQy4JAFxvgfK2aV0vTCpFzkeJN0N6m/SD/rQCCSOQXdMO71JnRW5Q+FLvsPA+XYkOmlCbgFpyRWuyWgjoZ+dgjLLKiAfLgLwX5kqE9lFC0fa1ENhNYLsjMuIng4RNURIKrFztUOQ4iLlXXRq9INBd/Iw9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432572; c=relaxed/simple;
	bh=HH7585n9BrJ9aDdyJlu5AduC3qK7epSeuHvw7eseJt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9EyAeQBvmEMeKgJouEoxk+AJOa53XGqXIXlLId0hvhGUBBb6iSmVr4vlO1bZjs4LKG7QqF6fVGyhEPVRD8eIE9Fwww1KQtTK2+n7I1N+XDBeJplL5iKw/JuB3Ej4KE3DcDrp72BGhCNkTjoYbt5ejT+VnaPxPba6aA5mgdrJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHSztCqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHSztCqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D671F000E9;
	Tue,  7 Jul 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432570;
	bh=YsulHPPV7cKKpq1pg5kBYTKSehBdOYqpjZso8VAZf8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jHSztCqNcZj5l1XY/Li9FJ51I+dsx9ENmMATmd3nYd+0ajUD5ZifB1uUJ9q4KamlW
	 cPnXiBcj/QaYeQJXAeJMjWEBAj3fzm9z8t6C0wam9zU1sJGY+MPP0DqWFqX+3iPUmx
	 4SBO109ZVTumz4UAuIGT5Q1ivLHFzXak6Wdi3+6BJfMH3NsEj4yUozA97CkdeaMeeX
	 fxJvwm9EOzQMajTkgSmlJomKTKjsjIUgNueiY/6T4FTtV752sp1oTetoK34IwHwcUs
	 J6FFP+JXPFkxkc9YSQwWMqfcioCsuSe+9bWB16ILqHP1dCwKo0DfjMz++b/AZWNhtf
	 vVwzU6cfNo94Q==
Date: Tue, 7 Jul 2026 14:55:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com, 
	bigeasy@linutronix.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org, 
	jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
Message-ID: <ak0EsCeucJarlI7G@lucifer>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com>
 <akz7ythMxfIZeT0d@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akz7ythMxfIZeT0d@lucifer>

On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
> See above about deduplicating.
>
> > +			ttu |= TTU_RESPECT_MLOCK;
>
> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
> being compaction here.
>
> But I'm confused anyway. We have the folio, why aren't we just checking for
> PG_mlocked() here instead of getting the rmap to see if it's mapped
> anywhere with VMA_LOCKED_BIT?

Also, since compaction_allow_unevictable() is a function that is accessible
elsewhere, you could literally just have a TTU_MIGRATION here instead and have
the rmap logic call compaction_allow_unevictable() instead rather than this.

And then you could adapt the function I suggested before not to take a reason
parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
TTU_MIGRATION) in.

BUT. I still question whether this is at all needed since you have the folio you
can check for PG_mlocked...

Cheers, Lorenzo
