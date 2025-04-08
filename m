Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F824886B;
	Tue,  8 Apr 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145693; cv=none; b=GCeLBnRO+K43TLnUcxrDM1cfhOgyVJjKEIDfwdsO9tpTbP8urHufvBypf+A4t4gV2ChangEaPl7qTbPXDzXbcWlrtqoaP192ETkwPniGKLHpM91k/WUNc7XG8DbwraeVLlbCVAZ+TWGLjdIjhxqP3PqlKH+XvTeGa+EIfULejYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145693; c=relaxed/simple;
	bh=WG+cj5i1GbTabFslLXYHUzovUuREFvJlBBWLxyJtbIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r4KsPTgKmgPLbRpvzCskaAKhd7xuXL1p9POEQdXPsyfelUj6Cx/p1zeNb8VzTuGDC2l4lH7hJRr2KIrxd4Q/xKo0xaDcQWQ0WA2TsLcrZhmr/4m3Pi5tR9L9g7Z/oG6Zl5x8V+Vui68wczohKZwrDCnO9iqyzFTFsLiAiQU2Rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=pbfovDHk; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="pbfovDHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1744145065;
	bh=WG+cj5i1GbTabFslLXYHUzovUuREFvJlBBWLxyJtbIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pbfovDHk6lOSLkh5+VshEKxpw9B2s+e5b5FfhUL4EZnfD3cJ8DoosczLAsisV8yLW
	 umFdiuqcSaxDGjjDJMEhONIexkS5nTlxQhV+7rIZqunpDswAg7lrxgRJaepklVq5uH
	 AaB6mcgkwWIipDh4qnIq7YInk1uNnee2r6rFR1L0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 51AF04028A; Tue,  8 Apr 2025 13:44:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 4EEF6401F1;
	Tue,  8 Apr 2025 13:44:25 -0700 (PDT)
Date: Tue, 8 Apr 2025 13:44:25 -0700 (PDT)
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
In-Reply-To: <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com>
Message-ID: <c013632c-b4ca-fb3d-9be5-b02ca5a3d859@gentwo.org>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com> <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org> <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Apr 2025, Mathieu Desnoyers wrote:

> Currently percpu_counter_tree_precise_sum_unbiased() iterates on each
> possible cpu, which does not require cpu hotplug integration.

Well that looks like a performance issue if you have a system that can
expand to 8K cpus but currently only has 16 or so online.

