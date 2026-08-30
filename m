Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974525785D;
	Sun, 30 Aug 2026 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068178; cv=none; b=W8tA7+8lDyuqCBnokRVIAdy7iJ0XuIpvAhyrI1bIxi9gAxE7s0lF4AB51/Pf+eK5Jt6Llgiq9lUPK+DKWYvD0WvVZRje59B1ijzpofBCF7ogp/izZrT9VKm/Y1IrGBdjgyF0Ttyczg6bymuUu6g1OcxvSbK3RTQJQlTm6R9JYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068178; c=relaxed/simple;
	bh=ppANgCqYjbrHGJPNi8JX7qDzvfAij53sX9+QybYQSlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaDsuKmUL6jHrGL+pnnD5SfZkn3nPRs2VRk+QhYsCm3zfoOuPIRowjgo7mbxz3H9ydG3amYGDnmgn7hXLXMMJ4PoJIKKPkjK4xTXb3zHgOnDhUwrZd+NdH82BikAamYaJuiPQ2W4KLecAtLM7nEN1xRACDsQpC+bVTuhQETZiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5e3f3zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5e3f3zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AFA1F000E9;
	Sun, 30 Aug 2026 05:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068176;
	bh=dbu7Q3qcydpbduK5d5xuw3bm+6kDkYu6ps7F3h/cYC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F5e3f3zrh6K28tm/qQp6Oue55tKOTLOm01Yu0X0OpWd11buxJM+oaQZgRaPgAlviw
	 orfhumU4zI6rXgZbcTbz0VyTxjMqyrqmt1yX+dwx/pPQKPoDwxaZymNkiEKL37jeMy
	 m8iwifd6CBos3sCjQc12VSH5HxST5TNAz8sS8HWLLTXtD53zgpGszWjYd1Udf6YqOi
	 RItioxeawc68IRB5v4ZTiIT2/t0l07vAMlA5MEkxNFTdL0oaOKmRwu/l+811BFK+ra
	 hPrKDWDpFPIFCqHB2QRZ5eP+KTGkOQHlKN9AYVVTraJss062/hlCVu+RUurmS761IA
	 JU6btVfCDBo7Q==
Date: Sun, 30 Aug 2026 08:36:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP}
 into single VM_UFFD
Message-ID: <apPBQQ-850DwlCVA@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <ao16VxNvaYzlt2WG@gremlin>
 <ao_9R3CbjYFipFu7@kernel.org>
 <apAB9GSnHNyNoSc1@gremlin>
 <apAcweThjiD-iIBF@gremlin>
 <37f6af95-950e-4457-886e-6548d4719f0d@kernel.org>
 <apK7s4xSgA_GmY7d@kernel.org>
 <178802897277.671075.10362065249796431311.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178802897277.671075.10362065249796431311.b4-reply@b4>

On Sat, Aug 29, 2026 at 02:42:52PM -0400, Tal Zussman wrote:
> On 2026-08-29 14:00 +0300, Mike Rapoport wrote:
> > On Thu, Aug 27, 2026 at 05:19:30PM +0200, David Hildenbrand (Arm) wrote:
> > > On 8/27/26 13:18, Lorenzo Stoakes (ARM) wrote:
> > > > On Thu, Aug 27, 2026 at 12:16:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > >> So actually you're increasing by a cacheline and increasing the VMA size by
> > > >> 64 bytes, i.e. 1/3, which is unacceptable obviously.
> > > >>
> > > >> Maybe there's something that can be done with:
> > > >>
> > > >> 		/* forced alignments: 1 */
> > > >>
> > > >> Perhaps? But that looks potentially ugly.
> > > >>
> > > > 
> > > > I say elsewhere (or think I do) but to highlight - I think probably we could fix
> > > > this by putting the flags in the low bits of vm_uffd_state.ctx?
> > > 
> > > if that's possible that would be clearly preferable memory-wise.
> > 
> > This gives only 4 bits and makes this completely not extendable.
> 
> Wouldn't it be 6 bits? struct userfaultfd_ctx is allocated with
> kmem_cache_create() and SLAB_HWCACHE_ALIGN, and most of the flags are
> only available on 64 bit, so it should be 64-byte aligned in the
> relevant cases.
> 
> (Not that 6 is that much better than 4... but it's a little more wiggle
> room.)

I did remember that SLAB_HWCACHE_ALIGN could be as small as 16 bytes, but I
didn't verify it for architectures that support fancy uffd modes.
 
> It could in theory also be bumped up to 7 by setting align in
> kmem_cache_create(). userfaultfd_ctx already takes 192 bytes due to
> existing alignment. Aligning it to 128 bytes would make it 256 bytes,
> adding 64 bytes to each uffd rather than each VMA. But this sounds like
> more pain for little gain :)

Yeah, even with as plenty as 7 bits :)
 
> > So I think I'll drop this for now and wait until VMA grows another cache
> > line or until having per-VMA uffd state rather than a pointer to per-fd
> > context is a must.
> >  
> > > -- 
> > > Cheers,
> > > 
> > > David
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 
> > 
> 
> 

-- 
Sincerely yours,
Mike.
