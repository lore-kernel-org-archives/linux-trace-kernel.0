Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7C81ACA;
	Fri,  1 Nov 2024 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425522; cv=none; b=LEkx3eHGboejcBv0BWx/Jk3Tt4XmMsJ5ZkCQuHGw/nuootYKHDs8GjztcjeahGrzps9H9QPgyS4BJMvCa5Z8ejZvKaduEg249L2GleJnugGB+CnM1hlVvYcOB3euTA+lcmrOJY+Ja7K9j6DMW4PJzUJzkMtbyuGlngG5O89SQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425522; c=relaxed/simple;
	bh=v1nWTFCmEiyff59rTwM1KgU4RA7eNdKHFTNPHxchZcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sdRYMZh/G3jdRGE56YLZIGC2daZRjxAeX+18Kp7U3uhCsGDpv8IeZfCaMyEnVZCHSo0hkWz2FtLbP+Z8R9SLp3UusBHcd+9NqI3XoIFjdfuiseuP/eF8TpBBn3lK6pAN2CPi2fXX7U8aOlqNiEDeZzDwo7FSdeB1UKgtFO4PjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfkDX2f9cz20r9r;
	Fri,  1 Nov 2024 09:44:12 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 7592B1A0188;
	Fri,  1 Nov 2024 09:45:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 09:45:12 +0800
Message-ID: <09e11947-beee-2e4e-843b-53ad7214f67c@huawei.com>
Date: Fri, 1 Nov 2024 09:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] tracing: Replace strncpy() with strscpy() when copying
 comm
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
CC: <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20241031120139.1343025-1-ruanjinjie@huawei.com>
 <af478335-d0ad-40d8-a827-eeb06c1f4e70@efficios.com>
 <20241031114838.02b404ba@gandalf.local.home>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241031114838.02b404ba@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/31 23:48, Steven Rostedt wrote:
> On Thu, 31 Oct 2024 11:12:06 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -1934,7 +1934,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>>>   	max_data->critical_start = data->critical_start;
>>>   	max_data->critical_end = data->critical_end;
>>>   
>>> -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
>>> +	strscpy(max_data->comm, tsk->comm);  
>>
>> make allyesconfig + make please ?
> 
> Or at a minimum, make sure all the code you change is compiled.

Sure, x86 and arm64 allmodconfig is ok

Thank you!

> 
> -- Steve
