Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742B22E3FD;
	Tue,  8 Apr 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133393; cv=none; b=WY/4iBuXNreXL8TDmBxmkZVLBjfuQquOjZ9UuhK3YYDgSOVyQ18fwxfZcU6Gp//phkyzWn3uzmpBGddtVvh4p4Z4mtddlSBXkkX3JNkZYBm0Avoewkfjow7PcdwfK1ez/MvJd4/xKzhiKwAm3yEB23LOzj2uObpCUrywYyTI9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133393; c=relaxed/simple;
	bh=npn242A2W/TEDA2uAEasMq1QFf+FdVgQvy3Kx/Py/CQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ikdsws/nHFFaDDFRWlsl0OYf80og+QdQ+Chk8uqEWzwJeIiTcWv+Z49XwAhEwannPavIt3MuH0ExwGn69n3TDzTmxYsgh/2GwTU/nvgc24zScf8ESi8ck9H6TFF9v+Ezh3ExrvKQQqpPh851gN5jka0S6okHmt/rvAHrTIDSVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=mCsSiias; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="mCsSiias"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1744130239;
	bh=npn242A2W/TEDA2uAEasMq1QFf+FdVgQvy3Kx/Py/CQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mCsSiias1qzrbUjlmat1qOSORLBNGyrFTWYZ10hRcOc3WLqxurH4aYDOPT7GMstwp
	 wfuLdqnG209+70DONPS+lYYNwr+tuLknOP80aU0l6AyQemovxzzQEwg8EuBoZzQ+Tb
	 Hzz2mJHcKXWOAcdA4aQNTdEdP4Sbq2Cu/1+yMVCM=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0153D4028A; Tue,  8 Apr 2025 09:37:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F40B8401F1;
	Tue,  8 Apr 2025 09:37:18 -0700 (PDT)
Date: Tue, 8 Apr 2025 09:37:18 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc: Sweet Tea Dorminy <sweettea@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
    linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, Martin Liu <liumartin@google.com>, 
    David Rientjes <rientjes@google.com>, christian.koenig@amd.com, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R . Howlett" <Liam.Howlett@Oracle.com>, 
    Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Christian Brauner <brauner@kernel.org>, 
    Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
    Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
In-Reply-To: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
Message-ID: <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Apr 2025, Mathieu Desnoyers wrote:

> - Minimize contention when incrementing and decrementing counters,
> - Provide fast access to a sum approximation,

In general I like this as a abstraction of the Zoned VM counters in
vmstat.c that will make the scalable counters there useful elsewhere.

> It aims at fixing the per-mm RSS tracking which has become too
> inaccurate for OOM killer purposes on large many-core systems [1].

There are numerous cases where these issues occur. I know of a few I could
use something like this.

> The hierarchical per-CPU counters propagate a sum approximation through
> a binary tree. When reaching the batch size, the carry is propagated
> through a binary tree which consists of log2(nr_cpu_ids) levels. The
> batch size for each level is twice the batch size of the prior level.

A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
on a 512 cpu machine. Given the inflation of the number of cpus this
scheme better work up to 8K cpus.

> +int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter);
> +int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
> +int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v);

Precise? Concurrent counter updates can occur while determining the global
value. People may get confused.

Also maybe there would be a need for a function to collape the values into
the global if f.e. a cpu goes off line or in order to switch off OS
activities on a cpu.

