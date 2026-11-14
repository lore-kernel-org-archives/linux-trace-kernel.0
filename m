Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679130;
	b=TIUH3sRAvLPVLmobeWmWgp83okrWzN8S2fUpBZXK6UJq4xgRI45a/mHMp8ktxb/6j0wI
	 cCpEmatt4h0LzasCsGxGsvzWdwvkwANxAPHB53+22JUT8qfFMFdqtYA/Q52/m1QHAMXNz
	 Ah/Zj9zGHYO2J5/1bY2b/IeXdCLUZoJMeEzjzA+bbs4RTcRUYo1mycj+EQ3R2tWx8V/3r
	 iHChe7eM+XjbdUn5TD8SHIiuX9lP9eBqAqnmlNScVSWid6hGghYY/5J91Md9LrFqVSUI/
	 H0YBuv0RgGZxEvZSGFmC5GAFpZyadpliUyFUQLvE660VLoDN7wGDGHMDVthkOj3UaYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679130;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/HQvy3Bf+SmAOhrQqSVfFUq9G41+E/cdawcP+LkvJ7k=;
	b=jzbbllll4W2yb3M96vRTAP58mRAqvfpz8E6HsH5V5OIkBoZcoY4TsESA2FtVK5XFINdy
	 6VKq7jfiBJaah1avaIWwUFM+o7ZOTOLhM//YhCpoZNT9MIlWTQuuXW4cU3G+Cneva1sTV
	 b//EQYHwaUgAPGFKc6QMYHhyVXYAuFT/ChZ4gJdlefkuuKHHU7jF3cZQNaasMBthvgpIF
	 TS8Pv8CPTvXFmJkRPjJ+b+eThkuaI79E/Gg6sWREqP71q/+cg8w1epj8p34QtJ1p1osyw
	 n2+BP5OYlK/agPdiBc9XnnrlPKKScDvb0z9GciNO0BiBW2sS4aD+Qwe0QX3B6V1x5Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8mR7pat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF85606A323;
	Sat, 14 Nov 2026 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8mR7pat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3851F000C4;
	Sat, 14 Nov 2026 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794679130;
	bh=/HQvy3Bf+SmAOhrQqSVfFUq9G41+E/cdawcP+LkvJ7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8mR7pat/AgWFEZudjyHd7qJBB0qQTOZWAzhwI7OKAco/3FMbPxpm7r6J9z2NrL5K
	 zZXPUFSkOwIalYeVT18FocvsBKg96UZd5zOLhGAflrdGsckEbf+bMqkdTquefCO1wP
	 eSUTsPFlNyU/yvae/e7nKC/z5iHwTytOrnpqjJW9Nrh3KEwZiH8M/G2j3RGSZILKyi
	 x0TDM8U7JFia1yyzVyYUvzq1uCt2k3vFI8O/t0subTSzLfoKO0LUQjthEzGudkGUNP
	 qQcj6uLH38Z0cXP+LUByAoxmrAp62uB/S9dh9+AR0xOn7VtX0Rgf5A+K3ipjRgzwK0
	 svq8hq1b/3v4w==
Date: Sat, 14 Nov 2026 17:58:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/userfaultfd: prevent poison marker loss
Message-ID: <avihSinN3BWkw2sS@gremlin>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>
 <822c1c7e-bfdf-4570-bf30-08f187e7253d@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822c1c7e-bfdf-4570-bf30-08f187e7253d@kernel.org>

On Sat, Nov 14, 2026 at 04:39:44PM +0100, David Hildenbrand (Arm) wrote:
> On 11/7/26 00:51, David Hildenbrand (Arm) wrote:
> > Unregistering userfaultfd leaves poison markers in the page tables.
> > However, once unregistered, hugetlb PMD tables can be shared again.
> >
> > Further, shmem page-table retraction can discard poison markers even
> > while registered in missing mode, and fork() can skip copying page
> > tables containing poison markers.
> >
> > To fix it, add VM_MAYBE_UFFD_POISON and set it before installing poison
> > markers. Preserve it across unregistration, splits, merges and fork(),
> > just like we do with guard markers.
> >
> > Use the new atomic VMA flag to disable PMD sharing and page-table
> > retraction, and to force page-table copying during fork().
> >
> > Move VM_UFFD_WP to bit 44 and make HAVE_ARCH_USERFAULTFD_WP depend on
> > 64BIT, freeing bit 12 for the new flag on both 32-bit and 64-bit systems.
> > Expose the flag as "up" in smaps.
> >
> > Losing poison markers, while unpleasant, is not really fatal, and the
> > use case is rather a niche thing. In addition, we rely on the atomic
> > VMA flags infrastructure ... so let's not CC stable.
> >
> > Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> > Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
>
> Ping on this one.

Ack, will have a look.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
