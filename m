Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E31A5B9D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653215; cv=none; b=QyghbMOl4R22cyoh7l8puhz/ys5lE1AjY8xpDb5Yj2nh8YZ7m/2tB+8RdonswYi1qkuMPrpZCk+49bk5vSqJkq0e9QAgQ+hu1UImXqsjFpjYjF1Kw95TCY9NzwyAD/9PHKrn+sWIJHe3tq06WJh0kDWZBpr4okyWKj7F3Xejq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653215; c=relaxed/simple;
	bh=701lOG8MnSEq2jYr/EnElfdCx8O8JpQZoT2tBXYB4wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7vZHQkyAIrJZ4jbWB4k+54yXBehA2fcgWGezHCxEoFr8HvrncCAlge30rRdtp8078bqIGBoJZzgxTG8vBmyQs7zvW2mqrWO8Lt9IVNA67DvN8tFrhCE60ar1RA/LoHIf15tqUnYqY8NPRG1mTAeBT6q9uzACIcHxyj/x3NcTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+ier64v; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+ier64v"
Date: Mon, 5 Jan 2026 14:46:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767653210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79XQ6RhIGnnd6I8pgKkQJHOMbLiB8lF2So69igEwoAA=;
	b=m+ier64v0ySqhJplW6HeK3ggP5za7wzEsI8O1Mi7sF7RtzARaAI+0KouF0WymvLfEpoi8q
	c/eE69n5lmrQbmNm0pZMo8QOfRVl22T8I5vPS31HaY0wIFx5eVi3Nj4px35wU5+0ahtUrj
	8F9BnapdxHXTjcKjQpiD/rROVMtRgcc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <62ia3v3oduyt2srkaneccoei7cwimifwduarteyn2ugpmmbw3p@rivcqvcksgpt>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-2-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105160423.23708-2-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 05, 2026 at 08:04:22AM -0800, Thomas Ballasi wrote:
> Memory reclaim events are currently difficult to attribute to
> specific cgroups, making debugging memory pressure issues
> challenging.  This patch adds memory cgroup ID (memcg_id) to key
> vmscan tracepoints to enable better correlation and analysis.
> 
> For operations not associated with a specific cgroup, the field
> is defaulted to 0.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Couple of comments:

1. memcg_id is u64 but the patch is using 'unsigned short'.
2. I would prefer memcg pointer be passed in tracepoint and then in
trace header file cgroup_id() be used similar to other users in
include/trace/events/ folder.

Orthogonally I am cleaning up memcg id usage and after that cleanup,
mem_cgroup_id() would be preferred way to get the ID. No need to do
anything now as I will cleanup this usage later as well.
