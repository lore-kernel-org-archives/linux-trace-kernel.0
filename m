Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DF3BB113;
	Thu, 27 Aug 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829513; cv=none; b=EqHIIrPIVycYt7zRdeNFZA6Etc2DCjqBgAhOxe4Bxqms1BeqJA0gRGCPRIwYsnzIwYnzbKq+9hTYzwHz6POzOUqMxWn6ZJJ8AN6Os99EMUGC7hsyCNvVP3fI+xuLb0D5Je+VqqWcG6OIycO+Ih4Njx5k/78jZOoFpWUAllSHeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829513; c=relaxed/simple;
	bh=+TRvDqchYoIwTYgqnq/cOtGwCvEcbUaVknQvACncHRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsZPf5MBhRkl2FxxafyXShUgrITPNW7Np5+yX9dyd4Ps85Z+hdYSDUJgexzvqVLAHtMRNrmUaRBxntdnrMI2h7Je41nBvOGFqgiqIsQUvP0hGyUNdnrOCq9VeYJpDeKPZQBFFHD3YTdc5YEmXDU7hucBNihOusZoBCnEwvEzLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC6qIxE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC6qIxE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FF01F000E9;
	Thu, 27 Aug 2026 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829504;
	bh=UXfBo8v3K8VIzDSO2VHXgtuPrAb/8lRFr7BXsf++oYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DC6qIxE0KrdRhnwTpQj+mqOREb/P52l2gDOdyFApoE8VA1gv3wcCC3cG1+ykL3FjI
	 gLV3FcWtR1+Q8HXEsmNwdHlWMLmr6Ox5CZzzOTla/i+4zIByVE+n7H9QeLbqUQogTP
	 HINaxGjyQ2EfkOvrIiHXrZQ/YuvaW1nAJ04hK9lO596nhxDAP9PBO+TTzqNAXyYD8y
	 jFe48V+dIKFBme7rHsNveL4VaiDtgdVQ6BFNh0GS6CIQwxW+R8p1M0PGA1lY/0j4F/
	 kjvulu43FN0rQAskUM5hgMh93Jh6XhGXLIM5ckhruJrXivG8JmUlG0gU47N82N0yaF
	 KlpeMGvJUSCAQ==
Date: Thu, 27 Aug 2026 12:18:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH 6/6] userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP}
 into single VM_UFFD
Message-ID: <apAcweThjiD-iIBF@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <ao16VxNvaYzlt2WG@gremlin>
 <ao_9R3CbjYFipFu7@kernel.org>
 <apAB9GSnHNyNoSc1@gremlin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apAB9GSnHNyNoSc1@gremlin>

On Thu, Aug 27, 2026 at 12:16:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> So actually you're increasing by a cacheline and increasing the VMA size by
> 64 bytes, i.e. 1/3, which is unacceptable obviously.
>
> Maybe there's something that can be done with:
>
> 		/* forced alignments: 1 */
>
> Perhaps? But that looks potentially ugly.
>

I say elsewhere (or think I do) but to highlight - I think probably we could fix
this by putting the flags in the low bits of vm_uffd_state.ctx?

--
Cheers, Lorenzo
