Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D962C21CC;
	Fri, 21 Nov 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750440; cv=none; b=H1UbxFqGBuq3z+qPrZPN+QI/tmDb4VYrrMq5QLM06TR0TDSmCmvca5dpkFPVYV6k2xYwdfKQsREwBBbsR6GHFXwVVnqBke5a+hKS6zZMPCgloi8Aw4bjzX5P8X5VBYD2V6n1KqXxdQnIQ4eHdX8IMsGM4ALXR6BB+AFL2yLJSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750440; c=relaxed/simple;
	bh=jWslEPu1h+kwOX+YdsgP+InMHvzad4h5A0TecdWZjCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jZxvRMXawmcnM8wJnamGiA9n9MpeeJNVb3Vx0EV4iGUGXC5spV2e2o1PuE/gub6pImOy8mWgpqvA/gWhqixHM5KNRZ8UtGOr9rlECHgF+1+qJqD7S27w72npAsszOeY41ttMv+27x+dV3ROLSh1/57ifplAxplRp6opLFVIvs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=tJF/sIc/; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="tJF/sIc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1763749851;
	bh=jWslEPu1h+kwOX+YdsgP+InMHvzad4h5A0TecdWZjCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tJF/sIc/EnfMzSu+amtP0YEIwtKbY9i/YPE5RHldGP3WzOuUGkOgNn3ZrQxRVC1kn
	 Hop2ettJhJjzv0M8nw5QrrHRo6jY587iX78MZxEcWLr2ARUawoQvtk5ChjQ4al40UE
	 pSnQbJevEBvXKCuEiU/2n8lRuRMrjBZppPH3aB84=
Received: by gentwo.org (Postfix, from userid 1003)
	id 1D331402BA; Fri, 21 Nov 2025 10:30:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 19BFE402B9;
	Fri, 21 Nov 2025 10:30:51 -0800 (PST)
Date: Fri, 21 Nov 2025 10:30:51 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, Martin Liu <liumartin@google.com>, 
    David Rientjes <rientjes@google.com>, christian.koenig@amd.com, 
    Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>, 
    Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R . Howlett" <liam.howlett@oracle.com>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
    Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
    Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v9 1/2] lib: Introduce hierarchical per-cpu counters
In-Reply-To: <20251121100308.65b36af9e090a78a66144c6c@linux-foundation.org>
Message-ID: <97a15b05-d61c-0035-82b7-37ac073c4055@gentwo.org>
References: <20251120210354.1233994-1-mathieu.desnoyers@efficios.com> <20251120210354.1233994-2-mathieu.desnoyers@efficios.com> <20251121100308.65b36af9e090a78a66144c6c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Nov 2025, Andrew Morton wrote:

> Have you identified other parts of the kernel which could use this?

We need to compare this with the ZVC counters used for the vm statistics.
Maybe this is better and we can scale counters easier in the VM.

ZVCs were designed for systems with a large number of NUMA nodes and a
handful of processors in each of those. What we have today is large number
of processors in one socket (my employer is shooting high on that level).

Hierachical counters may be better in that scenario. Maybe we can call
them HVC (Hierachical VM Counters). ;-) )


