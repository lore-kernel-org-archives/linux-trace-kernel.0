Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CB39A7E6;
	Thu, 26 Feb 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100968; cv=none; b=mmAPnW/BmzIwoOQhtdPVWZ0GUR/gkYfRoRewdJMtkZznk/BT9yT0sslEp12BYb+0nzIOOWPfhfLy4pJiU3a40vY/9PQhN5xBus28xnzz+OLNCDl0EGYi8pfb3EPv1C2ApVjIjGQnxgdPnolKQr7GT+yJQZKZAKq5xtAuiDhAGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100968; c=relaxed/simple;
	bh=l0pId/PCqbc+sEfunUJSlN55RlTGNH1BYflD8I/BCr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3CDMjVKrB/+CoAZJzpRdXuVwy5VW64vw5W5I+5SV47puJIDPCDCNMCZF2IyqFXgiuYUZ81ykVxYzmmc6+1Zl9adOqrpBYCBhweyp67CkkKNaVM5jTF3HfiwzCh/BuVUZeXS6jrzL+S7aj8tHcJrg4AEuY6dx5R929LJw7t0els=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.1953501931
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 867D240008B;
	Thu, 26 Feb 2026 18:12:07 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 9cf6afb7491a4db0b327a95338f3425d for rostedt@goodmis.org;
	Thu, 26 Feb 2026 18:12:08 CST
X-Transaction-ID: 9cf6afb7491a4db0b327a95338f3425d
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <e18ed5f4-3917-46e7-bca9-78063e6e4457@189.cn>
Date: Thu, 26 Feb 2026 18:12:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/trace/ftrace: introduce ftrace module notifier
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, atomlin@atomlin.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260225054639.21637-1-chensong_2000@189.cn>
 <20260225192724.48ed165e@fedora>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20260225192724.48ed165e@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2026/2/26 08:27, Steven Rostedt 写道:
> On Wed, 25 Feb 2026 13:46:39 +0800
> chensong_2000@189.cn wrote:
> 
>> From: Song Chen <chensong_2000@189.cn>
>>
>> Like kprobe, fprobe and btf, this patch attempts to introduce
>> a notifier_block for ftrace to decouple its initialization from
>> load_module.
>>
>> Below is the table of ftrace fucntions calls in different
>> module state:
>>
>> 	MODULE_STATE_UNFORMED	ftrace_module_init
>> 	MODULE_STATE_COMING	ftrace_module_enable
>> 	MODULE_STATE_LIVE	ftrace_free_mem
>> 	MODULE_STATE_GOING	ftrace_release_mod
>>
>> Unlike others, ftrace module notifier must take care of state
>> MODULE_STATE_UNFORMED to ensure calling ftrace_module_init
>> before complete_formation which changes module's text property.
>>
>> That pretty much remains same logic with its original design,
>> the only thing that changes is blocking_notifier_call_chain
>> (MODULE_STATE_GOING) has to be moved from coming_cleanup to
>> ddebug_cleanup in function load_module to ensure
>> ftrace_release_mod is invoked in case complete_formation fails.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   kernel/module/main.c  | 14 ++++----------
>>   kernel/trace/ftrace.c | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 710ee30b3bea..5dc0a980e9bd 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -45,7 +45,6 @@
>>   #include <linux/license.h>
>>   #include <asm/sections.h>
>>   #include <linux/tracepoint.h>
>> -#include <linux/ftrace.h>
>>   #include <linux/livepatch.h>
>>   #include <linux/async.h>
>>   #include <linux/percpu.h>
>> @@ -836,7 +835,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>   	blocking_notifier_call_chain(&module_notify_list,
>>   				     MODULE_STATE_GOING, mod);
>>   	klp_module_going(mod);
>> -	ftrace_release_mod(mod);
> 
> Is the above safe? klp uses ftrace. That means klp_module_going() may
> need to be called before ftrace_release_mod(). That said, I wonder if
> klp_module_going() could be moved into ftrace_release_mod()?
> 
>>   

I didn't test with klp, so i'm not sure if it's safe. But i consider klp 
is the other part which should be decoupled after ftrace and klp should 
introduce its own notifier.

If klp_module_going must be running before ftrace_release_mod, i can try 
to use priority in notifier_block to ensure their order.

