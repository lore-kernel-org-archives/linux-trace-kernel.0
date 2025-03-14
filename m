Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5A2E3383;
	Fri, 14 Mar 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913851; cv=none; b=iZNLlfW+wMH8Aua5ahlS+SJx8SoWX7P95wovW0RNVQHFle5l/AZuCg6J4j3X847LRNH82G4gCVKo3I3Ps3lQPJMCQFGTWUo0s8lwj2Wh9V3MY0P4y2Z1wXCJHRQAABr49lGMceD24LnuEOwwzqhe3DuTfyNy+zyZtR6tD8qCpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913851; c=relaxed/simple;
	bh=vBTlnOmgxZWKGka4jRBvC3fk3Xwx7Sqyo+qnil3kH7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHflmXXXVQbL8EQs4X8uzO+McGTd/G9BTiRaEwdVE7x/vcg4U/V9ovCvRs5JDUxOqQUlqyhzfFihYoE4mn+YuOACOG+5zeYm3iceBO2BtUlEs+hmxxpeBt+W9rdD2V5hIGTovWEJYeuB4yHg33RrPOSzR7zUJm5u2Q+hEZC+9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZDQtj69Fpz4f3jrh;
	Fri, 14 Mar 2025 08:57:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 50D9D1A138F;
	Fri, 14 Mar 2025 08:57:24 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgC3V8LzftNn+P1aGQ--.6324S2;
	Fri, 14 Mar 2025 08:57:24 +0800 (CST)
Message-ID: <1921659c-9bf7-4fd5-97e7-512da777461f@huaweicloud.com>
Date: Fri, 14 Mar 2025 08:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Correct the refcount for hist/hist_debug file if
 single_open() fails
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zheng Yejian <zhengyejian1@huawei.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313103719.1191073-1-wutengda@huaweicloud.com>
 <20250313104446.7b31820e@batman.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250313104446.7b31820e@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3V8LzftNn+P1aGQ--.6324S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xuF4rCr4DZF4xAr43Wrg_yoW8Kw1rpr
	Z5Gan8KF18tFy8K3Z7AFs7uryfZ3y8trW7WFyqgayrtrn8u340gFWDK3y5uF15trs5JrWI
	va1jgFy29rW5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Steven,

On 2025/3/13 22:44, Steven Rostedt wrote:
> On Thu, 13 Mar 2025 10:37:19 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> The function event_{hist,hist_debug}_open() maintains the refcount of
>> 'file->tr' and 'file' through tracing_open_file_tr(), but it does not
>> roll back these counts when the subsequent single_open() call fails,
>> leading to a refcount leak.
>>
>> A very obvious case is that if the hist/hist_debug file belongs to a
>> certain instance, the failure of single_open() will prevent the deletion
>> of that instance, as it relies on the condition 'tr->ref == 1' within
>> __remove_instance().
>>
>> Fix this by calling tracing_release_file_tr() to correct the refcount
>> when single_open() fails.
>>
>> Fixes: 1cc111b9cddc ("tracing: Fix uaf issue when open the hist or hist_debug file")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> Cc: stable@vger.kernel.org # v6.7+
>> ---
>>  kernel/trace/trace_events_hist.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index ad7419e24055..900b06fa8505 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -5702,8 +5702,10 @@ static int event_hist_open(struct inode *inode, struct file *file)
>>  	/* Clear private_data to avoid warning in single_open() */
>>  	file->private_data = NULL;
>>  	ret = single_open(file, hist_show, hist_file);
>> -	if (ret)
>> +	if (ret) {
>>  		kfree(hist_file);
>> +		tracing_release_file_tr(inode, file);
>> +	}
> 
> Hmm, this function has a couple more error path exits after taking the
> ref count. If this is to be fixed, let's fix it completely. Each of
> those error paths need to call tracing_release_file_tr().
> 
> -- Steve

Oops, I got it. The v2 is coming soon. Thanks a lot.

-- Tengda

> 
> 
>>  
>>  	return ret;
>>  }
>> @@ -5979,7 +5981,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
>>  
>>  	/* Clear private_data to avoid warning in single_open() */
>>  	file->private_data = NULL;
>> -	return single_open(file, hist_debug_show, file);
>> +	ret = single_open(file, hist_debug_show, file);
>> +	if (ret)
>> +		tracing_release_file_tr(inode, file);
>> +	return ret;
>>  }
>>  
>>  const struct file_operations event_hist_debug_fops = {

