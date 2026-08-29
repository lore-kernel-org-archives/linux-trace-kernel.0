Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3375809;
	Sat, 29 Aug 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788001218; cv=none; b=RR7XTUMizAWPxCsHZ37lAv98Qf5HgficPbQwg5PyN7LdsoaUxrIKySfiTI9BU8e+/Ecd5Ea61woZWq3wLdwUzIRaCHR6FHspC1XUDeIreoAyb9WqKrOirnqJ3wbitW3NvJQJ11tefmOuGng8reqyhnPRaGOD+cxOVo6kMf97iZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788001218; c=relaxed/simple;
	bh=ioxXzp74CW+7ObdcFL8p7Q1p8/W90TOj2urXj4LNitc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRht62Z2XXaLs8h91IxJdaiu1DyTzUmyNpn84SCMFSHr/ph1ks23cNXcNiSZhMJ+2QP9py1elTMCoOxVH6PzYRUOUotgxNQlfzNPnvaCWj8TpsrOULifTuMIkex+ak/9su2Iajt9BLmhRiujdV+VNFALgIcfk+ZeLs6ArEA+B58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuX452UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuX452UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACDE1F000E9;
	Sat, 29 Aug 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788001217;
	bh=gXc6uvmEEbs0tjpDmzTEGwxIlYg9TWDsfiwiPxngOzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuX452UXi8Md7T20vL745dUi69Ui1QV/KOxLJj/ty2S9fwWxlS38Y55KfLpQWahhr
	 hopl168pK0jYYEkNMg236NXMW6s3gtPGn3OvYa4cKJiZ3YyALIKdJwqiSbyfy7rnrL
	 PXnGZl2bYgkAb+OsTZMJfjlYbazbGpwXeglNtUEFeqIgSiw59ymCfL5oNAX0RsVmLf
	 T2vqLfykJ4tJGrDwUQkkVsFB69QnkEz41lElPHW4pzsVHGhlXtNPu50Q2Esmi3tJng
	 O38SgqKGHA2jitUBjxGfntIUAYcJMU8BeA3MtqD6nWhNjIAqTUVLfyVtTFW8ciUo3x
	 Kn6KLeUl0ZKlQ==
Date: Sat, 29 Aug 2026 14:00:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
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
Message-ID: <apK7s4xSgA_GmY7d@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <ao16VxNvaYzlt2WG@gremlin>
 <ao_9R3CbjYFipFu7@kernel.org>
 <apAB9GSnHNyNoSc1@gremlin>
 <apAcweThjiD-iIBF@gremlin>
 <37f6af95-950e-4457-886e-6548d4719f0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f6af95-950e-4457-886e-6548d4719f0d@kernel.org>

On Thu, Aug 27, 2026 at 05:19:30PM +0200, David Hildenbrand (Arm) wrote:
> On 8/27/26 13:18, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Aug 27, 2026 at 12:16:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> >> So actually you're increasing by a cacheline and increasing the VMA size by
> >> 64 bytes, i.e. 1/3, which is unacceptable obviously.
> >>
> >> Maybe there's something that can be done with:
> >>
> >> 		/* forced alignments: 1 */
> >>
> >> Perhaps? But that looks potentially ugly.
> >>
> > 
> > I say elsewhere (or think I do) but to highlight - I think probably we could fix
> > this by putting the flags in the low bits of vm_uffd_state.ctx?
> 
> if that's possible that would be clearly preferable memory-wise.

This gives only 4 bits and makes this completely not extendable.

So I think I'll drop this for now and wait until VMA grows another cache
line or until having per-VMA uffd state rather than a pointer to per-fd
context is a must.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
