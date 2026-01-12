Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB0632;
	Mon, 12 Jan 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245516; cv=none; b=i40o5oAiK50WYKT+QVRQlnS/9aT7fW+MpyooWaNIHl4tWrkLfeHcxoHACwY2hLc8WXGY7Mr0bKQm4hfCgvER5+m8Oo0s80YFDOuhGbvvMLR+JM/EVgdqczdyLVC8Y50jrpd93wOB2kLJ7sb1Py15oiFDFnre4wAW58VP7720zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245516; c=relaxed/simple;
	bh=r6lGopZInlHr+gqIy+X823d+K8SLErm2dTPKD6lH1NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUg2/sfpkIF2xdAqORwRPQuQVNsUbrsQ0R+OoViopQ116IoYRe4vJR5x7HUb1rDV4S1NakkWPHfO/p8hPl+QbkA7QKNJIu5KD+ZCJwXcfUIB5QUr2AT92jQK0KXzi/Q4q04gkNv6so2/ikbGQZt2oWAoHfU6i0biiD9FOiQ26Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C323ABD3C2;
	Mon, 12 Jan 2026 19:18:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id AA5F220024;
	Mon, 12 Jan 2026 19:18:18 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:18:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu
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
Subject: Re: [PATCH v12 0/3] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-ID: <20260112141821.76dda1a7@gandalf.local.home>
In-Reply-To: <171c5a7a-f12a-46a0-b791-18e25a3c7877@efficios.com>
References: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
	<20260111094823.6fcb1fcceb7cfca2dd37b66e@linux-foundation.org>
	<6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com>
	<20260112100523.6ab884be@gandalf.local.home>
	<171c5a7a-f12a-46a0-b791-18e25a3c7877@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ur493pghcfd3i1oiedxcihmcp8mdw3sh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AA5F220024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+eMNLw3QA+soatFqAhld37HLNb45YxNsQ=
X-HE-Tag: 1768245498-912157
X-HE-Meta: U2FsdGVkX1/5Kc44YQwH8O0aSMQGKaTsgtaBbz0xWqU6yDj2E2Y9yNPaFtsmL41f6dCaP4inN1fLW8/ZeJF2q89IzmiLBah9Pfrd2Ux4vB10kcuXdYr5SHWFKzOpmVhllJcEZIrDcSiAcvgZrQuDHnEh/gaRtVhBKbFSY2StMWYkUCzRYjDuENcmNw94QJeLC9krXX885rolrgilAjlOuDpdMNluseU9dWqPiqFFD3wtVty1D4dsniIhEiL8C6bsSSKVk1LMHENRGzd0vW6gD6iKuba3Fhm8fKvmyGdV4zax7gXMeiD5ysd+TvUlEeAYKche0dEMvgjj7RbGGqMxLlfOtBqvWEsRzM3ANpJ7FSD7GKbKn6IgtsEHBQ59FXZK

On Mon, 12 Jan 2026 13:36:48 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> That being said, I think this AI review can lead to interesting
> discussions where others can pitch in, so having it in the open
> is worthwhile.

Agreed. I'm interested in seeing what AI catches.

-- Steve
