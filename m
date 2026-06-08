Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D371876
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920873; cv=none; b=Imf62C2+/hIxfL3h1oFsYypcIIyG8g4nRw1rd4oHPvXFQ9t9rFG0pOexbPp0q5FSjxnJdFAvDiuhcYs9eMyzwRCBcdkG5YBJeEuYPSqsShZtUVJfLAPPAfZSd4c4Z+AWgHvnmVd3mx+BtLrXyxR8wBdwfkpfa0FbzFvOunrSaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920873; c=relaxed/simple;
	bh=Qo4RTGyfFfap2PJicuJb2YCbKGCxplm5wcylQRLCVuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCsziz5P5qKrMvFBog0taCdCCVNc5B3IittljJjgOPAArCBvjlYro2DhVpoRuIdHJfuQXlXAdfgxlZNn4xpPFJFae/FcIS/bPklqm7tB/yCzIXgAWg5I7yvwcALIlO4452A7Q2NwJq+hHMbb94Im/IEQogdRrQhziml9iSsNqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsVYtCvw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsVYtCvw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780920869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5o2TRur9x0ddEQ5S1UjxIZP9cFGroi39DgA97WlM4k=;
	b=nsVYtCvwz5kJ/fDZNfegNk2vh28gl5OGT8lmDDl8FnDOkfQ1uX81bOLtIbveMzdycnp3mZ
	6xambuCN2z3PCH86CXshNpvd8eCNp/50D+EnoQhd/wXFb5ATcf8SHNKF3X4N95BpUoryRS
	jXeK0MS3kF3w5lFyYMcp0nIVwO9kNlw=
From: Lance Yang <lance.yang@linux.dev>
To: xieyuanbin1@huawei.com
Cc: david@kernel.org,
	qiuxu.zhuo@intel.com,
	bp@alien8.de,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	mhiramat@kernel.org,
	mchehab+huawei@kernel.org,
	tony.luck@intel.com,
	yi1.lai@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	lilinjie8@huawei.com,
	liaohua4@huawei.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/memory-failure: trace: change memory_failure_event to ras subsystem
Date: Mon,  8 Jun 2026 20:14:20 +0800
Message-Id: <20260608121420.64197-1-lance.yang@linux.dev>
In-Reply-To: <20260605081213.154660-1-xieyuanbin1@huawei.com>
References: <20260605081213.154660-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 04:12:13PM +0800, Xie Yuanbin wrote:
>For historical version, commit 97f0b1345219 ("tracing: add trace event
>for memory-failure") introduced memory_failure_event in ras subsystem.
>commit 31807483d395 ("mm/memory-failure: remove the selection of RAS")
>changed memory_failure_event to memory_failure subsystem. This breaks
>the backward compatibility, some user programs rely on it.
>
>Change memory_failure_event to ras subsystem to keep backward
>compatibility.
>
>Fixes: 31807483d395 ("mm/memory-failure: remove the selection of RAS")
>
>Reported-by: Yi Lai <yi1.lai@intel.com>
>Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>Closes: https://lore.kernel.org/linux-mm/CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com
>Cc: David Hildenbrand <david@kernel.org>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Miaohe Lin <linmiaohe@huawei.com>
>Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
>---
> include/trace/events/memory-failure.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
>index aa57cc8f896b..7a8ee5d1a44e 100644
>--- a/include/trace/events/memory-failure.h
>+++ b/include/trace/events/memory-failure.h
>@@ -1,6 +1,10 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> #undef TRACE_SYSTEM
>-#define TRACE_SYSTEM memory_failure
>+/*
>+ * For historical versions, memory_failure_event is in ras subsystem,
>+ * some user programs depend on it.
>+ */
>+#define TRACE_SYSTEM ras
> #define TRACE_INCLUDE_FILE memory-failure
> 
> #if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)
>-- 

Thanks. Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
