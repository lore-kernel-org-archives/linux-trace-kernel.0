Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA86249EB;
	Mon, 26 May 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223225; cv=none; b=ALBxxEK6VxZwdsdA0h8rmbebWOrOdHWivnCYd9OtbS/eSi7HjyjHChPZwvjqVNq26Sq15GlKTZhmfpDIHz6QxgkrE47/TMyEbxplGgFjNZEifGLfiTJ2kGb40Tz9I+342qs7KR6CU9CwJ9ur6m4tkuAKl71Ejh0eHLjiK7L9HR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223225; c=relaxed/simple;
	bh=mLOejERJ3exTBvss/m5cpLwsxlTyx6iIqA2MxkKkNEM=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y+2hYm49QlxXZxMC7pMEgftcfcPQUoknA3h48XmvS/fAumT8/w3matiM9bozVWGzpRvWEeGPie1gyZOQSpMpd+3V4uAJylyHV0uZ8rNU3ra9/as31l0qrnPqvZcDLnNrwczXMduZ1SuuyaFb8P4KQDXaEPQIOYiMNIVQTwcjxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5JDt6Ky1z4f3jq5;
	Mon, 26 May 2025 09:33:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E67AA1A196B;
	Mon, 26 May 2025 09:33:38 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1_xxDNofXQbNg--.18534S3;
	Mon, 26 May 2025 09:33:38 +0800 (CST)
Subject: Re: [PATCH 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
To: Steven Rostedt <rostedt@goodmis.org>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
 <20250523083945.3390587-2-yebin@huaweicloud.com>
 <20250523135452.626d8dcd@gandalf.local.home>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <6833C4F1.3030300@huaweicloud.com>
Date: Mon, 26 May 2025 09:33:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250523135452.626d8dcd@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXu1_xxDNofXQbNg--.18534S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3Xw43Ar43AF4DuFWxJFb_yoWrGw45pF
	WftFWqya18ZF4qk3Zruw48ury7J3yUJrW8GFs5GrWSyws8Ary0grs2va1DZFy8Jw13GrWS
	vF4jvrnxWrWDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/5/24 1:54, Steven Rostedt wrote:
> On Fri, 23 May 2025 16:39:44 +0800
> Ye Bin <yebin@huaweicloud.com> wrote:
>
>> Above issue may happens as follow:
>> (1) Add kprobe trace point;
>> (2) insmod test.ko;
>> (3) Trigger ftrace disabled;
>
> This is the bug. How was ftrace_disabled triggered? That should never
> happen. Was test.ko buggy?
>
Yes. The following warning is reported during concurrent registration 
between register_kprobe() and live patch, causing ftrace_disabled.

WARNING: CPU: 56 PID: 2769 at kernel/trace/ftrace.c:2612 
ftrace_modify_all_code+0x116/0x140
>> (4) rmmod test.ko;
>> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
>> ftrace_mod_get_kallsym()
>> ...
>> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
>> ...
>>
>> As ftrace_release_mod() judge 'ftrace_disabled' is true will return, and
>> 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no chance to
>> release. Therefore, this also causes residual resources to accumulate.
>> To solve above issue, unconditionally clean up'mod_map'.
>>
>> Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")
>
> This is *not* a fix. ftrace_disabled gets set when a bug is triggered. If
> this prevents ftrace_disabled from getting set, then it would be a fix. But
> if something else happens when ftrace_disabled is set, it just fixes a
> symptom and not the bug itself.
>
There are multiple causes for triggering ftrace_disabled. I agree that 
aba4b5c22cba is not faulty. However, the incorporation of this patch 
will cause problems due to triggering ftrace_disabled. The generation of 
ftrace_disabled is beyond our control. This is related to the user. What 
we can do is even if there are no additional derivative problems.
>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   kernel/trace/ftrace.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index a3d4dfad0cbc..ff5d9d73a4a7 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -7438,9 +7438,6 @@ void ftrace_release_mod(struct module *mod)
>>
>>   	mutex_lock(&ftrace_lock);
>>
>> -	if (ftrace_disabled)
>> -		goto out_unlock;
>> -
>
> Here you delete the check, and the next patch you have:
>
> +	if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
> +		mutex_unlock(&ftrace_lock);
> +		return;
> +	}
> +
>
The second patch I added judgment when initializing 'mod_map' in 
ftrace_free_mem(). The first patch removes the judgment when 
ftrace_release_mod() releases'mod_map'. The logic modified by the two 
patches is isolated.
> Why the two patches where the second patch just adds back the check and
> then adds some more stuff around it. This should be a single patch.
>
> Also, why not just keep the goto unlock, that has:
>
The ftrace_free_mem() function itself looks a little strange. It is easy 
to misunderstand that it is a release function, but it is actually an 
initialization function. My two patches did not modify the same function.
>   out_unlock:
> 	mutex_unlock(&ftrace_lock);
>
> 	/* Need to synchronize with ftrace_location_range() */
> 	if (tmp_page)
> 		synchronize_rcu();
> 	for (pg = tmp_page; pg; pg = tmp_page) {
>
> 		/* Needs to be called outside of ftrace_lock */
> 		clear_mod_from_hashes(pg);
>
> 		if (pg->records) {
> 			free_pages((unsigned long)pg->records, pg->order);
> 			ftrace_number_of_pages -= 1 << pg->order;
> 		}
> 		tmp_page = pg->next;
> 		kfree(pg);
> 		ftrace_number_of_groups--;
> 	}
> }
>
> And tmp_page is set to NULL before that jump, so the if and for loop will
> both be nops.
>
> Why all this extra churn?
>
> -- Steve
>
>
>>   	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
>>   		if (mod_map->mod == mod) {
>>   			list_del_rcu(&mod_map->list);
>

