Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59337BE79
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238984; cv=none; b=ezJXIwGJzoTbPeQyi+NAtKgippXxlV9rDa8Zch4YKlFe98dp9LbaSVpTM/ZKjrLwE3wQ5BP/HAzK3S35lnK2dR+Yq+07KP7+EDqU8KGFUTHxMT+8x/Jc3LZC3mUSEzxCs823+XKjwFQPO8c/XvOzYUec3iRubbden3f6jzcOosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238984; c=relaxed/simple;
	bh=oaqOfBU9QCXf3q7kAAXFTGObaRb/5DS9ru+SWI7772A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8hLds6/Sy7KaENBaICATpWtygRij9cWqWc+qlaJGTlg8lyWQ8Knw/nJ+LPslBGnFJqz5qqaxxlgk+IFLv5q7VHCUsnvDrHyCH9p1GEusclvOOag7Jivvdsd2X5x0UGu8DhCunQyCa9v2FU+IFQSoa71Wr/LgBVWkSFFEay1HAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+Qy5jvU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+Qy5jvU"
Date: Mon, 12 Jan 2026 09:29:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768238968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FY0/w6SRI+2kqetzJX1LT0B9kLK/wcrXIARZ28Atleo=;
	b=a+Qy5jvUIu6rI6L3MSNDfOPnirV01SolmBzJs+91mceIcOXZWZC3DRiGClIVkVEYMi1GdT
	9h9ns5Wa9JtBBD3zxDWc8WULASiK/qQ1nRna0ZKqI8klrqnqPBeTtbrya1DrlR1y7FFUE3
	wB8alzoyh6v0+XmH/0J7ojnf011k2Jg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>, christian.koenig@amd.com, 
	SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <liam.howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <tzgfnxf3tii4s65inlzghhrzgc5gkp2stugnuzuqnjraqbp57k@khqklb37lci2>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 11, 2026 at 02:49:57PM -0500, Mathieu Desnoyers wrote:
[...]
> @@ -626,14 +631,12 @@ static void check_mm(struct mm_struct *mm)
>  			 "Please make sure 'struct resident_page_types[]' is updated as well");
>  
>  	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
> -
> -		if (unlikely(x)) {
> -			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
> -				 mm, resident_page_types[i], x,
> +		if (unlikely(percpu_counter_tree_precise_compare_value(&mm->rss_stat[i], 0) != 0))
> +			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%d Comm:%s Pid:%d\n",
> +				 mm, resident_page_types[i],
> +				 percpu_counter_tree_precise_sum(&mm->rss_stat[i]),

I haven't gone through the whole series yet but this "val:%ld" to
"val:%d" conversion seems like unintended. Next patch fixed it but it
should be fixed here.

