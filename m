Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FC6FC3;
	Mon, 30 Sep 2024 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727660038; cv=none; b=GJ9FzUqGhkfqSFQezRh5R6PZROSInrmaWVVliwlGQ7wrMjRQukO7JSk6f07q+rlSzEiZoTn4oIw1rRQFxWzFBSJS6XU85qf4nJeZkv1AUwdqq+6gvb07Fshl5aTLKDEghK+q1c3FwD5zCYaPIPahVzzfNqFRApTQawlyVS/P2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727660038; c=relaxed/simple;
	bh=roVW00bT7xfGdc0pP8uGHYrUwIoTJyPIyEdTjtIb8DY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K+BynpTdd6+cRzuXJ7itNdFbYTAltgoa6gUj9U7OyQgntVXfo31klG1AaUElWGYyzAcujiIv2fYkH3hm1/3Cz+Djve0WtCR0th5503pgrWkqqM7ks4i2IfPY2sAnqta25O+lAFrPJaOLhW0KaLznAC6/baarM+YCLT+SWeTez48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxLOv4__lms1IEAA--.4221S3;
	Mon, 30 Sep 2024 09:33:45 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMAxa8b2__lmisYYAA--.22840S3;
	Mon, 30 Sep 2024 09:33:43 +0800 (CST)
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
 <20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
Date: Mon, 30 Sep 2024 09:33:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qciowMAxa8b2__lmisYYAA--.22840S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF48uw47CFWfCr4rJw48Zrc_yoW8AFyfpF
	s2ya9aqrs3GFZYyrZFyw4xCFW0qrZ5JrW3Gr1rGFyrAan5A3y8Ar1IgrWYyFy7uwnFqFWY
	yFn7tFZrZay5AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
	UUU==

On 09/30/2024 07:15 AM, Masami Hiramatsu (Google) wrote:
> On Wed, 11 Sep 2024 14:40:56 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> Hi Masami,
>>
>> I am a little confused about config UPROBES and UPROBE_EVENTS.
>> Uprobes is the user-space counterpart to kprobes, I want to do
>> some small changes:
>>
>> (1) since config KPROBES can be selectable, just make config UPROBES
>>      selectable too.
>>
>> (2) since config KPROBE_EVENTS depends on KPROBES rather than select
>>      KPROBES, just make config UPROBE_EVENTS depends on UPROBES rather
>>      than select UPROBES.
>>
>> Could you please let me know are you OK with the following changes?
>> If yes, I will send formal patches later.
>
> Hm, I don't completely reject this idea,

Thanks for your reply. I have almost dropped this idea due to my
thoughtless after receiving the reply of Steven Rostedt [1].

> but I'm not sure about the benefits
> to users and keeping backward compatibility.

Yes, I think so too.

> Especially, the latter one
> may hide uprobe_events by default.

Yes.

> As you can see, the CONFIG_KPROBES is
> enabled by default, thus it does not hide the CONFIG_KPROBE_EVENTS.But

Maybe I missed something, AFAICT, the CONFIG_KPROBES is disabled by
default, it needs to enable manually by the users, and also we can
not see the CONFIG_KPROBE_EVENTS menu if CONFIG_KPROBES is not set
because CONFIG_KPROBE_EVENTS depends on CONFIG_KPROBES.

> the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
> depending on it, the uprobe_events menu is hidden. I don't like this.

This is somehow like the current status of CONFIG_KPROBES and
CONFIG_KPROBE_EVENTS.


[1] https://lore.kernel.org/all/20240911094317.4a28fc3b@gandalf.local.home/

Thanks,
Tiezhu

