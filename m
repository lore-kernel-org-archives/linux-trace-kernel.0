Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F473EFFD5;
	Tue,  9 Jun 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995218; cv=none; b=Qx8NuUmmFjWU7zWJe0vjPLnLdPt3b1Q6TPdatyVggfPTsrvPblcAgjIPXxy0p6eExtKZ9uciU2m6KKI6fy9VTQgytT6TcidSMR4N9pZVEOfUBBaYvMKnH+E8zitIPfl6ZWYv5RU3Pgndy+cbXsMIdrFrzU6Ds4qgEU5Pc7wy6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995218; c=relaxed/simple;
	bh=CdNtrSGH9Haeb5/QVYSCEdS/CYkTSVRW//fAT6qo32o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb2UEEUKZu40Pb+zcnNzzjlmgtwiZdVPPTcHb7+4n8MxPemakMDfLQmYRWvVcUZO+4wKfEj75bfQTtkxX+7nLXgaQM4c4OHNQaVhpo7A5bpkmFCbGIU3TmoKznfzoGhV4ATKs4T5EGrll1bxhOIuF8uUywLPYkO4WJYSnGnCoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZN3B0PrKzKHLv4;
	Tue,  9 Jun 2026 16:52:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4F8FF40539;
	Tue,  9 Jun 2026 16:53:29 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgDHHYKH1CdqeMauBA--.63597S2;
	Tue, 09 Jun 2026 16:53:28 +0800 (CST)
Message-ID: <127bdde3-7838-4d99-82ef-039b4f187ec0@huaweicloud.com>
Date: Tue, 9 Jun 2026 16:53:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rethook: Remove the running task check in
 rethook_find_ret_addr()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260609005728.458962-1-wutengda@huaweicloud.com>
 <20260609071412.GG3102624@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260609071412.GG3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHHYKH1CdqeMauBA--.63597S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW7Jr18AFy3Zw4fGF13twb_yoW8Wr1fpF
	WxGw4vkFWqk3W0krsFka1rZryrZ395Kr98GFsxG34Fkas8J3yjgr13Kw409Fn5uFZ5GFZF
	qr4jv398C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/9 15:14, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 08:57:28AM +0800, Tengda Wu wrote:
>> The current check in rethook_find_ret_addr() prevents obtaining a return
>> address when the target task is marked as running. However, this condition
>> is both insufficient for safety and unnecessary for its intended purpose.
> 
> Depends on what safety means. If safety means not crashing, it is
> entirely superfluous. If safety means correctness, then yes, it is
> insufficient.
> 
>> The check is inherently racy: a task can begin running on another CPU
>> immediately after task_is_running() returns false, potentially leading to
>> concurrent modification of rethook data structures while the iteration is
>> in progress.
>>
>> Rather than attempting to fix this unreliable check deep in the unwinding
>> path, remove it entirely. Callers that require consistency are expected
>> to provide a safe context.
> 
> Perhaps also note that unwind_next() will hold RCU and the rethook_node
> things are RCU freed, so while the iteration might go off the rails and
> return invalid information, it will not crash.
> 
> 
>> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> With clarifications:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 

Thank you for the review and suggestions, Peter.

I have incorporated your feedback into v3. The patch has been sent out.
https://lore.kernel.org/all/20260609084953.901576-1-wutengda@huaweicloud.com/

Best regards,
Tengda

