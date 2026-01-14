Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF429E114
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410421; cv=none; b=Ubk9i7rzW2bFGffDQq3AMAvqMr79oTW91q4ceL5p4wxu4T3AWmc4Y1197w8/nnkh1qddt0kzXtZBAS0qCM5jGY03gfRJ5ZPpGIZoxMPg3gPc49IwEtsC7fNJNyS20rmhynw5Npm/yQ/LQTVyXeajgJL/YLvkg2jnEYahxcUhmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410421; c=relaxed/simple;
	bh=A6bzYs1H0+5OFv59DsWcCt6zVkgchgEpVQValhdOOJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSwG6MpLu6lDE1Om/HT44dqs4oyJsEucQ1gpSQlxpfD2VTBiHPa0MyXZxCyPig6Yylmor/I2bjo4yYcs+Fsy09B7QICr6l7URXPKlUKbqz/1QYtSsjaInAbKdfTJwlMabfo/nH3IXm6m5WGhjh249Bc0jXJBNkZcz3/xM63FQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KTlIPcgy; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KTlIPcgy"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee974e230so562065e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768410418; x=1769015218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8rPwjfzU+1ry2RQl+0zGZMNXdxcPKW2Gfu/u1uR+Mw=;
        b=KTlIPcgyJGw5wz3tLPXh/RKnTqtkSYDNP9eDP2s0sQFdDeIzRn5HA2RmAnC65W84p4
         7tSiK7HkAl8GGzPilJXGpyFFYKxZzDD+rFnhx5cOSjfym7CikawmgyDRcpX1/02DGgut
         Tk6J6O87jIRSfjvdIr+xW58mf1tE6T4sTVjy4Wfe+GxyM8T6jVxeeRcDR4OFWsghJ3L8
         cG9RvGjSYDWnBoDns/AOzYpILXTXqMlvf8TXF0/CmigdHIfBmC9KxvrbZ2CxnnouyWAb
         tu2VUsQ7d8w9XpgxCRT2BugIO5/bX9VvKisr6PZXeMNrQugelm6COPU8WMR+62JlvL1p
         OHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410418; x=1769015218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8rPwjfzU+1ry2RQl+0zGZMNXdxcPKW2Gfu/u1uR+Mw=;
        b=B/J5lrJytGWydLlbksPgPN83jtnZFWY+9laxgmvhIpfuSK+iI0Oobex7UcNEp6y75u
         oW5ZU2nYjRr49cS+t0WXSsBnuKl4dpNeGOhejXJJNYEjo8Xw62m0yTa03jYqmU39cTBg
         Qrnrs6bm841fpXzki2u5/e4Tin7YL6s0IeDoO/HK2FmR1Ax8D84Y2MkWF4FLff1VfC9z
         my832qMMJpvqbtJMV4o87ssIw+hCI0IqVLD/vCV/+94whvhHyXev3LZ4KmrQn1nkOm0p
         8uLEJJc5EHmp+aCMmj+4xzeWpn/fcZWMpYaT36JPTZO/+PeSu3dY9wwyMQmosHKF/koU
         3PJg==
X-Forwarded-Encrypted: i=1; AJvYcCXgj+7SFRC3SPEfzB44BEqJu4FA+pDRjauiqru2XuM7TXHlVaxLgaijUFO3dmSr11+twqxO2uD3A8kIX5dCsg2RpoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1TDW6U6moW1LsPZGLADPwOmrW9XyueHkXLOznBHrjB+fRGts
	gbnCuT16qkuilCx2JZv0cJLf+nBQuYUBsNZpWJS/rkfCdMCtVbc5XHwEC+eXICEcC0w=
