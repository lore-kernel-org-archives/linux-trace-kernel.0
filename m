Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E757D528;
	Fri, 12 Jul 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775611; cv=none; b=Yjh7l2N8yXMlrtglc1LXBU2RmUDJ2AqgcMrj+JehRMcfjZAY7PoZ7Xw94eBui9oEuVaOVk3lnNmVklvUKtmbizYMSye+o0Al1zv3ede8guihQDecFhW8h7THOfX+9+1M2HYglULWBFvUYXK5SUqSBTPv4BI71E8AyQFTicxavXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775611; c=relaxed/simple;
	bh=hMvYO8BWkE32Nv4UoVWnX83NGmh2+P78oihiB8x7kBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltj2O5LDjk3oeRksxd5Ghd4OBFda+3Sk+8czdZGsqK5ZIRQDZ5q4ygA9pj6lwyiZghBBEhQYdTNRHaPi1nbWHduT4/vj063ynUuw/w6bCISMtojnKjHZvRL6qBoKvFNLDnpbb8W8u96H/41NWxacCNV+1gF+9fgKOwpgt1bO1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LyiUHIb5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LyiUHIb5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hMvYO8BWkE32Nv4UoVWnX83NGmh2+P78oihiB8x7kBo=; b=LyiUHIb5omPkbjuwl4YQqcEhFh
	Qau7/17wV/cbw2pYK4+jUZVv74aJEpb3RIj4oTGh++T3F+SGRTmJTXeIJqKhFK+SDYr/EtdOH6SUo
	chOqlFc9OuXVBspir+sjB8otq07+Tp2o3E3LRJRsCaAo/NOY3jXl7H/FRvWLZgTaxGv0MJLeTi3LC
	0W+D89A0bCODYjRoM1c7tMkdwKdUbcebgWFNE5uBBjLZARrApjVlI1I7g5T83s5mNrDSPO1xW3wep
	JKLf+HxnhsHvldF7kIRlLo1Ajm9ID/CpDu3inxhsTFi/i/38dUemVH1mp3rnl/iv4ss5Hz8Tnj7Jg
	mA2NJu5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSCLE-00000001Ggk-0PIx;
	Fri, 12 Jul 2024 09:13:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B591830050D; Fri, 12 Jul 2024 11:13:23 +0200 (CEST)
Date: Fri, 12 Jul 2024 11:13:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
Message-ID: <20240712091323.GB19796@noisy.programming.kicks-ass.net>
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

> You should only need not-too-old Clang to build everything (Clang 12+
> should work, I believe). But do let me know if you run into troubles.

A quick look at the thing shows me it's full of BPF gunk :/

Which means, I probably also need a kernel with BPF and BTF and all that
other gunk on -- which I don't have on any of my machines.

Esp. the BTF stuff is a force kill on all my builds as it completely
destroys build times.

> But then I also ran it on Linux built from perf/uprobes branch (these
> patches), and after a few seconds I see that there is no more
> attachment/detachment happening. Eventually I got splats, which you
> can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` command
> to run it inside my QEMU image.

OK, I'll see if I can make it work.
