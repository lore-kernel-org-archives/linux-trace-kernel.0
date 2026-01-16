Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FD33B6C0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578685; cv=none; b=QLTR4mF3nC6ssVsKRmqqJbtX4rHyRYizyGHoaakvPGs4xeX2xpIyzUc5RP253zKjLWlbBxD47PFHeTRtpTnUp114ZV+qCjfCMBU3ZZ/87fEEc/8lJbdP1RsCdnTGQodjrATLW/e0fCcFpjHrdMb+Jxa8HbOcExFeFjjoyUEWa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578685; c=relaxed/simple;
	bh=sWsFXuclsCQHF1wp24NKR1BJW2Va0NelV/xUk3GRd+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4czgeKll2XyKZx5HnS3KJTQDnsR9kHQu+77se+UlnUL03cOH/kQr28XYViUp+zQUtX7iI/QajL7XI9t0/oEP4qTKeT/X3C0zOyPkLERuNVHnXcK4x8WCtsI4wCnv/KQYdacrfkfJ5guppjOe6p3Ey+Tfl4go5bEvEKW0Wh0T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FcdsOP3M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FcdsOP3M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801c314c84so11577715e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768578681; x=1769183481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxikc1y77Ls9+KOGiahB2sX17dgvn1C4IYfzeZk12RM=;
        b=FcdsOP3MR4AEmQ4rmKuDfT3DYfQ++lQvmNZ0fM2IJgj+GNzEw1EEpJiJZDwkSzYRh8
         4L5PTc2/9gvJlUTY/BY7AC7bilte4mIAUjGXWdpK3iM1pW5PbQ4selN8wMa3PK2Oo/CW
         eEN2kyWMUOID0muh11EHFIQA7GfF2yuxqr3M3Kfb8nAVBAoxqRwh5aehDdvD7mRSs/dr
         GRr5jijSzAeZIv2IK8HZbV+t4IOUfWIPBpFUxmVDexQW9/ivDOLXxrAkkCUoRellTBSd
         HIb9tVVMbIWJfHy7rfRf0GjWkOc3oza5kuEFsAa6T2dOh82vbcPLBS0P0Db0RnUdEp9h
         YqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578681; x=1769183481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yxikc1y77Ls9+KOGiahB2sX17dgvn1C4IYfzeZk12RM=;
        b=C8vsEfhDnaUuU1cTuEQFaHP2OEc2dsLVIJp1h5ocBA+LBCjUUGP6V0cY9pe+/F1BZV
         KoHYAWmCQMkw/LoEXL1/hNPRYwHZ/fc65/KSIh1UnBqRq5W42oVPD+XNSrJJf1wQ4rKi
         hONjHbAsm2YAmXuVBrV3MFsrx9tMwI1HrNqvznAJGdVfFhFhuBRazOTPlFE/0uW40jDX
         zOgrTGLWNgsE84manhV2sjkDqWXyGQMH0B5FtJ+fGVgv7nURMM9pCUoFvF/FemJCtggi
         WNBGrNyfuy/sZauEVY9cGBjxfUP68LKSPDy30iV/48EUz3hGuP8GBdWKe/vtURFyYCKM
         RoJg==
X-Forwarded-Encrypted: i=1; AJvYcCXvp+SSNiYU9lqUtdFR4kcugw2YSxJirsbjuIWAlgn/np612hzU5U5UrS1/RVcWlTVJNg328yaTG1Fa02QhcW/Cfbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjqp/akH2FrX6CgkWh9cifTFo78BQspICSfu9y6YW53S2f05i2
	up4p+4kh3iFHWZCZi+2rKCpl1gS3tUPGIICklLeluXPs04uCDl/ycmRNt9LXAUC3Yic=
