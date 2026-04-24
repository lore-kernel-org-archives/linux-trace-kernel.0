Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C3126C03
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Apr 2026 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776996969; cv=none; b=Ilvz1EAzQihg4mfPRPHiJ/1BgeZlGa59GSN0EG+40rWw5s2+cyzdVFwMX9Wj0XkdXU1Jlpg6X7xQdo4a21GP9PMGtgdGl6WkLE5BEagRfyhQ6lg/x68Fy982isu9IBdoStWKE/nN/gGAMyZYPqEbnomTFm9i8prXwQuHaC7YBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776996969; c=relaxed/simple;
	bh=4w3IuS/oqHzLqud/0898Trb07IbeiGQMNDs3L0TT/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Xgh+ZXDWAcJYxMYbw8FtETA3T/nL+Xof6joulzW1riBy+Fk6VfF3+BJAZMz+MMfbXRhDkQ9hNFnc5TtYIKC01swX5zsTfyTkWZ+1wcp0e7i1ZHdxWPKjequ8D5Wb5KDZFVkqZYAl8Uroh0XyGYGX4OuHWNNcaPDQ6VlRrpgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wH9fOxRu; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wH9fOxRu"
Date: Thu, 23 Apr 2026 19:15:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776996966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dlxddP1P9He+AYlEf35eXxMUf+eEDoqi9U/ypnXl5w=;
	b=wH9fOxRuWf451/O8ybKiEaL2t5dS/lLC/mg65WFbJDBPxLQD92sK8Nr9NGZLzpTk7oHtih
	l4FDnlBfQA4xowe0r9Bo91650RHYbhyxtcvZy9ZuVGENxUu3fdBCw//xCi1xjnvozoSZDw
	fdbzLU3s1mCC29shJLsEisFjsHGOlqU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, david@kernel.org, mhocko@kernel.org, 
	zhengqi arch <zhengqi.arch@bytedance.com>, ljs@kernel.org, 
	mathieu desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: add balance_pgdat begin/end tracepoints
Message-ID: <aerSNntuPLdGWts6@linux.dev>
References: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
 <aepavbLy7H3odp6p@linux.dev>
 <1868971658.1970916.1776991584726.JavaMail.zimbra@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1868971658.1970916.1776991584726.JavaMail.zimbra@sjtu.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 24, 2026 at 08:46:24AM +0800, SUVONOV BUNYOD wrote:
> Thank you for reviewing Shakeel,
> 
> > Do we need to trace highest_zoneidx at the end? Can it change within
> > balance_pgdat()?
> 
> highest_zoneidx does not change within a balance_pgdat() invocation. It
> is passed in as an argument and remains the classzone bound used for the
> balancing checks throughout the function.
> 
> I kept highest_zoneidx in the end tracepoint to make the outcome event
> self-contained. In principle, begin/end correlation is possible, but
> under sustained memory pressure kswapd reclaim can be frequent enough
> that consumers may prefer to analyze end events directly, and any
> dependence on matching begin/end becomes less convenient and less robust
> in the presence of filtering or dropped trace records.
> 
> Since nr_reclaimed and the final order are only known at the end, having
> highest_zoneidx there allows end-only analysis without correlating with
> the begin event.
> 
> For example, it lets users answer questions like:
> - this pass reclaimed too much or too little memory; what highest_zoneidx
> did that result correspond to?
> - how much reclaim was done when balancing up to ZONE_NORMAL vs other
> classzone bounds?
> - when highest_zoneidx == ZONE_NORMAL, how often did reclaim finish at
> order=0?
> 
> So it is there because it provides context for the end-of-reclaim result.
> Do you think this is sufficient justification? If not, then I can drop it
> from the end tracepoint in v2.

I think it is ok but let's add this reasoning in the commit message.

