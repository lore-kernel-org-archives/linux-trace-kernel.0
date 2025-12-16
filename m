Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFE33D6DF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911023; cv=none; b=pf4GDN6+sh52UiWcA5slUXtc+4nehSUpHRCh4NpD5IzteCgkQs+36raB3GkvdwLJydPHHgsqFWMR/cwkokfdeLHIXxAtUv3cUvK+eVuiI2JDA7O+Ri7z2Qf/fKD6V4lOe9yNwx4X5i7eSmjdWdXWZ6/D/mYaTbb4LcpvC4/pSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911023; c=relaxed/simple;
	bh=n8lCrqrB+R7yxlMUpXeA8qdR1ZIZiA8UzQ+HvvDttq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB9YmzajgTbVUIzs6bNr3xyQfsJocMTBxr/ldHspuBGc5//1ypvuOfO3reTx05ol7uvKIUyyALabydIZik8NPjLJXq4dIpKCVDepe1mi1TKTmN0Y8fJyH3b4z4fPJQQOwlmsUCNrZPaOVB8fh54+NT7MqQ/7u4cE9VOyka0AkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o5EDx6I+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o5EDx6I+"
Date: Tue, 16 Dec 2025 10:50:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765911015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoRglrMxu+eacAPa08o6kdXKC07L0bqVNlSWnxZl7SA=;
	b=o5EDx6I+vAidYIyuKW4KOdyNctXcWwX5Au2gYnCqREfUxuVpua0PrSrtTTEu6PfH+n8okX
	IsHY7qYBvws10cXUE2ZgH1gEhlsLW/PpFJJydiKDgcA9JKxXwbo2DoD8BdCIluJYmfxLN4
	iXvza8+ptelhHI74JQt9PkrUR97w2OQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <stm4ixcvtc6bwr75fos6w6anfaqfgjpe2mtt76zfrb2y63bat2@grvm7kzfz47n>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
 <20251216140252.11864-1-tballasi@linux.microsoft.com>
 <20251216140252.11864-2-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216140252.11864-2-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 16, 2025 at 06:02:51AM -0800, Thomas Ballasi wrote:
> Memory reclaim events are currently difficult to attribute to
> specific cgroups, making debugging memory pressure issues
> challenging.  This patch adds memory cgroup ID (memcg_id) to key
> vmscan tracepoints to enable better correlation and analysis.
> 
> For operations not associated with a specific cgroup, the field
> is defaulted to 0.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
> ---
...
> +		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
...
> +		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
...
>  
...
>  	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
> -						      sc.gfp_mask);
> +						      sc.gfp_mask,
> +						      mem_cgroup_id(memcg));
>  

...

> +	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed, mem_cgroup_id(memcg));
...
> +	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask, mem_cgroup_id(memcg));
...
> +	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed, mem_cgroup_id(memcg));

Please don't use mem_cgroup_id() here as it is an ID internal to memcg.
Use cgroup_id(memcg->css.cgroup) instead which is inode number and is
exposed to the userspace.

