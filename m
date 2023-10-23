Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E491BDE8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Oct 2023 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B555C433C7;
	Mon, 23 Oct 2023 15:43:06 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:43:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 naveen.n.rao@linux.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, sander@svanheule.net, ebiggers@google.com,
 dan.j.williams@intel.com, jpoimboe@kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Message-ID: <20231023114304.1bebb327@gandalf.local.home>
In-Reply-To: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 19:24:52 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> The objpool_push can only happen on local cpu node, so only the local
> cpu can touch slot->tail and slot->last, which ensures the correctness
> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
> of try_cmpxchg_acquire).
> 
> Testing with IACA found the lock version of pop/push pair costs 16.46
> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
> is improved to 1.019 times of the lock version for x86_64 systems.
> 
> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> 
>                  1T         2T         4T         8T        16T
>   lock:    29909085   59865637  119692073  239750369  478005250
>   local:   30297523   60532376  121147338  242598499  484620355
>                 32T        48T        64T        96T       128T
>   lock:   957553042 1435814086 1680872925 2043126796 2165424198
>   local:  968526317 1454991286 1861053557 2059530343 2171732306
> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  lib/objpool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/objpool.c b/lib/objpool.c
> index ce0087f64400..a032701beccb 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -166,7 +166,7 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>  		head = READ_ONCE(slot->head);
>  		/* fault caught: something must be wrong */
>  		WARN_ON_ONCE(tail - head > pool->nr_objs);
> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
>  
>  	/* now the tail position is reserved for the given obj */
>  	WRITE_ONCE(slot->entries[tail & slot->mask], obj);

I'm good with the change, but I don't like how "cpu" is passed to this
function. It currently is only used in one location, which does:

	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());

Which makes this change fine. But there's nothing here to prevent someone
for some reason passing another CPU to that function.

If we are to make that change, I would be much more comfortable with
removing "int cpu" as a parameter to objpool_try_add_slot() and adding:

	int cpu = raw_smp_processor_id();

Which now shows that this function *only* deals with the current CPU.

-- Steve
