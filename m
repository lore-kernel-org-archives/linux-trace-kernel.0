Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363037F75B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889314; cv=none; b=PHu4J0EMQ6Um9xlXij84A2VW6FoKGv+HRygX8XXGdIckebiKFOpnNEpeU7XbNVgCgJGymauupAcQb+5ysPkRvUrbratYs63VsQC3EXLeWMz+1EOFDiuW19j2LzdYeVotntMDDGZ+wXsdh7ATtYLSXf2MXZ+IkpCBTh3qmgdlRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889314; c=relaxed/simple;
	bh=R34J6jvnkRPZjUFInmh1iWJ7K4DTrcNs8QrCatVBwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uilhiXe6pn03btjhwk12P7QEu6EihYlFPdriacfNyIVCAa4kVSYdoMgzRhPZ7+8C5CRllKJyxphJqhr6szND3klqdf7G9+eYGbjs10a6YGLRAYBWPsKpJoaCE/RhtKyKiS1MhFFvVnoY0AcVXmsmg8TquOcjL/camVHPvwB9uHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U9I3TT8y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U9I3TT8y"
Date: Mon, 23 Feb 2026 15:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771889301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLOdiaqX3yPW7m0nfesCXj4Mjr6o8vyaIg3hDRZrwfg=;
	b=U9I3TT8y7+uV4deYZUwpc4lIdgTCMA8gOEmXftR1Fmaq+hNfql6+1u3cYtPTi8xDkpb/8y
	UZpwFxw/9s7pc9xorCwqzRuZJawv6q/Xjd3SQ4PubC1AuBd9EVXJc5/ZQNf6ZH4rDlxEU+
	Q97zILbWyMtZuFl4NOxk2bX9/BQBdtg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/4] mm: convert zone lock users to wrappers
Message-ID: <aZzicQS19G_WeL-J@linux.dev>
References: <cover.1770821420.git.d@ilvokhin.com>
 <7d1ee95201a8870445556e61e47161f46ade8b3b.1770821420.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1ee95201a8870445556e61e47161f46ade8b3b.1770821420.git.d@ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 11, 2026 at 03:22:14PM +0000, Dmitry Ilvokhin wrote:
> Replace direct zone lock acquire/release operations with the
> newly introduced wrappers.
> 
> The changes are purely mechanical substitutions. No functional change
> intended. Locking semantics and ordering remain unchanged.
> 
> The compaction path is left unchanged for now and will be
> handled separately in the following patch due to additional
> non-trivial modifications.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
