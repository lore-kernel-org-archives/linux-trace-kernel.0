Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C986329;
	Thu, 21 May 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376206; cv=none; b=RD650SuuFuUFzHx5oHGoty5fZdw9HriEDVhRAiL+CvIWVeJIhHUO3fAZKiWA1pakP/DDzBOuUrRuIE/LhXRe7RVwxnvBph3SSjbpluRFeMo1uGaVn5TLMREPEXI5MzXt4x5MxH3eUFj0K/M775cx7SLzN82KYx8qhSfJU0rjr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376206; c=relaxed/simple;
	bh=G0G5aOL+eU/pFN2zYhXxj8RIhBwaJebA18iecgHvrDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul0g9Dihy81cenP3fR99h4NiTpU0AJ3WdLVN6F8DZTDGvwZA5+UqrB7U9DST8TNCpZczqWf3qKRiwi0LqCifUFKzYaHh/fnYZRO0JPsTxNq11bVwV594lOkQX1KORnIssghVM4ZcVhv/v7xM49kvBWliRUKXqoJx2p6HrvM5tEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=upj6C5S9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="upj6C5S9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HfKgnmkxzmNOJLZxt74jCmZIPMukmqle2YeHK8y00YQ=; b=upj6C5S9PNg5BasGyzMLk2eay5
	kzmMWjqxrq6r3Z2kso/qvUxTL0mHvuGR+X/jksHgbq8u4wXddtU8ZF+kqcR8tn/rXegF4kKEBQEdt
	Yltq+1WpV3NUrdqeNHFsmQMSE50B13SspoS8/YXUVLd97D+m/ssmZJvkSTCy5BsDZv5JsxSfMKMvx
	7pCgygy8UX1dEgY0W62oijkmvV4kCwOXHFgWs02GTWVfgLTeV1bP5NlItNOoFlYN6DV+aSrfZVnDD
	O9n/PvX9uGbxJi2fzotLNFrW7urs+VFKjXl+O+kMd5Oy7+2mlPvfcZrQ5/RShRmdQKpwFTEJOs/fP
	so16I8bw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ51Z-003yDF-2C;
	Thu, 21 May 2026 15:09:25 +0000
Date: Thu, 21 May 2026 08:09:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: linmiaohe@huawei.com, akpm@linux-foundation.org, david@kernel.org, 
	ljs@kernel.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, shuah@kernel.org, nao.horiguchi@gmail.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, liam@infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v7 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <ag8gDkHNWT-92Jjd@gmail.com>
References: <agXcPleVC9LGVCmj@gmail.com>
 <20260515070353.87244-1-lance.yang@linux.dev>
 <agcbfLHT5ZWnNeN0@gmail.com>
 <f76b79d3-080a-4931-873e-99d4b3e1020f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76b79d3-080a-4931-873e-99d4b3e1020f@linux.dev>
X-Debian-User: leitao

On Sat, May 16, 2026 at 12:06:14PM +0800, Lance Yang wrote:
> 
> 
> On 2026/5/15 21:13, Breno Leitao wrote:
> [...]
> > > 
> > > Wonder if it would be simpler to just do a positive check near the top
> > > of get_any_page() instead. Something like:
> > > 
> > > static bool hwpoison_unrecoverable_kernel_page(struct page *page,
> > > 						unsigned long flags)
> > 
> > Ack. We probably want to call it something like HWPoisonKernelOwned() to
> > follow the same naming sematics of these helpers, such as HWPoisonHandlable()
> > 
> > By the way, I will re-include the self test back to this patch series,
> > In case they are not useful, we do not merge it.
> > 
> 
> Sounds good :)
> 
> Can you also test the relevant page types if possible, especially
> the ones the new helper is supposed to classify?

Ack. I will expand the test to cover different page types as well!

Thanks,
--breno
