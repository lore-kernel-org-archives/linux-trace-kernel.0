Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11678352006
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126025; cv=none; b=PQC0aQ7jb6h2Gfi2CPfiWv+n7+EsgQpVUY2Ln1PgDrD7QkzHnygaeTqqCo4bGEJUiwLddvj3duCYDtNRDchd8m2Q1IX6iGPOU6kDxBHTAe8iD5WXy/v8lkO+ruxNZ4CbxpwNc4eFsr201dwbVunY11FvxBv+jXQAHYIpt7WoD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126025; c=relaxed/simple;
	bh=8sERx9VhZYNgtNpWToYz+x+EuJ/+ICrwDelmyI8fkww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7EuFTsikbQyNOBDpWXD8yuokiJ7rSS9BqBeoHfDnOnB0XwKzDWfKOVcd+LEuUMBbQszvR2DUPG6IhHfMOclyi6eDZ/k2nf3iZHK/bGF9bfSnR4E401Rx16z/h8DmG/MMz9Uy3gR5Xeptf6H21Gnz3zP7XW+fFXbgDZBmXz/vZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWaWX5SH; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWaWX5SH"
Date: Wed, 10 Jun 2026 14:13:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781126021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ikb65W1PWX9LtR2B41SaPI3vlwLCYLSMOuFtg/4KXzM=;
	b=CWaWX5SHnj4MeHYvyjLwqG5gpN0qCRGwdE0LwQN6mGH74LHMXirPPvjtFwbczwgnK9L/n1
	XSdDKKg3WO9zfFIbCzSYpN1Rdj+LucRTFK1dRZH6wEGOyWvzQxRlvOVKiZhv2iquSdnRhQ
	qF0a9zi0T9fxV7vIHc4jDyTFFisDsNc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, usama.arif@linux.dev, 
	akpm@linux-foundation.org, vbabka@kernel.org, mhocko@suse.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kasong@tencent.com, 
	qi.zheng@linux.dev, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
Message-ID: <ainTWlyb7SIiYdeC@linux.dev>
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610195220.12403-1-jp.kobryn@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 10, 2026 at 12:52:20PM -0700, JP Kobryn wrote:
> LRU add batches can be drained before they reach capacity. This can be a
> source of LRU lock contention, but it is not currently possible to
> attribute these drains to callers with existing tracepoints.
> 
> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> lru_add batch is drained. This allows tracing to distinguish full drains
> from partial drains and attribute them to the calling stack.
> 
> Add mm_lru_add_drain_all to capture callers of __lru_add_drain_all and
> whether they set the force flag for all CPUs. The tracepoint resembles
> the signature of the enclosing function, but is needed because of
> potential inlining.
> 
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

