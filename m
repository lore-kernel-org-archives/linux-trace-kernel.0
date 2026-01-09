Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F83346796
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999099; cv=none; b=Qbz4FQ9g43XLITThEpaFc8ddo/xopNrEkuVq01WWi+IDXNX7IqFUvcazOqC4CUfBYQ2eZbeVUrbzn05+O0kN8r6kJgOlAddGo2GPvIzwYDlAmjg/UyCgzBegLR5HgW9WYrdeTsX4T75UxdLUI1Qq1ZcI7tMYoq5Eznjy1ZKHdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999099; c=relaxed/simple;
	bh=FxBy4FZqdwNrjXp7kUgNP2DTPQwGCA11DgvPugnUAQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMTY/Xc+KUsenykaHcN2vWcxraYW+qyydUHi8zcZ64hrbvOdBNH5uPZrvDM2B6XRuvEo+TYkAPHNQj3aKkvB34NR1aojXI4GmG5ZrOjaREhxwuWoLq79pE1vC9BCGSGsSDaW37nocSjwFx/GaJLdEyuaw+z8pVanvN2oEMhxePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajACC4zp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajACC4zp"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-450be85b7d9so3089363b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767999096; x=1768603896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qqxdc3iSw1oDJtxQ6sPbrPeu0O6MQwhvX4RqMc6t0PE=;
        b=ajACC4zpVV8JO2n5ZkWe0gZIvLd5YBX2/c+xd7zOxHqhaooazmFovM4mPHeAMh/oud
         mwaEVf6k7QyUOzDjvRj8I6tixhlgtfKVadoyQO0EWhUQ5BJ7xfIdz/d/CNL9Nv0tNDKK
         r0t/ErVQopgSjHf+Ut29aDcVfq2wa6RYPykkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999096; x=1768603896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqxdc3iSw1oDJtxQ6sPbrPeu0O6MQwhvX4RqMc6t0PE=;
        b=aidTFki1YKx7f4BpIOIlRY7/8CFeNPFYh1gOhMnL9wuZWz/5a8o3dErPCR+kYmTDd3
         t5JjWB8OJG8wC/X/6KrXHK+OHfhtqsEAgAm5/TFX4Wo/VoKpyJCbJrYGFV5i5KfXXEiJ
         3UlDx59m5s1H8stPxapqUftbvXPsOdaithcuGpvNRJSdlWj7T7lfGSGLGRfOuY1jcOiH
         p3Y00ZE/3QjIDqeIvdG7j/tqbYNpKYM1RsCr2L656OKDww2l+qLD+yvQLiJXUUxhYq+S
         d9Pnx0b+T8BPvtpdoIb7gmjkggWrcYke0hm/GDvxM9GPDzIkU/zP9G16tN3ewkIa70SQ
         bKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Nhkv4k19Qg9gsCz78l4jlen1TrFclEPYX34bEZpbuJAN2QPrWfWeiDEZJy+T5BGbzAWRk83CxrbGpWYzhCX1MH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcmex+IF6/maTkvviSE9fJuFA86dzW7oK/lYDFnj7qg5ULwFWA
	I04uLfrqp8dEqpaEnEU+wIMnGhKZI4Pe8YKvW0Cf8xVQcoJr/hRQzPUS+sbBuo73FVo=
X-Gm-Gg: AY/fxX42S8Q91v4tw68m2LB5xlkJIL/Lw6pBS/t7yiCgPVtDWcjhPCv5u5meghgaRPi
	Cq+j29vwqzSTvzLZqtXThyRCMKlCaZ2X2HgmAeUr0BM7rZZUSwcCC1PQ1ly5e9HaIP+1x6Os3Hj
	zGdRNY4c2TwJQLH7rkFjZ07SQ0LUMZ40jh9WVer6p9HYJ44ZsxCHxPOyIzU4BIU+CVT+nbQXko8
	PVVBWt7MVyOuT4/ylbvs2EntYoCsdP/JbWxSqMqx7e/t8gcNwmS9gUmCReylXiAbtPkWWkGBzDw
	B00O3fL8aC1kjafpKEKGTxpxOuD2Ds08xLdlMB7D63fYyHW2aWyQnlXGrnZX6x5cNRoTEWVlE7m
	g1pgAkdW7hM1EVq617/nkipfDJjvVU/nnBWhtEoWPibjeQ/ZuiZD8VcrRs2SAjJdV4hjD8B1XdB
	VF+8SbXZd/Dq5JmmseW5XCba8=
X-Google-Smtp-Source: AGHT+IHHPWtAASdfA2cFXKfe0WnH9UpvIrOeltbh6InlGG6D5LTffSmeRA6Rg1LT0cGbIBcuXn49rQ==
X-Received: by 2002:a05:6808:158e:b0:442:82:3efd with SMTP id 5614622812f47-45a6bd690b2mr6631377b6e.18.1767999096215;
        Fri, 09 Jan 2026 14:51:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e8fb1sm5117059b6e.21.2026.01.09.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 14:51:35 -0800 (PST)
Message-ID: <1d52f1ee-0f60-410e-8c7e-c5fee0a92402@linuxfoundation.org>
Date: Fri, 9 Jan 2026 15:51:34 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/tracing: Fix test_multiple_writes stall
To: Fushuai Wang <fushuai.wang@linux.dev>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 wangfushuai@baidu.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260109033620.25727-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109033620.25727-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 20:36, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
> the test_multiple_writes test will stall and wait for more
> input due to insufficient buffer space.
> 
> Check current buffer_size_kb value before the test. If it is
> less than 12KB, it temporarily increase the buffer to 12KB,
> and restore the original value after the tests are completed.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> V2 -> V3: Make the From and SoB match.
> V1 -> V2: Restore buffer_size_kb outside of awk script.

Thank you. Applied to linux-kselftest fixes branch.
I will send this up for the next rc.

thanks,
-- Shuah
