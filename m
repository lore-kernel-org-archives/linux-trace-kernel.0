Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEE13B5AF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728806219; cv=none; b=HWo4d/KXEr7J57aOx4zkE772CsWRTiQ2JHTu76Cb7V2jUv8LegED9JNcW6mFrSqCZWTJHCqMLcDyRRoJE6YvZNab8KZ61hX7JFCRl0lJZoRhi6W4zTV7qD59x7hL49Jc/+/JNmUnu/01K1NxTLaBmWYEGlj9hcJF0DkoePUyNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728806219; c=relaxed/simple;
	bh=D48w3EHfC4XQxOzpIIrw10rJRqxgNy/vry9jE7GFnEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZhKQ4RTo1xsaKsf6y48p+08iZEM7XfWcgAoicpAWQyAptvv3I/X3gsAWkpcPweubAV4h2Qy2CbWvKc+v6wcD9XU5FR2l+EfzPT9pW7qaN1PCUy4lVr+uI39+0zIoabAWwx3XvPqFN3/FMd5jwRjRjLe94ZlpdHU3Oyp53CE0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OhvQ4iYg; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OhvQ4iYg"
Date: Sun, 13 Oct 2024 00:56:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728806210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IS5ld+TSbl+kNeWYScFUSy7z01NMJzyZaBDFgbTS7x8=;
	b=OhvQ4iYgQjx1Ivs6+rhB5cpNBwGPd/E5l5cDdaNPjVzTE/2cfC+hf2xYcTR/DKozTU4ojp
	Qlm26be7xHp0rZ+QnStIMg3L+9bCvlr04ioz18Z3+NkoWCTNc702C5gPCjnTBW+3Q8VuOc
	oOKozOG5j3pb4yABfFfmnMxsT2Vgw8w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
Message-ID: <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-3-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> To increase mm->mm_lock_seq robustness, switch it from int to long, so
> that it's a 64-bit counter on 64-bit systems and we can stop worrying
> about it wrapping around in just ~4 billion iterations. Same goes for
> VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> 
> I didn't use __u64 outright to keep 32-bit architectures unaffected, but
> if it seems important enough, I have nothing against using __u64.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
