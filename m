Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FF1FF7C5;
	Tue, 25 Aug 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661953; cv=none; b=PGqx3DfnRSVDnxEZ9bC20AJA5yhC/A69JuFvxeU8xscp+9jNAFjzdovsxijWr64tBwP5K+TcSYdfX12Wx+HvkzMtuRLzUHogjd3itoJrB41MD+BQEjy9tU0ZUAcyDkOzbDe5np6rkt3TzjKKxnVnZCgGKGU98iBQQDFbt7jSZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661953; c=relaxed/simple;
	bh=HmU7Nx1JQE3YxPhX+v6TAS2KEkW3fAfvmpp1LlgfD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmjyYijK4dB4BWbfxSN0uqnKrXBNXatIC+SFaIVQKYWEC1YWoMrT6ORzbXZCDeA3UJ2d8hp14rr4k6nLsGg72T/KyNOYVVndMGqUav+ph//02E0ri6gLU384uyYAuKeFeSNtFY4oTh4ZkzaImXVYoJh08vYAEWkZeFlmamo1wJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrQeZFxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrQeZFxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D541F00A3A;
	Tue, 25 Aug 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661951;
	bh=HmU7Nx1JQE3YxPhX+v6TAS2KEkW3fAfvmpp1LlgfD+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FrQeZFxFXeX4LKudQJw20QTFvQnO22SmMG56FnrB8ggAxqyHNYAmRrDt/U5lQp2o9
	 xD+k7xpnj2S8whkR1WdLH0svZP3kuSymzo+wTdxkJc/2n5edsDZ5cJRohfzF9iw6G4
	 IkjJvlB4YOLDHmNGUWqU3rgH+dNXpRpHT6EUpBjyobO/kfK7IeYn7Uf2JWjaJjcjN5
	 Qc73mVM2KUtXpsULAKT8QcnDJ34cwDJ1dV+0phk/lTP3asmXoYQy99p/E4oyP0gCJ0
	 M4RarS4afzXUSN02FSIwBh6pLVN/oJZjZX8rm0QttrMbjnMn/gRxqKT9d+neMslcNs
	 ujeukwwwcgftA==
Date: Tue, 25 Aug 2026 13:45:40 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
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
Message-ID: <ao2OYvbEIOfwBuoD@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <ao16VxNvaYzlt2WG@gremlin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao16VxNvaYzlt2WG@gremlin>

On Tue, Aug 25, 2026 at 01:44:23PM +0100, Lorenzo Stoakes (ARM) wrote:
> Isn't this patch then a bisection hazard where the previous one makes the flags

Ignore this one, I realised I was wrong and forgot to delete :)

--
Cheers, Lorenzo
