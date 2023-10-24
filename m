Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045A7E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDYX/pqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D204C433C7;
	Tue, 24 Oct 2023 00:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698108747;
	bh=Cz2C33V7rW5mFx+/r38YL53PClSvAQtbG3qbhk9hvAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDYX/pqMphrx0x16wq56T8zNqw7D87iDLbydIUAmF//YqfycSHqDKdN7izTfqM6u1
	 5RgwT9aKniQfjiJ0FyyTTqy2CqREwu35OHcIxwcCNX4CvCnS6cmMVDfmZYI0TRQzeG
	 xs9oL8ml/6eM0p8qVv22KpmipXzV2mZ3T/vklDS1zwNT7VUaltF5lYf5RNFwpywm3i
	 92gji/oLrkEkp73Ap3oG1ae4CNbijzSvO3CLnyWokBzJMBtLcSm20unvJMB9NBjwY4
	 kRgH1quN43rR+7s5+Axr74sFrjTBNzsOukVDrdJRlKPpZfpn5v+ibIg14951EYPaic
	 lXpgjgYS0QoSQ==
Date: Tue, 24 Oct 2023 09:52:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
 rostedt@goodmis.org, peterz@infradead.org, akpm@linux-foundation.org,
 sander@svanheule.net, ebiggers@google.com, dan.j.williams@intel.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 mattwu@163.com
Subject: Re: [PATCH v1] kprobes: unused header files removed
Message-Id: <20231024095221.4a9ab55c6bd3abd875f0ac08@kernel.org>
In-Reply-To: <20231023112245.6112-1-wuqiang.matt@bytedance.com>
References: <20231023112245.6112-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 19:22:45 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> As kernel test robot reported, lib/test_objpool.c (trace:probes/for-next)
> has linux/version.h included, but version.h is not used at all. Then more
> unused headers are found in test_objpool.c and rethook.c, and all of them
> should be removed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310191512.vvypKU5Z-lkp@intel.com/

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  kernel/trace/rethook.c | 2 --
>  lib/test_objpool.c     | 6 ------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 13c8e6773892..6fd7d4ecbbc6 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -8,8 +8,6 @@
>  #include <linux/preempt.h>
>  #include <linux/rethook.h>
>  #include <linux/slab.h>
> -#include <linux/sort.h>
> -#include <linux/smp.h>
>  
>  /* Return hook list (shadow stack by list) */
>  
> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> index 98b5b37b6eea..a94078402138 100644
> --- a/lib/test_objpool.c
> +++ b/lib/test_objpool.c
> @@ -6,21 +6,15 @@
>   * Copyright: wuqiang.matt@bytedance.com
>   */
>  
> -#include <linux/version.h>
>  #include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/sched.h>
> -#include <linux/cpumask.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
> -#include <linux/cpu.h>
> -#include <linux/cpuset.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/delay.h>
>  #include <linux/hrtimer.h>
> -#include <linux/interrupt.h>
>  #include <linux/objpool.h>
>  
>  #define OT_NR_MAX_BULK (16)
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
