Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438891;
	b=qWALUJ4VW6+JKGzW4aIHztMREBvtp4KbTdrkxI8S1lA9Ou1jP68ADKOMbiasNCMIGcw4
	 +Vqmpbnaf9fuxvLon1VprJ1GPve7hNtvVcRawNw+ZKd85rmTjOMJSDOXMlADAs9tmc92k
	 WzXbZYvdtXhnY+KWjNvvankiOsSlD0lPNCyp2kwSEaQKf9oJWOWV2290RV4efjCxlJ/4g
	 ld6akxPzGjhXjyS5g9TUHgaBxmXklX0NF++OkNIDKA1EvYVh5fhQp4ZptazjqoVbW+dIp
	 /ktq0PAoi2VsRRrFdlYuiKyyCRpZNoDelp6nx0Avda4Ov2XXUxHp+gMPoYYYyvN91Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438891;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=/He75rqZEHTrbQuKFrcjCckncTUr+jB2aL3GERrJXuo=;
	b=kyA1SwM+mhgIhVxmHsci7qLazFbZMcYI7vScUzISCuwfuvHzKpKxlgpfjC4HMF8faWAV
	 G1p/6Np1Ri8e+sFmnqjg6oEvngtprW/aU8rZSdJXN0wRuJakA49W6TC8xLvXO48uD9pcg
	 BZ43FLfWpwvq40gJI66/TkXCjzjbqLwJB1tUIIfGHdJB0+IhNZ+pZoXmYUioDS4vh8TUZ
	 zWC18iOXtVGQ86EwMrL68j8PplP+xlYHng/jAdYJZ39NYKWusDVMn80ETTy2Fh4e7yZUy
	 RWrx9vty8vi8t9gtXfkSj7WMQnkb1gVhmMGWkz23PNemxHFe7NZs5NrYt3aDjQx2LmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sVxs5SaD;
	arc=none smtp.remote-ip=91.218.175.77
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED6606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 09:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CED6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sVxs5SaD
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=08Ba43Ng1QTJoClFmEOcfURkhCB+iyftKxXyUWNmLKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793438888; v=1; x=1794043688;
 b=sVxs5SaDkDBa09uTFu4hFJOaqrtNtfEPrN2fBpSuwy9ko181eiquYUD8AOWi9trGcmunnpcx
 sLJzJIJ+JB9/1wP5f764vUWk8rhW4KYWW1Qfb0Kx6k3KcUZKmeE4KbhbIDn+wtMKR2i8l7yWZgt
 o5KYGeBJItZdvSCZKs9EPhTo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 034d958c6540cbee;
	Sat, 31 Oct 2026 09:28:07 +0000
X-Mizu-Trace-ID: 034d958c6540cbee
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v5 2/6] mm/vmscan: move vmscan tracepoints to a local
 header
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261031090041.58574-3-ridong.chen@linux.dev>
Date: Sat, 31 Oct 2026 17:27:45 +0800
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Dave Chinner <david@fromorbit.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
 bpf@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>,
 "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org (ope>)
Content-Transfer-Encoding: 7bit
Message-Id: <9F0BED6B-4992-4F67-A8C6-D9550FBCEF22@linux.dev>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-3-ridong.chen@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 17:00, Ridong Chen <ridong.chen@linux.dev> wrote:
> 
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Move include/trace/events/vmscan.h to mm/trace_vmscan.h so that the
> tracepoints can be extended to reference vmscan-internal structures such
> as struct scan_control, which is not visible outside mm/.  This mirrors
> what several other subsystems already do with their trace headers (e.g.
> fs/fuse/fuse_trace.h, fs/gfs2/trace_gfs2.h, fs/lockd/trace.h).  As they
> do, set TRACE_INCLUDE_PATH to "." and add mm/ to the include path of
> vmscan.o, the only user that defines CREATE_TRACE_POINTS.
> 
> No functional change.
> 
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

