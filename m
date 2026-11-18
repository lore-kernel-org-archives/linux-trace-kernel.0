Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001215;
	b=sQfs0aMjuvN9Srw8sIh66hJsCW56dH8NzjkSkTYXn4/nMoz/8mc08ebUKD1Hw9oV7+Tr
	 Hyacl/hAR6BzgxXZ9aVhMeyzXbVzUfRJfwh9ikUYUZjNniL4B3LUtnp+94I59dud0RzUl
	 SA8htmbT5L67AVaCW4cMBYLkOOi9HgGYNXci+IfLZ8EjKEc8oqDdBeuj6zebqrUW+Q9Y7
	 JntWgt4uDDovou5wEleLv6Bc/zNP+HaNkXeiZZHKT83I9DthY+tuT44qOxW3qoc8SD6Fs
	 gXu42V+e3JnuukQFBraZOTuKNZTA9aJpj2UpEJGCcCFWJtuvBCfEPgWttNAQsNE7svw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
	b=R0XCXwlRUGHMqrPcXiEpXzH4KsyRxHBcJmWwrB+phfBCKgUfGyB7/+ZZXo4FxBgbC78E
	 InbmCxYxueNlisx5AhOOkjYSEMkwvqBYrKypf+HwFhSKzQ9De/M8T3BOe4Z9OybxlHIQ1
	 5DIecpNBIZ7lo1U6NRNebth/VN0kDFuu1gNrWyt87X3LutJjsOtPxMBC5wgFw7kf7oYmo
	 nsnlHJYXKmM92N2ZG5tZcWVEReGGBKqvBxA80noX8MExYodb59FT4zd/ZtOCmx7FbaG/v
	 YxAcwcrjqh5U8itZXsSaZBuio4g6Ob32npvAHN+Hr9jN9+/lDVoqc/bLlPYUhLfNVLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5otasT3;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B760A2620
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5B760A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5otasT3
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab938dc83so467938a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 03:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001210; x=1795606010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
        b=P5otasT3x0KiFi3TS4Vwf6vtcEOMgiVWP29dcN/e9s7NBmiEG7HdrHGZImmidMDo5o
         5xU+BvlKcj0+KXFWFEC6gq77MtAhKse1eou1ji4Zd3lSWe8x2gQiVXGBx0eaaDdXC3I3
         wD/SMzHcbNyQGxuokrJROPQ7UU26BYymJf6lubkRav7AWx7Vn2P5Vi6z94wCSxUojU+s
         +xApZYHKHYnFFfeCQ7t+Q6hM32sj+uTaXL5J+NtlmYzf2R1JsVDdgFZqZiRmPH4jyDNX
         TVXJxEdQW6qA8P98NZx6jAwMpmvFTLN8U3ybDvWsif3nBIrOCjLrCqyesYadO329VCr+
         tBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001210; x=1795606010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
        b=l7GkHlvj74lgpSoAVSMei1qyMsMbFxVbewc9X+gqe9r+15EcEzZk6UI3Jtjuabl74f
         3CGZHGpf2+jwV98ubz/BgdJhOMisrUIdFzAxT6Tzr6dzRJ7trAGDvLbv1JHJ3JK3NH51
         ZbtjinO9ra4RJKv1prPoPXcL0/Netfn+qUH7K7TLLijH6RN/1xHb7Ed/kQjG8hJtjaJ4
         0AJsw14okujd6Rx4cv71mNij5/3q5Ar2ITrtdbc4FjgXTyEI/cc+JR5S+MlCafIDove2
         doh1gt9nj96H2My5INS8MkbOxZYzdLPOmw5Jh1dHy1ZODV61wTgLPeL9v7496EeFKDxW
         TmXw==
X-Forwarded-Encrypted: i=1; AL+hErEF8TLgn27fkk6y5EAf5BiVUzLBtHLjVyZdsAVpdLkp8x1VwX65oMLT+PJllKqm3taBOJt+xg4pN7WLFDYsJatcaVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gIpWdBcZMjRhX+LwO+S0KAaK18CwT4cbXoqa1Rf9638FqDuHH
	WO9PzkrM/Km2vcONUgQW3Fd+lMgyWs5rwHsb7oLcihwStXPYErl7HuSW
