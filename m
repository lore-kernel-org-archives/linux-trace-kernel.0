Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001563;
	b=E90JBh9ApHs5avVD4p8BPNbM4Gat/7zDBlF26pjrcr8+AWQtdqGbzsiiC8A6kzivkpDU
	 ZUL4dToz79EthknrDf4AFDWBTUXpz016ugHy3J42F8z/hydED+IL8c8bMIMyKHK86WkIx
	 yLHti8gA/VLxzXnhjIBNqdH6e/rIoOcHQLNS7iZzNDFF8QonW1b8L9W+qxv113ddLj+l9
	 k6KmnN7HaL8vbgWN21JNXKelCcjDNrL7bS2N985gtP2MktuR2vp68yIMVyMPqFV54SdaX
	 sjvCEPQLoPg2xafNU3W+q4vOBkpBcs37dIAniSWXVqytUQdUhuMX0BPTPfkBBRxbkiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=H9Cu/kf3uQAfc3wOhY3cicQG45Gk9MDAfDaeHK7X00E=;
	b=wEfXMN3/S3aghiJy6mvJakE9xqwbnS1uybD7LmDvI6uDJSFAiEqQLNuPdI+yLd+KjjOV
	 I2RZXTTxf9cVvOPqHAeDZNb86HL8Qs598u/odSF1vVJYYEutpQkB7oJ59UZI35XV9qETU
	 VomvLwyZLWgjcJ5jU6LXniapAcFE8NwEWQnnPnG60SBCgx1fDvhqfenJSLi9Pa01uKE2Z
	 u03486W8iKr6S1xCGK1PJfKydeaMOj6mWzgN6mRDOE0SxCNbnz4z0+AZcW7LmqYuC8bH0
	 +Ylrg6WoKFtW7pQ6hpXvUtZnGrjnL88SBAFAR/DG7p4ynrhRUs8q4W6dfVMnbBEf66w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MiO4jiOS;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B8606A331
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 11:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76B8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MiO4jiOS
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc751eddf25so661566a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001562; x=1795606362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9Cu/kf3uQAfc3wOhY3cicQG45Gk9MDAfDaeHK7X00E=;
        b=MiO4jiOSh+izPlb/pD5mMnf6E+AnfPUK+Am2VeZt4OkNeOu10ClNnidnE8xaC0lGWQ
         nGA4z/X3MtrsrTxY0gMXenchWlLtDIfK9w3NuHacwElr4aGbwDyHz3j6B5DBapuOeYKo
         jcWdB9dWo24fWmVq/yEdw5/qWKypllnpF1UiFVz3ICLySzOFgv7jZNUzh4q+YLgYCa5z
         UPa4IlxYIHYHXHEwlJHRQ6GiLHAHs+LI7rzenJjJy128WSdLTlw/VGgGi5PgmJuh66Wo
         2eDao3w7OZYB79Y59lJIYxfqi7nhB8xAFUks+IWy5HoY1T0syiXMCDJ9Q1ZkFmkIP9MG
         Fymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001562; x=1795606362;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9Cu/kf3uQAfc3wOhY3cicQG45Gk9MDAfDaeHK7X00E=;
        b=Q5SE/oRzONgjTpSsflPGlie/xuaal583hX0uU7ezeb8G0RGcQjus6vTjUmjKNqvrtX
         YOfgvYMJH6X5TIuSlXDYYDTxoljMS9TZRimS0PhkBoDwd5RCwiZzRkFpJ3bUp/YdhlFF
         n6zql8SiKRsrxTlkiPD6G104DsuyujylGWNUZ39WqQMd02jhvDsSllqMzkbzxWUHTOCc
         cispwylLnt4EMTR0EYdctIR/AJPmZkbsQUSYG8NPQzEVf7MEnNyjdJYGJ4NUwerqJeWb
         6KSceLqBYQChsY0VFoSlrnChZVSpiiASNhKRuYvJVCLqE3/iGzC3rL9seA7Rt5+y51TY
         II/Q==
X-Forwarded-Encrypted: i=1; AL+hErHcoyA851rkUI6dZsAVfI8uNOOBbemR2oOrmD7wTWnXQ1HmZk6Ljnl5wKR1ijXhjQP/zX5cz9xJNG3oSJFEFxuN494=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gwMXX5cLE8QrL/Z1aJVqS/Vxh77vgJhAlmFEkSGpy4IYj9R7Z
	sc0M30vZX2QlRhV8G0upvhop+E5nEGNJRyyoYZJsDOt/JixOakb7sXxW3reXnw==
