Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611447;
	b=mzT+xwMxKnogEvlXd+L22Yqv6S16Xu+jbpi7s339xlrCj0N5/f491/MGonrdRlAdFGhV
	 9YR5KpSj6POlS0TtPyldEUiyy11bKhTplAvA1wb1Yh0XvkXb4IGc/HXa5X6yES1S1MWPp
	 rWPwYab7XGgyv4iliXjQ/8n6GMo29qXvzbciUordTjY7XdsdP4EUoPfCGUs60AAo1C9ix
	 ZjC21Ruv1mHFaOq8wDecJNUDWbY0dX0ZtOYnIIXnR0n/+eQgdLcAQo6TYcHaY+5f2xD8k
	 YffpzdnZv8iEin2Rmw9W66QhoXBmejXtMCKQn/twjB+++xY2j9TQYnqMgm2BuQ96HCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611447;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f2W5mYDF5OyICWdxbTulTo2Xs0l8NIvi3HpphFNiK5k=;
	b=kwdVI8/4gMOfh/gu/XVFsgrYvuny+0SPfx8GC8C3Yxqnf7czeqIBEZ4ONhJ9Zta41N6w
	 OW5wqmOMLstRScCp5fyj7ftmb2GUhd05Bzxv3u/mSd6vNbtajGZ5V1HZAuW9qW2s1WOFk
	 qsimlZGBDuK6hrYeA62wLbEz7f7SRR/6bM06HR/RA92Qfjvl8f/B+y/LKTovTHso06V/2
	 pWosvbSzEom+ZD2PHhmMJcLEIZCZ37UdkWdpLE1h1FcrSTJsfZTnOZ9Qy/sD7d9u/mXGG
	 cf0I4dv9vLDSn7Engvdd77d5Xs3zbpRdueKq6W/GYjARwNkLW14L4cTxCJPL/JtCh4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBXXKqgE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB3606A32D;
	Mon,  2 Nov 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBXXKqgE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591501F00A02;
	Mon,  2 Nov 2026 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611446;
	bh=f2W5mYDF5OyICWdxbTulTo2Xs0l8NIvi3HpphFNiK5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBXXKqgEs3cSEuo6JJMv4uQVYjwdPeUgKfOBFx3sGgRKSwaV7jr59rwXU6tl4kL1f
	 UIlGzQEfsGQkHOH/TbbDmLFtZg8Lg5fdSCTziFBdnk6TsVtI5yXd8hryFE0Ipc+XR6
	 jJwyfimv9DUYz/zcOWn3gUb3rQMyTHBdKf3AE1AilwXPZhOf+ikg0TX9pmlQWbt4p3
	 ZxklufKeISTuCfcwr1O/n49giKkDK76NYcCUf7r480LRRgWGND519LzVuzJFnKMhbQ
	 jEx/+S+Q2WxLeS4zw0Vr4+AL7I6IVMMHfFAho+9Ili2hsun175IqIkvSxRP6wDwmZG
	 02nxh+L9gixOw==
Date: Mon, 2 Nov 2026 09:23:58 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/compaction: stop repeating failed async
 compaction on every THP fault
Message-ID: <auhSzBcVE0M23miL@gremlin>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-bug-mm-thp-async-compact-defer-v2-0-b407e974db54@gmail.com>

You had 2 maintainers NAK your v1, why on earth are you sending a v2?

For avoidance of doubt:

Nacked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

For this and any future revisions. Stop sending it.

I have no confidence you understand any of this.

--
Cheers, Lorenzo
