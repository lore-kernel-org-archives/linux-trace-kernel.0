Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793928065;
	b=0kTVj+eEdF/Mu4TwMuhFxfzIxBY+H/QBAt0i2BhQe+AA73iAwhZJymoAiMyRN8RzT8lr
	 aY8q657c7z1A1oBZOcNxYxW4ePuZjBxabChbHPlBOWowplAHn+F8E9nALpXXlREgqY7sb
	 tKDyCYU9oRjY6HiSSoHBFC+Lx0qUqHQqoA+nWa/JOShqjch/Xom5TP3oMMWusrUzKZc4a
	 y7S/8LQRYGwp+jQxnm6N1IT89C9nc12mgHUTDjYELO3RmvH2gcg9N2Jtv0zjeOMJaeXif
	 NDEIxfScS/JqVuRt96Vgw4j9wVA52s7BVwXtwD9Zsvz3B6NSmrnq8Xcg+KXafH6epkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928065;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7Unoc9ykJp/GThx0lrtdBnOWr0Hmq9Ix53iTlmBSWd4=;
	b=xfX3k9nFTBoPRQq5F6nUNmF1mjbpXXAi3Ta4C1RVmLn6RDSPqfF00kz8c7EPX1cXjmyO
	 72KV3B+jv1GLFQTvb+1ogpFnGHDPhit+XiphdkmLceEdFjoOYHDnNVnN1loUGSLCwT3BO
	 xcTnIpSZ9B+jUrmetS66DknLA1PKm13l5Z8H4OKZmf0G7tWbgSCkPo/g7dY4WbGOV7shh
	 AzIzicpV0pjvV0zeDLHQ9V4x33xCc69ZkCsoEND75OfzRQkmICWarcWEN+UZv+LS+Qk5v
	 F170PFLCG1Zc2+ygx83GsHJe1XJMszcbkp7UTCiKBa77S4wVl/gt11fTOoyR/hXt3cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KMes1A9s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7A606A31B;
	Fri,  6 Nov 2026 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KMes1A9s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7618B1F0089F;
	Fri,  6 Nov 2026 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793928064;
	bh=7Unoc9ykJp/GThx0lrtdBnOWr0Hmq9Ix53iTlmBSWd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KMes1A9sA4g9PG6XPVvWwq4m8NUsIhBXxh5nU/wyof25j5ItRx98EzpODxaK5nLon
	 yTx8RPDbOgpEagV+rxz0usgLwYAgIjV6kpO9b7yJ/ecSHddtQSEjRCllr+UsPOd7EL
	 LLtDmGNP26YX8RWu0HaDtDnY9emISukuJDELCSzE=
Date: Thu, 5 Nov 2026 17:21:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Suren Baghdasaryan
 <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation
 tracepoints
Message-Id: <20261105172104.339c6f598a65056ed46e56fc@linux-foundation.org>
In-Reply-To: <202611052344.mDV2DB89-lkp@intel.com>
References: <37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat@google.com>
	<202611052344.mDV2DB89-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 23:15:33 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Abhishek,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on bcc036cfa1670a64500f6d857eaa71908b79e3fb]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Bapat/alloc_tag-Add-trace-events-for-tracing-allocations/20261104-190336
> base:   bcc036cfa1670a64500f6d857eaa71908b79e3fb
> patch link:    https://lore.kernel.org/r/37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat%40google.com
> patch subject: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
> config: xtensa-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611052344.mDV2DB89-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052344.mDV2DB89-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611052344.mDV2DB89-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_trace_enabled+0x2c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

Thanks.

#syz test

From: Andrew Morton <akpm@linux-foundation.org>
Subject: alloc_tag: force inline the allocation tracing check
Date: Thu, 05 Nov 2026 17:18:09 -0800

alloc_tag_trace_enabled() is declared inline, but the compiler can
still emit an out-of-line copy. Force it inline,

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611052344.mDV2DB89-lkp@intel.com/
Cc: Abhishek Bapat <abhishekbapat@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>
---

 include/linux/alloc_tag.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/alloc_tag.h~alloc_tag-introduce-ioctls-to-toggle-allocation-tracepoints-fix
+++ a/include/linux/alloc_tag.h
@@ -161,7 +161,7 @@ static inline bool alloc_tag_is_traced(c
 	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
 }
 
-static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
+static __always_inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
 {
 	if (static_branch_unlikely(&alloc_tag_trace_key))
 		return tag && alloc_tag_is_traced(tag);
_

