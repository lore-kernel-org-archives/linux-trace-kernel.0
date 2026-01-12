Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94983191AC;
	Mon, 12 Jan 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252938; cv=none; b=fBlUl3GPBenTF/N+Dt+UcyVZNy1ia4dfuE6BxWOmCg7bhnf9f6LdvtqaIm2iOYXZza9zGq3jmTn9IfWusZHbuKsa2llT3kUETRLlZDQe0tWTSNX7mDKDioPL/4Hvgd4V7/WrD/g9ntZvNK3eLBhgdxS3R88+jdvxRjsv+WCO0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252938; c=relaxed/simple;
	bh=J3VMesCThZ1UWC5jU0M9fsUjdYd6KTqtAF/dzXL2hyY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hfqO38yaGNXZilxkFxTbdk8LUt1CPL38MV6av19hqNoawOop8Jk0Y7lOfwqQqAjLl9K+tXQiW39GVZMN12tEr46fP6J/8e9BVUaSPzpMRcEWUcgLEGUq2XXWCbxLjNLbZMUnBjLumDZx5VPSYciG09sEAAVNgb8VlzdLu0DMk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VkBPeIk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VkBPeIk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4105EC116D0;
	Mon, 12 Jan 2026 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768252938;
	bh=J3VMesCThZ1UWC5jU0M9fsUjdYd6KTqtAF/dzXL2hyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VkBPeIk5hnPI1Byvct97SYuIWm1QwmI6SaiV8Vx+6cunuESwapg0u70Kja7HHSdoV
	 hoo3ndhtalp7KValVIHZ9iCFzOIir7VpqtW5W/h5Ulf6DyVfK8fz5KQzVtUkPuXaEj
	 TJlNZtRMJJkAOjQz3jyvMdLqD+y59sTiLRwUsaA0=
Date: Mon, 12 Jan 2026 13:22:16 -0800
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
 <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v14 0/3] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-Id: <20260112132216.1e347117f15fbf44c752bed1@linux-foundation.org>
In-Reply-To: <20260112200056.1250404-1-mathieu.desnoyers@efficios.com>
References: <20260112200056.1250404-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 15:00:53 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Introduce hierarchical per-cpu counters and use them for RSS tracking to
> fix the per-mm RSS tracking which has become too inaccurate for OOM
> killer purposes on large many-core systems.

Thanks, I'll throw this back into the testing pot while monitoring the
discussion with Michal.

