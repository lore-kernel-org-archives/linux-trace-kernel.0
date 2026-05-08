Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665C3D810D;
	Fri,  8 May 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261894; cv=none; b=jicF/XSGRiTXqGqf+BONBF50C9KRIQ7fjTLCqm6w0sCLQzuHDkpQzTNkr2O4xZaMWfTRlZaQVlRXAa5Lk61vpIfDbOGjfDytuQvbbEYloWEGBdGeoO873WCp/sDeAXV6vbjnlowcfi1LgGt5Yf9TtOrtxkzTml90thmv5E/rNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261894; c=relaxed/simple;
	bh=8O1+aE8sZNGhibwsXUzGKlGSLLVTQImi02JgLRN5+Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJovh+p1OvfL4xNYZaVhvpKJa0p2LE96GH3AlOeDOrIw+PaD49IQ9Ar0rZpr5RJYKci/vEymfyBBaNHr5PxH8US2T4LpXdS/GoFmNTsRxxYRlAIokCiZWMr4l88/1LWXEKkOSrbtPHDXfC98Gu4NNx2ZEWUQd8DUXlnZA9NP6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMhg/zvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMhg/zvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A70C2BCB0;
	Fri,  8 May 2026 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778261894;
	bh=8O1+aE8sZNGhibwsXUzGKlGSLLVTQImi02JgLRN5+Wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XMhg/zvtUQbsUJj0jEEmzzEM1sOuu2PmK5XEbqJjnz8o2pgGld2ayg7B3R8Gv48Se
	 SmstiDzpRJMQD++m9DEwq/Pu6nQPU4xv1OqaIy/PzhfSY41PXkak32EB72oP4Ti6rG
	 uMcVYCmNg5miEcjUE3rMaaeI0s3eawFjKU9a1KMFzXzW0OereAzwNY+rHfs34M23jD
	 KxIiqOHzrUuvw8uKG3GOmDHICi7Af+HNsA+C5PHINOKJzauazTtSt4ZdZszBLQxv8v
	 8Es+m9P0oiFJzZ8g+qeYVdj4nT2saQc/XKe/I1+f1XLeSyKjKCIJxedx3amZxr544i
	 so18H0arHs96g==
Message-ID: <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
Date: Fri, 8 May 2026 19:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock
 acquisitions
To: Andrew Morton <akpm@linux-foundation.org>, hawk@kernel.org,
 Dmitry Ilvokhin <d@ilvokhin.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 7:29 PM, Andrew Morton wrote:
> e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:
> 
>> Add tracepoints to the page allocator fast paths that acquire
>> zone->lock, allowing diagnosis of lock contention in production.
> 
> Thanks, I'm surprised we haven't done this yet.

There was a recent attempt [1]. Not being a generic solution wasn't welcome.

[1] https://lore.kernel.org/all/cover.1772206930.git.d@ilvokhin.com/

> Unfortunately "mm: use spinlock guards for zone lock" messed this up
> (https://lore.kernel.org/all/cover.1777462630.git.d@ilvokhin.com/).
> 
> So please let's give it a few days for reviewers to comment then redo
> against mm.git's mm-unstable branch?

