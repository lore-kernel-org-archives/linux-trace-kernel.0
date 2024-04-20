Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C188472
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585044; cv=none; b=TchPSa4AMVUIRPo7chxUyEQyEZtnlTEr9hCcVqNxh9FRm7MHOyDTAhC9GNTxqfQz8CRdUu1t6Tt7USKzir/XnHJ3bH+xOIsIQRGwc+wvFXst3NZOxWEF5CzX7Hqvn02EQMyCvjgHyvVX7z9d05IisbjREEc84GpuxbNJL7kOsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585044; c=relaxed/simple;
	bh=mWYnMDKdixjCqNNjdEZ3BxVyfBJC2JODgk8uuHx0rek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA88HxfCt6dOa/3Bsv1qqt1lhvel2s6Z1Iol0dp9D0Bt4Rp6kN/9pzNIY8gM6A99I4QKkqm5cc3SU9JPG6Uwt+YbVPq0fxGBqrEyK4iLbmVHv7YSlpvzZPKKItdg6/aN3qKv2H47U/XVLdl+1JyHwfcfsnVanX+prBU+eQiQPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XGXQbAA_1713585030;
Received: from 30.15.196.203(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XGXQbAA_1713585030)
          by smtp.aliyun-inc.com;
          Sat, 20 Apr 2024 11:50:31 +0800
Message-ID: <0c43ff81-042c-4705-8a46-543c47e2c203@antgroup.com>
Date: Sat, 20 Apr 2024 11:50:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Replace ftrace_disabled variable with
 ftrace_is_dead function
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 libang.linux@gmail.com
References: <20240419143844.97847-1-libang.li@antgroup.com>
 <20240419214054.688d624e@rorschach.local.home>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <20240419214054.688d624e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/4/20 9:40, Steven Rostedt wrote:
> On Fri, 19 Apr 2024 22:38:44 +0800
> "Bang Li" <libang.li@antgroup.com> wrote:
> 
>> Use the existing function ftrace_is_dead to replace the variable to make
>> the code clearer.
>>
>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>> ---
>>   kernel/trace/ftrace.c | 46 +++++++++++++++++++++----------------------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 50ca4d4f8840..4a08c79db677 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -2693,7 +2693,7 @@ void __weak ftrace_replace_code(int mod_flags)
>>   	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
>>   	int failed;
>>   
>> -	if (unlikely(ftrace_disabled))
>> +	if (unlikely(ftrace_is_dead()))
>>   		return;
>>   
> 
> NACK!
> 
> ftrace_is_dead() is only there to make the static variable
> "ftrace_disabled" available for code outside of ftrace.c. In ftrace.c,
> it is perfectly fine to use ftrace_disabled.
> 
> -- Steve

Thank you for your explanation, let me understand this. How about
replacing ftrace_disabled with unlike(ftrace_disabled)?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 50ca4d4f8840..76e0814723cb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6767,7 +6767,7 @@ void ftrace_release_mod(struct module *mod)

         mutex_lock(&ftrace_lock);

-       if (ftrace_disabled)
+       if (unlikely(ftrace_disabled))
                 goto out_unlock;

         list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
@@ -6830,7 +6830,7 @@ void ftrace_module_enable(struct module *mod)

         mutex_lock(&ftrace_lock);

-       if (ftrace_disabled)
+       if (unlikely(ftrace_disabled))
                 goto out_unlock;

         /*

Thanks again for the review!
Bang
