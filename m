Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CF18C16B;
	Mon, 15 Jul 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054744; cv=none; b=tBJFVcwhR/nFc4+jfMiaMZFvmxEBy381pmjzYd6PsNrJfm/kDrWWpeq5HKLc6arzTsjMbFfC4n1f+65a1rEX3uEp0X3bpbZVHMtPBFcUDD+DNTwOpFQGXOxlzDVy2cnUkf5yr/+puORAZLvBRq5PgC999LJJMKzyIlARheff6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054744; c=relaxed/simple;
	bh=XmhCps4yzO//fsjGo1NlfXN4ZiHdGW2EBPxLS3Y6mF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0ql743ClBN+/Zd2KyEUw1m66EE/yeSu/7JqeOqYTPobIjwgkOZ0IBMy6bbgfir+Y27eucbG0K7Ri+J0AjySJg+aXsSrvJwjIygTLumgWuKKVf+s5HCEAbwg5hS/T0LRmUSwCawGirUqUdGs82ZNJQd8/RY3d+V970Eggbfdqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TLvFXNCi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLvFXNCi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XmhCps4yzO//fsjGo1NlfXN4ZiHdGW2EBPxLS3Y6mF0=; b=TLvFXNCiwj1COYjynS52a+ahkZ
	0FbQTITL6lyKZdSWhXJvIKBWjaSTqP1UfyqDsxeVH9ZzmFrMOPiHeAVF819AVdHdP9SxiQWDhjIyS
	Txd/nzAbftN/4ulpJqqIauFBKCGSoL7LCADHqFEhK6QPNeUj9z/BjomA6u23wM1fkyaKG+woqI8n1
	Q9xanNwvrgcypT2fcRFEegYNNLMZSD4x1qa8OAoBW0ofs+9h0LxplSonu/gB8jS7LvnqeBLuHVOm4
	zQid8EahouBK4xfoW8NqS8J8xpzLe88cELYAQpUghm3WFpMSotnFuI4LXMaTxghMXwxv81H6LRvCS
	p1FoVYwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTMxO-00000001o9R-289x;
	Mon, 15 Jul 2024 14:45:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B12C3003FF; Mon, 15 Jul 2024 16:45:36 +0200 (CEST)
Date: Mon, 15 Jul 2024 16:45:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
Message-ID: <20240715144536.GI14400@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>

On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:

> But then I also ran it on Linux built from perf/uprobes branch (these
> patches), and after a few seconds I see that there is no more
> attachment/detachment happening. Eventually I got splats, which you
> can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` command
> to run it inside my QEMU image.

So them git voodoo incantations did work and I got it built. I'm running
that exact same line above (minus the sudo, because test box only has a
root account I think) on real hardware.

I'm now ~100 periods in and wondering what 'eventually' means...

Also, this is a 2 socket, 10 core per socket, 2 threads per core
ivybridge thing, are those parameters sufficient?
