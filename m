Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F81379EC6;
	Tue, 14 Jul 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030247; cv=none; b=MgJUy1sev0oWGy7Ah8E5RdJIwZ90Lz+QAaKNXgQAtXeZ1EMxtJhYQxdRsFezB+1zoMnk6sayhpmRFx8c9dXh00m/YjFPs3PY8zJAEBCQiksflE9FILVxGuuMbNr9YHWOSAqlcArbTStvIvwMWx4qcpKlZxXj62cUwoz8GKtVxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030247; c=relaxed/simple;
	bh=oFKBju0M5pJzSC+zTDI6PbjVmc0ZLrZJ8dP7jCO3SeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB1q+UAdB7LMWFzDV5QMMxf08WLJbePqmTt6qT6bpj7lAAAP0/gFn9M/CnI2FN4iBV5JLRRV0ep4HomJm2+k76UJAIBz48tGuGUQNGmWPS8rU5vJKZ1kT4wS8hmZlFuMTcLgQ1dS+UhRf0RHrjQTbpyBJL+oZQpjNksTNgwPVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzyTH0wjDzKHMRg;
	Tue, 14 Jul 2026 19:56:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BEB6C4057F;
	Tue, 14 Jul 2026 19:57:21 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAn8aEgJFZqn3HFBA--.16095S2;
	Tue, 14 Jul 2026 19:57:21 +0800 (CST)
Message-ID: <12298259-cca6-4244-bacb-ea07958e19b7@huaweicloud.com>
Date: Tue, 14 Jul 2026 19:57:20 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
 <20260713153624.48fc4be4@robin>
 <ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
 <20260713221318.63f741ad@gandalf.local.home>
 <059bee5e-6852-4afb-a993-dd5ddcd86d3e@huaweicloud.com>
 <20260714072440.4ff92b33@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260714072440.4ff92b33@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAn8aEgJFZqn3HFBA--.16095S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXry5CF1xAF45tr45uryDWrg_yoWxXwc_uw
	4F9a97G3WkCr45AFsxtr17XrZ8J3yDWrWUu3sYgrZIya43K345KF1kCrn3Aa1xtrZ0kr9a
	gryjvr15J34xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/14 19:24, Steven Rostedt wrote:
> On Tue, 14 Jul 2026 18:16:26 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> _Approach 3_: As you suggested earlier, build on v1 but add proper lockdep
>> assertions to enforce that the parser lock is held by all callers,
>> regardless of how the parser is used.
>>
>> Approach 3 seems cleaner and more straightforward.
> 
> I thought about having a global lock as writes to tracefs are very much a
> slow path, but I think Approach 3 is probably the most "correct" fix.
> 
> Yeah, let's go with that.
> 
> Thanks,
> 
> -- Steve

Thanks, Steve. I'll spin a v2 with the lockdep assertions added.

Tengda

