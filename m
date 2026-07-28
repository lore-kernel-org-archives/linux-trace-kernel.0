Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A73B583B;
	Tue, 28 Jul 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276474; cv=none; b=ezUJqmyyKji5Fj+5KI9BRb4vWz0aYdASp0OriOcT7weJrt0lH+pnFEhHwlFZTWoqEj+bu5R6vvn3Kxcj6+Eigh4O5bvYhZZDuxomRfyy+7Hokayi3zBzWxn6cgzizkbSPVjbtHCR291CmAoA9PZ3HkP6dvM3rZlFUWQe8UH6SVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276474; c=relaxed/simple;
	bh=UolEMvehXsDCGXhOGT+PQ60dtlXW5Fj3xlabNsXIbZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tULlbw3EkQV3SMH4lRgw3vLU1Wzs5D6tHDIIwl44sGMBV4lxLjEz3ujmIxbw2pS84oxXx/1I4tFQ9mFOMl7nVdWSIveIDnkwju6266YzhI9mnmidEOFUhQU3AWnyx6Olqvw9FfSJ5ZkbzF27HmAULlg+ssLx62kE9nvpJjupQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LNPOGY2E; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LNPOGY2E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W4Dy3XC6qV1NBDVHSm+NbhvnKY5yieX/MYpP17k22sI=; b=LNPOGY2EtqaZoCfhvpiM1Z9mVM
	R47JO4wkihzNcB0yiiZcpYy9lpohbIafNUZ3l2vHDkbSbGhdvC4gRNeckQrQswUlR5ccBYvJ/MT7T
	30w9YM7x5pbW+UBQvlt4cR/zgunFQN2huxclA4gwk7WAA1qFsLtwB8QpCR8TaLJyBB+5ajZAhFziX
	Em0SlWdrnF812sHKXQcLyJkjU+YE2XW9vv3Vxn5beDDTppE5uxrj+l+2aDH+ie+/J91Rt5Lx3njkl
	9XQiyF2OD4EmnrQzcvhvdz7E5Lr5JR8fjDHfhOAvdyCipuZ/5hpEGKGTd8UDF8VSPVlnpQAyDsDGC
	SKT30P5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wopxV-007zAH-0m;
	Tue, 28 Jul 2026 22:07:33 +0000
Date: Tue, 28 Jul 2026 15:07:26 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <amkn21ftNme48Vbl@gmail.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
 <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
 <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
 <amh1nZVVaaZSGD3M@gmail.com>
 <20260728122016.30752d36c3b3c3af231efa9d@linux-foundation.org>
 <44f81bea-d64a-4f73-8665-46652a928c83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f81bea-d64a-4f73-8665-46652a928c83@kernel.org>
X-Debian-User: leitao

On Tue, Jul 28, 2026 at 09:21:40PM +0200, David Hildenbrand (Arm) wrote:
> On 7/28/26 21:20, Andrew Morton wrote:
> > On Tue, 28 Jul 2026 02:29:39 -0700 Breno Leitao <leitao@debian.org> wrote:
> > 
> >> On Tue, Jul 28, 2026 at 04:57:13PM +0800, Miaohe Lin wrote:
> >>>
> >>> Sure. Should I make this change or should we wait until Breno has time to do it?
> >>
> >> Apologies for the delay. This is on my TODO list, and I'll prioritize it.
> >>
> >> Just to confirm: the feature is already in mm-next without the selftest, so I
> >> only need to submit the C version of the test, correct?
> > 
> > The bash script is still there, no known issues.
> > 
> > We have the thing and tests are useful.  I'd say retain it until the
> > rewrite-in-C happens?
> 
> Nacked-by: David Hildenbrand <david@kernel.org>

I have a draft of the selftest in C already and I will give it more bake
time, and I will submit it until EOW.

Sorry for the noise,
--breno
