Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3C1D435F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449631; cv=none; b=ahzsLn5OPFczQ9AOsqXyeTyBxnUxH9RYSvVtUI/M/a3accCJ4UWVxmompXd79bi1Md7yeREUfUNCJ+UlDoIzm2bwhoRQP9Wzo9EAGOh9ThfftQGoiUHYTtz5KOYGGiF8/Prx5vjQuvYvVVd4h4cyxRxuKxQ7aF/EVQGQb+s6OE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449631; c=relaxed/simple;
	bh=SxiigcO5jULVZQb+1TTV1IfnLgHH67BQCQAXlPCmZV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcJcik0ZgXBSNqolQ9W0rRFtS7pMkOe/h0eiMf75l/hr/xPdM+o80DMrxMNJ0jBFpprnaAaOTb51QO5o75BwwhukskDH3bEOg8LGlscf3HBBNCmboqmaDMNTqH/+yXREqeNekAj3OBpoKbYxZmNjB3Krw6rDYt6K+wdAT05TeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=INOgFblc; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="INOgFblc"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so53376435e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769449628; x=1770054428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb/leG6Ch5DsFFPtx2vrqbxxpTr3aeU3kEJMHwQ4pjU=;
        b=INOgFblcWXjeH2dHKVybFbRSezcR7FNBmpFFUh3Rz9jBMPwl9weKbhvTQFfPzRBGCa
         3oUVakKJ65ScTyOP/FhHSGTGyCz1AQfTFDXZlmak6kIvZ2tR+vYD04nKMzBPgisytc9M
         qS/aj8abAsWHw4rMKYhUJbaFbIb/kJFOK8VteyQDJr8hEccOMbcBKTx+E8LqeAnTY7Cz
         aqFnBh9OESJMDQoETVhBGaaFOksJaqIFBzoGI8+uB/VyFX8oE7ytyYhwmrNAEfUYnag1
         D1+E8keeAWg5zFiOISn0JPC6o2BcoV9uH2V1T5OEKdnoVSkgNClSx7v2Z/kXvqyPBnS+
         kggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449628; x=1770054428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb/leG6Ch5DsFFPtx2vrqbxxpTr3aeU3kEJMHwQ4pjU=;
        b=Kfeao+qshHGvDqIDudJL/R4buA9hXPCteNwQ+aK0XLiHdWeags+dQZ1VFF5mofa+ct
         PPG7wvIN3LY96DUC6jswrAfhBt326AG4suexUauiENYSsXFaPI4xWSRJdp4d3vBTpL6i
         yoCM21g9LwJ7Cpw5DjR+9mbMDY0tT9ql77E/QRwWWbtCpDLAQyZmsnqQvdNYn/+EP3Zg
         qw3lui8B9mkh/wA0GJu07sbrJc2w/Ltw+HczdhK/7ynSpLd21MacaRcmjUy3QFpsHLlC
         rCSCc5g7bl4VL3TsEniXw4Qu9akLFOFy1I/V8N+gEavucqZfaZ7Dfghc4y9GG/mhab9e
         1s2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTJ7ddCD2teZNWBKB2MPVyEqpMVGMWyKbHFgybspx51FpuUhKe5pdUWiIAhRIOKE6AsrGL/i9X+TvJp+Xnf0QRPoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UyJ/gbtFTmHYXb34vf12vR8yB75QWFXxsJmBTQbVJ9bVKerV
	yqnn5Z7ACrv7QL3EtKt+t6aWQJLMiuew3OzntWhEvtD/XTwrC13rNqL4FJsSSyLX6lk=
