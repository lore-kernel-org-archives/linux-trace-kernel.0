Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439042;
	b=Vnr++d87B+XmRiT/piiM5nncs6AB7APB12iIk5pYZZxxDF+UEtqDqKMB4Tpom9KPjMuq
	 twq0v2GPtUqZqi17tt4Iifn/ZearLxNgorI7fj5kZR27tG7A0aQYDZ9php61TB1iipBtt
	 Wd8uaVrAkzPkqvi3KZZewFNFdZtZ0rOSA5dXW0BCT5OL/AMZsaAZEUHtGu9PWOmLcn98h
	 sDAkjsw3Vd27dymWpI7vzaxR7g/PowrwUhM3iRNs4J1mSjwP9chlBGtjzYHdsBPBODLrY
	 P63Oj5biJZ2sXSbM/C7R4gYjlHwER8abTKE2dQxsQOAp1WUWJ8qiAjkhkZWmXQ+cm+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439042;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=znrLCuEJJGmNbO1Yhr6pNkt2XZN+PDlviOAs+EksPeM=;
	b=W8C8znTefYG0ju72u7Ma3pQPP3BoMpMIPhEZZY6oE4TwZPi5TWs7MYeMqs+iwGN3oT71
	 gcviSDgfj6UzUH8NCoWNjyryA8gFxwSNWyyKT+8rulXi6cVrEjvI8c34WqcTeAhd2irRN
	 XB7MKS+p/BbgOrqeobQyK8vA+zr8tyy53gGrexRT4YdRTlcP9R4YhUUP7zNhazKF6StTA
	 aTZc7LB+lewsHZsXbok/ixbYzuRtb2r6CJKkXTGA9txaodkEUo6BIAJfDlDUtSc+QLNDn
	 ZMvHUdJ7y5Jmp2/povHJLF2FblLUiOIEwsiE62yyzV2IyHzWNMkqDV9werw3sTEjj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=onn1sehd;
	arc=none smtp.remote-ip=91.218.175.97
Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D7606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 09:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76D7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=onn1sehd
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PvpE2xVkJZQp9Z5Dmn2rK7a3rOZLgmd/wYqlMX90kr4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793439039; v=1; x=1794043839;
 b=onn1sehdzhf2xVt9I5V0tDQ5w9aAfRk0sOy/O9MWDjUCaWL8OHQphb5kYXw9lprgNKlkr/MS
 yocmdX1yyu4yR+KFfILxLldFXdGYjd9gx/6b43A2Zc+p2/kh4Dr2f8mKdfMkwsgEkWOdiGpuCX+
 7ItVumMlQ8COOuay8M73TH1s=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9f95f1fa206c4141;
	Sat, 31 Oct 2026 09:30:09 +0000
X-Mizu-Trace-ID: 9f95f1fa206c4141
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
Subject: Re: [PATCH v5 3/6] mm/vmscan: move struct scan_control to a dedicated
 header
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261031090041.58574-4-ridong.chen@linux.dev>
Date: Sat, 31 Oct 2026 17:29:49 +0800
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
Message-Id: <CB3856A6-C6D5-41E1-B6BB-B263BB63BCD6@linux.dev>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-4-ridong.chen@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 17:00, Ridong Chen <ridong.chen@linux.dev> wrote:
> 
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> The definition of struct scan_control has lived inline at the top of
> mm/vmscan.c. Move it out to a new mm/vmscan.h so the reclaim-internal
> state can be referenced from other reclaim translation units without
> duplicating the definition.
> 
> The header uses an ordinary include guard and pulls in only what the
> struct needs (nodemask_t, gfp_t and struct reclaim_state).
> 
> mm/trace_vmscan.h includes the new header directly so that any
> translation unit pulling in the trace events (mm/vmscan.c, mm/shrinker.c)
> sees the full definition of struct scan_control regardless of include
> order.
> 
> No functional change.
> 
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

