Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AC39EF27
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295329; cv=none; b=FOk7iI/xIKzT8IRCJEL85D/EBrs0O3BM+M3qiK2jnVlHLf6SuoY3TuLmamCQdOWR4sd3/n7nZ+c5kgGccB221BT9PVGuc+Ehw0FlOcg90qhS5I5UL4tbdpbogdOr0+xGix31NA9XaOtc/8lAshY54U6NNWp70Zrrv/MQIprEqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295329; c=relaxed/simple;
	bh=W6quqEuqAVLHu3zsXDdGSvOmeLHolpa6R9zg2wSv4vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN1+35mvKoJgDKLpWWUSuhE87gPF6+Iz4wJIN+WEkMHmybmFWMBqp7adLgv7blFuqYNoEZD4f+HchynnbZrisgNQ0rWge5wfTCDUeUb8o4T/LTcSj9xjy8ZfFfxuvIQaZS8B85wlOJq8U7rEBJpxYWmxXbrBRFr9zlwjZ//dGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTP+7qa8; arc=none smtp.client-ip=91.218.175.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTP+7qa8"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W6quqEuqAVLHu3zsXDdGSvOmeLHolpa6R9zg2wSv4vI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789295310; v=1; x=1789900110;
 b=RTP+7qa8E27RwXEebfZc1ApKGdgGS+WqVnNAJQhC3GxlRxCa4Lj2TIJtF/Vq9upEwpjZpcWo
 r3hCAI5av6nUt8GxGpKzm5yQZbjq23Lk2kbJ9L7BhGua4hl9+IA8bHaiUJWq7ueJTn0hAXtCGi0
 aoYpcCkzfhnKv09WY9r5VDGA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c13bf885cb93025;
	Sun, 13 Sep 2026 10:28:19 +0000
X-Mizu-Trace-ID: 9c13bf885cb93025
X-Migadu-Flow: FLOW_OUT
Message-ID: <7cf8e45c-51a3-4de3-9417-170eb34e0713@linux.dev>
Date: Sun, 13 Sep 2026 18:28:08 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/mglru: add tracepoint for inc_max_seq()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
 <20260911072848.2346073-4-ridong.chen@linux.dev>
 <20260911101514.1fe0d543@gandalf.local.home>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260911101514.1fe0d543@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2026 10:15 PM, Steven Rostedt wrote:
> On Fri, 11 Sep 2026 15:28:48 +0800
> Ridong Chen <ridong.chen@linux.dev> wrote:
> 
>> +static void trace_inc_max_seq(struct lruvec *lruvec)
>> +{
>> +	int type, gen;
>> +	unsigned long nr[ANON_AND_FILE][MAX_NR_GENS];
>> +	struct lru_gen_folio *lrugen = &lruvec->lrugen;
>> +
>> +	if (!trace_mm_mglru_inc_max_seq_enabled())
>> +		return;
>> +
>> +	for (type = 0; type < ANON_AND_FILE; type++)
>> +		for (gen = 0; gen < MAX_NR_GENS; gen++)
>> +			nr[type][gen] = lru_gen_seq_nr_pages(lrugen, gen, type);
>> +
>> +	trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
>> +				   lrugen->max_seq,
>> +				   lrugen->min_seq[LRU_GEN_ANON],
>> +				   lrugen->min_seq[LRU_GEN_FILE],
>> +				   nr[LRU_GEN_ANON], nr[LRU_GEN_FILE]);
>> +}
> 
> I would always look at trying to move as much logic into the
> TP_fast_assign() and not have it be where the tracepoint is called.
> 
> -- Steve

Thanks. Will update.

-- 
Best regards
Ridong

