Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913728;
	b=OFmmO5POZZTwq3gCyL8klqe8yjp9Sjc6wD5sswDDPJVc+i36RQAjb+VUGjsA0ntQ+w+E
	 63BD9Ib9Lu9LHWVhZSM7u6YoTIiFm1WpcQiUGMWfvtp6BmJo11y5GWfCAsgJKwaILKNNX
	 migqUm2WS02Qqd3bPfypVkbI+VfPHmwU8N3M20zcktnycQYd+JCoFLpPtPNvhN1KVYdry
	 zPnUhkjmruks2i4QD0cTtXIplawdD8JdTLylLi9897nC06YBpf2Anoowzkhq6RLYpaEef
	 454uAqDuntltDOYpJwOmP3Q5rVq0zM7duhYEBTkkegGF79WsYDHd1OoOOVXJu2RYaAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aBGHCZkustJPVUltaen+A6WhD/Flx68KUOj5TtSCMzI=;
	b=Gj4Uh2a8HN2G+zUStNo7jW2pmdDhGWCZ0lF+mezJ4MBDm6JRMtWivN7qwb65lAMvEC4p
	 PMEtmsQ/NYVqGSS+NrjwnDKC198BDEuh0+a5xxnwk+6dvNKEmGvhsOv4fHkXcLuQoB2BM
	 OMLVMkv/AwhkEga9Tj4LX0x7P9cQzard+msU1NgRvR4e3Hch84AQJphAo/EvQ55T5gJsT
	 1JmlSd1NwivZogiOtxXTFk1rRselBVlyO/znsk4bKZcBTMW4ImUguKdPVhO4C1ItmtNEZ
	 Kplpxj2JnxMDBJyvO/Qh3F6hCpRoST4TguLNN+9wzDEbq3sfSNI2ru6lXGRr7qeAx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=M1zRf0uf;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEA606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 21:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BAEA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=M1zRf0uf
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8479f46ecd8so14843a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793913726; x=1794518526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBGHCZkustJPVUltaen+A6WhD/Flx68KUOj5TtSCMzI=;
        b=M1zRf0uf4eSX65ttB1CQosJZYv4SX0ATNjnBtizp7BgNgAmlUv4HoVyZ/BSNmEQ3DS
         +wArByDyEFOgk6/XKSsQd+s17ECPk9EKKQFsTNZw2Hm693x7uNHNKUldZ2lIAWD0bpmq
         VlYvM6A88fLa2vtc8V6TXqtLb0WlLFYbP4euI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913726; x=1794518526;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBGHCZkustJPVUltaen+A6WhD/Flx68KUOj5TtSCMzI=;
        b=2GcnXu0Ot44fuAWEyOOv1yrGC2DpIralOtO2kI/NfCiekha8r49V0/KLxHH2J+tDvv
         GfM6cHOsEyxrJPArWF7VcIv1SqPsuhYr6wTkefaIJeuo0Rh+GJbOfmQmmmPla7FC0lu8
         ZVUPbr1WMEcIYLB44vWHW000bMdl3Or0JGFh/M68ccaBu9KdOge3pqzgoZwmvwSARUl/
         oACohu2I+gmI1sKKToMxbx3oNp/SOYX0AfYrY3OhqTA97mMqiTsODuPXl2PHZ/SQ+WhH
         Et0ndB1yFAKsnTHRZ3cL6GQTMGFPheuWD9HmyNjr6/AEXXE7dvcvnQDaLRCYfHrMLz93
         74QA==
X-Forwarded-Encrypted: i=1; AKwUvByEMPM8Z09c9Eda9wE4H89EATY8vgnQTNaDUXBGji3CMFBP25DT+lq9XYHGSb0RGBQ8jSVfSaPImg4V3UmuL5ZgFhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gGDTZ2kwORbiXBFPIGD4oxir8ckVw0w+XZXMUaZE1uvmwTdwR
	OGMuSaOQzxRj6iNQsO9cxpFMBx5tub9cg2Vblx66TQ5ByLOp15X0C1udmkf7quU4fXE=
X-Gm-Gg: AYBFou22qRw0ZY0/cjfFWKy1rtujF0d2Ry/+ryvJ2ZYFRWhnV8aBSsqAXSO9wfLz9SD
	fdbn17lNGYh5pk6bTileJgsC9FLBTIaVfxqpAyL5/MbpQfef8xN6bwo3HCjaZ94G47nIizckcry
	zHAYlBthLtQJ+WbaqN3epur6ZspTbEM+D/ISP5pMCZU5/oqnY2SkFqSb99Vua3zcc4b+WGITgfH
	uppbC5iE4PYAfWpZIhAjxA2z9tz1m0vGKbBuLFaay2kn0gP0ikoL7HRdBlZN4E7S8DkBzVsCwdj
	mU3UwX3bOwVtWX6svB7UkGPbPZy9U6Q5AZz+roedhFhUnJ4TEBqv5jMHn50jq304HQTzbR2RS76
	YuKZ4gCVFF7dgcajBUM5l11ZB7TZXEC0IsbRM8fZDE1hp2RRu2rGx2ZJ5YR9LzIHzyNZfcWITp3
	8prG00DMjW7Zhax8HjhU8nLzUF3k2jNCSx14GL5R1FE+7aLCu8Dk4//eVv1BTaPBbb7IvVrgPDN
	sbyp/zsU2dmp2hpG8AqBSDO743a3/eJxNBSvP4+3sv5rJ6cFvhOtaCeWmjqg+GBWklZEPojPFdZ
	oAe5ewQSTSjOakUNJkQPMnsfoDuC/dy48t5jrua/PKCc9KP8oIZGl2ql/vLJhg==
X-Received: by 2002:a05:6830:438f:b0:821:94d2:83cd with SMTP id 46e09a7af769-85f1cee4f2cmr703548a34.9.1793913725956;
        Thu, 05 Nov 2026 13:22:05 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbf375dsm338315a34.13.2026.11.05.13.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:22:05 -0800 (PST)
Message-ID: <7de6d2c9-0f2d-4f7e-a2a5-30eca1b42bfd@linuxfoundation.org>
Date: Thu, 5 Nov 2026 14:22:03 -0700
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
Subject: Re: [PATCH] tracing/selftests: Fix false bashism in
 kprobe_non_uniq_symbol.tc
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sven Schnelle <svens@linux.ibm.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20261029211218.3749963a@fedora>
 <undine-1793665155348284042-31145736d231a8b5@undined.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <undine-1793665155348284042-31145736d231a8b5@undined.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 17:19, Masami Hiramatsu (Google) wrote:
> On Thu, 29 Oct 2026 21:12:18 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> The checkbashism is giving a false positive to the kprobe test of:
>>
>>    ($"foo" should be eval_gettext "foo"):
>>    if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
>>
>> This is because it sees the $" at the end of the grep as a bash symbol.
>> Instead, escape the '$' with a backslash as it is within quotes and that
>> '$' is for grep to process an end of line character and not a bash
>> variable.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d22c3e0088e85 ("selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc")
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Oops, good catch!
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, can you pick this?
> 

Applied to kselftest fixes branch for next rc

thanks,
-- Shuah
