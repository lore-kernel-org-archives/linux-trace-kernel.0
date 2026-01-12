Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F2DA760;
	Mon, 12 Jan 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230334; cv=none; b=Zu+SrMg0x3mjyOWd6aWEL7sZfOjD08ahIWnH9sXKvmy3Djwo6BLu0mlOrr7rGNvHTPDpyK8V6EWLSZp9NKv721sThpi08Vrtw/7SZbSI4BJg4Zyd8/vUX9RzmKlABn1xJjbU7lYBPdPZlGKmLBgyUwpHr5OVL/yLWjxRfLfmPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230334; c=relaxed/simple;
	bh=Eb5J7+AM7hMHs/8rMAmXiWtWiI1frjLvFc1DdzTFI2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrx6WbYG5W0SGKSpKIQuujMaPdB10twY8v9gbOS4lTelFTms9thuEwIupns5p3y8Vx4PafcPKL7FDtynaOo8DqK2NJn9J77I1fqDey+AP/YaXnmcQMwu08ryieUByO8c+NGaJNL73F2HXrVllCAOBsUwrrjCLMZMrrZ5zpaQTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 52FDC13B014;
	Mon, 12 Jan 2026 15:05:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id F2E762002D;
	Mon, 12 Jan 2026 15:05:20 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:05:23 -0500
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
Message-ID: <20260112100523.6ab884be@gandalf.local.home>
In-Reply-To: <6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com>
References: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
	<20260111094823.6fcb1fcceb7cfca2dd37b66e@linux-foundation.org>
	<6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z9jkushrmo6cen9obskcedymfttod441
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F2E762002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/IXX5X2GrSacT7vWCjRhpUMWV//FH1/IQ=
X-HE-Tag: 1768230320-229295
X-HE-Meta: U2FsdGVkX1/IntiD8c6ZUJRRSq0u0uLBSB/y0015X3rBH6Xogr/HB59Qv8pJUVIxqu51FohwNnT+uoluB5aqmjFBtW5bE+ZA3W+tddIPd25DDSL8BUkpJdR7yVe8HmjNL6RZR+K0yOKiwuyHdpPNhBobGPX21vux5N/6ZgrDPbmVqw++5pqIPOJA1om5i+Uqj4XxRVaoiOEdFiK4xdd+ObSgtmEMXm1kpglP42d8gnT5IhpTYOUCVSKZUGq98nR+88et97cLh8Xxp+CQZWkGOS0Eq/FhTkbHRdE7mIChOQwS1rLmLghKvwsmjNE3v8Iw9aMrNIdYaXGpThncxYOK0Ua/FLvsblhpmEntzXxdM5+6LhdTbd/Av9LEEZ+MJ8Rp

On Sun, 11 Jan 2026 13:04:59 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> As a patch author, I find this feedback really useful. Is there
> an easy way to get this feedback privately before sending out my
> patches ?

Hehe, we all want to look good don't we ;-)

For me. I let people see the good, the bad, and the ugly (probably more than I should!)

-- Steve
