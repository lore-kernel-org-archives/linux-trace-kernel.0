Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7025525E;
	Tue,  8 Apr 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148693; cv=none; b=E/J6KcOlwPu08BaFCZFRd2x61E4S+VtFKZIe7pqNdICU1r/WZvMPlKYFu+j0IL0ViYSJOFvjf1Zh2E+/5TO9RPCEG/a3Y5X/g3pMHugYzIdZi9fRLyfOspEA0hGwGSpg3eSBHnqePg1N1GdVLdsrCA/4/XI9liE+x2eutfns0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148693; c=relaxed/simple;
	bh=6srHW5qh8Uap0ryDmqBLLWjegtWKolNGZsB6CSsqmJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CjbkAdqucdYMkHpEp0Km7vd3CbuARVsDLyfrR/mqzVkXfIeaGIqbcWhNFa00xReMiFPqvNsKVG3bmMYxUcP0x8TL1BSbbMQKnfx7kOtuRbIwxQPzVGvhWv+6SH2a8/Ti0Bspmpf71SOzeIxvzubsOKKnRUA6jMvKG7Wb+gOTiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=X17M4ZrK; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="X17M4ZrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1744147319;
	bh=6srHW5qh8Uap0ryDmqBLLWjegtWKolNGZsB6CSsqmJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=X17M4ZrKiLtjDdVFS2xjmp4xpY6Z8s/msCSXy8Lj9Kxlt8jP4ktfpK/RpAOocquCS
	 nCPPRisNdTTBM8+5DGjNgB/Y2XzFVGP2Sgcc2X4UQvoj8GxhSuUookTPin+SEeOYYi
	 OJDEdVEXA3bvUDdONzspvDlXhGxNQdmvIwl1zA7k=
Received: by gentwo.org (Postfix, from userid 1003)
	id 190B5406EB; Tue,  8 Apr 2025 14:21:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 16201401F1;
	Tue,  8 Apr 2025 14:21:59 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:21:59 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Sweet Tea Dorminy <sweettea@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
    linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, Martin Liu <liumartin@google.com>, 
    David Rientjes <rientjes@google.com>, christian.koenig@amd.com, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Christian Brauner <brauner@kernel.org>, 
    Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
    Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
In-Reply-To: <9f42144b-dca9-41b0-a80b-2e402cb5ab98@paulmck-laptop>
Message-ID: <8897b4e1-b5ba-807d-7bc4-5a6080a93462@gentwo.org>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com> <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org> <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com> <c013632c-b4ca-fb3d-9be5-b02ca5a3d859@gentwo.org>
 <9f42144b-dca9-41b0-a80b-2e402cb5ab98@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Apr 2025, Paul E. McKenney wrote:

> RCU handles this by iterating from zero to nr_cpu_ids, which is set during
> early boot.  It also builds its tree-shaped data structures during early
> boot based on nr_cpu_ids.

nr_cpu_ids is better but there are funky things like the default bios of a
major server vendor indicating 256 or so possible cpus although only 2
were installed. Thus nr_cpu_id is 256. Presumably some hardware
configurations can support onlining 256 cpus....