X-Gm-Gg: AZFdTZeacCKW8phpelhP1mOq306xLklMz6y2tfMxaIrNPZWQxKq5/JAbriC1Zeix7NM
	QeWn2gQyN53ChbiBw4QTvPJwMzUTB2DYL9o1NJvPkTezJm12xkwzLy6A/pM6ihtelw8XLXmRTKH
	gL5f00v14vhROKRq5Eiw5ItlDFGgq0Pn9jDxWs7JucT1uaRGjiCNWeMxlhwt3qUk0alcHVMDsug
	623OXyQHWI3X+M75nL3FRsAYSO9XBWNVEB+qo54yLYN4U8P0da/eVbSLRNXoTfELtF3zMUoCmu7
	rX1+IkBEI+67Qxie4EyULypNcDCpjdeZJo66Gt3Bkuop5oGEFgzTHzLh7OdtZTyIJZHqYMG5Jq/
	JfWJe6NtpM1TiWb3WIwPyIKkoy+rZO9x4T22HN2B30y0N2lbhdVTVlI5b1Y1gsDk6vCNQ4XcD/D
	KiWLDpKByukh4gc4a5r3XDjqmFdvnmjVUF0PFm0FaKtKm6OKdVqhkhgZ9nwnHTahWhWBC3JAvrZ
	AaZajH7R2KZmwT+X6J9La792kgvIUhPhG4QctSUj9FzTEsl+FF8KmfH72CWAo1SuIvNVDJ1PO72
	vhxfmKvTp78gRRmbZe8ah6AG1PmyxKvxAXLcujQjEzPY1iXztIZ2ipb4UGfqcdxaR6ZRKA==
X-Received: by 2002:a17:90b:4fd1:b0:3ac:8ee9:c8ed with SMTP id 98e67ed59e1d1-3b3d074e3dcmr2653572a91.13.1795001561953;
        Wed, 18 Nov 2026 03:32:41 -0800 (PST)
Received: from ?IPV6:2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7? ([2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm4024123a91.12.2026.11.18.03.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:32:41 -0800 (PST)
Message-ID: <0c859418-ef73-4870-a45d-66137882ab74@gmail.com>
Date: Wed, 18 Nov 2026 17:02:35 +0530
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] openrisc: Add utilities and clean up simulation of
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-2-sahilcdq0@gmail.com> <au7I8FNoMcsoh54X@antec>
 <52c3ae66-4165-4fc3-a440-fcb76931382a@gmail.com> <avkHMp3Qa_C01Nd8@antec>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <avkHMp3Qa_C01Nd8@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 6:43 AM, Stafford Horne wrote:
> On Fri, Nov 13, 2026 at 10:41:56PM +0530, Sahil wrote:
>> Hi Stafford,
>> 
>> On 11/7/26 12:15 PM, Stafford Horne wrote:
>>> Hi Sahil,
>>>
>>> Thanks for your patches, sorry its taken me time to get around to them, my year
>>> since summer has been quite hectic.
>>
>> No worries. I completely understand :)
>>
>>> I will do the review in chunks so give me some time.
>>
>> Thank you for the review.
>>
>>> On Tue, Oct 27, 2026 at 01:42:37AM +0530, Sahil Siddiq wrote:
>>>> Introduce new instruction-related utilities and macros for OpenRISC.
>>>> This is in preparation for patches that add tracing support such as
>>>> KProbes and Kretprobes.
>>>> [...]
>>>> +
>>>> +void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
>>>> +{
>>>> +	int displacement;
>>>> +	unsigned int rb, op, link_offset, temp;
>>>> +
>>>> +	displacement = sign_extend32(
>>>> +		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
>>>> +	rb = (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
>>>> +	op = get_6_bit_opcode(jmp_insn);
>>>> +	link_offset = OPENRISC_INSN_SIZE;
>>>> +
>>>> +	if (static_branch_likely(&delay_slot))
>>>> +		link_offset <<= 1;
>>>
>>> Why do shift left here instead of += OPENRISC_INSN_SIZE? Since logically we are
>>> adding one more insn for the delay slot, not doubling.
>>
>> Since link_offset is initialized to OPENRISC_INSN_SIZE, shifting it to the left by 1 would
>> update link_offset to 2 * OPENRISC_INSN_SIZE. This is a little more obscure than explicitly
>> setting it to 2 * OPENRISC_INSN_SIZE. Initially, I thought the left shift operator might be
>> less expensive than multiplying.
>>
>> I was going through mor1kx's design and noticed there's also a pipelined implementation for
>> the multiplier [1]. But it looks like the implementation for shifting is simpler and can be done
>> in one cycle. Please let me know if my understanding is incorrect here.
> 
> That's correct, but my suggestion was to use += OPENRISC_INSN_SIZE instead of
> 2 *.
> 
>>> However, It may be more efficient to avoid using the alu and write as:
>>>
>>>          if (static_branch_likely(&delay_slot))
>>>                  link_offset = 2 * OPENRISC_INSN_SIZE;
>>>          else
>>>                  link_offset = OPENRISC_INSN_SIZE;
>>>
>>> what do you think?
>>
>> I am not sure if I have understood the alu part. WIll it be more efficient because 2 * OPENRISC_INSN_SIZE
>> will be optimized by the compiler to simply be a single number? So no alu operation will be required,
>> just one store operation?
> 
> Yup, since 2 * OPENRISC_INSN_SIZE is a constant expression the compiler
> will replace it with 8.  Then the above code would be just one store operation,
> something like:
> 
>      if (static_branch_likely(&delay_slot))
> 	    link_offset = 8;
>      else
> 	    link_offset = 4;
> 
Got it. Thank you for the clarification. Based on our conversation in commit #3
regarding delay slots, it should now be fine to remove the static key and handle
delay slots unconditionally.

>>
>>>> +	switch (op) {
>>>> +	case OPENRISC_OPCODE_J: /* l.j */
>>>
>>> I think these comments (/* l.j */) are no longer needed sinc you have
>>> the named macros.
>>
>> Got it, I'll remove the comments.
> 
> [snip]
> 
> Thanks,
>   -Stafford

Thanks,
Sahil
