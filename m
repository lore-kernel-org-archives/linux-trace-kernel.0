Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325188;
	b=QXkXLqjeTi6tZ61sKRA6yfDM681oOFzlO7o7AEGeYaXp5o9Img/cqA4l69wz6wIBN++I
	 b+QCm5t/SnSaU4FVTIj2Zbm+syjHQTAoH4umDnDu5c5c3A2X8IO4WxQjx/BYrhTqdlPdK
	 Bey3/HbMTfThG2cqGwJnCdn89L2ZOd5WnjoXxqY/DjTmONTRGnzKmt3DtHxOmQ/dCEg12
	 nO37h1QOx73rqZcvx+3pgAyX8UzzoWXWi4SCsWM4RH862cLtmvvBjh1pSx5/jHiDM0c/C
	 kRq7aXtL5GGpb5ErXkaxnVwu9QdSWY4h7Cp8wH8Lw0oG2UA9tjF8p8g5i9mfUwTj9lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325188;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/Dc+JwsdmgyYxqvZQmyNcFdizNnWnNQRrjUAX8hzcoU=;
	b=v2zC5xycdpLJj0px1j1RRuPkg7BfEqOusBzBia9VExlArCcMXxFx90gVdXolxQNiqsAd
	 TFSIVvx1FXgKQ3ZgHQrbbU4pGPZ6b9ZRsbWVP3gewEjvd2KqY9/CD0IJeBJ6PSRSdtz9+
	 Bz9sPcpQf3VyLV4iiFqyQQDnSVperXLYuAlULc8r5r4lQZtFBlohqKVG0lF84MjItoD1e
	 tUifFJByYPinawjdO9JL/Ne+9k3BuEfhxMlXYWhOMps5Kjd4WGjtupEQh/pHLhtjJYbl5
	 AD8bbOaBsk/2FyL4fJ/VoeDZPAkfcopqT+fD0rGiRrHiyrH/fyUwJGVbGUuiMx+P4gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SsQSQlHy;
	arc=none smtp.remote-ip=95.215.58.177
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BB606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 15:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946BB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SsQSQlHy
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U8k35pxEd0m+x8ZKDuQMkZMM3+/gIzGlGIc3CscMOqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794325185; v=1; x=1794929985;
 b=SsQSQlHyp7V5Z0CCbhyiGrxvJPcWe9+dkoM1G2BZx1xIyZDJVnejZeMb1MALH+7xItNzDytf
 u6MYKWta7tzzj39/69e7aCn1s1eozEAGLBrWMUMof7KcaaGsU2MKtoOWyxFwM3nG5Xw1DiOl67M
 zyLFvGH+f39e5KhEBw8n8fu8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0bcc4bd1f1aaf32a;
	Tue, 10 Nov 2026 15:39:45 +0000
X-Mizu-Trace-ID: 0bcc4bd1f1aaf32a
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/compaction: stop repeating failed async compaction on every THP fault
Date: Tue, 10 Nov 2026 10:39:28 -0500
Message-ID: <20261110153928.4039653-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0a850ec1-d45d-463e-829a-e782290ef864@kernel.org>
References: <20261102-bug-mm-thp-async-compact-defer-v2-0-b407e974db54@gmail.com> <20261110135824.3264904-1-qiliang.yuan@linux.dev> <0a850ec1-d45d-463e-829a-e782290ef864@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/26 15:13, Vlastimil Babka wrote:
> The series was nacked twice by senior maintainers. Due to dealing with
> urgent issues [1] we might perhaps find time later to see if it reports a
> real issue, and in that case fix it ourselves. We have currently no time to
> help those who need AI assistance to contribute instead of having own knowledge.
>
> [1]
> https://lore.kernel.org/linux-mm/a2f584f6-e382-4876-aa6d-d5a34de6ee59@kernel.org/

I'm only spending time on this because it gets in the way of AI
training and inference, which long-term pin large buffers for RDMA.
Mooncake, the KV cache store used with vLLM and SGLang, hit it with
8 ranks x 190GB taking ~38 minutes to register. The stall and the
numbers are real, also measured on my own test setup.

Async failures have not been deferred since commit 66199712e9ee ("mm:
page allocator: do not call direct reclaim for THP allocations while
compaction is deferred"), which explained:

	/*
	 * As async compaction considers a subset of pageblocks, only
	 * defer if the failure was a sync compaction failure.
	 */

That still holds, so the series has no Fixes tag: it isn't a bug in
that commit. What the rule doesn't cover is long-term pinned memory,
much less common in 2012, where async fails the same way on every
fault and is never deferred. The series leaves sync deferral as it is
and gives async a state of its own. The analysis and a reproducer are
in [2].

If you look at it later, I'm happy to test whatever you come up with.

[2] https://lore.kernel.org/r/20261110144256.3841504-1-qiliang.yuan@linux.dev

Thanks,
Qiliang
