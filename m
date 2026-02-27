Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D642428494;
	Fri, 27 Feb 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227639; cv=none; b=RxumHYwNDc5y1lAwLLsdJxND6WYoTOgEW7Dekw9vbjJRqNk3me9ya8vDciHPSi6KOVHFO8uDCgoq5TdLSLXxZPJ0JYr71jRIIPAev3Hp7TyWp94yWspe4ZbvhtjGItYV0PMUk0bfRQzfzq7tncf4+UC/SmjtU4us9Vm35IIzmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227639; c=relaxed/simple;
	bh=WDjPZKs4MqgqqUaiQyuXBaE6TTaaT0C+D7IxDQoFPjE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u87RKJjZkuZdm61XTfdxLD+cE469kQcMKM8WLI/z53hSUAQ4O/ky+qJHvtmiuBnpgOzJF49mZSrW2jbku2uv5kxfT8x+I5lBV6mGPhZ3TExD120TokdD9pUTFizDJaYFW4yz+Cs9EK7lJWiMbkRJBCCAkzaZ4a2/A0e6pg9+FiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h13cm9u2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h13cm9u2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FAAC116C6;
	Fri, 27 Feb 2026 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772227638;
	bh=WDjPZKs4MqgqqUaiQyuXBaE6TTaaT0C+D7IxDQoFPjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h13cm9u2Haz3r+0D/dv7uzmEiEhrbak0bfbOKms+/VF9CK1wFmohzV7Oc2f4ltVpX
	 VkDYOqGRahVOKkttbyX/W2TGuCe698IMvn/RjFUtJJFvyy9pwrEKCg3RkvJ4XXZUy/
	 8iSqa17sXW/GLsZzyuVqRAoCPzeW0Obx7rikUoW0=
Date: Fri, 27 Feb 2026 13:27:17 -0800
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
Subject: Re: [PATCH v18 0/3] Improve proc RSS accuracy
Message-Id: <20260227132717.c811f04b63a332f88e354e08@linux-foundation.org>
In-Reply-To: <20260227153730.1556542-1-mathieu.desnoyers@efficios.com>
References: <20260227153730.1556542-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 10:37:27 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This series introduces the hierarchical tree counter (hpcc) to increase
> accuracy of approximated RSS counters exposed through proc interfaces.
> 
> With a test program hopping across CPUs doing frequent mmap/munmap
> operations, the upstream implementation approximation reaches a 1GB
> delta from the precise value after a few minutes, compared to a 80MB
> delta with the hierarchical counter. The hierarchical counter provides a
> guaranteed maximum approximation inaccuracy of 192MB on that hardware
> topology.
> 
> This series is based on tag v7.0-rc1.
> 
> The main changes since v17:
> - Fix patch series bissectability.
> - Export GPL symbols for kunit tests.
> - Improve kunit tests coverage.
> - Fix kunit tests wait queue head reinit bug.
> - Fix an out-of-bound on bootup on configurations where nr_cpu_ids is
>   close to NR_CPUS.

Updated, thanks.

> Andrew, this series targets 7.1.

Some review would be useful.  Can you think of someone we could ask to
undertake this?

