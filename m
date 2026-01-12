Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD317BB21
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238157; cv=none; b=OcJRO+2vbCvxIyinptUidUnWpq37OAH8PPw4+6xucuBBkDxsGGXfMvodFFUwvE73Y61nTEbP/z1lavanG9/b8JHhKkUhcyIGc1vLgQ40Kd1V271+YDkkJW+mVNG11qqB3LNUFQBoIo9p0Jmb5P0rew7Fs4S5ULpVi5xqMIsFTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238157; c=relaxed/simple;
	bh=U5/YI+ZjTewt/M8uJHnSgM6EbiiwOwSY292udpEViDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cq1FNQp/iiYlCi4K//7iVqF9kCgFg7XDMzQKLls0TsnOsPgXIna51ORyuuWxa/4nSWVRWNs09p4IBkbfoMwv4S5gdqeGvBdB+rYfIv0aX/KscMMu92bCYABYy+sm9CjEgOXs/Q22bUls47WByOA6tabDIzC4RIoRK60D+1x8XvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stHkps/v; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stHkps/v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768238152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOW0Y2WwzMDSvX6e6gxQ8/DR62t44tPrvU+xaCSB0EY=;
	b=stHkps/vtcyG6bwWOUBgkwNhYjEhcBGwxkbKERZThkcxe+4bD7FI3ULaLSlI7vjxzdPSSi
	vYJA2OmB2MHtSwB39YOg5/B1ba/whGdM6Zoj9X09B1umme4/2htOtQch3w0BMCNUEFBdCc
	3pdFzXXV499KIBrCMkX5srkf1HeNf1o=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  "Paul E. McKenney" <paulmck@kernel.org>,
  Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Dennis Zhou <dennis@kernel.org>,  Tejun Heo
 <tj@kernel.org>,  Christoph Lameter <cl@linux.com>,  Martin Liu
 <liumartin@google.com>,  David Rientjes <rientjes@google.com>,
  christian.koenig@amd.com,  Shakeel Butt <shakeel.butt@linux.dev>,
  SeongJae Park <sj@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Sweet Tea Dorminy
 <sweettea-kernel@dorminy.me>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  "Liam R . Howlett"
 <liam.howlett@oracle.com>,  Mike Rapoport <rppt@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Christian Brauner <brauner@kernel.org>,  Wei Yang
 <richard.weiyang@gmail.com>,  David Hildenbrand <david@redhat.com>,
  Miaohe Lin <linmiaohe@huawei.com>,  Al Viro <viro@zeniv.linux.org.uk>,
  linux-mm@kvack.org,  linux-trace-kernel@vger.kernel.org,  Yu Zhao
 <yuzhao@google.com>,  Mateusz Guzik <mjguzik@gmail.com>,  Matthew Wilcox
 <willy@infradead.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v12 0/3] mm: Fix OOM killer inaccuracy on large
 many-core systems
In-Reply-To: <6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com> (Mathieu
	Desnoyers's message of "Sun, 11 Jan 2026 13:04:59 -0500")
References: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
	<20260111094823.6fcb1fcceb7cfca2dd37b66e@linux-foundation.org>
	<6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com>
Date: Mon, 12 Jan 2026 09:15:40 -0800
Message-ID: <871pjuu4zn.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> On 2026-01-11 12:48, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:02:46 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>>> Notable changes for v12:
>>>
>>> - Reduce per-CPU counters memory allocation size to sizeof long
>>>    (fixing mixup with sizeof intermediate cache line aligned items).
>>> - Use "long" counters types rather than "int".
>>> - get_mm_counter_sum() returns a precise sum.
>>> - Introduce and use functions to calculate the min/max possible precise
>>>    sum values associated with an approximate sum.
>> May I ask, as an early adopter, what is your overall impression of
>> the Gemini reviewbot?
>
> The review comments were all spot-on. This is the level of review I
> would expect from a good reviewer who spends a significant amount of
> effort digging into the proposed change to make sure the type limits
> are OK for the intended purpose stated in the commit message and that
> the intent stated in comments match the code.
>
> As a patch author, I find this feedback really useful. Is there
> an easy way to get this feedback privately before sending out my
> patches ?

If you need to review a limited number of patches, the easiest way to
use gemini cli/claude code or similar tools with a consumer grade
subscription (most are $20/month these days).
I maintain a pre-configured environment for Gemini:
git@github.com:rgushchin/kengp.git , but it's not hard to hack something
similar for other tools.

Thanks!