X-Gm-Gg: AY/fxX4tAe6cWskYTV8K7qclkEcgVPxk96YWkwWRwN4dcLGWbN8YvzR7LBcwV69CPvH
	woy0sJOx8FBMDa1a4/Kt+bbF+Q8Q75klfiQHb7123g2duFWWpn+3lBtVecqvlCPkCYOn1F5l6nD
	GS9WVxq1MYz6wNwn7v1jWXza8nliRJMruhEDY74AXDJbMb3qna1Ajb4beytiCxElk58vWyoaZ+a
	Q4+HAA4zve0rR1r06OvNK7h7oMvepEwPYRs/U1Xy3QI+ZlWKJeDe50idMHFkivGD4w2KZYOLmjp
	AJ93QfIhszc0KgBO9Annv+T0xz+GB/CDxV7azbAA5YW2Hod05WR+KD2HCSpTCZ44RIzP5vOQezT
	4WhgCqtq167ujmf1YCRhMGIlIR9YZlLBeDccEGEtlZqNS9Jbm4v1DcjchL8vw9nv1X9jYkjaVpe
	CXFuvCR8gI9YZi+Fv76EY2Nfg1
X-Received: by 2002:a05:600c:3b9e:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-4801e2a5861mr49417745e9.0.1768578681507;
        Fri, 16 Jan 2026 07:51:21 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe65883sm18036695e9.15.2026.01.16.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:51:20 -0800 (PST)
Date: Fri, 16 Jan 2026 16:51:19 +0100
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
Subject: Re: [PATCH v16 1/3] lib: Introduce hierarchical per-cpu counters
Message-ID: <aWped4MIi5i0Y7-R@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-2-mathieu.desnoyers@efficios.com>
 <aWfHTLDA8-Fja_gD@tiehlicka>
 <67bdfd38-1acf-4b90-9e34-ce752632ddb1@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bdfd38-1acf-4b90-9e34-ce752632ddb1@efficios.com>

On Wed 14-01-26 14:19:38, Mathieu Desnoyers wrote:
> On 2026-01-14 11:41, Michal Hocko wrote:
> > 
> > One thing you should probably mention here is the memory consumption of
> > the structure.
> Good point.
> 
> The most important parts are the per-cpu counters and the tree items
> which propagate the carry.
> 
> In the proposed implementation, the per-cpu counters are allocated
> within per-cpu data structures, so they end up using:
> 
>   nr_possible_cpus * sizeof(unsigned long)
> 
> In addition, the tree items are appended at the end of the mm_struct.
> The size of those items is defined by the per_nr_cpu_order_config
> table "nr_items" field.
> 
> Each item is aligned on cacheline size (typically 64 bytes) to minimize
> false sharing.
> 
> Here is the footprint for a few nr_cpus on a 64-bit arch:
> 
> nr_cpus     percpu counters (bytes)     nr_items       items size (bytes)     total (bytes)
>   2                 16                     1                 64                    80
>   4                 32                     3                192                   224
>   8                 64                     7                448                   512
>  64                 512                   21               1344                  1856
> 128                1024                   21               1344                  2368
> 256                2048                   37               2368                  4416
> 512                4096                   73               4672                  8768

I assume this is nr_possible_cpus not NR_CPUS, right?

> There are of course various trade offs we can make here. We can:
> 
> * Increase the n-arity of the intermediate items to shrink the nr_items
>   required for a given nr_cpus. This will increase contention of carry
>   propagation across more cores.
> 
> * Remove cacheline alignment of intermediate tree items. This will
>   shrink the memory needed for tree items, but will increase false
>   sharing.
> 
> * Represent intermediate tree items on a byte rather than long.
>   This further reduces the memory required for intermediate tree
>   items, but further increases false sharing.
> 
> * Represent per-cpu counters on bytes rather than long. This makes
>   the "sum" operation trickier, because it needs to iterate on the
>   intermediate carry propagation nodes as well and synchronize with
>   ongoing "tree add" operations. It further reduces memory use.
> 
> * Implement a custom strided allocator for intermediate items carry
>   propagation bytes. This shares cachelines across different tree
>   instances, keeping good locality. This ensures that all accesses
>   from a given location in the machine topology touch the same
>   cacheline for the various tree instances. This adds complexity,
>   but provides compactness as well as minimal false-sharing.
> 
> Compared to this, the upstream percpu counters use a 32-bit integer per-cpu
> (4 bytes), and accumulate within a 64-bit global value.
> 
> So yes, there is an extra memory footprint added by the current hpcc
> implementation, but if it's an issue we have various options to consider
> to reduce its footprint.
> 
> Is it OK if I add this discussion to the commit message, or should it
> be also added into the high level design doc within
> Documentation/core-api/percpu-counter-tree.rst ?

I would mention them in both changelog and the documentation.

-- 
Michal Hocko
SUSE Labs
