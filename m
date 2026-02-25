Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A42C21F2;
	Wed, 25 Feb 2026 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050463; cv=none; b=gCse5nD7I3aQMqD9e57kEMB+sD36oU9i6qjhOKyTEmKNX3P+oAQpHGXEFnPzKM9+EZAw2O3aYJ2u51DQjmgwFg8jJx4Qn4IX0viTaLqy6dEVRykXMhEIOBrT0Po3Pez3IH/a+lzlGjPr/cALWEK6lHti0NW6vkqXiw4lCg1Dd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050463; c=relaxed/simple;
	bh=ZR89WZo19RbWI5s9dT12x74sNrjCq2xbeHPg2EjiXV4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rMw15aTXukb8X+eTKL9F+2xeckjz0yL3/1VT9hN3Q4DnFbzZfhbD0uPdiouPtd5WUIK4BgvHpi3EwN9TgIIsigiydaQ/chX1jM0kbkQx+xvkKoAkcUYyCJiZ6gojM9IBxOenWa8qCgJDXXOJ42q7e08zEq337zLL6/lK7Ji+3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zclgkkzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zclgkkzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2578C116D0;
	Wed, 25 Feb 2026 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772050462;
	bh=ZR89WZo19RbWI5s9dT12x74sNrjCq2xbeHPg2EjiXV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zclgkkzosw4SMxwoKAiGEH/ZbSH9lv41enOItAHjveMmmZUvHmQ8eDLlYUpQ8Dqay
	 bvcVj8hga4F1yCL5hHRS3huAelb+vI0W117kN4ZVuAI3nnfaA5MvJBqV5S+x3xJTQp
	 XPjNtQxc2PJjF8J9s365amibB7Wd3e6YgxdtlP50=
Date: Wed, 25 Feb 2026 12:14:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 1/4] mm: introduce zone lock wrappers
Message-Id: <20260225121421.2eb75a94578af35780978851@linux-foundation.org>
In-Reply-To: <5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772030186.git.d@ilvokhin.com>
References: <cover.1772030186.git.d@ilvokhin.com>
	<5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772030186.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 14:43:03 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Add thin wrappers around zone lock acquire/release operations. This
> prepares the code for future tracepoint instrumentation without
> modifying individual call sites.
> 
> Centralizing zone lock operations behind wrappers allows future
> instrumentation or debugging hooks to be added without touching
> all users.
> 
> No functional change intended. The wrappers are introduced in
> preparation for subsequent patches and are not yet used.
> 
> ...
>
> +static inline void zone_lock_init(struct zone *zone)
> +{
> +	spin_lock_init(&zone->lock);
> +}

Please consider renaming zone.lock to something else (_lock would be
conventional) so that any present and future and out-of-tree
unconverted code won't compile.