X-Gm-Gg: AY/fxX7J3InMpCxs8BOeyPgZr/4T4Rsq0G7VbmA83tukRxwLRYLweSBaREj7Xsgw6aH
	eM1ahYSyNSuuDUeM4PeTVO8o5gJsDHahsNL6ALlbKV78Z4iChqYn8VZ19f6Lut1WsPIwpVyRFIZ
	os0g9tcF540FMxE5Yq4qrDNxaOvJyfCapZXqaSir6YdFjaAGVYwdrr2yJ072gGsGtRgdcUavJPb
	LrcbG18Py6utI76rfay2CNWw94KO9r/Z+Mz9cbi1w/J6x3umqfXZWTq0SxjBwt5n1AD4AzksQw9
	czg8yYXAu6qsHw+jLnUTOjhh50rzz/YutyfaHFpEwwLODbGw8jZfDACJchhqjENGEuDYUeEDJrz
	JJwAYDo0pLACk3hVWhkRFHSr7LogOAVcdP/2XLdNTomkA3cydxh4z6HuvX50LqkeCjt1M/FZTUh
	S5zMc8q116zNrwnzzScdjxYFsT
X-Received: by 2002:a05:600c:4f4d:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47ee338a84cmr41858385e9.32.1768410418292;
        Wed, 14 Jan 2026 09:06:58 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428cc338sm1933365e9.11.2026.01.14.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:06:57 -0800 (PST)
Date: Wed, 14 Jan 2026 18:06:56 +0100
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
Message-ID: <aWfNMKCoEp2LuA2v@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114145915.49926-4-mathieu.desnoyers@efficios.com>

On Wed 14-01-26 09:59:15, Mathieu Desnoyers wrote:
> Use the hierarchical tree counter approximation (hpcc) to implement the
> OOM killer task selection with a 2-pass algorithm. The first pass
> selects the process that has the highest badness points approximation,
> and the second pass compares each process using the current max badness
> points approximation.
> 
> The second pass uses an approximate comparison to eliminate all processes
> which are below the current max badness points approximation accuracy
> range.
> 
> Summing the per-CPU counters to calculate the precise badness of tasks
> is only required for tasks with an approximate badness within the
> accuracy range of the current max points value.
> 
> Limit to 16 the maximum number of badness sums allowed for an OOM killer
> task selection before falling back to the approximated comparison. This
> ensures bounded execution time for scenarios where many tasks have
> badness within the accuracy of the maximum badness approximation.
> 
> Testing the execution time of select_bad_process() with a single
> tail -f /dev/zero:
> 
>     AMD EPYC 9654 96-Core (2 sockets)
>     Within a KVM, configured with 256 logical cpus.
> 
>                                       | precise sum |   hpcc   |
>     ----------------------------------|-------------|----------|
>     nr_processes=40                   |    0.5 ms   |   0.3 ms |
>     nr_processes=10000                |   80.0 ms   |   7.9 ms |
> 
> Tested with the following script:

I am confused by these numbers. Are you saying that 2 pass over all
tasks and evaluating all of them is 10 times faster than a single pass
with exact sum of pcp counters?

> 
>   #!/bin/sh
> 
>   for a in $(seq 1 10); do (tail /dev/zero &); done
>   sleep 5
>   for a in $(seq 1 10); do (tail /dev/zero &); done
>   sleep 2
>   for a in $(seq 1 10); do (tail /dev/zero &); done
>   echo "Waiting for tasks to finish"
>   wait
> 
> Results: OOM kill order on a 128GB memory system
> ================================================

I find this section confusing as well. Is that before/after comparision.
If yes it would be great to call out explicit behavior before and after.

My overall impression is that the implementation is really involved and
at this moment I do not really see a big benefit of all the complexity.

It would help to explicitly mention what is the the overall imprecision
of the oom victim selection with the new data structure (maybe this is
good enough[*]). What if we go with exact precision with the new data
structure comparing to the original pcp counters.


[*] please keep in mind that oom victim selection is by no means an
exact science, we try to pick up a task that is likely to free up some
memory to unlock the system from memory depletion. We want that to be a
big memory consumer to reduce number of tasks to kill and we want to
roughly apply oom_score_adj.
-- 
Michal Hocko
SUSE Labs