Let me see if there is any way to use notifier and remain below calling 
sequence:

ftrace_module_enable
klp_module_coming
blocking_notifier_call_chain_robust(MODULE_STATE_COMING)

blocking_notifier_call_chain(MODULE_STATE_GOING)
klp_module_going
ftrace_release_mod


>>   	async_synchronize_full();
>>   
>> @@ -3067,8 +3065,6 @@ static noinline int do_init_module(struct module *mod)
>>   	if (!mod->async_probe_requested)
>>   		async_synchronize_full();
>>   
>> -	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
>> -			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
> 
> Have you tested the case for why this is called? It has to be called
> before the module frees the kallsyms. It's for tracing the module's
> init functions.
> 
>    cd /sys/kernel/tracing
>    echo :mod:<module> > set_ftrace_filter
>    echo function > current_tracer
>    modprobe <module>
>    cat trace
> 
> You should see the init functions of the module loaded. If
> ftrace_free_mem() is called after the module frees the kallsyms of the
> module init functions, you'll just get garbage for the init function
> names.
> 
> 

Yes, after applying this patch, i tested it with your above commands, 
result is:

cat trace_pipe
            <...>-4027    [004] .....   103.171161: mem_blkdev_init 
<-do_one_initcall
           insmod-4027    [004] .....   103.249854: mem_blkdev_queue_rq 
<-blk_mq_dispatch_rq_list
           insmod-4027    [004] .....   103.249865: mem_blkdev_queue_rq 
<-blk_mq_dispatch_rq_list
....
module init function can be seen when module is being loaded.

As far as my understanding, ftrace_free_mem is called right after 
blocking_notifier_call_chain(MODULE_STATE_LIVE) originally in 
do_init_module, after this patch, it's called by notifier, almost 
nothing changed, so no impact to current calling sequence.

Correct me if I'm wrong.

> 
>>   	mutex_lock(&module_mutex);
>>   	/* Drop initial reference. */
>>   	module_put(mod);
>> @@ -3131,7 +3127,6 @@ static noinline int do_init_module(struct module *mod)
>>   	blocking_notifier_call_chain(&module_notify_list,
>>   				     MODULE_STATE_GOING, mod);
>>   	klp_module_going(mod);
>> -	ftrace_release_mod(mod);
>>   	free_module(mod);
>>   	wake_up_all(&module_wq);
>>   
>> @@ -3278,7 +3273,6 @@ static int prepare_coming_module(struct module *mod)
>>   {
>>   	int err;
>>   
>> -	ftrace_module_enable(mod);
>>   	err = klp_module_coming(mod);
> 
> Same issue with ftrace and klp here.
> 
>>   	if (err)
>>   		return err;
>> @@ -3461,7 +3455,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>   	init_build_id(mod, info);
>>   
>>   	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
>> -	ftrace_module_init(mod);
>> +	blocking_notifier_call_chain(&module_notify_list,
>> +				MODULE_STATE_UNFORMED, mod);
>>   
>>   	/* Finally it's fully formed, ready to start executing. */
>>   	err = complete_formation(mod, info);
>> @@ -3513,8 +3508,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>    coming_cleanup:
>>   	mod->state = MODULE_STATE_GOING;
>>   	destroy_params(mod->kp, mod->num_kp);
>> -	blocking_notifier_call_chain(&module_notify_list,
>> -				     MODULE_STATE_GOING, mod);
>>   	klp_module_going(mod);
> 
> Now klp_module_going() may need to be called *after* the
> MODULE_STATE_GOING callbacks and *before* ftrace_release_mod(). But
> again, if that's moved into ftrace_release_mod() it may be fine.
> 
>>    bug_cleanup:
>>   	mod->state = MODULE_STATE_GOING;
>> @@ -3524,7 +3517,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>   	mutex_unlock(&module_mutex);
>>   
>>    ddebug_cleanup:
>> -	ftrace_release_mod(mod);
>> +	blocking_notifier_call_chain(&module_notify_list,
>> +				     MODULE_STATE_GOING, mod);
>>   	synchronize_rcu();
>>   	kfree(mod->args);
>>    free_arch_cleanup:
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> 
> -- Steve
> 

