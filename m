Received: from smtp185.sjtu.edu.cn (smtp185.sjtu.edu.cn [202.120.2.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA392370D54;
	Mon, 27 Apr 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271412; cv=none; b=He57IwPJ8iaMnkAKhU2fgyoyQtPZ5Uz0ai5OBFcRYdy0JgJAwu1TUYcNYjPQnDb5Ve4hYi/QS96wfYee+lw45KX8QwIPtjMT+eNvqAedwGbbtFlr97H2TaGdn/IyaBaz4Js7P9BrB889gZTEv3m2uUrE4DaBHarFk333tOcT+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271412; c=relaxed/simple;
	bh=k7FXG2e/EV/GJJSCGDqsYjbBQrgk+18Y2MXRX65qSoU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ofw7qP8dKfw/byPPUa/5nUukmGpzGmipcQbuC1SDufqkG4KRYEoa9tAxcv9AKgXE7AHxTGYzdygz+ReACZklLAeELY2HIt7P56SPNvJoWVHTz+MjNWndCBGeJEF3a2SqFn4N4EfZ/yW10BjGjf50czIj6i26awaF62fyT5XM4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=CSwgEdst; arc=none smtp.client-ip=202.120.2.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="CSwgEdst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1777270866;
	bh=k7FXG2e/EV/GJJSCGDqsYjbBQrgk+18Y2MXRX65qSoU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CSwgEdstly7B72IwKWTHhbDtU1N7meh5Pfl9ZqiNWq+Gic8lcBgwzyCxl726lhz/U
	 u9KVRBx7Tb0UHBRCJ6NcmpEuBjPSE3eAzP0ehQXZEVGD5vS2Wap/3ebIu0dB5R0deu
	 djA9gfE3NKxJ7DAja1D0htzIYLYuTXFKoqXDBTGC8pcMi1OW3Z3QRh+hZJPdyyoZic
	 zdMrsD20NEY9yXOodq3VF40T88eVRtp1eBIv0HUoTVy5TeeHTu6btQyD6j3zexqY1p
	 Lua4RdWxp/ahZev4oEC/BVGs+Ut3bzf2jaJqjIGtOTodk6OfHPEvFNUyC5tFU/BRzn
	 I+Ead7DoH3R7A==
Received: from mta90.sjtu.edu.cn (unknown [10.118.0.90])
	by smtp185.sjtu.edu.cn (Postfix) with ESMTPS id EC18E385A6E;
	Mon, 27 Apr 2026 06:21:05 +0000 (UTC)
Received: from mstore137.sjtu.edu.cn (unknown [10.118.0.137])
	by mta90.sjtu.edu.cn (Postfix) with ESMTP id B841737C878;
	Mon, 27 Apr 2026 14:21:05 +0800 (CST)
Date: Mon, 27 Apr 2026 14:21:05 +0800 (CST)
From: SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn>
To: akpm <akpm@linux-foundation.org>, vbabka@kernel.org, 
	linux-mm <linux-mm@kvack.org>
Cc: rostedt <rostedt@goodmis.org>, mhiramat <mhiramat@kernel.org>, 
	mathieu desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes <hannes@cmpxchg.org>, 
	ziy@nvidia.com, david <david@kernel.org>, 
	vishal moola <vishal.moola@gmail.com>, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Message-ID: <222049437.2315342.1777270865090.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <20260427060142.131055-1-b.suvonov@sjtu.edu.cn>
References: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn> <20260427060142.131055-1-b.suvonov@sjtu.edu.cn>
Subject: Re: [PATCH v2] mm/page_alloc: trace PCP refills and PCP zone lock
 usage
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.18_GA_4835 (ZimbraWebClient - FF149 (Linux)/10.0.18_GA_4828)
Thread-Topic: mm/page_alloc: trace PCP refills and PCP zone lock usage
Thread-Index: cvNpGKS1fD456U+LMNaVmpa/8ckf2g==

Thank you for reviewing v1 Vishal,

All of your concerns except for the last one should be covered in v2.

> If you're trying to trace all pages as they come onto the pcp lists,
> should you also account for the free_frozen_page_commit() path?
>
>>          }
>>          spin_unlock_irqrestore(&zone->lock, flags);

No, the intent is not to trace every insertion into PCP lists. This patch
is trying to make buddy <-> PCP traffic observable by adding a new
mm_page_pcpu_refill event symmetric with the existing mm_page_pcpu_drain
event.

I also added additional zone_locked tracepoints because my research is
focusing on analyzing which kernel mm subsystems and other parts are
under stress for a given workload. The best way to see it for PCP would
be to count zone lock acquirings as the whole purpose of PCP is to lower
number of zone lock acquiring in first place.
