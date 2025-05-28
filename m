Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EE286D74;
	Wed, 28 May 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438564; cv=none; b=Pba4b1V9XHQTlOrardD3+xGxeI8vYHdlV/COvcnF3a++M3rLNc1G07SLpYqt502Il0MO3PgMubfuCxxiLOFaK6rOF17XaCHaZQ7QcI73tgv3qII+NA9WT4tTlbky9dJN4/wcDGrlt6AxHjyogAkgo0Cfs9xbXtybjPwLeBHZ468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438564; c=relaxed/simple;
	bh=9B09LdKjupc2KUC3Z122eNeKX4XjkQrIA4hbaw1bsnY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ubuZWzRT5SGuTqdJeAtMbBFAOH745xI4CfpJ2Muu6fVjNNlxU/drj4bwGCuoOlXF3SzIyuQyZLw939VwimeN4VCtqe5TqIVQYwP4Ev50roZrN3Z+I7YqaLzD7AIkpD2M3uyxamg08ZBYDzj81YGjPWT1E2T1Vl4/HrQiRPVQYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b6qtS26YMzKHLyf;
	Wed, 28 May 2025 21:22:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B71401A1ABE;
	Wed, 28 May 2025 21:22:38 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2AdDjdokjQdNw--.49955S3;
	Wed, 28 May 2025 21:22:38 +0800 (CST)
Subject: Re: [PATCH 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
To: Steven Rostedt <rostedt@goodmis.org>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
 <20250523083945.3390587-2-yebin@huaweicloud.com>
 <20250523135452.626d8dcd@gandalf.local.home>
 <6833C4F1.3030300@huaweicloud.com>
 <20250527094131.1f4a92ab@gandalf.local.home>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <68370E1D.3070802@huaweicloud.com>
Date: Wed, 28 May 2025 21:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250527094131.1f4a92ab@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnC2AdDjdokjQdNw--.49955S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JryxJFWkKw43Kr1UZF4kXrb_yoWxWr4Upr
	yftFWqkF4UZF4vk3Z29w18Wryjy3yUtrW3Was8Gr1fZw4Dtry0grs7tFs8uFyxJr15GrWS
	vF4jvr9rWrWDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/5/27 21:41, Steven Rostedt wrote:
> On Mon, 26 May 2025 09:33:37 +0800
> yebin <yebin@huaweicloud.com> wrote:
>
>> On 2025/5/24 1:54, Steven Rostedt wrote:
>>> On Fri, 23 May 2025 16:39:44 +0800
>>> Ye Bin <yebin@huaweicloud.com> wrote:
>>>
>>>> Above issue may happens as follow:
>>>> (1) Add kprobe trace point;
>>>> (2) insmod test.ko;
>>>> (3) Trigger ftrace disabled;
>>>
>>> This is the bug. How was ftrace_disabled triggered? That should never
>>> happen. Was test.ko buggy?
>>>
>> Yes. The following warning is reported during concurrent registration
>> between register_kprobe() and live patch, causing ftrace_disabled.
>>
>> WARNING: CPU: 56 PID: 2769 at kernel/trace/ftrace.c:2612
>> ftrace_modify_all_code+0x116/0x140
>
> OK, so it is a buggy module.
>
>>>> (4) rmmod test.ko;
>>>> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
>>>> ftrace_mod_get_kallsym()
>>>> ...
>>>> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
>>>> ...
>>>>
>>>> As ftrace_release_mod() judge 'ftrace_disabled' is true will return, and
>>>> 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no chance to
>>>> release. Therefore, this also causes residual resources to accumulate.
>>>> To solve above issue, unconditionally clean up'mod_map'.
>>>>
>>>> Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")
>>>
>>> This is *not* a fix. ftrace_disabled gets set when a bug is triggered. If
>>> this prevents ftrace_disabled from getting set, then it would be a fix. But
>>> if something else happens when ftrace_disabled is set, it just fixes a
>>> symptom and not the bug itself.
>>>
>> There are multiple causes for triggering ftrace_disabled. I agree that
>
> Yes, just like there's multiple causes for BUG_ON() ;-)
>
> The ftrace_disable is used to help keep the system from being totally
> corrupted. When it triggers, the best thing to do is a reboot.
>
>> aba4b5c22cba is not faulty. However, the incorporation of this patch
>> will cause problems due to triggering ftrace_disabled. The generation of
>> ftrace_disabled is beyond our control. This is related to the user. What
>> we can do is even if there are no additional derivative problems.
>
> Well, when a user inserts a module, then they become a kernel developer too ;-)
>
>>>
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>> ---
>>>>    kernel/trace/ftrace.c | 3 ---
>>>>    1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>>>> index a3d4dfad0cbc..ff5d9d73a4a7 100644
>>>> --- a/kernel/trace/ftrace.c
>>>> +++ b/kernel/trace/ftrace.c
>>>> @@ -7438,9 +7438,6 @@ void ftrace_release_mod(struct module *mod)
>>>>
>>>>    	mutex_lock(&ftrace_lock);
>>>>
>>>> -	if (ftrace_disabled)
>>>> -		goto out_unlock;
>>>> -
>>>
>>> Here you delete the check, and the next patch you have:
>>>
>>> +	if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
>>> +		mutex_unlock(&ftrace_lock);
>>> +		return;
>>> +	}
>>> +
>>>
>> The second patch I added judgment when initializing 'mod_map' in
>> ftrace_free_mem(). The first patch removes the judgment when
>> ftrace_release_mod() releases'mod_map'. The logic modified by the two
>> patches is isolated.
>
> Actually I think both patches are buggy.
>
> When ftrace_disabled is set, we don't know the state of the code and we do
> not want to do *any* more text modification. That's what ftrace_disable
> means. Something went wrong with text modification and any more changes can
> cause a bigger problem.
>
This problem can be solved by releasing the 'mod_map' resource when the 
module is unloaded. Freeing up these resources is just an address that 
cannot be translated into symbols, and there are no worse consequences.