X-Gm-Gg: AZuq6aJeuPQn9qcb3gmuKt1F4auUJ4t69PDuSeEkDdoyPFf4Vrx4RTrI6Y85UNTIyPB
	r4Xh+2p3kN6ZS6JeTcI0i3lNW4+zS9rzxDiFvRg74bBKUjEUAlr6yDJQXZFxIoGMzv0/M/iDonX
	rUVm2p3RCCaYmCv1lYCPqbKW6yPjDT0rWiIJwqTOA4rX658ZrUM1PqKxQNsRAJvkAl6tKipsqI/
	HJWkqsKOBFKoGHCEac5UaoJ58KM9eUYVkkuDZFzl01YkMgxyhkrn/iteHg1hIUPhfCEeemEhldI
	l2G6cZh32ljTBoiDPlei1MkSTZNAzyh9ZiROB+JX5y5+EUtk7/sCFnzSvwvEcjwAdRjDKV49rw7
	e71EPWEleNDk0qvDuRO1zl7Hm8l5ux6r+uQJhGPdV3OZJ7ShBTewSD1YvYCmUc0TRAfJlYkcFsO
	tuDGUENble5U4LRm7gMhI2WBLH
X-Received: by 2002:a05:600c:8b11:b0:47e:e2ec:9960 with SMTP id 5b1f17b1804b1-4805d06cdadmr105139335e9.35.1769449627682;
        Mon, 26 Jan 2026 09:47:07 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee000sm3831515e9.4.2026.01.26.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:47:07 -0800 (PST)
Date: Mon, 26 Jan 2026 18:47:06 +0100
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
Subject: Re: [PATCH v16 3/3] mm: Reduce latency of OOM killer task selection
 with 2-pass algorithm
Message-ID: <aXeommbTq_KNpUZa@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-4-mathieu.desnoyers@efficios.com>
 <aWfNMKCoEp2LuA2v@tiehlicka>
 <a46b298b-baa3-4998-8715-0568b5b186e6@efficios.com>
 <aWpfbSJe5vREzzyd@tiehlicka>
 <0079bc61-5655-4677-a421-1a61f4c52d59@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0079bc61-5655-4677-a421-1a61f4c52d59@efficios.com>

On Mon 26-01-26 11:39:33, Mathieu Desnoyers wrote:
> On 2026-01-16 16:55, Michal Hocko wrote:
> > On Wed 14-01-26 14:36:44, Mathieu Desnoyers wrote:
> > > On 2026-01-14 12:06, Michal Hocko wrote:
> > > > On Wed 14-01-26 09:59:15, Mathieu Desnoyers wrote:
> > [...]
> > Thanks to those clarifications
> > > > My overall impression is that the implementation is really involved and
> > > > at this moment I do not really see a big benefit of all the complexity.
> > > 
> > > Note that we can get the proc ABI RSS accuracy improvements with the
> > > previous 2 patches without this 2-pass algo. Do you see more value in
> > > the RSS accuracy improvements than in the oom killer latency reduction ?
> > 
> > Yes, TBH I do not see oom latency as a big problem. As already mention
> > this is a slow path and we are not talking about a huge latency anyway.
> > proc numbers are much more sensitive to latency as they are regularly
> > read by user space tools and accuracy for those matters as well (being
> > off by 100s MB or GBs is simply making those numbers completely bogus).
> 
> It makes sense.
> 
> > > > It would help to explicitly mention what is the the overall imprecision
> > > > of the oom victim selection with the new data structure (maybe this is
> > > > good enough[*]). What if we go with exact precision with the new data
> > > > structure comparing to the original pcp counters.
> > > 
> > > Do you mean comparing using approximate sums with the new data
> > > structure (which has a bounded accuracy of O(nr_cpus*log(nr_cpus)))
> > > compared to the old data structure which had an inaccuracy of
> > > O(nr_cpus^2) ? So if the inaccuracy provided by the new data structure
> > > is good enough for OOM task selection, we could go from precise sum
> > > back to an approximation and just use that with the new data
> > > structure.
> > 
> > Exactly!
> OK, so based on your feedback, I plan to remove this 2-pass algo
> from the series, and simply keep using the precise sum for the OOM
> killer. If people complain about its latency, then we can eventually
> use the approximation provided by the hierarchical counters. But let's
> wait until someone asks for it rather than add this complexity when
> there is no need.
> 
> The hierarchical counters are still useful as they increase the
> accuracy of approximations exported through /proc.
> 
> How does that sound ?

Works for me.

Thanks!
-- 
Michal Hocko
SUSE Labs
