Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00183C3F7D;
	Tue, 28 Jul 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231009; cv=none; b=Bb+87jvBGivFFGvFmH0W76YcyS0JIO/KgIhbDdPKR/XHFiqsYuVjplAlxrkFq3pXnX4xQ3OxzJaiDs1eTR0doaeqye/txM4Lm6smA5V13QoUIWeOU/7UweoM986QeuhMWRCA59ie/pJ14vDnN7PJlv4hUXoId8SUlsk0LSetizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231009; c=relaxed/simple;
	bh=u9fU8EMWAxoQsNdnxe5q6WpgEwE6mtcAmc6+r+g7ejc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXRfToPcrlbdDcTU7VmMRgwET1kpcpqhQRZs0cFjq5Y0bIsufEooA+ltLzvBYaxqYBqCnDAffC4t62xmTowLAHs5C1BgrHjjyOGfqGeFDIGAKMd3IN1ZO//Yt2bnfSQupoUPh6BssMXVG/SpoOyMUhsSsHYvXkEPDNHdnA//ZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GuBEno1T; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GuBEno1T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ohxPJwzY/8M7Wi6UDani9iBOICXrnJWyNUrb+Njoc54=; b=GuBEno1TGrjyfR5/do1cSGpmJg
	QkB/oHpscLnb3m6pPryje2Utr1FaGjGv52zoD7Rd6BMXWde76KPuE9XG5C4elQyDLb7j85pwXGq33
	SRRjeVlqKAvYcrJsAw8FTI+520qLTxu2sfEHxngLn+ec+Cx+wZo4/B3VrAGaJHR2IWZc805JNUoVM
	9jQx0Xj1qIgQmY1w6ez503ypOsJTM9PRCNzPexmUBmN644jNA5yZWuqUs2eKztXfT048vHy1eI96U
	NibGf3p+u/FSVQwiEuFf4O47cbG4CkQH8XF7NKlW8ze42bmn66b8zissvkkKN/gptpGtCTAWWoF44
	MCb/2I3A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woe8A-007Zpo-08;
	Tue, 28 Jul 2026 09:29:46 +0000
Date: Tue, 28 Jul 2026 02:29:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <amh1nZVVaaZSGD3M@gmail.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
 <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
 <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
X-Debian-User: leitao

On Tue, Jul 28, 2026 at 04:57:13PM +0800, Miaohe Lin wrote:
> On 2026/7/28 12:24, Andrew Morton wrote:
> > On Thu, 9 Jul 2026 11:34:05 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >>> The script is intentionally NOT wired into run_vmtests.sh: every
> >>> successful run panics the kernel, which is incompatible with the
> >>> sequential "run each category in the same VM" model that
> >>> run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
> >>> ksft_* wrapper so a default kselftest run does not opt itself into
> >>> a panic.  The script is meant to be executed manually inside a
> >>> disposable VM (e.g. virtme-ng), one variant per VM boot, and
> >>> requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
> >>>
> >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> >>
> >> With Mike's comment addressed:
> >>
> >> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > As I understand it, Breno would prefer not to rewrite the selftest in C
> > at this time.  IOW, we stick with the bash version for now and add
> > "convert this to C" to the todo list, OK?
> 
> Sure. Should I make this change or should we wait until Breno has time to do it?

Apologies for the delay. This is on my TODO list, and I'll prioritize it.

Just to confirm: the feature is already in mm-next without the selftest, so I
only need to submit the C version of the test, correct?
