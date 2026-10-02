Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288142E40C;
	Fri,  2 Oct 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950904; cv=none; b=p8L83NlFokB9YFN1axKTZQCTaFwvCcHSCd0NXEG7J8SqgyxwvnAccFaPZl8aoErmN4U/lpjzEWzqlp5pKQx4s3fpUQPNXkJjDtsKc/b5GB9RCfzK/EExTHnnokWVBewqaDnxBoQ4T5mcIBHdprpAhgpsYjjdaOaeWI5tOGiZpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950904; c=relaxed/simple;
	bh=n6+QQymcOivf0+4zdsobFJgsrQHGOpoNwZ+nFpDoq6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9aISf8On2SZD5Fdqj5NqY4UIL+VM5Ttc0qt2SL0j4wCAWczFjiTAhKuYo0BaXSWekXA4Yy+htoc4hBpu9S5GtPII308DpUDP/h8X+v9Pgu3+ZReul/MCfCD2w3J+pRqUjv2hMBuaJRVKl/2X6w0SBw8i51GXSpb6GCKX5M4WR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSj9PA/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSj9PA/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF661F000FF;
	Fri,  2 Oct 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950903;
	bh=+f7gBbOphql33Q3z9qijzYQyChgApQkTFAi8r/69YSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSj9PA/L2u6jo9z1u1+xXGOd0b46RN4+ABOIYgfMTbCTH5TUJxFeD+he758vhlLJ6
	 7eA8pJKsjgArpERYc1uj+EZ/l8FefKlH395TpTTvHFhm4qCoMF5KId3X//R9z1p/7j
	 70wZAfczigNeHRxm6TlJupLHi5VI9V3X+NvJ8ZLZFOBOnfySKta/PRQcYQerx5OeWT
	 uSRm+TJCaVwDL7g6Hu1zfM0afLXPL+ggJrbwWzqeM0gwze/v9npXMbBVva6stebNfw
	 HAK3t6gLfwT9Qfm6E/2EwwMAGDbnVjqjpyaWs1rrcRcpaKSw7J/enU1qHozKIG5k1t
	 UhXhJ/fCBg77w==
Date: Fri, 2 Oct 2026 15:21:34 +0100
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
Subject: Re: [PATCH 0/2] mm/compaction: stop repeating failed async
 compaction on every THP fault
Message-ID: <ar-8Vkchzn4QobA6@gremlin>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>

Hi,

NAK.

This series is buggy, and has triggered my AI detection script.

It is kernel policy that you must disclose this with an
Assisted-by tag like:

Assisted-by: LLM

See https://docs.kernel.org/process/coding-assistants.html

It is also kernel policy that you must fully understand and take
responsibility for every patch that you send.

See https://docs.kernel.org/process/generated-content.html most
notably:

        If tools permit you to generate a contribution automatically, expect
        additional scrutiny in proportion to how much of it was generated.

        As with the output of any tooling, the result may be incorrect or
        inappropriate. You are expected to understand and to be able to
        defend everything you submit. If you are unable to do so, then do
        not submit the resulting changes.

        If you do so anyway, maintainers are entitled to reject your series
        without detailed review.

In general, if you are a newcomer to mm, we expect you to do smaller work
before moving on to larger changes, so you build understanding of both the
technical aspects of mm and how we do things.

Given you sent your first mail on 21st September and have since been
spamming complicated series across multiple different domains, I'm
absolutely not confident that you have any understanding of this.

https://lore.kernel.org/all/?q=f%3Aodys.yuan%40gmail.com

It also noted that you had a previous email, realwujing@gmail.com, which
you have silent switched from, which also bore the hallmarks of AI slop.

The script noted:

- Output rate: since 09-28 he has sent KVM SMM CR3/Hyper-V, ext4+jbd2+quota
  "shrinker scan budget accounting" (the same fix applied to three shrinkers;
  jbd2 went v1->v5 in 3 days and v1->v3 in 3 hours), blk-mq SRCU tag sets, a
  blk-mq sync-run, ublk x2, a 4-patch bpf-next verifier rework, mm/migrate
  move_pages (v2 sent 10h after v1) and this series. That is ~9 unrelated deep
  areas in 4 days from someone with 4 commits.

Among many other indicators.

It also found several glaring flaws with your series, so it's clearly not
upstreamable.

I am going to have to ask you to focus on smaller changes as a newcomer,
and to acknowledge any LLM tools you have used, please.

Thanks.

--
Cheers, Lorenzo
