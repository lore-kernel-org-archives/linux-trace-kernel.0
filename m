Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB78EEB1;
	Tue,  8 Apr 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744146040; cv=none; b=OC2w0L3mU/OXy8+wDpHHtJ3WFsZx27Ww7j8CPDqoS2bvfkpm1i+Ihe3tUlfQxUsZX8xbx0KEM3+NCO28LfuHO7X45kXV+5w1iUpnE9n+esh4lztXUpL4LudjYWMw8+uud8QaGvVjnh71d1d7cGgHYuZVvQBhybHBHLehUCHgt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744146040; c=relaxed/simple;
	bh=bGKOijQVu1+pUuCKBs23IqehlZaimz7v9u8pcZR2Vhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMYZ+Og4ZCG4lZO4Z13EsgFywFOs8qj3/KGxzPgae1fOvt2Tu0gMZLkt/NQvLATGfvOSMgDdUMlzbccKQcYPxWliptNXW6xjVL+v9gBrnbwnxgFwPrAK0hywek38kNe6/FZtHbqUotSwP6foMZQsYljAxlgh5PWwEkF3fcptHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juoz0Svt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juoz0Svt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD138C4CEE5;
	Tue,  8 Apr 2025 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744146040;
	bh=bGKOijQVu1+pUuCKBs23IqehlZaimz7v9u8pcZR2Vhg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=juoz0SvtB4cb5Bz7qspYMWrGzklrpJW9yZHr19p1rm9otYvpFvHQj+v7wWlAZbMBP
	 c1IrIOlwI6/LJcCVPmnrAXuEwRifXpVb92xx2LjqeTeYgVUmlumqlkLeyQ7YTBf4uX
	 rF3HXgs0TkK+R3/GNPqVwLFq3sPZ/Bg70nWXAHZxeg8jRyE2OZePXSXuFSAYlgf5l1
	 CvN1+bvnRa02VtHuYNTYOdTNFOhiF2VliNffq63fR4hyPtvccZ9nuRyYgt4t8PLts7
	 Rcb2ghCoUo3oDCneOUIJq6tImWQ+xmCMjIzhgVM8BDIkwVCyiw3qUF09cB7NToWATT
	 cDZ7n7z5uKhKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 882DACE0F64; Tue,  8 Apr 2025 14:00:39 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:00:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Message-ID: <9f42144b-dca9-41b0-a80b-2e402cb5ab98@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
 <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com>
 <c013632c-b4ca-fb3d-9be5-b02ca5a3d859@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c013632c-b4ca-fb3d-9be5-b02ca5a3d859@gentwo.org>

On Tue, Apr 08, 2025 at 01:44:25PM -0700, Christoph Lameter (Ampere) wrote:
> On Tue, 8 Apr 2025, Mathieu Desnoyers wrote:
> 
> > Currently percpu_counter_tree_precise_sum_unbiased() iterates on each
> > possible cpu, which does not require cpu hotplug integration.
> 
> Well that looks like a performance issue if you have a system that can
> expand to 8K cpus but currently only has 16 or so online.

RCU handles this by iterating from zero to nr_cpu_ids, which is set during
early boot.  It also builds its tree-shaped data structures during early
boot based on nr_cpu_ids.

							Thanx, Paul
