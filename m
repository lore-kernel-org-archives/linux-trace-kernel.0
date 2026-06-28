Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D823BD1B;
	Sun, 28 Jun 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665291; cv=none; b=op/rvUFbEcZvpLE16KMkueeFluiud5oDCdBqJBNksXXZd91R3gUBLoN4x6PFtWQpqx8iwsT69zeE4/2Bleo1K5AqvMdbqguD4xhi1AkLXWDgIBoCHpLoeHBhjM+tmv6rUUdEQD98WRDDfa+UawhWPyOsoWvDmNTIZG0iYKoBv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665291; c=relaxed/simple;
	bh=8U8sPoPAuln1YOL6o+Y3TI7rQJHcWF6fAbeO75W68+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izYO1tyetcMt4u9vI31b7qFZF61A9wswNUSH+ctzaOQTCTZQIHO6sRRZhQrfELFmS4Wy3Q5lNGxB2gPmHf9x6+0CljDd6jP62aGEZGNNs4e2yLMOkCObfJsrNDAW0M3mP6+V+kiMitW4QAeHGjb/SqcrWZv2li27DH9sQX6cqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChFTW2mu; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChFTW2mu"
Message-ID: <878be1d4-2f93-4fbd-a1f6-b2b7836c9c44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782665285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKkfE5ystnk9sV1BpoXQgov/tuifr5wOm6G6J0HZi74=;
	b=ChFTW2mu+FTgvZyvmJG9rmDdkYSYaRA2Ydbq2X/hMGRqR9jQTxD3HfVwWXrqlYJL1FO1Gr
	0dDaK4AOVZvwQ5kYPgbhNHzyeQXaLlXcKVLrfbXnt0zNGVPynXgyBlGTVXmZRigddlMdzS
	tXfb2HgT7xETuaOSc9qbAcoh3Bdd0UQ=
Date: Mon, 29 Jun 2026 00:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780847473.git.wen.yang@linux.dev>
 <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
 <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/16/26 17:49, Gabriele Monaco wrote:
