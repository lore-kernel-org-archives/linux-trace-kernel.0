Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62815E97;
	Sun, 11 Jan 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153705; cv=none; b=AmOlmnXvS5Y6S3s1jLHU7nmGyPMqdyMbcvMynaw0D3mLnNMjf3VPVRx22XIPuqgbraGG5jFG726kAy6OgMg5htTxHDhj4FHwKnTpgVaNrqzGYp8XteXUceKLiI3ZkEGh8N7duMMFzna0unkBXwVjuBhqXVHROR7ZGziDUDZEw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153705; c=relaxed/simple;
	bh=tAZQO9fZL+JCzR/NPdben4nsIslJaqE+/9xN+WeZAqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nrvoapaAgC8imZs89VLa+dODOS/iyJrZ7ynFV/iHYVoph9p6nxDYzA3EpH20dTZt++g2F3RtoFloDoG1Dt4g8uFsmEm4RGD63CQY2eA8b5hUVcqhOV0Tc5pnbolknUkhKiEnujZGm4L4cVU9Mb8e8J55YVeEOIeQzzlv9BkQED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GhY6az9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GhY6az9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CB1C4CEF7;
	Sun, 11 Jan 2026 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768153705;
	bh=tAZQO9fZL+JCzR/NPdben4nsIslJaqE+/9xN+WeZAqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GhY6az9gPT+YHZRlpbbkHcZtCPSU1JiLV2/cEVfjET15oezT62Q8szgpeGZUbhJdR
	 ODZezElIfHzTUWpG4wwCkSvNIq3rZy8dH0Y9Ni2lTWRoR0BlPHtbUC/dedIlRThJx3
	 TRK44p702DI7/hFWTItDmpBmGEMMc7un6OkKqO4Y=
Date: Sun, 11 Jan 2026 09:48:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Martin Liu
 <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>, SeongJae
 Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <liam.howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, Miaohe
 Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, Yu Zhao
 <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Mateusz
 Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Aboorva Devarajan
 <aboorvad@linux.ibm.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v12 0/3] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-Id: <20260111094823.6fcb1fcceb7cfca2dd37b66e@linux-foundation.org>
In-Reply-To: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
References: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 10:02:46 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Introduce hierarchical per-cpu counters and use them for RSS tracking to
> fix the per-mm RSS tracking which has become too inaccurate for OOM
> killer purposes on large many-core systems.

Great, thanks.

> Notable changes for v12:
> 
> - Reduce per-CPU counters memory allocation size to sizeof long
>   (fixing mixup with sizeof intermediate cache line aligned items).
> - Use "long" counters types rather than "int".
> - get_mm_counter_sum() returns a precise sum.
> - Introduce and use functions to calculate the min/max possible precise
>   sum values associated with an approximate sum.

May I ask, as an early adopter, what is your overall impression of
the Gemini reviewbot?
