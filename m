Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785A450906
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243559; cv=none; b=U1irCSan1+c61rTYSJqDIg0ECOoyboht7uDMYImKMaKySw2bbveYpbsHn6mBjn77G3JWlmmKf+pgoErEWiprACxf6PMpGVUnf8Oj6rzSzbH+KNasc4FXf9FNjhqTkIuj+zLV5DshIDkXmpExBN+LDTuNrj/Mt3Eg3hMTVjhS1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243559; c=relaxed/simple;
	bh=CACgk1em+Vy8Gh1bLJdug8Dy1sGNAy+1bOJLeSRf7IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT7iYuz6wx3BnqQEbyEATcOEdq3y+xHj6ab0wIYF1fIaDGf251+QbTkH4toy+3LZ8fXMuSrAknvddXVowCgcTB4Fhqnx3xOIBPaHTvJq+ar6V2vDUQAsoC0nuIncyi3MEh/StYk3Rkd7kF/TxgRjhvnoc2GU5ERbftbi/32fpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+yfmRxo; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v+yfmRxo"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CACgk1em+Vy8Gh1bLJdug8Dy1sGNAy+1bOJLeSRf7IU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790243542; v=1; x=1790848342;
 b=v+yfmRxoiCZYw0BX/hk9KDD8VZSGbzrq1Zazi/MgI2IRvjP8/xr69rKJLi5gUbimeabIicDX
 KjwI1XZz8RPD1kiYG/1ke+Gnjv0ijR/4/1UZYgcybhbqu3cXe3y2IjeN4SfGEWL2lyxr3NgGFTl
 lwqycXdp9Bs7ZwK2oDeCEk7k=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c0029a296d3c7a22;
	Thu, 24 Sep 2026 09:52:22 +0000
X-Mizu-Trace-ID: c0029a296d3c7a22
X-Migadu-Flow: FLOW_OUT
Message-ID: <057359f7-0e8f-416b-8b5e-0b60c1c936e9@linux.dev>
Date: Thu, 24 Sep 2026 17:53:25 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] alloc_tag: Introduce selective tracing for MAP
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <cover.1790025465.git.abhishekbapat@google.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <cover.1790025465.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Abhishek

Thanks for your patch.

On 2026/9/22 05:26, Abhishek Bapat wrote:
> The existing memory allocation profiling (MAP) tool accurately maintains
> aggregate counters for overall memory accounting. However, relying
> purely on aggregated counters restrics the visibility needed for
> targeted debugging.
> 
> This patch series integrates three new tracepoints (alloc_tag_hit,
> alloc_tag_mem_alloced and alloc_tag_mem_freed) directly into the
> alloc_hooks_tag fast path.
> 
> Enabling trace events globally for all allocations introduces a severe
> baseline overhead. To limit the performance overhead, we let the admin
> select specific allocations to be traced.
> 
> A new IOCTL is introduced to allow privileged users to determine which
> allocation tags need tracing enabled. The IOCTL utilizes the
> pre-existing filtering mechanism to specify the allocation tags to
> enable tracing on.
>

I think this cover‑letter could go into more detail.
Also, the cover‑letter doesn't include any how‑to‑use.

Looking over this series, it seems you expect users to first call
ALLOCINFO_IOC_GET_AT to obtain a tag, then pass that tag into
ALLOCINFO_IOC_TOGGLE_TRACE.

This behaviour is not reflected in the existing cover‑letter.
Before reading the code, I assumed I could just pass a module
name to trace all allocations from that module. After going
through the implementation, that turns out not to be the case.

Because patch 2 enforces a full mask requirement for the filter.

struct allocinfo_filter filter = {
	.mask = ALLOCINFO_FILTER_MASK_MODNAME |
		ALLOCINFO_FILTER_MASK_FUNCTION |
		ALLOCINFO_FILTER_MASK_FILENAME |
		ALLOCINFO_FILTER_MASK_LINENO,
	.fields = params.fields,
};

So to trace all allocations from an entire module, users have to combine
ALLOCINFO_IOC_GET_AT, ALLOCINFO_IOC_GET_NEXT and ALLOCINFO_IOC_TOGGLE_TRACE
together.

I have no strong objections if this is the intended design.
That said, we should settle on the expected usage model up‑front.

Having corresponding Documentation would also be quite helpful. That way when others
ask how to work with this feature, we can point them to existing written material.

https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/mm/allocation-profiling.rst

Thanks
Best Regards
Hao

> Abhishek Bapat (4):
>   alloc_tag: Add trace events for tracing allocations
>   alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
>   alloc_tag: extend allocinfo_filter to support tracing queries
>   alloc_tag: add a test for trace state toggle and filtering
> 
>  MAINTAINERS                                   |   1 +
>  include/linux/alloc_tag.h                     |  94 +++++++++---
>  include/linux/codetag.h                       |   5 +-
>  include/trace/events/alloc_tag.h              | 122 +++++++++++++++
>  include/uapi/linux/alloc_tag.h                |  17 ++-
>  mm/alloc_tag.c                                | 142 +++++++++++++++++-
>  .../alloc_tag/allocinfo_ioctl_test.c          | 111 +++++++++++++-
>  7 files changed, 462 insertions(+), 30 deletions(-)
>  create mode 100644 include/trace/events/alloc_tag.h
> 
> 
> base-commit: 8d61431ed2607386b427752505379536eb634ce8
