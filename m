Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531F309EF4;
	Fri, 24 Apr 2026 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000599; cv=none; b=ChNKSGEhGGiJmNj/J0Dc7we9z2Oy5lw2wIdrcZ34uLITcSw8FRa9yhB+3/oL3og8CVRaF3my+gfgTSIypHYtj1ktBepMlnhBj+/QaPe1bO+ciNCSVHeCZuIV8XgdozhKXVJ75BSb5v9yRmV4yHYQ9W/DvudrRguy3w05VIpLFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000599; c=relaxed/simple;
	bh=v1NQXyoIZKwnFAlS0+sIC5LZWfMSPAnT8N08Bst9LIk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gJBObxnnhraCnmuVaTg1U8dwxFbj4QWb+km6XD9HuG3UYbB4D/gqG53e6Ec1xlEvZIYQVv2BxOzzR5pwXA8pddbp9wb/c9ZOGHq5tBSz80GZ8bYtVZKeM+Ig11MLfjv3e303tSFCcNGoUBQ1Qi/r3BBO72sO9rerxepKK5kUtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6+VzU43; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6+VzU43"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777000596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1NQXyoIZKwnFAlS0+sIC5LZWfMSPAnT8N08Bst9LIk=;
	b=J6+VzU431YtV6KyK6MjnabKRLohMOIaMxZHVTh1qt+xXqQCxaqdPmMxOhWOxW/3nuV0mFn
	bUW021+IIBE/5JPiTmpYjbZfrMMG42x+ddheBI5gFygQyX6LpMgH/mytLseIJpAJagjx6H
	tkRtW848Kx9IYSWeGwqBfwP6W4fTjw4=
Date: Fri, 24 Apr 2026 03:16:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shakeel Butt" <shakeel.butt@linux.dev>
Message-ID: <8cd382082ba7f5b9a23e0e6cc99e0fd7b9b663cb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mm/vmscan: add balance_pgdat begin/end tracepoints
To: "Bunyod Suvonov" <b.suvonov@sjtu.edu.cn>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: david@kernel.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 ljs@kernel.org, mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, "Bunyod
 Suvonov" <b.suvonov@sjtu.edu.cn>
In-Reply-To: <20260424031418.174597-1-b.suvonov@sjtu.edu.cn>
References: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
 <20260424031418.174597-1-b.suvonov@sjtu.edu.cn>
X-Migadu-Flow: FLOW_OUT

April 23, 2026 at 8:14 PM, "Bunyod Suvonov" <b.suvonov@sjtu.edu.cn mailto=
:b.suvonov@sjtu.edu.cn?to=3D%22Bunyod%20Suvonov%22%20%3Cb.suvonov%40sjtu.=
edu.cn%3E > wrote:


>=20
>=20Vmscan has six main reclaim entry points: try_to_free_pages() for
> direct reclaim, try_to_free_mem_cgroup_pages() for memcg reclaim,
> mem_cgroup_shrink_node() for memcg soft limit reclaim, node_reclaim()
> for node reclaim, shrink_all_memory() for hibernation reclaim, and
> balance_pgdat() for kswapd reclaim.
>=20
>=20All of them, except for shrink_all_memory() and balance_pgdat(), alre=
ady
> have begin/end tracepoints. This makes it harder to trace which reclaim
> path is responsible for memory reclaim activity, because kswapd reclaim
> cannot be identified as cleanly as other reclaim entry points, even
> though it is the main background reclaim path under memory pressure.
> There may be no need to trace shrink_all_memory() as it is primarily
> used during hibernation. So this patch adds the missing tracepoint pair
> for balance_pgdat().
>=20
>=20The begin tracepoint records the node id, requested reclaim order, an=
d
> the requested classzone bound (highest_zoneidx). The end tracepoint
> records the node id, the reclaim order that balance_pgdat() finished
> with, the requested classzone bound, and nr_reclaimed. Together, they
> show the requested reclaim order and classzone bound, whether reclaim
> fell back to a lower order, and how much reclaim work was done.
>=20
>=20The end tracepoint also records highest_zoneidx even though it does n=
ot
> change within a balance_pgdat() invocation. This keeps the end event
> self-contained, so users can analyze reclaim results directly from end
> events without depending on begin/end correlation, which is less
> convenient when tracing is filtered or records are dropped. It also
> makes it straightforward to relate nr_reclaimed and the final reclaim
> order to the requested classzone bound.
>=20
>=20Signed-off-by: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
