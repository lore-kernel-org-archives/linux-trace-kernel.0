Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9023955EB;
	Tue, 25 Aug 2026 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657903; cv=none; b=MdanWYaPvV4moZMV+JXqNbk3lZCm/r8OAW76SrSStCLmG7IdrpJJo67dOlR22A48vAbHKKpdJ8+7evCrhNpefv3z/CCpSYOgLyNTlZcdp6ZTV8QQpZWKm1ZkQ2jyvnkubobrB5tlG98VRzjyfhlisbqyz3DuJ0fZicB2z4/SYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657903; c=relaxed/simple;
	bh=5f5YopjlFLeF3Izpn2etmBG19MnPLOZHESikMHgRfz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhMP5mtyaNXJBOaoQYuj5n2paF5CX248bFJzqWwsoF3PXdvJfmcmG/uk5oaq7hTEH+SvVgt4dZxIa+V7EignbgKo5JtasgISTFljStxd7oIBScWg9UOMH/nFTlFiQgC2NIXV3M/lJy+1uNp4vN2m/APaTdtRbTWQzypphpuTSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBsTwrPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBsTwrPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C21F000E9;
	Tue, 25 Aug 2026 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657902;
	bh=kYx8aeMEaBJjieFEUuIAbUN5rp+4oyE9/j58DZHMqKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nBsTwrPQM1EQ8ZVvH2h8CSQlt+V+fybz/E5HCoH1g/6G4NmVlh47TTU4WNrrp7BTQ
	 otqVRkJ8bbmT80kozyp9ZvsMUg5aBhbrwe0yHgKbbNAYPIhIaQu02bC2LrQk2qqb9n
	 AB75JmSK9W2uBSF4XKy5BXp7jwWI3ljH6atrax4n1CxRmyLlMV1oJg5csmXS2gGHog
	 fQcR4lL4xGda1kycL3mKxp7F7Ho3WSZUcQ7cAfviSNgwcvlbo1IReMLbNd8TfUU4ZO
	 fIgy01nc4DqVMvUcIHG5+dXyvvi1epORsPRXyxX/D1/XsphHrPL3o2MmxlGgrWv3Bf
	 TaHkq6xODc69A==
Date: Tue, 25 Aug 2026 12:38:12 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
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
Subject: Re: [PATCH 5/6] userfaultfd: decouple fault reason from VMA flags
Message-ID: <ao1-FMVkGlTtGDNy@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <aoxm4jUrmL1eQlCJ@gremlin>
 <ao1waln1lklfk8th@kernel.org>
 <1bd9eac9-e078-42c2-b12c-bd8b92efeae5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd9eac9-e078-42c2-b12c-bd8b92efeae5@kernel.org>

On Tue, Aug 25, 2026 at 01:08:33PM +0200, David Hildenbrand (Arm) wrote:
>
> >>> @@ -2793,14 +2793,14 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> >>>  	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
> >>>  	 * resolve the fault.
> >>>  	 */
> >>> -	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
> >>> +	if (!pte_write(ptent) && (reason & USERFAULT_WP))
> >>
> >> I wonder if you could actually
> >>
> >> You do this quite a lot and they read a bit horribly with the && and & on the
> >> same sight-line. With the changes to the enum proposed above you could do:
> >>
> >> 	if (!pte_write(ptent) && test_bit(reason, USERFAULT_WP_BIT))
> >
> > I find && and & perfectly readable and adding _BIT defines looks really
> > excessive to me.
>
> Yeah, that looks alright to me as well.

I find the general inconsistent different sets of flags/bits but not
really/naming all a bit of a mess.

But these are largely aesthetic and I don't maintain this file so I guess
you guys can live without my tag here...

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