> We don't add "exceptions".
>
> If you are worried about unloading modules when ftrace_disable is set, what
> is a much safer solution is to up the module count of all modules that have
> any ftrace callsites active, and prevent those modules from being removed.
>
I don't think it's necessary to introduce logic to restrict module 
unloading here, which doesn't bring benefits but increases the cost of 
interpretation for maintainers.

> Again, the only solution to a ftrace_disable being set is a full reboot.
>
We can't ask users to know such specialized details of the 
implementation, which are unclear even to developers unfamiliar with the 
ftrace module. Users can accept planned reboot system recovery, but 
should not accept casual operations and the system crashes.All we can do 
is do a good job of protection, give users more tolerance.Perhaps a 
system that is dead but won't lie down is also a very undesirable 
situation.However, ftrace is used to collect information and locate 
faults. Even if it does not work, it does not affect services.In the 
production environment, the most afraid of using ftrace suddenly crashes 
the system.Therefore, the robustness of the tool itself is very important.
> -- Steve
>

I reworked the two patches, and the changes to the existing process 
should be minimal. I don't know if I can get your approval. If you 
agree, I'll post another V3 version.

PATCH[1/2]:
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 51580e54677f..b3436d86e470 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7438,9 +7438,10 @@ void ftrace_release_mod(struct module *mod)

         mutex_lock(&ftrace_lock);

-       if (ftrace_disabled)
-               goto out_unlock;
-
+       /*
+        * To avoid the UAF problem after the module is unloaded, the
+        * 'mod_map' resource needs to be released unconditionally.
+        */
         list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
                 if (mod_map->mod == mod) {
                         list_del_rcu(&mod_map->list);
@@ -7451,6 +7452,9 @@ void ftrace_release_mod(struct module *mod)
                 }
         }

+       if (ftrace_disabled)
+               goto out_unlock;
+
         /*
          * Each module has its own ftrace_pages, remove
          * them from the list.

PATCH[2/2]:
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a3d4dfad0cbc..51580e54677f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7629,6 +7629,9 @@ allocate_ftrace_mod_map(struct module *mod,
  {
         struct ftrace_mod_map *mod_map;

+       if (ftrace_disabled)
+               return NULL;
+
         mod_map = kmalloc(sizeof(*mod_map), GFP_KERNEL);
         if (!mod_map)
                 return NULL;

