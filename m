Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD02C0F68;
	Sat, 22 Nov 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763838819; cv=none; b=DkVL2qy3L8zFiFwZhZx2+1TmnfR2nFArvp8O+4/8cKyebIrpFJ/D5rTOGpCwAiDADmQYtFuxX254wdMpVW4Y5qOrhCAYSldaWvQsMT5ySIQovMAVFuoB7lNtIQJRg6lo6B6OP4BbzwMsPr+84ZGrbH/QXsj3v8YLXAeLjIQ8Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763838819; c=relaxed/simple;
	bh=P+IvViypdqWTsu2iUchRRO/BOZ/npDCJSLzUqKJBHTY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vBNFYZa6E7KAXVddMtaFzakNSwyyPxk0MKVI97IDvp1m98vPwZ0J6XsgY2pU4Swsxcmuzv+eEjM9wATv6fCMgV4ZsxtPy7AqLBQc4j6qtwZVXPNnTY4si9+H/Z/S3BOxPjktHAY/cH/hQuzzVf7mi46Ua08nneQWGp2yzjYTPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=czXNTPSq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="czXNTPSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA5C4CEF5;
	Sat, 22 Nov 2025 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763838818;
	bh=P+IvViypdqWTsu2iUchRRO/BOZ/npDCJSLzUqKJBHTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czXNTPSqe45T71X7q+uZSl5WU7lNGQWLBNpMccvRrHs0Y/LVEHxdhDD9iqtEykBhl
	 S9ry1g9ioR5zeZj8Kj2L8MOBEe2j9ADEXH1F7e15xF4yNSKj2LrXKXzERmc+OVHfuF
	 ftYbqquy5hDcL/KFxtpqhnM+5seZdfENlIP0Dlao=
Date: Sat, 22 Nov 2025 11:13:36 -0800
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
Subject: Re: [PATCH v9 1/2] lib: Introduce hierarchical per-cpu counters
Message-Id: <20251122111336.56b060c86ff6ba41fe76bfd4@linux-foundation.org>
In-Reply-To: <a3652f6b-cd3b-45ad-a3ad-e92369cf4068@efficios.com>
References: <20251120210354.1233994-1-mathieu.desnoyers@efficios.com>
	<20251120210354.1233994-2-mathieu.desnoyers@efficios.com>
	<20251121100308.65b36af9e090a78a66144c6c@linux-foundation.org>
	<a3652f6b-cd3b-45ad-a3ad-e92369cf4068@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 12:15:02 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> >>   include/linux/percpu_counter_tree.h | 239 +++++++++++++++
> >>   init/main.c                         |   2 +
> >>   lib/Makefile                        |   1 +
> >>   lib/percpu_counter_tree.c           | 443 ++++++++++++++++++++++++++++
> >>   4 files changed, 685 insertions(+)
> >>   create mode 100644 include/linux/percpu_counter_tree.h
> >>   create mode 100644 lib/percpu_counter_tree.c
> > 
> > An in-kernel test suite would be great.  Like lib/*test*.c or
> > tools/testing/.
> 
> I'll keep a note to port the tests from my userspace librseq
> percpu counters feature branch to the kernel. I did not do it
> initially because I wanted to see if the overall approach was
> deemed interesting for the kernel.

It deems interesting to me - certainly seems useful in addressing some
nasty problems.

If it hasn't been massacred by reviewers, please poke me in a week or
so and I'll look at giving it some exposure in mm.git's mm-new branch
(which isn't included in linux-next).
