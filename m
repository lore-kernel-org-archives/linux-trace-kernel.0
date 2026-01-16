Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22533E36F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578935; cv=none; b=fuR5QtB3x/JhFJWk+dVgs3W3kCb2+nHiU30FkSa8zPVaSp+dtsTwJrdFgV6aiiarx6JLaVj4QYzOwJp2XhiJMdk7IDkYo8qXxfjJ6gRau0ANCWns1HJbqAEerJfsoVlVZv3A+Etbwu3aewkc54ErwGE3e0jSdQlnmeZO4AhMXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578935; c=relaxed/simple;
	bh=gYRLTx/x34zgvDGr8Ikg/savTmJY601nWRaB0KVkXwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1xr/g96Rr11Lp4RVStQbWG+sMIQD8F+qWivPS6c6p83/2l8SoQ+8m+icPvhs5FambYbr6BZREFUxxOSLXZrypQpehYbRDCBRPaXByRWRfw51Vg00EZpDXgczySAyUOxNjVKCHXfpIGYJ/tvMw0FurwO8ZvcCMDTL/JYit/LfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NE8FiOyk; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NE8FiOyk"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso11616315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768578927; x=1769183727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nC1t8XaX/bq14ENSBQ5Fda7IB2vEXwzrtJEP49kE9AQ=;
        b=NE8FiOykdnhDOMKOtxxcUZ2A8byokPHbFAfOK5GO64nMeeDvjWiq0bsUAyJ+jngW2m
         /Jpa3fuCUlDE5b7mlmdpT1GsZTogNatJk/18TC/8ukSAFpoQUCp2/V1VnrahOPuT6MlP
         ReKNrOHjA5ANiRTgGGMAXYGEnEZ/uOVZCHw1VErcWhRQl1GkgDklJOo+5VCnFTMd/OJX
         nPiqrQh/aESx3YtVefF0ktumIfI5gkNbAt1wL69LJFL4G5z7P3QA233hJPwsoxK9bbcc
         pq2Yd/uPVv6ReSJXp49ygr+FPjazMwO53m+ZQjR9KeDTskpI/efYkchFs1ERb0k/c5fs
         qQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578927; x=1769183727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC1t8XaX/bq14ENSBQ5Fda7IB2vEXwzrtJEP49kE9AQ=;
        b=tMjJl6S8laNcOKQ2mWtMz/BiB224VY+oN65R1fbQeoGp2doDA2+nsPLYFvsGItMK/c
         FzJ+3ZvYbtD2gG3ZDReSJ8DlZVYNzYiKfMlj2NNLnjqLiQBuHPbVQzqu8DmUER30noxo
         N01oA52kLj91Z5IBTp0DFeunZSqsGx6QhbnjnTx3gXKwGWu1o4ZEsBu9TcpLoVRhVgI7
         MucOL1e5jBwzDvBPe+NCjN2HXQiXXmYyNyQ1BtqA6T9Tc1TFrz4kqNf0fa/XnGBzl+A5
         /96c0y3C9X7AUMcMDWkCgKKtjZtqVvtIkhsRlcUteXlBBsGQYzWySd2Hi02nI4g0jbCP
         Nfbw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8sjcKJx2TGSJR5VkFwhf0ciu7/7ybbfoadxa+gNJqEHMRgI06GESthLDC7j8Db7+1C+ZY5/bv2ivEOA5XMkWJsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttcwVZIT7EhW9VS9cBQWAZ24Q2O2pjK2fca1ekI3ZmuQuNBOm
	YKhJX/Vaegd5IbMRphfpVwgScfjcvkv0134CATgIOoVWP0JIE9I/S/MM7cqvUcNZFFE=
X-Gm-Gg: AY/fxX7VL5AE57snRJWVi2ClJRSrCC0I2qL6GScc3izRx+Y70tb4wyLsSsa7LmJhSlX
	YyqcsQ2kQiMglxlsYVt7VdjiK8IP2FlrbK1dAL9vEaOK680pEbYTEtfUD1mRZFDt1K2Czyp9CtQ
	ynPdUjuWqulnfJRG+PLcPPRy0H3beTJQave+HqPkrK5mT6g0WHAk4lCzKXk/iqVyiGQKfIzGroq
	QnNJ2ZvGhOxqBPpwStOvculEfngFfSRj/BJ7KEpGJl/b1y9wcL5RoJHXwd5l6T8OgiJBQkW671F
	lsd6A/BCEpitWtIZi2bVn1+9pKDTJCcoejDCDuFTt8PuBMgKicQ1pTAID3pMA+G1dp3cDJF1BLz
	NRI66kYzysBeotg38kitF8gVP5QdFN+EAgN+Qc+wBNstftLL2xh7zpJNBoursxsAxAP3o+V9zN2
	K4GfjqKG4lORbUH8DF4SHuWdbvMay7cf2aQC0=
X-Received: by 2002:a05:600c:1f12:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4801e34ce8emr40733615e9.30.1768578927236;
        Fri, 16 Jan 2026 07:55:27 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fdefed9sm19855285e9.3.2026.01.16.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:55:26 -0800 (PST)
Date: Fri, 16 Jan 2026 16:55:25 +0100
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
Message-ID: <aWpfbSJe5vREzzyd@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-4-mathieu.desnoyers@efficios.com>
 <aWfNMKCoEp2LuA2v@tiehlicka>
 <a46b298b-baa3-4998-8715-0568b5b186e6@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46b298b-baa3-4998-8715-0568b5b186e6@efficios.com>

On Wed 14-01-26 14:36:44, Mathieu Desnoyers wrote:
> On 2026-01-14 12:06, Michal Hocko wrote:
> > On Wed 14-01-26 09:59:15, Mathieu Desnoyers wrote:
[...]
Thanks to those clarifications
 
> > My overall impression is that the implementation is really involved and
> > at this moment I do not really see a big benefit of all the complexity.
> 
> Note that we can get the proc ABI RSS accuracy improvements with the
> previous 2 patches without this 2-pass algo. Do you see more value in
> the RSS accuracy improvements than in the oom killer latency reduction ?

Yes, TBH I do not see oom latency as a big problem. As already mention
this is a slow path and we are not talking about a huge latency anyway.
proc numbers are much more sensitive to latency as they are regularly
read by user space tools and accuracy for those matters as well (being
off by 100s MB or GBs is simply making those numbers completely bogus).
 
> > It would help to explicitly mention what is the the overall imprecision
> > of the oom victim selection with the new data structure (maybe this is
> > good enough[*]). What if we go with exact precision with the new data
> > structure comparing to the original pcp counters.
> 
> Do you mean comparing using approximate sums with the new data
> structure (which has a bounded accuracy of O(nr_cpus*log(nr_cpus)))
> compared to the old data structure which had an inaccuracy of
> O(nr_cpus^2) ? So if the inaccuracy provided by the new data structure
> is good enough for OOM task selection, we could go from precise sum
> back to an approximation and just use that with the new data
> structure.

Exactly!

-- 
Michal Hocko
SUSE Labs