> On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Introduce rv_uprobe, a thin wrapper around uprobe_consumer providing
>> rv_uprobe_attach_path(), rv_uprobe_attach(), and rv_uprobe_detach()
>> for RV monitors.  An opaque priv pointer is forwarded unchanged to
>> entry/return handlers so monitors can carry per-binding state (e.g. a
>> latency threshold) to the hot path without any global lookup.
>>
>> rv_uprobe_detach() is fully synchronous (nosync + sync + path_put +
>> kfree), closing the use-after-free window present in open-coded
>> patterns where kfree() precedes uprobe_unregister_sync().
>>
>> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> 
> I find your implementation solid, but I wonder if it isn't a bit
> overdoing it. It's good to have helper functions abstracting away the
> common uprobes code, but I find the number of structures used to indirect/hide
> the process a bit confusing.
> 
> Users of this headers still know they're using uprobes, so we don't
> really need to hide it that much, plus the double function pointers are
> an additional performance hit we could easily skip.
> 
> As I get it, we want to pass a private pointer (essentially to get the
> threshold in tlob) and the uprobe infrastructure doesn't allow that
> transparently. So let's keep on using struct embedding but a bit more
> cut to the bone:
> 
> 	struct rv_uprobe {
> 		struct uprobe_consumer	uc;
> 		struct uprobe		*uprobe;
> 		void			*priv;
> 	};
> 
> Then handlers would use container_of() appropriately to derive the data they
> need.
> 
> 	static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data)
> 	{
> 		struct rv_uprobe *p = container_of(self, struct rv_uprobe, uc);
> 		struct tlob_uprobe_binding *b = p->priv;
> 
> 		...
> 	}
> 
> You could even define the struct directly inside your private data and save one
> step (and no void *):
> 
> 	struct rv_uprobe {
> 		struct uprobe_consumer	uc;
> 		struct uprobe		*uprobe;
> 	};
> 
> 	#define DECLARE_RV_UPROBE(name) struct rv_uprobe name
> 
> 	// And then
> 
> 	struct tlob_uprobe_binding {
> 		u64 threshold_ns;
> 		...
> 		DECLARE_RV_UPROBE(start);
> 		DECLARE_RV_UPROBE(stop);
> 	}
> 
> 	static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data)
> 	{
> 		struct tlob_uprobe_binding *b = container_of(self, struct tlob_uprobe_binding, start.uc);
> 
> 		...
> 	}
> 
> 
> Now I intentionally skipped offset, as I don't really see why carry it around,
> and path, as we could live without it by relying on inodes (uprobes
> reference-track them but you'd need to save them somewhere).
> 
> Mind, I only build tested this idea (appended after). This was supported by an
> LLM which did a few more changes like standardising names and return values of
> registration functions (a bit more consistent with other stuff, you don't have
> to commit with that though).
> 
> By the way, do we really need the duplicate check? Would it break if a user
> defines it twice? If not, we could simplify the tlob_add_uprobe() even further
> and doing all path related checks in the library, since those aren't quite tlob
> specific.
> 
> Thoughts?
> 

Hi Gabriele,

Thanks for the detailed v3 review.  All feedback is addressed in v4;
only one item ([2-1]) required a design deviation due to a UAF found 
during PREEMPT_RT testing.

On [2-1]~[2-5]: embedded consumer causes UAF on PREEMPT_RT
-----------------------------------------------------------

The uprobe_bind selftest oopses on PREEMPT_RT(full):

   handler_chain+0xc9: mov rax, [r15+0x18]  ; advance list iterator
   RAX: 000015ec00001f28   ; garbage — &uprobe->consumers after kfree

handler_chain() reads uc->cons_node.next after uc->handler() returns,
still inside rcu_read_lock_trace().  That pointer is &uprobe->consumers
(the list head embedded in struct uprobe), which gets freed through:

   put_uprobe()
     -> schedule_work(uprobe_free_deferred)   /* async */
        -> call_srcu(&uretprobes_srcu, ...)
           -> call_rcu_tasks_trace(kfree_uprobe)
              -> kfree(uprobe)

rv_uprobe_sync() calls uprobe_unregister_sync() which calls
synchronize_srcu(&uretprobes_srcu), but that only matters after the
kworker has submitted work to uretprobes_srcu.  On a loaded PREEMPT_RT
box the kworker may not have run yet, so synchronize_srcu() returns
immediately and kfree(uprobe) races with the still-iterating
handler_chain():

   CPU A                                CPU B
   consumer_del() → list_del_rcu        rcu_read_lock_trace()
   put_uprobe()   → schedule_work         uc->handler() returns
   rv_uprobe_sync():                       reading cons_node.next...
     synchronize_srcu(&uretprobes_srcu)
     ← idle; returns immediately
   [kworker fires later]
     kfree(uprobe)  ← frees &uprobe->consumers
                                         cons_node.next = freed mem → CRASH

With uc embedded in the binding (as [2-1] suggests), no amount of
delaying kfree(binding) helps: uprobe->consumers is freed by a chain we
don't control.  The fix is to keep uc->cons_node in memory that outlives
the handler_chain() iteration, which means a separate allocation freed
only after rv_uprobe_sync():

   rv_uprobe_unregister_nosync()  /* list_del_rcu + schedule_work */
   rv_uprobe_sync()               /* waits for any already-submitted 
srcu work */
   rv_uprobe_free()               /* kfree(impl) — safe, iteration is 
done */
   kfree(b)                       /* binding; never contained uc */

v4 keeps the public API shape you suggested with impl private:

   struct rv_uprobe {
       struct rv_uprobe_impl  *impl;  /* allocated by 
rv_uprobe_register() */
       struct inode           *inode;
   };
   #define DECLARE_RV_UPROBE(name)  struct rv_uprobe name        /* [2-2] */

   int   rv_uprobe_register(const char *binpath, loff_t offset,
                            struct rv_uprobe *p, handler_fn,
                            ret_handler_fn, void *priv);         /* [2-4] */
   void  rv_uprobe_unregister(struct rv_uprobe *p);
   void  rv_uprobe_unregister_nosync(struct rv_uprobe *p);
   void  rv_uprobe_sync(void);
   void  rv_uprobe_free(struct rv_uprobe *p);                    /* 
[2-5] restored */
   bool  rv_uprobe_is_registered(const struct rv_uprobe *p);     /* 
[2-7] added */
   void *rv_uprobe_get_priv(struct uprobe_consumer *uc);

Handler signature is (struct uprobe_consumer *self, ...) [2-3]; private
data is retrieved via rv_uprobe_get_priv(self) instead of container_of().

Then, rv_uprobe_free() is restored ([2-5] partially reverted).


All other v3 items have been resolved, we are waiting for your comments 
on the above（embedded consumer causes UAF）:

[1-1,1-3]  `# define` / `# error` space removed
[1-4]      `⟹` -> `=>`
[1-6,1-7]  #if/#else in da_destroy_storage() and da_monitor_init()
            replaced with plain if (DA_MON_ALLOCATION_STRATEGY == 
DA_ALLOC_POOL)
[1-8]      tracepoint_synchronize_unregister() lifted to 
da_monitor_destroy before the pool/kmalloc branch

[2-2]  DECLARE_RV_UPROBE(name) — kept
[2-3]  handler sig (struct uprobe_consumer *self, ...) — kept
[2-4]  rv_uprobe_register() returns int — kept
[2-5]  rv_uprobe_attach/detach removed; rv_uprobe_free() restored (see 
above)
[2-6]  offset, path fields removed; inode used for identity
[2-7]  rv_uprobe_is_registered() added

[6-1]  Suggested-by removed
[6-2]  tlob Kconfig entry placed after the deadline monitors marker
[6-3]  Unnecessary includes removed (hrtimer.h, ktime.h, sched.h, tracefs.h)
[6-4]  `#include "../../rv.h"` -> `<rv.h>`
[6-5,6-6]  Verbose comments around DA_MON_POOL_SIZE and da_extra_cleanup
            simplified; early return in tlob_reset_notify() on
            !trace_detail_env_tlob_enabled()
[6-7]  ha_setup_invariants():
          if (atomic_read_acquire(&target->stopping)) return;
          if (next_state < state_max_tlob) ha_start_timer_ns(...);
          else ha_cancel_timer(ha_mon);
[6-8]  offsetof() arithmetic -> enum-indexed array:
          enum tlob_acc_idx { TLOB_ACC_RUNNING, TLOB_ACC_WAITING,
                              TLOB_ACC_SLEEPING, TLOB_ACC_MAX };
          u64 accs_ns[TLOB_ACC_MAX];
[6-9]  1000 → TLOB_MIN_THRESHOLD_NS
[6-10] WARN_ON_ONCE(!da_mon) -> if (unlikely(WARN_ON_ONCE(!da_mon)))
[6-11] __free(kfree) + list_add_tail(&no_free_ptr(b)->list, ...) in
        tlob_add_uprobe(); note that "b = no_free_ptr(b)" would restore b
        and re-trigger __free on return — the correct pattern is to use
        no_free_ptr() as the argument to list_add_tail() directly
[6-15] tlob.h enum/struct order aligned with rvgen output
[6-16] tracefs_create_file() -> rv_create_file()

[7-1]  KUnit tests call tlob_parse_uprobe_line/tlob_parse_remove_line
        directly; no real uprobe creation from unit tests
[7-2]  KUNIT_EXPECT_EQ(test, ..., 0) for valid-line cases

[8-1]  ftracetest: walk-up algorithm to locate test.d/functions
[9-4]  tlob_busy/sleep/preempt_work unified to duration_ms


--
Best wishes,
Wen


> Gabriele
> 
> **Suggested simplification:**
> 
> ---
> diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> index 9106c5c927..4fb3f50a63 100644
> --- a/include/rv/rv_uprobe.h
> +++ b/include/rv/rv_uprobe.h
> @@ -7,83 +7,56 @@
>   #ifndef _RV_UPROBE_H
>   #define _RV_UPROBE_H
>   
> -#include <linux/path.h>
>   #include <linux/types.h>
> +#include <linux/uprobes.h>
>   
>   struct pt_regs;
> +struct inode;
>   
>   /**
>    * struct rv_uprobe - a single uprobe registered on behalf of an RV monitor
>    *
> - * @offset:   byte offset within the ELF binary where the probe is installed
> - * @priv:     monitor-private pointer; set at attach time, never touched by
> - *            this layer; passed unchanged to entry_fn / ret_fn
> - * @path:     resolved path of the probed binary (read-only after attach);
> - *            callers may use path.dentry for identity comparisons
> - *
> - * The implementation fields (uprobe_consumer, uprobe handle, callbacks) are
> - * private to rv_uprobe.c and are not exposed here; monitors must not access
> - * them directly.
> + * @uc:       underlying uprobe consumer (publicly visible)
> + * @uprobe:   active uprobe structure handle
> + * @inode:    inode of the target binary (read-only after registration)
>    */
>   struct rv_uprobe {
> -	/* public: read-only after rv_uprobe_attach*() */
> -	loff_t		 offset;
> -	void		*priv;
> -	struct path	 path;
> +	struct uprobe_consumer	uc;
> +	struct uprobe		*uprobe;
> +	struct inode		*inode;
>   };
>   
> -/**
> - * rv_uprobe_attach_path - register an uprobe given an already-resolved path
> - * @path:     path of the target binary; rv_uprobe takes its own reference
> - * @offset:   byte offset within the binary
> - * @entry_fn: called on probe hit (entry); may be NULL
> - * @ret_fn:   called on function return (uretprobe); may be NULL
> - * @priv:     opaque pointer forwarded to callbacks unchanged
> - *
> - * Use this variant when the caller has already resolved the path (e.g. to
> - * register multiple probes on the same binary with a single kern_path call).
> - * The inode is derived internally via d_real_inode(), so inode and path are
> - * always consistent.
> - *
> - * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
> - */
> -struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
> -	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
> -	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -			struct pt_regs *regs, __u64 *data),
> -	void *priv);
> +/* Seamless inline declaration of a named uprobe inside user structs */
> +#define DECLARE_RV_UPROBE(name) \
> +	struct rv_uprobe name
>   
>   /**
> - * rv_uprobe_attach - resolve binpath and register an uprobe
> - * @binpath:  absolute path to the target binary
> - * @offset:   byte offset within the binary
> - * @entry_fn: called on probe hit (entry); may be NULL
> - * @ret_fn:   called on function return (uretprobe); may be NULL
> - * @priv:     opaque pointer forwarded to callbacks unchanged
> + * rv_uprobe_register - resolve binpath and register an uprobe
> + * @binpath:     absolute path to the target binary
> + * @offset:      byte offset within the binary
> + * @p:           pointer to the allocated/embedded rv_uprobe structure
> + * @handler:     called on probe hit (entry); may be NULL
> + * @ret_handler: called on function return (uretprobe); may be NULL
>    *
> - * Resolves binpath via kern_path(), then delegates to rv_uprobe_attach_path().
> + * Resolves binpath via kern_path(), registers the uprobe directly using the
> + * embedded `uprobe_consumer`, and immediately releases the path reference.
>    *
> - * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
> + * Returns 0 on success, or a negative error code on failure.
>    */
> -struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
> -	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
> -	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -			struct pt_regs *regs, __u64 *data),
> -	void *priv);
> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprobe *p,
> +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data),
> +	int (*ret_handler)(struct uprobe_consumer *self, unsigned long func,
> +			   struct pt_regs *regs, __u64 *data));
>   
>   /**
> - * rv_uprobe_detach - synchronously unregister an uprobe and free it
> - * @p:  probe to detach; may be NULL (no-op)
> - *
> - * Calls uprobe_unregister_nosync(), then uprobe_unregister_sync() to wait
> - * for any in-progress handler to finish, then releases the path reference
> - * and frees the rv_uprobe struct.  The caller's priv data is NOT freed.
> + * rv_uprobe_unregister - synchronously unregister a uprobe
> + * @p:  probe to unregister; may be NULL (no-op)
>    *
> - * When removing a single probe, prefer this over the three-phase API.
> - * Safe to call from process context only (uprobe_unregister_sync() may
> - * schedule).
> + * Dequeues the uprobe and waits synchronously for all in-flight handlers
> + * to complete.
>    */
> -void rv_uprobe_detach(struct rv_uprobe *p);
> +void rv_uprobe_unregister(struct rv_uprobe *p);
>   
>   /**
>    * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
> @@ -91,9 +64,7 @@ void rv_uprobe_detach(struct rv_uprobe *p);
>    *
>    * Removes the uprobe from the uprobe subsystem but does NOT wait for
>    * in-flight handlers to complete.  The caller must call rv_uprobe_sync()
> - * before calling rv_uprobe_free() on the same probe.
> - *
> - * Use this to batch multiple deregistrations before a single rv_uprobe_sync().
> + * before freeing any container holding this probe.
>    */
>   void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
>   
> @@ -101,19 +72,8 @@ void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
>    * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
>    *
>    * Global barrier: waits for every in-flight uprobe handler across the system
> - * to finish.  Call once after a batch of rv_uprobe_unregister_nosync() calls
> - * and before any rv_uprobe_free() call.
> + * to finish.
>    */
>   void rv_uprobe_sync(void);
>   
> -/**
> - * rv_uprobe_free - release resources of a previously deregistered probe
> - * @p:  probe to free; may be NULL (no-op)
> - *
> - * Releases the path reference and frees the rv_uprobe struct.  Must only
> - * be called after rv_uprobe_sync() has returned.  The caller's priv data
> - * is NOT freed.
> - */
> -void rv_uprobe_free(struct rv_uprobe *p);
> -
>   #endif /* _RV_UPROBE_H */
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitors/tlob/tlob.c
> index d8e0c47947..28a6c740c7 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -252,8 +252,8 @@ struct tlob_uprobe_binding {
>   	char			binpath[TLOB_MAX_PATH];
>   	loff_t			offset_start;
>   	loff_t			offset_stop;
> -	struct rv_uprobe	*start_probe;
> -	struct rv_uprobe	*stop_probe;
> +	DECLARE_RV_UPROBE(start_probe);
> +	DECLARE_RV_UPROBE(stop_probe);
>   };
>   
>   /* RCU callback: free the slab once no readers remain. */
> @@ -512,16 +512,16 @@ int tlob_stop_task(struct task_struct *task)
>   EXPORT_SYMBOL_GPL(tlob_stop_task);
>   
>   
> -static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_regs *regs,
> +static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struct pt_regs *regs,
>   				     __u64 *data)
>   {
> -	struct tlob_uprobe_binding *b = p->priv;
> +	struct tlob_uprobe_binding *b = container_of(self, struct tlob_uprobe_binding, start_probe.uc);
>   
>   	tlob_start_task(current, b->threshold_ns);
>   	return 0;
>   }
>   
> -static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct pt_regs *regs,
> +static int tlob_uprobe_stop_handler(struct uprobe_consumer *self, struct pt_regs *regs,
>   				    __u64 *data)
>   {
>   	tlob_stop_task(current);
> @@ -537,6 +537,7 @@ static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
>   {
>   	struct tlob_uprobe_binding *b, *tmp_b;
>   	char pathbuf[TLOB_MAX_PATH];
> +	struct inode *inode;
>   	struct path path;
>   	char *canon;
>   	int ret;
> @@ -561,10 +562,12 @@ static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
>   		goto err_path;
>   	}
>   
> -	/* Reject duplicate start offset for the same binary. */
> +	inode = d_real_inode(path.dentry);
> +
> +	/* Reject duplicate start offset for the same binary inode. */
>   	list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
>   		if (tmp_b->offset_start == offset_start &&
> -		    tmp_b->start_probe->path.dentry == path.dentry) {
> +		    tmp_b->start_probe.inode == inode) {
>   			ret = -EEXIST;
>   			goto err_path;
>   		}
> @@ -577,29 +580,25 @@ static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
>   	}
>   	strscpy(b->binpath, canon, sizeof(b->binpath));
>   
> -	/* Both probes share b (priv) and path; attach_path refs path itself. */
> -	b->start_probe = rv_uprobe_attach_path(&path, offset_start,
> -					       tlob_uprobe_entry_handler, NULL, b);
> -	if (IS_ERR(b->start_probe)) {
> -		ret = PTR_ERR(b->start_probe);
> -		b->start_probe = NULL;
> -		goto err_path;
> -	}
> +	path_put(&path);
> +
> +	/* Both probes are registered directly on the embedded fields */
> +	ret = rv_uprobe_register(b->binpath, offset_start, &b->start_probe,
> +				 tlob_uprobe_entry_handler, NULL);
> +	if (ret)
> +		goto err_free;
>   
> -	b->stop_probe = rv_uprobe_attach_path(&path, offset_stop,
> -					      tlob_uprobe_stop_handler, NULL, b);
> -	if (IS_ERR(b->stop_probe)) {
> -		ret = PTR_ERR(b->stop_probe);
> -		b->stop_probe = NULL;
> +	ret = rv_uprobe_register(b->binpath, offset_stop, &b->stop_probe,
> +				 tlob_uprobe_stop_handler, NULL);
> +	if (ret)
>   		goto err_start;
> -	}
>   
> -	path_put(&path);
>   	list_add_tail(&b->list, &tlob_uprobe_list);
>   	return 0;
>   
>   err_start:
> -	rv_uprobe_detach(b->start_probe);
> +	rv_uprobe_unregister(&b->start_probe);
> +	goto err_free;
>   err_path:
>   	path_put(&path);
>   err_free:
> @@ -611,21 +610,24 @@ static int tlob_remove_uprobe_by_key(loff_t offset_start, const char *binpath)
>   {
>   	struct tlob_uprobe_binding *b, *tmp;
>   	struct path remove_path;
> +	struct inode *inode;
>   	int ret;
>   
>   	ret = kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
>   	if (ret)
>   		return ret;
>   
> +	inode = d_real_inode(remove_path.dentry);
> +
>   	ret = -ENOENT;
>   	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
>   		if (b->offset_start != offset_start)
>   			continue;
> -		if (b->start_probe->path.dentry != remove_path.dentry)
> +		if (b->start_probe.inode != inode)
>   			continue;
>   		list_del(&b->list);
> -		rv_uprobe_detach(b->start_probe);
> -		rv_uprobe_detach(b->stop_probe);
> +		rv_uprobe_unregister(&b->start_probe);
> +		rv_uprobe_unregister(&b->stop_probe);
>   		kfree(b);
>   		ret = 0;
>   		break;
> @@ -643,8 +645,8 @@ static void tlob_remove_all_uprobes(void)
>   	mutex_lock(&tlob_uprobe_mutex);
>   	list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
>   		list_move(&b->list, &pending);
> -		rv_uprobe_unregister_nosync(b->start_probe);
> -		rv_uprobe_unregister_nosync(b->stop_probe);
> +		rv_uprobe_unregister_nosync(&b->start_probe);
> +		rv_uprobe_unregister_nosync(&b->stop_probe);
>   	}
>   	mutex_unlock(&tlob_uprobe_mutex);
>   
> @@ -658,8 +660,6 @@ static void tlob_remove_all_uprobes(void)
>   	rv_uprobe_sync();
>   
>   	list_for_each_entry_safe(b, tmp, &pending, list) {
> -		rv_uprobe_free(b->start_probe);
> -		rv_uprobe_free(b->stop_probe);
>   		kfree(b);
>   	}
>   }
> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> index 3d8b764dde..69b8b0c27e 100644
> --- a/kernel/trace/rv/rv_uprobe.c
> +++ b/kernel/trace/rv/rv_uprobe.c
> @@ -10,149 +10,74 @@
>   #include <linux/uprobes.h>
>   #include <rv/rv_uprobe.h>
>   
> -/*
> - * Private extension of struct rv_uprobe.  Allocated by rv_uprobe_attach*()
> - * and returned to callers as &impl->pub.
> - */
> -struct rv_uprobe_impl {
> -	struct rv_uprobe	pub;	/* must be first; callers hold &pub */
> -	struct uprobe_consumer	uc;
> -	struct uprobe		*uprobe;
> -	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data);
> -	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -			struct pt_regs *regs, __u64 *data);
> -};
> -
> -static int rv_uprobe_handler(struct uprobe_consumer *uc,
> -			     struct pt_regs *regs, __u64 *data)
> -{
> -	struct rv_uprobe_impl *impl = container_of(uc, struct rv_uprobe_impl, uc);
> -
> -	if (impl->entry_fn)
> -		return impl->entry_fn(&impl->pub, regs, data);
> -	return 0;
> -}
> -
> -static int rv_uprobe_ret_handler(struct uprobe_consumer *uc,
> -				 unsigned long func,
> -				 struct pt_regs *regs, __u64 *data)
> -{
> -	struct rv_uprobe_impl *impl = container_of(uc, struct rv_uprobe_impl, uc);
> -
> -	if (impl->ret_fn)
> -		return impl->ret_fn(&impl->pub, func, regs, data);
> -	return 0;
> -}
> -
> -static struct rv_uprobe *
> -__rv_uprobe_attach(struct inode *inode, struct path *path, loff_t offset,
> -		   int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
> -		   int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -				   struct pt_regs *regs, __u64 *data),
> -		   void *priv)
> -{
> -	struct rv_uprobe_impl *impl;
> -	int ret;
> -
> -	if (!entry_fn && !ret_fn)
> -		return ERR_PTR(-EINVAL);
> -
> -	impl = kzalloc_obj(*impl, GFP_KERNEL);
> -	if (!impl)
> -		return ERR_PTR(-ENOMEM);
> -
> -	impl->pub.offset = offset;
> -	impl->pub.priv   = priv;
> -	impl->entry_fn   = entry_fn;
> -	impl->ret_fn     = ret_fn;
> -	path_get(path);
> -	impl->pub.path   = *path;
> -
> -	if (entry_fn)
> -		impl->uc.handler     = rv_uprobe_handler;
> -	if (ret_fn)
> -		impl->uc.ret_handler = rv_uprobe_ret_handler;
> -
> -	impl->uprobe = uprobe_register(inode, offset, 0, &impl->uc);
> -	if (IS_ERR(impl->uprobe)) {
> -		ret = PTR_ERR(impl->uprobe);
> -		path_put(&impl->pub.path);
> -		kfree(impl);
> -		return ERR_PTR(ret);
> -	}
> -
> -	return &impl->pub;
> -}
> -
> -/**
> - * rv_uprobe_attach_path - register an uprobe given an already-resolved path
> - */
> -struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
> -	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
> -	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -			struct pt_regs *regs, __u64 *data),
> -	void *priv)
> -{
> -	struct inode *inode = d_real_inode(path->dentry);
> -
> -	return __rv_uprobe_attach(inode, path, offset, entry_fn, ret_fn, priv);
> -}
> -EXPORT_SYMBOL_GPL(rv_uprobe_attach_path);
> -
>   /**
> - * rv_uprobe_attach - resolve binpath and register an uprobe
> + * rv_uprobe_register - resolve binpath and register an uprobe
>    */
> -struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
> -	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
> -	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> -			struct pt_regs *regs, __u64 *data),
> -	void *priv)
> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprobe *p,
> +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data),
> +	int (*ret_handler)(struct uprobe_consumer *self, unsigned long func,
> +			   struct pt_regs *regs, __u64 *data))
>   {
> -	struct rv_uprobe *p;
> +	struct inode *inode;
>   	struct path path;
>   	int ret;
>   
> +	if (!handler && !ret_handler)
> +		return -EINVAL;
> +
>   	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
>   	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
>   
>   	if (!d_is_reg(path.dentry)) {
>   		path_put(&path);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   	}
>   
> -	p = rv_uprobe_attach_path(&path, offset, entry_fn, ret_fn, priv);
> +	inode = d_real_inode(path.dentry);
> +
> +	p->uc.handler     = handler;
> +	p->uc.ret_handler = ret_handler;
> +	p->inode          = inode;
> +
> +	p->uprobe = uprobe_register(inode, offset, 0, &p->uc);
>   	path_put(&path);
> -	return p;
> +
> +	if (IS_ERR(p->uprobe)) {
> +		ret = PTR_ERR(p->uprobe);
> +		p->uprobe = NULL;
> +		p->inode  = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
>   }
> -EXPORT_SYMBOL_GPL(rv_uprobe_attach);
> +EXPORT_SYMBOL_GPL(rv_uprobe_register);
>   
>   /**
> - * rv_uprobe_detach - synchronously unregister an uprobe and free it
> + * rv_uprobe_unregister - synchronously unregister a uprobe
>    */
> -void rv_uprobe_detach(struct rv_uprobe *p)
> +void rv_uprobe_unregister(struct rv_uprobe *p)
>   {
> -	if (!p)
> +	if (!p || IS_ERR_OR_NULL(p->uprobe))
>   		return;
>   
>   	rv_uprobe_unregister_nosync(p);
>   	rv_uprobe_sync();
> -	rv_uprobe_free(p);
>   }
> -EXPORT_SYMBOL_GPL(rv_uprobe_detach);
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
>   
>   /**
>    * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
>    */
>   void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
>   {
> -	struct rv_uprobe_impl *impl;
> -
> -	if (!p)
> +	if (!p || IS_ERR_OR_NULL(p->uprobe))
>   		return;
>   
> -	impl = container_of(p, struct rv_uprobe_impl, pub);
> -	uprobe_unregister_nosync(impl->uprobe, &impl->uc);
> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
> +	p->uprobe = NULL;
> +	p->inode  = NULL;
>   }
>   EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
>   
> @@ -164,19 +89,3 @@ void rv_uprobe_sync(void)
>   	uprobe_unregister_sync();
>   }
>   EXPORT_SYMBOL_GPL(rv_uprobe_sync);
> -
> -/**
> - * rv_uprobe_free - release resources of a previously deregistered probe
> - */
> -void rv_uprobe_free(struct rv_uprobe *p)
> -{
> -	struct rv_uprobe_impl *impl;
> -
> -	if (!p)
> -		return;
> -
> -	impl = container_of(p, struct rv_uprobe_impl, pub);
> -	path_put(&p->path);
> -	kfree(impl);
> -}
> -EXPORT_SYMBOL_GPL(rv_uprobe_free);
> 
