Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CE3B27FA;
	Thu, 27 Aug 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822502; cv=none; b=N8OZbgWlVpmrylthuQzBTFvzfqVn6jfKhOvut2TbDzTmm06IYAcmj+m727m8zQgxKZvtqK64G5h/bvVEnJXeoJSStDsVOc7NdIGhYUYOIzYb31RsM8E5QkiGtIBKVaaQT4ZjwGN9/0yG5/WunLETG4ij1oRjbA8m90VwpyR43ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822502; c=relaxed/simple;
	bh=n4z9h38OfpEH2Q8HujaPpay0A2etD00gYp/7BjEfmXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoLWNwNikTDhysPSQ4lU20jyDTpL/RyJ3oniGOt24qZbDu2zkxay0rq9NpW9XNp01qjRH8nMsQO2lzlktQBVF9XxkjcNb67cnsvnPIW7B7J9aLKQWh9X00HuiftsJ5zafQ4yEyJ9P9FygCFiRp47bp1tF032d71YVhW7X7yKGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpAIlQkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpAIlQkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA07E1F000E9;
	Thu, 27 Aug 2026 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822500;
	bh=n4z9h38OfpEH2Q8HujaPpay0A2etD00gYp/7BjEfmXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jpAIlQkz8SPDBEHr/++so/yIfXSgHbjIgfwBjM0AnESqfPxYYIyw7mOcf1VeWz7H7
	 dWc4G8Vcvna7EtYgW14PuMnBFfwaPSUMhDnXDNvcmrutWQ7/KBlDuNTWG6SGTzAs1f
	 bgtSdTc44WUrqbLs4fbf5ciNiUUewPvph2b9Jd+E2+wDZbdX5GUlbjgb1jL5QIYFBu
	 cdgtM2FcQ73fbrZ0kcJCIslqpAVgKKMSGrnLPhHpzWPpatzuBD1YjPnbvVMgQVgEc+
	 csnfU7xXh4lo7wlNL/iEsZ9D+OX4gQBBv/Z/FxAM1NFJ19iVi9bi9ALqP+KcOBEFB7
	 4CHak9EewcvJQ==
Date: Thu, 27 Aug 2026 10:21:31 +0100
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
Message-ID: <apABifdLFy3ct2IN@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <5bb86e34-6196-4b50-b553-be2ff7c1fa32@kernel.org>
 <ao_sCh5zP0IC9H2S@kernel.org>
 <e8aaddde-0a07-4197-9874-5ca0ea8af43f@kernel.org>
 <ao_-uZrrsVX9lzbz@kernel.org>
 <01aae5b4-ee10-4601-8ddd-c9428e11d651@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01aae5b4-ee10-4601-8ddd-c9428e11d651@kernel.org>

On Thu, Aug 27, 2026 at 11:19:01AM +0200, David Hildenbrand (Arm) wrote:
> I lean towards just calling stuff uffd consistently might be cleanest.

Agreed. Let's use the same naming everywhere please.

--
Cheers, Lorenzo
