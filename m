Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC537E2E2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378717; cv=none; b=dwTx5ZSTtDCgYHAIVuDZemNK0EpDxODpXeYioOsn8/sWobmB1xqzqlf+DMMyPMuQWcmyKL5Qct4gBZuHfWLYRB4nUuAfizhWu9yaUo5RqMeUL7D/a2tU3mpV+cUSoUlOv6zc0nmHUsMdK8pM5DRTW+QL0RZAu7ud0/OxE5mf63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378717; c=relaxed/simple;
	bh=2rIhPbY6ae6VI8ZyQYMQitssWKnS1Vd903IkWFk6G2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob+KzP6BHXv6JRFywqMhOizxmxXVRZXeEDgeycQ8scRMQzAcCdgISO5LFITJknYbbQWcVRN54gWoor2pYXdNGAGbkgRUZ8XKlwi+zAU21Gfs1B4yhYSPY5MHqwfFOIeYd+BILTD4BSEZu9DJxr/uYO72vX4NmTs8VX3H/m+M/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F4BjAfHV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F4BjAfHV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4606969f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 00:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768378712; x=1768983512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8y3eBpdpZ4jiLb2IpPbzYhjPFac6qto4kOtboVZXAA=;
        b=F4BjAfHVOTbK7cj4O4iZiH6hCLmrvT4Ll85x5Dz6S181097YQzaaxbgP9HLTsUcuJ2
         qejf6vtPbIfYJft3cbwhKpiEekG+gvXKj/YhABoZm/66yEY1j1qhkMD2nvp1giR1ZDvF
         zunpkz2XURefF/mKvsO6G/IO4rmxSnk98dSWz3bu1iY1yyEcC+rgVdYhIBNIpoKwg059
         KXhJad3CRVlJU08HtUl9MugxEE73SmKH74uqOjerQgLYhXNHh3hgiYOezgEGZMhAAarA
         XARBM4r/C6NouBuQ84VP8ZQdqn0iVgsZJelHp0gQADRth5EI0jbbPrscR6Rl+SU3J5fT
         nmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378712; x=1768983512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8y3eBpdpZ4jiLb2IpPbzYhjPFac6qto4kOtboVZXAA=;
        b=ei1vRPVKYBdciabxSbvArhs//Tnj1M3NIZVtzhJXFWScQAQ8Ljv6ItwzQ7dwofMe2d
         PBbjZgTvOZk2XjecoTd9pRb8X2hY3bqhkSd0ly9dMheeGPC8+iqKXPcYLyGmalrrjRhH
         QDchtIWtcLxunzJ0smvwgZ12XEQfx3Jp5fbxsMCeG7d1hd/2/1tBe62RM6ib0sJ/MDXG
         ZvyiNgHplsRVHGU7YM7Nq0aAgjgEjl4cCGotpjLB1VbVSnByG4oAURCpsC1+pazqMgPT
         ZAaTxb6c692KK1ZC8SKTyc8/GqmfNcqiZXTU70pmfvJyBG+tDOFGg2CtBzF9JZpaa/oe
         on2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHeNAW+F75u584Cy9OarZ7Nf9rjs+jqa375EP/Fv8wG7JgjSTBNe/dGHszLZBS8sVvSvrM2jq+vtcZnuWMF66y9ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkfwv9TtC/cDjPb/w9eAljQGzo6m4m2yOfJ8MpCUASTHNXJO88
	Pwr4c9S0OfV97GjrudSkt3V5gEkrTglBjN4ihghL24eKJKbPaUtH9AXfO2MDdnQo/e0=
X-Gm-Gg: AY/fxX49UwAliBDFyCKfj8Y+iGIVkB81Ewg6ge9Y51be2pm1pTh8/kFuXbNahNkggv8
	uGFv50MW+DPUiiwRW3QkpLd5fvdrC9pIl8dH9KNg98TJma8GJVANf4GTCRQZzkNu7weOd1Q0AOX
	M200k/W2SEJ1SWKZRhlWIZHgZSobf7nSjcQSVKz+ahroh7hisyZOEt8outnGbM9VoB303Uj8+e8
	iqK6tpYLI5WJugMZJlG3ErYMXJEWWWiyS4RSQdB0I+tNR6S8gK9j6IhiYyrLZ8gS0M1ccoh5HHQ
	aoadeGKs4raVbqXqhcJa589ayj6N8PbM3VLBS7dFfwYnSen2wipcktMTi6Fkgia5sDtCAex8+73
	6v37TTfHgew7wmZNjWFFj6boyaQQtEPCooyaTV+cK8MiQ/q9VTdFOZ82XKjbabLsA1YZ9D6nZK5
	ZZmNaaVswrXa/3iLrnkKInHOvGm9AXcYJpEjY=
X-Received: by 2002:a05:6000:1a88:b0:431:327:5dd4 with SMTP id ffacd0b85a97d-4342c557825mr1897922f8f.46.1768378711829;
        Wed, 14 Jan 2026 00:18:31 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm48487321f8f.5.2026.01.14.00.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:18:31 -0800 (PST)
Date: Wed, 14 Jan 2026 09:18:29 +0100
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
	stable@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
Message-ID: <aWdRVY6Bzw2kjedk@tiehlicka>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
 <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
 <c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
 <20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
 <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>

On Tue 13-01-26 20:22:16, Mathieu Desnoyers wrote:
> On 2026-01-13 18:55, Andrew Morton wrote:
> > On Tue, 13 Jan 2026 17:16:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > The hpcc series introduces an approximation which provides accuracy
> > > limits on the approximation that make the result is still somewhat
> > > meaninful on large many core systems.
> > 
> > Can we leave the non-oom related parts of procfs as-is for now, then
> > migrate them over to hpcc when that is available?  Safer that way.
> 
> Of course.
> 
> So AFAIU the plan is:
> 
> 1) update the oom accuracy fix to only use the precise sum for
>    the oom killer, no changes to procfs ABIs. This targets mm-new.
> 
> 2) update the hpcc series to base them on top of the new fix from (1).
>    Update their commit messages to indicate that they bring accuracy
>    improvements to the procfs ABI on large many-core systems, as well as
>    latency improvements to the oom killer. This will target upstreaming
>    after the next merge window, but I will still post it soon to gather
>    feedback.
> 
> Does that plan look OK ?

I was about to propose the same. 1) is a regression fix and should be
merged first and go to stable trees (it is a low priority fix but still
worth having addressed).

Also a minor nit. You do not have to send cover letter for a single
patch series.

Thanks for working on this Mathieu!

-- 
Michal Hocko
SUSE Labs
