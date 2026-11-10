Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319124;
	b=a7XNT19pgiRgc5Qe31Bdy23ZG9Yt9It8h/3JFh79hwDPAJ6KlR0HO8Nu/ey00xu5Mmna
	 msR0BMMKuzxmQuMY23hS3EVPU7jfK0aKSmDAh7DNWk/lJic/aMd6UVly/sRya8ZopUTlf
	 evwmfAos5dpDr+F2cHVh3WeQnuuzve0S0drImTF0DxUH0k9EnceTFv5Q9HKh0x3yUrdAx
	 CxQ05jLVEnT3YvxXpldvqLuFzOZHN/t/uSP/ENziMZmd1M49jhhPbM2KPNjnn5jeMoJtn
	 0YqrEydcs0whXZPMsBCS6qpVvpadeygxONaKnbUBOPB10cNQWD5BNagPIOAXYURV11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319124;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4AuBCb/I7k73HlQgjzDYi07i0QVcp76kIK/7/UWRP9M=;
	b=5XgesfvtT7V+jK8ZVlDpptjRiVEgUVgWe9dcQsyEnNeAZ4TRz23R6AUJ+17fiZuQp/aM
	 NBf2C9Ct7XiRrRnOBP3enLWlS5x3xA/2JXEFsE5LzW9LfETaiwd3dPfpnpJ3Ebya8V6dp
	 dMoLVLQPneBXXkmwsidWzQq3wMmKGW2zgFWk/48CdGc54kNjJv0GAfuq+46wQjJ/5ghC2
	 zN9X4Kj1euh0whjzv1ig3vlR97fiBw1/mP2NkXnlcEjw/3h3dCthYPbaQUgGYbAX/7n2G
	 4HjJyhUM8L/u0sxrcEevS4us4jDsbJP0DZ+XnpQiVnbNynM/B88zUmpYa9XdMfml2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g7jmzUK0;
	arc=none smtp.remote-ip=95.215.58.2
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9E606A321
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 13:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F9E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g7jmzUK0
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4AuBCb/I7k73HlQgjzDYi07i0QVcp76kIK/7/UWRP9M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794319120; v=1; x=1794923920;
 b=g7jmzUK0d/G3BvqcNkqamkKsfKfjCzjV+abGar/cbKfi8lCffnKVGlS+BDf9zv+dSjxtSI+q
 CvBjp53iEChofoerEKpjDOV14gGPTeuNCTU4ZShT1gKUKrWKjy3OVvLQNeQRcEMHNKKu8XXJckr
 O7zs8C9P+sBOxpKZY42/axD4=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 68181a37af8247a7;
	Tue, 10 Nov 2026 13:58:38 +0000
X-Mizu-Trace-ID: 68181a37af8247a7
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
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
Date: Tue, 10 Nov 2026 08:58:24 -0500
Message-ID: <20261110135824.3264904-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102-bug-mm-thp-async-compact-defer-v2-0-b407e974db54@gmail.com>
References: <20261102-bug-mm-thp-async-compact-defer-v2-0-b407e974db54@gmail.com>
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

Hi Vlastimil, Johannes,

Could you share your view on this series when you have time?

One known issue in v2: the cc->mode != MIGRATE_ASYNC check added to
2/2 blocks clearing stale skip hints once sync compaction is fully
deferred, so local THP may not recover after the pins are released.
I'd drop it in v3, but won't send one before hearing from you.

Thanks,
Qiliang
