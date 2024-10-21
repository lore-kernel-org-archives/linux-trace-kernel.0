Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F11E5711;
	Mon, 21 Oct 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502973; cv=none; b=u6ay5PWrWKj+EQIPfKSlEMSthiVc5RguiTehy9Ui8QgpVJge1CzrOJQycmZDfWEQT/SfD4oLa6jipP+K6WoVXvE87bMsZyuacPGRft+xRoMUki7DxzBIWWKgX82DPnAw5ITfYX9FAgDS3YQVnRwtB7FUNh80f0cEO8gJ8vgF+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502973; c=relaxed/simple;
	bh=KHZGBTePI06aPYFpJe30SY8OJD30zQRv1KsUWqnJxas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlQuxr8MfpbvP0erWFyrRDPkWQpRVKyxX6wQ83Y0riK/3Xm8T00PbPHBwMwqtFWDJUpgxk01XUFBqg3fuFFOgab8dZcv5bda8q+BQ/w/ADo63zhkZwAOBW1E3GhSD+srZSBjk6dVsxwtQhxqWW4OqCqFGw8OLYaX6vUen0Mtkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E72DA7;
	Mon, 21 Oct 2024 02:30:00 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16103F73B;
	Mon, 21 Oct 2024 02:29:29 -0700 (PDT)
Message-ID: <e7a45262-ec83-4638-bd44-d5605c5b17a7@arm.com>
Date: Mon, 21 Oct 2024 10:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fgraph: Give ret_stack its own kmem cache
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241019152719.321772eb@rorschach.local.home>
 <bf425884-b355-4da9-8e2b-6da693f2760b@arm.com>
 <20241021043738.4d55a6a1@rorschach.local.home>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241021043738.4d55a6a1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 09:37, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 08:58:11 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>>> @@ -1290,6 +1305,16 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>>>  
>>>  	mutex_lock(&ftrace_lock);
>>>  
>>> +	if (!fgraph_stack_cachep)
>>> +		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
>>> +							SHADOW_STACK_SIZE,
>>> +							SHADOW_STACK_SIZE, 0, NULL);  
>>
>> (I don't have any experience with this code, but...) is there any value/need to
>> destroy the cache in unregister_ftrace_graph()? I guess you would need to
>> refcount it, so its created on the first call to register and destroyed on the
>> last call to unregister?
> 
> No, we can't destroy it. In fact, we can't destroy the stacks
> themselves until the task exits. This is because a function could have
> been traced and its return address gets replaced by the fgraph return
> code. Then it goes to sleep. For example, say you were tracing poll,
> and systemd did a poll and you traced it. Now it may be sleeping
> forever, waiting for some input. When it finally wakes up and exits the
> function, it will need to get its original return address back.
> 
> The ret_stack holds the original return address that is needed when the
> function finishes. Thus, its not safe to free it even when tracing is
> finished. The callbacks may not be called when tracing is done, but the
> ret_stack used to do the tracing will be called long after tracing is
> over.
> 
> Now I'm looking at being able to free stacks by scanning all the tasks
> after tracing is over and if the stack isn't being used (it's easy to
> know if it is or not) then we can free it. But for those cases where
> they are still being used, then we just have to give up and leave it be.

Ah, gotya. Thanks for the explanation!

> 
> -- Steve

