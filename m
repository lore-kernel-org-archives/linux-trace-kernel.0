Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213141E0DD8;
	Fri, 23 Jan 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190315; cv=none; b=aMPmU2EChLGH2wn/nzgsd9FMc72k4Okg7Iy3Zv4HiLdU2EwL8+l7/Ogr6mArztCDGV160DlC66O3lG/xZ3wvcT1EZh9Gznit6LlMdWGufB/SIpGNRaBsTJAJMcv04NSY1Hre9pd8ZMeFd5EPfHB0FiFKnnGNUpf9Af2US4PHwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190315; c=relaxed/simple;
	bh=wYFzmBn8gDK4KH/15rkBjIDe9SrSV3OLA7nZw/09V8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRCv7pPftYxpiLtsXObnGRc6YETwKedfEheB55xU9DRvzf6atRT0svKiroMezwOkR8NaMO/0ATXNtaCD7zwAFEjuj1+HKglxxHKvtlGYeIAB5YfJ6FdAdE2se9s/ieGDPKCdPBeFGHyPeHPdZnVvqZrm04XhxaGmZ2+cwftnh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7453E13B16D;
	Fri, 23 Jan 2026 17:45:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id E42D330;
	Fri, 23 Jan 2026 17:44:59 +0000 (UTC)
Date: Fri, 23 Jan 2026 12:45:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/vmscan: add tracepoint and reason for
 kswapd_failures reset
Message-ID: <20260123124528.3d118cca@gandalf.local.home>
In-Reply-To: <20260120024402.387576-3-jiayuan.chen@linux.dev>
References: <20260120024402.387576-1-jiayuan.chen@linux.dev>
	<20260120024402.387576-3-jiayuan.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: q4zhqppw5gjibr9p9yjxnf81j4335nkf
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E42D330
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JXD2BXE3/gdW7HdTzbiyh3DXw65GaDyQ=
X-HE-Tag: 1769190299-137174
X-HE-Meta: U2FsdGVkX1/k0WOEjxuFlRjyrwM6ArGM7a37Fl64pCJk2GzPiMBmWsuXF8UK0DlA5h/C4mbQxdjBen0JUgQuQao39sP24WpFDoBSjXmo/ltdziwlBwEPBoXNkNV6agREqWfVHY4r2XGIzJMvf1rFArbAoTfyZbxs0LSj8jqtS2NKl1ew4vMM1Se1Ms5XvCZfSSisMN45JE9yGe0aBvnrMpOd0h6JAvSpmNKxOojpvrRHYWSvO4GQIPdin/aNhQ6WYvW0juG7STJpsJpOsK01MgaRr5by5kQ+a5mJaCpEitupsDHW+FJoJg4T2q1JpebOUfzJHoLi2lE7o561rmCIt2Ciko0EviKmKneUaumyl1OiQkvtF7WfCNC+Sn7sERm/+Ijcdoxbsf3QNEdovYnnO4MNaS2hHI13YUGg0GTQ0Ac9aAbHgv7BtvpSr25U367DPLTn9zGREABwH9XsaFB4T4cUgPJKkm6IjHyPH1c4BnCoMcYoMx5Vuw==

On Tue, 20 Jan 2026 10:43:49 +0800
Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/mmzone.h        | 19 ++++++++++---
>  include/trace/events/vmscan.h | 51 +++++++++++++++++++++++++++++++++++
>  mm/memory-tiers.c             |  2 +-
>  mm/page_alloc.c               |  4 +--
>  mm/show_mem.c                 |  3 +--
>  mm/vmscan.c                   | 29 +++++++++++++-------
>  mm/vmstat.c                   |  2 +-
>  7 files changed, 91 insertions(+), 19 deletions(-)

=46rom a tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
