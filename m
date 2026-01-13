Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570E3921EF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313519; cv=none; b=OC937ulmd11Q1dj8LnVG7nUotqWWgbU2s2sqW7k+320sUcOhnDUGT9RPB+CACU1obuNj74lMS6Xd8ltjQ/9a2emeObRK2hmdOzAtYLpL6rds1+ZnD0X7CLRmGqby2ioIi9qujDj4EtodGJYvFCY0peYGaQb2vk7u4VS0H5qkFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313519; c=relaxed/simple;
	bh=hrwPmGRBPW6ENjYbR/tdXAfuNg915ebiMPC6ktv8FrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiOubn5Yh3UrKxHr7UN5xwJ7Wowra2wiOPwBYe49Mfd91GKKZayZWCFLqo0cdiaj1MD8bXzllrdPEfbwgUFZxL+P9Hs82vCSfHdVjYbA9mE2M6FRGm3NorB3UUKddlippzNfCyIkkA+K4qvUFyIB1QzR9FdCHC4YKAf85+Mj/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZwcLpVIg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZwcLpVIg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477770019e4so56453905e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768313514; x=1768918314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQeUllddCLGPs0eraWtlh6AK1o1Gp8YJboZb0KWOg4s=;
        b=ZwcLpVIgIFxNA80gEx54HNVr23TOfWjYGaiMNehGRyemYrqQyry1NKOeuNGZIQc8Ai
         pZitsajwyFEzgVB0n1VJ2oHfEX3uKquWlIRAcF9a9a4NRrswdxxLLx0jZHSaHrEcYgGP
         iGQ9Z2SWgWGUKRA4ftY/iacp+fi/RyZI9ADEmJkIElePafVYu8Kh9uBJjbg2Dyfj0hqH
         fVZCiL6D3e39gZh1uUedMJmm1rNNLLeNFrYncBx9FheoJKU8EtYEH9Akaj32Cz7JbBJK
         5e0EZdzapOhgCY05DLw8srJqWuT4VPp8vxi5qSoOq6BBGhNQKcqhsZKSoBHHx2ojOYKS
         4XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313514; x=1768918314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQeUllddCLGPs0eraWtlh6AK1o1Gp8YJboZb0KWOg4s=;
        b=fXN9cdWNO81wuFxdrH9NaGN489BtBfOM0Dg+PicpNe6S4v9yiCRXAe4J4DYUtx0d+R
         COKtIsJrD7zg52oHB5aO1Xa2ewW/jP7AxcZVvNFIbe2bfXRyoN/Y78AE9N+n/ynMeCp3
         NCtuzeI4UY15t2npG/I/1rbViW5DRTU7wDurpeDs5oBs4j9C44zLU+ITJ3e/dFNxsyUy
         c8WH8SRpJy2dc9Gfux5qp1lOJe47J7w62SabUJrRP+kiVmnkI8GcS6urtmnRcb+QCGXq
         FUSQn5h1+lrfsAayeK5GnSkPTWXwBYcGkEy5YTmtjUrv9w++XU05x3+CiTuUofSrOUBQ
         11XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY37g0bfvHXL8khu4IOH8h90B9DZijAP4nBXu87+O0Afdqeqr8kRtzS+8GHmge0CQ84kVHCbg/1MioYpJS7sXZuAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaq+0byKU8ckWYyCm/vcQIj8t3kIp2rZUQ/reOdHOgSsUASVQ7
	HokXHpXrk4NkJkSv5P8ZeZTeIQ91gD/bYBWml0SzbWxYRCfjUxjezweUGEbWIHXVZdo=
X-Gm-Gg: AY/fxX79rYZsjublX9wiD/6BXTU4o+ZwIsdKHGYzWo1O0PGUxd2gw6Tk6E+RKJl9wrI
	wsIeRLT/Gu3ohhZnrhRmOjPvl8h5lRwbOx5NZFi6nH/nn+MjoZDViZzSk5Ne5h0A6440hIgEns8
	hlaOeLtCUTum5eYP4vftmHzFLHBVVPvLB6+/WOOqnHmtwQgEr9Z4E/GuVK+NQz+qIgxOqLQ9ZLW
	/jtnhaLqYFfclNUBdO0fuTA0fkFF0k1q/+5ZkJePmuUJ1gvF9C13YW98zCRQdxVQPgxeobgU1HF
	HV25SQIZRDadYOP118f3ePNyZn59SvT5MSIVYr1rWTp+PAc/WF5rSDQqs+N4HnK6IXdQnIHZbrS
	+IvYPJafrMVHJUxD0u/NgzfXa6BI4V318NJ1YA6tVHa23T6xj5JKPWEZVeRPNlEtkqMhfUzu80u
	dLYqLQjTIAOZIWguqm5vKTuCJs
X-Google-Smtp-Source: AGHT+IHyggS3qEwURO+dzayczEUAIkKcmNZxfMg4n0ab7f0L4Lj6EymBbmGapVEZIooJxC8xoc27vQ==
X-Received: by 2002:a05:600c:820f:b0:477:aed0:f40a with SMTP id 5b1f17b1804b1-47d84b31525mr225996635e9.19.1768313513736;
        Tue, 13 Jan 2026 06:11:53 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df96asm43642097f8f.28.2026.01.13.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:11:53 -0800 (PST)
Date: Tue, 13 Jan 2026 15:11:52 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <aWZSqIrbJW9q824H@tiehlicka>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
 <aWSz5OHBwtfYrruu@tiehlicka>
 <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>
 <aWVP9sPqG8VC8Oq_@tiehlicka>
 <b779c646-64c7-49f8-8847-8819227e3f1f@efficios.com>
 <aWYPWNIv4lR2FpUZ@tiehlicka>
 <c99778c3-6ef0-48de-98ac-10913419ec90@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99778c3-6ef0-48de-98ac-10913419ec90@efficios.com>

On Tue 13-01-26 08:51:45, Mathieu Desnoyers wrote:
> On 2026-01-13 04:24, Michal Hocko wrote:
[...]
> - Introduce new proc files, e.g.
> 
>   /proc/<pid>/rss/approximate
>   /proc/<pid>/rss/precise
> 
> Where the "approximate" file would export the following lines for each
> page type (MM_FILEPAGES, MM_ANONPAGES, MM_SWAPENTS, MM_SHMPAGES,
> allowing future additions):
> 
> <page type> <approximate> <precise_sum_min> <precise_sum_max>
> 
> And "precise" would export lines for each page type:
> 
> <page type> <precise_sum>
> 
> The key thing here is to have different files to query approximated
> vs precise values, so we don't have the overhead of the precise sum
> when all we need is an approximation.
> 
> This would expose all the bits and pieces needed to allow userspace to
> implement something similar to the 2-pass algorithm I'm proposing for
> the OOM killer, but tweaked for other use-cases.
> 
> This proposed ABI is purely hypothetical at this stage. Please let me
> know if you have something different in mind.

TBH, I am not convinced this is really needed. I would simply use the
new more-precise interface for /proc/<pid>/stat with numbers of
potential overhead payed by an increased precision. If we need to revert
to low precision then we can do that based on a specific report.

> When you mention "highlevel doc", which document do you have in mind ?
> Something related to lib/percpu_counter_tree.c or to the /proc ABI ?

Documentation/core-api/percpu_counter_tree.rst

-- 
Michal Hocko
SUSE Labs
