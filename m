Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111A3FB8B;
	Thu, 31 Oct 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339258; cv=none; b=Ha1PO3vdmW5Clxg/knLY+tjzGCEq4rqM5ruZKt/1+Hg/TtfwiK7SgoPnowRXM/cxHkpR8m9Fu7LZTEysdaHncF16LDCleaySWCiq6QCgA17W/fNe9gBkZdu74L25tq8ZBCABb/7Rf1hxv7LGc6PkDYKEFT3btHB9Ny8lnPE25Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339258; c=relaxed/simple;
	bh=Q5MfpmGX5hkWyHpglOjQkPw/CXGNuTq7gRN5CV+ND6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ul/Vp5+E3ipYdiUQk1ifWOyUqaz+RJxhm9P8BRvlPC6wuasSHxE2RpC00SoA15vsf9Ap5R2IUVNMWqAvoUUN5M0+ynJrEPyWp1E0/5RKLa9XOqVEFPsiy7Y+zt/76pT3OdzRjRY9Wj82xhVZ1e+iXHEfm7QHWCppABUvqFqimEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xf6Jv0zByzyTxZ;
	Thu, 31 Oct 2024 09:45:51 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E1C421800DB;
	Thu, 31 Oct 2024 09:47:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 09:47:30 +0800
Message-ID: <0ccbb6b9-27a2-7afc-c47e-4ac9c71a23b6@huawei.com>
Date: Thu, 31 Oct 2024 09:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tracing: Replace strncpy() with strscpy() when copying
 comm
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20240731075058.617588-1-ruanjinjie@huawei.com>
 <20241030194006.4d29417c@rorschach.local.home>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241030194006.4d29417c@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/31 7:40, Steven Rostedt wrote:
> On Wed, 31 Jul 2024 15:50:58 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index 6ece1308d36a..4ee0e64719fa 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
>>  		return;
>>  	}
>>  
>> -	strncpy(comm, task->comm, TASK_COMM_LEN);
>> +	strscpy(comm, task->comm);
>>  }
>>  
> 
> Was this even compiled?

Sorry, the trace_events_hist.c was left out, will fix it.

> 
> In file included from /work/git/test-linux.git/include/linux/container_of.h:5,
>                  from /work/git/test-linux.git/include/linux/list.h:5,
>                  from /work/git/test-linux.git/include/linux/module.h:12,
>                  from /work/git/test-linux.git/kernel/trace/trace_events_hist.c:8:
> /work/git/test-linux.git/kernel/trace/trace_events_hist.c: In function ‘save_comm’:
> /work/git/test-linux.git/include/linux/build_bug.h:16:51: error: negative width in bit-field ‘<anonymous>’
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                   ^
> /work/git/test-linux.git/include/linux/compiler.h:243:33: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>   243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>       |                                 ^~~~~~~~~~~~~~~~~
> /work/git/test-linux.git/include/linux/string.h:79:47: note: in expansion of macro ‘__must_be_array’
>    79 |         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +    \
>       |                                               ^~~~~~~~~~~~~~~
> /work/git/test-linux.git/include/linux/args.h:25:24: note: in expansion of macro ‘__strscpy0’
>    25 | #define __CONCAT(a, b) a ## b
>       |                        ^
> /work/git/test-linux.git/include/linux/args.h:26:27: note: in expansion of macro ‘__CONCAT’
>    26 | #define CONCATENATE(a, b) __CONCAT(a, b)
>       |                           ^~~~~~~~
> /work/git/test-linux.git/include/linux/string.h:113:9: note: in expansion of macro ‘CONCATENATE’
>   113 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>       |         ^~~~~~~~~~~
> /work/git/test-linux.git/kernel/trace/trace_events_hist.c:1602:9: note: in expansion of macro ‘strscpy’
>  1602 |         strscpy(comm, task->comm);
>       |         ^~~~~~~
> 
> Bah!
> 
> -- Steve
> 