X-Gm-Gg: AZFdTZf9oFAqW1vJS8XnrjTXCyGGXkeUF2+vCj4TcwURFIFokTgEstN/jc0Sr/GNyoV
	X5D5E/Q7nfV711H89bNTHQSjoHmLo3sNmRO7Qv2yHMIK9qWsxwULBRQCq10So37O4H6oZL2t0QS
	7SUJEV4abMXxy1O3FwMkqed2LgLOlnVE67ZvJgdAG1eo4ch60QF+IF6PCsQ6wHxdTDCNPBjrWLu
	2HNUJ2n7inCYqQ5u9tyLFLGiKc3zEGDUoRwEyqWBVrqrtHXIU+BTpZYe2+gU/kJGXDeqq0lyc+O
	eQ66QjDSNS9c8jdbzC2uab7Qv3V64Fu/6dkK0gf7JoI4WC7f02gwTutDlJ7wgJJ7qvcx0U10Ewx
	5DkwJ5ZWbwsLwSSNuUAzOQwqf/4toHtpCNXPkVrapBt/0nK3P6nqmVVVsKQo25OTR/NuTBVV5N9
	uRb/oZ0K3EZIIrjrvF2U/qqqaCkX+OSezuvVhDmTww/Z353cK8pneh4JjPUbeSAu0r/MIx/WTwd
	OMGiMegxwCyFhKm1lG37HKxIV8POiSeB1T3Djf23ObgCp7cI8H7PUh6UUvrFaZ+EXTv/x9bwGc6
	0zUBFtHLRTA34eWNBdUwa9xgws3n+Frne373ySO98s/Ngv+M3TVfgDMe+XK1E0o/4wp1
X-Received: by 2002:a17:90b:440b:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3b3d07e3950mr2232429a91.58.1795001208717;
        Wed, 18 Nov 2026 03:26:48 -0800 (PST)
Received: from ?IPV6:2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7? ([2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm3997301a91.12.2026.11.18.03.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:26:48 -0800 (PST)
Message-ID: <fe93e84a-1876-4416-b3cc-547b9816c865@gmail.com>
Date: Wed, 18 Nov 2026 16:56:41 +0530
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
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com> <avAsy43KVO-7Nm9z@antec>
 <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com> <avkQctt0CKt3YcsH@antec>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <avkQctt0CKt3YcsH@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 7:22 AM, Stafford Horne wrote:
> On Fri, Nov 13, 2026 at 10:45:03PM +0530, Sahil wrote:
>> On 11/8/26 1:33 PM, Stafford Horne wrote:
>>> On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
>>>> Tests already exist lib/tests to verify the generic functionality of
>>>> KProbes. Add unit tests to verify that KProbes work on instructions
>>>> that require simulation in the OpenRISC ISA, and that the corresponding
>>>> delay slots are handled correctly.
>>>>
>>>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>>>> [...]
>>>> +
>>>> +SYM_FUNC_START(test_kprobes_j)
>>>> +test_kprobes_j_addr1:
>>>> +	l.addi	r11,r0,0
>>>> +	l.j	2f
>>>> +	l.nop
>>>
>>> Just a tiny comment here about indenting the delay slots.
>>
>> Got it, I'll indent this.
>>
>>> You could also use the delayslots here, for example:
>>>
>>> 	l.j	2f
>>> 	 l.addi	r11,r0,0
>>
>> I initially thought of that too. But then I thought by keeping l.addi
>> before l.j, I would also be able to test this for the case when
>> there are no delay slots. I can reshuffle the instructions if that
>> test isn't required. Please let me know what your thoughts are.
> 
> I don't think it matters either way since these are tests.  But, it would be good
> to note that in a comment at the top of the files where you want to maintain
> that convention.
> 
> However, thinking a bit further that may be hard to enforce down the line just
> for a handful of files.  We should assume the kernel code uses delayslots.

I agree. Since "head.S" and "entry.S" already use delay slots, I don't think the
kernel will work with a CPU config that has delay slots disabled. Also, there
should now be no need to have a static key for "delay_slot".

> 
> -Stafford
> 

Thanks,
Sahil

