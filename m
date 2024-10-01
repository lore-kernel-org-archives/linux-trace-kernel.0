Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE17DA62;
	Tue,  1 Oct 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764248; cv=none; b=ggdvtNOOBzV/Ub9XWrzuIcOyOj2DV++iLl/lzp0J8bxxEOQ5aaIT/VEa5yBYCU1fQz92eXuVaqtpXm9FT43d0ICETNbaHDNBBRp1CAj5rZLFVHgk4LyUeSgullnj76qyu86RiDeXs+qVS3/9CEkmrSbY0lAo6XTTt4Xr8i9UPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764248; c=relaxed/simple;
	bh=aeEMi5y4Wm7t12xkLSyziUL1L+zL5VmxY8/gvt8bHZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASY/OktgFPPVUCweab4X+6l7pssdhoJveBXpNwvlksIJGVZQ2ULeEbti5DsiVzDqr2B/FrK4PyTwcAUR0LMwin8EgDwrAkxMYwg+wg85o/LQryS+D/ct5VKd9x9c3s8r50z4G2cfX4LnMzU4JBRQvTvSSxxT8GVnxC6vYy5q5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.125.240])
	by gateway (Coremail) with SMTP id _____8BxkugOl_tmKW8FAA--.5998S3;
	Tue, 01 Oct 2024 14:30:38 +0800 (CST)
Received: from [192.168.0.109] (unknown [36.44.125.240])
	by front1 (Coremail) with SMTP id qMiowMCxrtcJl_tmbPUWAA--.63107S3;
	Tue, 01 Oct 2024 14:30:37 +0800 (CST)
Message-ID: <10d33d7f-5785-93e1-128d-5ad6ac2e771f@loongson.cn>
Date: Tue, 1 Oct 2024 14:30:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
 <20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
 <f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
 <20240930100630.7894c442@gandalf.local.home>
 <20241001002813.6012587b5e52737a576f1d0b@kernel.org>
 <20240930113231.6c87108d@gandalf.local.home>
 <20241001004307.bc238bbda81907c08a8c1e96@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20241001004307.bc238bbda81907c08a8c1e96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxrtcJl_tmbPUWAA--.63107S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWkKw4Duw4DZw43JF17CFX_yoW8XrWUpa
	4vyFs2van5Jwsayr4qyr1kCayrtrWDGrW7Xrn5AFyxJrnY93y8Ar10gF45uFy7Wr12qr4a
	yFZ2qa9xZayUJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

On 9/30/24 23:43, Masami Hiramatsu (Google) wrote:
> On Mon, 30 Sep 2024 11:32:31 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Tue, 1 Oct 2024 00:28:13 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>> On Mon, 30 Sep 2024 10:06:30 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>> On Mon, 30 Sep 2024 09:33:42 +0800
>>>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>    
>>>>>> the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
>>>>>> depending on it, the uprobe_events menu is hidden. I don't like this.
>>>>>
>>>>> This is somehow like the current status of CONFIG_KPROBES and
>>>>> CONFIG_KPROBE_EVENTS.
>>>>
>>>> The question is, can uprobes be used without uprobe_events? With the
>>>> current BPF work that I haven't been following, it may be possible now.
>>>
>>> uprobe_register/unregister APIs are exposed to the kernel modules,
>>> since systemtap had been introduced this feature.
>>>
>>
>> OK, but since they have always been visible, I would just make
>> CONFIG_UPROBES a normal option and CONFIG_UPROBE_EVENTS select it if it
>> gets selected, and not depend on it.
> 
> Agreed.

Thanks very much for your discussions. I agree with you.

Then, CONFIG_KPROBE_EVENTS should depend on or select CONFIG_KPROBES?
In the current code, CONFIG_KPROBE_EVENTS depend on CONFIG_KPROBES,
the CONFIG_KPROBE_EVENTS menu is hidden if CONFIG_KPROBES is not set.

Thanks,
Tiezhu

