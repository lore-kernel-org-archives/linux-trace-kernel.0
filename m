Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DF7261E;
	Fri, 22 Aug 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826549; cv=none; b=ARCcjije5bt924QK4FpQhOARd0gall4ta5jVCjp4WmQy66oLrGKiFxmsT+AbpMm1ybdJ4vdxtVSEPj5kIi1hKdt/eWC1cVvcXT37emIog/YZf3Cxc3GGGHU4zrvTc+u52fnwqqSp4mfgEy68kruMhzUN8ER7bJ2KHCx78nWRw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826549; c=relaxed/simple;
	bh=JalOgAPy+10ijoEjkUyxw2IZaQ73SnV+0ZOBdc0KXz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgk6jV3Rs7jkhFCMVfCwZbXTi2Iingslmz9QcnIdIlnuLTdXEUYMNnNEZa8msZuwXUqSQR7o7cwvx9MeRZs5fMbl0M7zHg+uE/LsBcQLHSVtwkeHdULX6a8CB5KnGgGzNd1x/FHUyS6JwZNXHoBDx6zUi18vDNCYzKKHhgbUAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c7N746wB9zKHMww;
	Fri, 22 Aug 2025 09:35:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 763841A1724;
	Fri, 22 Aug 2025 09:35:44 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgAX3w9vyadomKT9EQ--.7615S2;
	Fri, 22 Aug 2025 09:35:44 +0800 (CST)
Message-ID: <edc9900c-b2d9-49f9-bd12-cd44f11b89a1@huaweicloud.com>
Date: Fri, 22 Aug 2025 09:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ftrace: Fix potential warning in trace_printk_seq
 during ftrace_dump
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820090017.2978279-1-wutengda@huaweicloud.com>
 <20250820101054.50c0b8b8@gandalf.local.home>
 <40bcf20b-e2e6-442f-bfd8-bb7ad6245397@huaweicloud.com>
 <20250821105113.1536d567@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250821105113.1536d567@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAX3w9vyadomKT9EQ--.7615S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzV
	bUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/21 22:51, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 09:53:53 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> There remains an edge case that concerns me: if size is 0, setting len to
>> size - 1 would cause an underflow. Should we handle this edge case?
> 
> When the trace_seq is allocated, the size is set to 8K. If size is ever
> zero, then there would be no buffer. So no, we should not worry about that
> edge case because if it happened then we have a lot of other things to
> worry about.
> 
> -- Steve

Got it, thanks for the clarification.

-- Tengda

