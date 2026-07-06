Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493825A359;
	Mon,  6 Jul 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355031; cv=none; b=jHTqFHHqgDvdMjDpwaBRgg+9ozWA46/CkKDZgyQJaHQSouG5nvQqXSQxoL5QW+tcokfzxNmyvSAYeR26bM5+G0bVwB8Mr4h1RPAVZf5pbKA9/Ng8Fr+vimqmjn9MA/4/RHj7TJi3K/0X3CIPcuNna7MTtKk/WFLdqlyk2B9sTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355031; c=relaxed/simple;
	bh=GcZm7hTREYj/AH08uyg2/jGONo0jqSBiDWmPpkmxnrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTH1hQzVT1rQQ6DVIfr437B75qTPpH63V9vAa6fa4ZcA4xgXiktQv7GfDeJCj5cIU/FXsCPcdCS/pLFwrlrK+xS6aspqMq9fJuFnjjMCLzNLqvzHkwSbyblfpYF5DWcDTWCblgfbIpQakgR+x4ntdb/m1nqTRHWS5aY8/BKruV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBIeOIrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBIeOIrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4EB1F000E9;
	Mon,  6 Jul 2026 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783355030;
	bh=7wHt8+HkNGnM0KxjsEMNSxKDUZE1xV28kMigSgeCFxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mBIeOIrQabVsxIUz+QOTSD9LBsdjsg87Mq8zSzYyUz4LPP7CDEzQ/vXsHMoLDtrgf
	 dEZt5lYkdRunGlUtVvX95Jdocdjo34KBqgi4ZxbDX/a03zrCfiitxcWoSJOgYkZ92V
	 z2ZlbKtgb8Yho0Vgdg8LygVvEPOOybAj/HOCNsHkO0ruI4Vzs+jcxnZWNvy8klXH+u
	 xq327ySGBvoJo4kBrfXUCEsTViLRrJzFefIhUhtjWcLX3SBKMin8qwtSYeR7qVn2F1
	 pJUdUUmIhUpgmGX42UzmCLbQCclvOhhX5PvmoGVaqj1KFDM7Dahd7c+/BShR/kPSba
	 iAQ4vh4KfzR9w==
Date: Mon, 6 Jul 2026 19:23:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <akvWipFuwLt41wOM@kernel.org>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <akjS7kiGjVwWaWEz@kernel.org>
 <akvSzb0mRSS5aCg_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvSzb0mRSS5aCg_@gmail.com>

On Mon, Jul 06, 2026 at 09:14:22AM -0700, Breno Leitao wrote:
> Hello Mike,
> 
> On Sat, Jul 04, 2026 at 12:31:26PM +0300, Mike Rapoport wrote:
> > On Tue, Jun 30, 2026 at 05:46:09AM -0700, Breno Leitao wrote:
> 
> > I'm looking at these awk scripts and od encodings and I wonder if wasn't it
> > simpler to write the test in C.
> > 
> > We have a bunch of helpers in tools/testing/selftests/mm/vm_utils.h for
> > accessing /proc files and there is already /proc/iomem parser in
> > tools/testing/selftests/mm/pfnmap.c that also could be lifter to vm_util
> 
> I'm fine with either approach.
> 
> My main concern is keeping the selftest decoupled from the feature
> itself, so that review of the test doesn't block the feature from
> landing. Would that work for you?

Sure.
 
> Thanks
> --breno

-- 
Sincerely yours,
Mike.
