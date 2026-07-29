Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0953CF208;
	Wed, 29 Jul 2026 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315206; cv=none; b=CtSI1qsWDV+sg/lO8xd/FU1xkRtMDac9F62cKUBIifNq8gVZ/KL5fgvs2xFF4TW42UQr7oZiikWCTinSERD/y82vcQwjPc01t3BjibRFqT0AgMVlnYBJW9XeO9zN/I3btxNcDY7e7P2+aXT3JZrdQXeOXfaPfenmivizVquhgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315206; c=relaxed/simple;
	bh=Ss/DaoJYNqjgpN1lAskphAlKNITya8LLU2vIUgnSPIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4P1aGQ/GTqpddK/tdc6yS1MKnybCNPONsuMWl0DOmh3/fN+VfHqtgzll2zYDLiEaz5Xd8gkXq3SgfXBB477ZvE3+PtdotcBkUvZliLpfSX7HgBWFkfOuSj38Yjom6jJZDctOs7hj3LEwodLHkw5K/9fnLcO4rtMgxMaA4mnSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kKo2A1BQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kKo2A1BQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ss/DaoJYNqjgpN1lAskphAlKNITya8LLU2vIUgnSPIA=; b=kKo2A1BQR3Y09foW8g7qBwUPmX
	NYROK6U4J0bpmZKOyfm1oFEXpv3CNR7vfCuRy+FO0mbwp84eXe/JU9LFMYD1ge1BkKqbwxKSdae2K
	4KqnPzg5sQt3KaFOUT+/Qrql0v/KSWTs/CgLao7wTcgECQR7c1SU6cLiV/gtktS9ZhLLmN4GgWr2O
	4ki88TRZvcEBBLW+SutP4Up07yWZHIh4rfIlySxODkjQaFtKxlBp0dlXMiRmcx1UyuRLTtaUU1YqS
	/p7TeB9eHR2ldVifgdc8dOspz1w740YC97n3B9wlxbYGxnj8yYlC1HwuqWePIDeQM51EBozdKJoZv
	akJNbqqw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp02F-008KmC-2v;
	Wed, 29 Jul 2026 08:53:08 +0000
Date: Wed, 29 Jul 2026 01:53:01 -0700
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
Message-ID: <amm72Bu9qmWLI-9b@gmail.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
 <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
 <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
 <amh1nZVVaaZSGD3M@gmail.com>
 <20260728122016.30752d36c3b3c3af231efa9d@linux-foundation.org>
 <44f81bea-d64a-4f73-8665-46652a928c83@kernel.org>
 <amkn21ftNme48Vbl@gmail.com>
 <f83d5b26-b369-489b-a305-1eb5ec6fccfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83d5b26-b369-489b-a305-1eb5ec6fccfb@kernel.org>
X-Debian-User: leitao

On Wed, Jul 29, 2026 at 09:25:16AM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 00:07, Breno Leitao wrote:
> > I have a draft of the selftest in C already and I will give it more bake
> > time, and I will submit it until EOW.
>
> IMHO there is no need to rush this test here, we could merge it after the main work.
>
> We neglected our selftests quite a bit in the past, and that is biting us now.
>
> That's why I push back hard now (sorry) against stuff that is different than the
> rest and not easy to maintain.
>
> I know, hwpoison-panic is a destructive test, but I really don't think we should
> just merge mostly unreviewed bash tests that will just bitrot.
>
> Which makes me wonder now: should this actually be a selftest? It's nothing one
> would just want to run in a CI. It will crash your machine.
>
> Maybe this should just be a tool in tools/mm? I really think so. So having a
> nice C-level hwpoison-panic.c in tools/mm might be the way to go.

Agreed. In v6 [0] I actually removed the selftest entirely, since the value
wasn't clear and it seemed like an ugly duckling.

It seems tools/mm would be a good fit, and make a better home for this
type of "test".

Given more changes coming in memory failure (at least from my side
[1][2]), I think it would be a good idea to create a subdirectory
(tools/mm/memory-failure) and keep these semi-destructive tools in there. Is
this the right direction?

> So let's rather make this test well maintainable and have it properly reviewed
> than rushing something suboptimal.

Sounds good. I'll move this to tools/mm and resubmit. Given Andrew has
removed the selftest from mm-unstable while keeping the rest of the
series (which is fully reviewed and frictionless), so I'll focus on the
test tool now and send it separately.

Thanks for the discussion,
--breno

Link: https://lore.kernel.org/all/20260511-ecc_panic-v6-0-183012ba7d4b@debian.org/ [0]
Link: https://lore.kernel.org/all/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org/ [1]
Link: https://lore.kernel.org/all/20260717-hwpoison-kho-v1-0-9c5eda551998@debian.org/ [2]

