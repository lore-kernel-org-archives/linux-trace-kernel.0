Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78434CFBA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889421; cv=none; b=lIJhU4hpV6RhQo+iR7ItdnZaAMdy63WC/02l1z7Ys+ks7naBxNQf2riWGxqcEN+KRc3DPJc8NJ9VIoqR8ktM7VGP0ZnD6kYO3/bOBpdswR/c7im3oCaU+/Y58hJ/qUlq4Avx9OasH3F2sQbU40g6m+LJ7Z9yqklsq58hMj4TBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889421; c=relaxed/simple;
	bh=Glie2dDdb0rtYRRJaB/UrvAAGXrFPRVG05iXdt9Zf5g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iFBDBDUjW7G4WJX9NNKtYnBmTSV8xv3OBSGocxxpWx0LNWas7Wb2P8x4qEbCGCVnjbclIYwyrDHlSp4A910m7K7lHrO/5H1TK/FyEDf/R9GJRdTX/Jzh1WFZkVAypWw5AAT2h8ds0BB3qYDH4QZdCCJLwLMyBGbmL1pg9sPBGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQplAEaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQplAEaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A74EC116C6;
	Mon, 23 Feb 2026 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889420;
	bh=Glie2dDdb0rtYRRJaB/UrvAAGXrFPRVG05iXdt9Zf5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQplAEaznmMrCJ6SgkIq5wf0WtoJXumBiFEkgJe3OJQ3oqPctce0aW2nZYm4W0EV9
	 EVEO6T6DZvaJkJgtRoQyey8sILh+2X1ppdtZjMdrzAGFlgVw5d/v3kZMlYTHDgsN+p
	 e8XlPGTWv/0KH1oAVE/w9LK0MVoGRmZer55PopAVjX7qKAqIHUVX2QEaYZXvWA6hb3
	 LGby9WFIxqBZGFQxusZvD7q4PWlHUViAjzwCThkhysUMWQ2dJMEPFGZAw6T2f3z+o1
	 XLiPlOrX5K+2qxV3cSreRHlukrKItI+ujzkNpCxKnQDEVXgfm/L3e3nH6lJi7uhNqu
	 PUuFrnPj9xacQ==
Date: Tue, 24 Feb 2026 08:30:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, david@kernel.org,
 hannes@cmpxchg.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org,
 rostedt@goodmis.org, shakeel.butt@linux.dev, weixugc@google.com,
 yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v7 3/3] mm: vmscan: add PIDs to vmscan tracepoints
Message-Id: <20260224083014.66bf222ffd81a3ebaa57a0e0@kernel.org>
In-Reply-To: <20260223171544.4750-4-tballasi@linux.microsoft.com>
References: <20260213181537.54350-1-tballasi@linux.microsoft.com>
	<20260223171544.4750-1-tballasi@linux.microsoft.com>
	<20260223171544.4750-4-tballasi@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 23 Feb 2026 09:15:44 -0800
Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> The changes aims at adding additionnal tracepoints variables to help
> debuggers attribute them to specific processes.
> 
> The PID field uses in_task() to reliably detect when we're in process
> context and can safely access current->pid.  When not in process
> context (such as in interrupt or in an asynchronous RCU context), the
> field is set to -1 as a sentinel value.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
> ---
>  include/trace/events/vmscan.h | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 1212f6a7c223e..15b31281f0955 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -122,18 +122,22 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  		__field(	unsigned long,	gfp_flags	)
>  		__field(	u64,	memcg_id	)
>  		__field(	int,	order		)
> +		__field(	int,	pid		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->order		= order;
> +		__entry->pid		= current->pid;

All entries saves current->pid in common_pid field. Can you use
this common field?

# cat events/vmscan/mm_vmscan_reclaim_pages/format 
name: mm_vmscan_reclaim_pages
ID: 590
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;    ## <------------here

	field:int nid;	offset:8;	size:4;	signed:1;
	field:unsigned long nr_scanned;	offset:16;	size:8;	signed:0;
	field:unsigned long nr_reclaimed;	offset:24;	size:8;	signed:0;
	field:unsigned long nr_dirty;	offset:32;	size:8;	signed:0;
	field:unsigned long nr_writeback;	offset:40;	size:8;	signed:0;
	field:unsigned long nr_congested;	offset:48;	size:8;	signed:0;
	field:unsigned long nr_immediate;	offset:56;	size:8;	signed:0;
	field:unsigned int nr_activate0;	offset:64;	size:4;	signed:0;
	field:unsigned int nr_activate1;	offset:68;	size:4;	signed:0;
	field:unsigned long nr_ref_keep;	offset:72;	size:8;	signed:0;
	field:unsigned long nr_unmap_fail;	offset:80;	size:8;	signed:0;

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
