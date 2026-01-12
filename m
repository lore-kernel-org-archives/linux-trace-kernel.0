Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573D34107E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207337; cv=none; b=Uw16GX4il8036bt/Rvo1DXAJ/Otom9jm7GB8qoxu78tpxvM20WlIvpxU8bYa2l77fiP0vl2eIkJHtcplhgirczzwxCXZE+s2eqNxth85G7qHJE1Yw9W3zqAL6BslEL1o834K3XXEpFzmopZtirb3/ep6m7R4zTPCOfkWH+RZN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207337; c=relaxed/simple;
	bh=rjITqn12+D2tvtJTf7/BRP0AALPZnd8r3PQY4MECiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFLrhuhVDoACuoq/FKvyZBMsr588WhZ2AoCqMNEJU4lO9OqlBTblXq0GLDPX1G4AOZh2iREzmwJ7dBXO7LrFh9ngm0HKxuc84DB3XpESJ0MOf1lkEYsWcyxYvZ8d9t3cmMtdDWEOIbAppi2GNvdRCBv0SiUVJSlPoMxF5aYJqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ECMsPALb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ECMsPALb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so33027345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768207334; x=1768812134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDfFNoiSuTKA5KfAUoXISxuSK51bp7lujfs6vADIdxE=;
        b=ECMsPALbh38oKqxWkweA8gysOOon0feqAtyuXePZlNC8xXrr2CugQ/ykGFDLCYIo+I
         xv2m7iBI0t9mvHg2JGY2rVLY1wUuwbPHXMX/pME2zoOh/n/GH5I4HRqi/uasbl6t9ljU
         1sjCWoTfadNh/PbwUetBw99/0XLPAiX/lVtj7+91xnRazzkSxbhTrcdhyrCYCIEDHvvU
         UIkRrhQpE+YRErb80gOnrwsOTfTG7tSH/7cyPCiRkgsElZmsMs5FZ1G1v8c1XbhudRpq
         wVeC5U89KChbpVBHtiCh3f8ro2sWFlGJJ/P8xNdwXWcNM6fnxx/S+ssy3nVvazNdGU//
         X+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207334; x=1768812134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDfFNoiSuTKA5KfAUoXISxuSK51bp7lujfs6vADIdxE=;
        b=FTna4CsPewm6HIlzpPcoab+MqqlOtoHwbKqY7wTuOVyvsLRewL4281MJcjnqDvErwD
         wQfUSPS0NyqahKzC9WC05/gZwURCGBuJKWWjfwxAfvg/XZTnvgJu3kUx3S3S84l/fWLB
         LGb50CT4oIZ24syg7nv9d4GT8MbBI/hkrVJ0juhWaLAjT6i+69sOCrgueG45fmosYbkl
         Qr2ybIFPlOCHJyQL18GLK31eW/UhgkGzvBVoRkfLazjDNKFCujjhrB8tcQ31I9mlNfWR
         orxiDvcWaRUA8Mf1aydTcr9pqcyBOPbv29l24L2BvS393Bio75PsoWu9Ynvd0js/jv5Q
         12JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/+qJ4zw1u6XPnQQKXnShb1dzJkBrjoEZswfWKQvjfVrj+9lrGPichHQCMVeUJUPgN1iw8gghU6w8dkYCG/X71P3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluIcd1sLt1xIWnN7Xai18nzGrhVTaQ0/i+IQf0kkACn6gmCHa
	gLLK9c/Qih4r+/O4eX/0CmkFmzg+/eBJcLHHyR4UoOAr96/OOJWBFQ+NvOYizc/s0xc=
X-Gm-Gg: AY/fxX6EKJ8JUTV5F380ZYeBFszi5GnSlmdsl6AkVrRdAt6PGjKbPZUuecn0oxpxk83
	6wOQPtypg4PhS7SHPSAP3BrsCUJiVBkpMJh9osVIWsmBweoAsYkYcIrTPscMFtp5lx6HKZUm6Ks
	ruduu1JO4zn0HBQWddE7zXl9E1iEZ/4M2Vl+86smxyPzhhIfZGPCkDv0nytGNmYgmMZ29Pn3uC0
	6+2AmgpSeIakg+le5VpOJwA6h78eUnLKLQhMXc5l1/ZgTfNTAdAkCeKJgjrxnWrAoDkpCW8qX8l
	avCpkdDnXOLCIxwUl++UomSkkMwqlUUBoEK8yOgeCwEyfauSvOWQSLFiZwtyVsOZo2Mt9rufWKF
	nhvlsl0FHaYG27NhvPRQZTBbfx71xSCVoMfKqfiWAZSGQBYN/c/w5ISdeVjvoXxiplr9QJ+V6ET
	tZKqt63XOK0T6ll+ulNuBf8XsuViNToknF6c4=
X-Google-Smtp-Source: AGHT+IGOZ9lkMoCzrUzWNxChXoAXhL7/lCG+k3HeWbbjlLCJz2d0Tg02k9SjW7Z9t8X4D9e1/0CcXQ==
X-Received: by 2002:a05:600c:3b05:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d84877e51mr207488795e9.13.1768207334460;
        Mon, 12 Jan 2026 00:42:14 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm132725385e9.1.2026.01.12.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:42:13 -0800 (PST)
Date: Mon, 12 Jan 2026 09:42:12 +0100
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
Message-ID: <aWSz5OHBwtfYrruu@tiehlicka>
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

Hi,
sorry to jump in this late but the timing of previous versions didn't
really work well for me.

On Sun 11-01-26 14:49:57, Mathieu Desnoyers wrote:
[...]
> Here is a (possibly incomplete) list of the prior approaches that were
> used or proposed, along with their downside:
> 
> 1) Per-thread rss tracking: large error on many-thread processes.
> 
> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>    increased system time in make test workloads [1]. Moreover, the
>    inaccuracy increases with O(n^2) with the number of CPUs.
> 
> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>    error is high with systems that have lots of NUMA nodes (32 times
>    the number of NUMA nodes).
> 
> The approach proposed here is to replace this by the hierarchical
> per-cpu counters, which bounds the inaccuracy based on the system
> topology with O(N*logN).

The concept of hierarchical pcp counter is interesting and I am
definitely not opposed if there are more users that would benefit.

From the OOM POV, IIUC the primary problem is that get_mm_counter
(percpu_counter_read_positive) is too imprecise on systems when the task
is moving around a large number of cpus. In the list of alternative
solutions I do not see percpu_counter_sum_positive to be mentioned.
oom_badness() is a really slow path and taking the slow path to
calculate a much more precise value seems acceptable. Have you
considered that option?

-- 
Michal Hocko
SUSE Labs
