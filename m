Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804333E0C57
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930339; cv=none; b=Rq3Zt1B0RjQ9pZ7yMGFQZj72QD99oDfs1AcNKkzDFtIu2ezDPyD/AJxmypEYRWCDP4H8p/ZvyvBPwVWlhkqAEydXJYvcFzeC9/oZH2oStM0VNmV/qGT/3Mi790Yl13G6weRCoQVNQb681nnQuMza3DY0qaVsvCNp3/bFPoXbqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930339; c=relaxed/simple;
	bh=rpXnnfiHVzHB7ncZ9FTFRFhCJjEV5nU6ygT9vS6g1Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO3fZ3DduYKDxxXyuUucUFiCvEZz28XZryjqiKhGaGT0XGr1zN4rRJyO4QG74LMfUhZuyOy2EpjYnkGPGFL9/gc7YxDcu6MrKefT5F8g+sKv/XEyPyS0mL+qgvQ1TvXAnZYpVtoa/mVSAnjix9DYvqJXFz6Ng3G6F/2k//ubKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lwvYLV27; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lwvYLV27"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B1FF43F206
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1780930328;
	bh=b1pX3FZIzR6JtivhZtR5O2oycxLZ7mVagYmhnEiYG4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lwvYLV27F7oDIAYT5ufo85O2nrP6AVjpKxCNaXn23/fbNLZGowueC2j4PdTfOcWnC
	 ZxJAhKXPvVKvP/Dp+mrsJmNf0f90KiQf20jWYOOVgvdvF1sCbpea6sI7qEZFJ2iCPV
	 9Cjj9OjyAe2deWqcrlSRCaEh9ytHG/gxQgovE4bC8UNl0lsnv8L4SYZk5+SrYThp1s
	 zPVzP1PHzmTa7R97645CvFtwO4JM3rk38+/wkwtO/Y010IsJ8Pz3/3qTHai3js61fv
	 Hwe0KhyNq6M2yX95G9nsiwLZu5aZ8U74lVqnsJaWmPn4fycnYi4NxFxdgyYjkWWhhX
	 PgFlr4eUh0oy1qy7SCnNp7wn5akkxmowTVPrPNfL4P27+/ixVl0YSYpRae189Bbpzu
	 e7pC/VISdVJEvFL2Yw+GL6ORqwCFePHM2PIx3fLJai4ej4vWYpG8nv8lbh8IQtto4P
	 5u5WkTj4pGlzCln1AfR5GDCjL9kvqw92ddq+3oFlbekoaslot17tkTkvlMOr/3PmEi
	 LMwI0GL7hb/MQ6N1uwBmanCwcAr86FsFlJv227/DtlvNQaV7jHg9jI6sONE8SDVuo3
	 B9794cT5Z0TR4wi3nvOU4DV+WVU0JOkZTUAz/HRkDEZp2pH4OhrpX0YgIKy8XQOCS3
	 9XwUu4X+/AO8+YuPhBXOKENM=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso4042587a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930327; x=1781535127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1pX3FZIzR6JtivhZtR5O2oycxLZ7mVagYmhnEiYG4Q=;
        b=eXxwBthtpOhTDwBCU6N8y98YRj/uQK+95iZELAWF0hjGXPf8PNzmV9YFBE5vyqMWUq
         HHgOQ0LU7xLCGZVRx2kiyO10B2/9tX6/6fvP06qALp9HZbHCY0sicje1ilamn71HhjGp
         mYJxTA9j+ilwsc4SPCzuq2iNtSYrRcYrL7Jd5qAqmQBjog9K3zm80vJ0zp2teBUSmD6f
         nd+Ug53up0Flp4h7WdN6wTcWtrYtvid57ZE8AeiXXai9qzQ5OR7aZanCzDThaPVtp7gA
         nUPP+x3xiqaIXZ4MMihwMAERjCUe5ni+jrzzeCMWy/EdtgYLsCsIIBZsmvlHprqqaw7v
         PuoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1AJIc1U727aAt3tMeTMDVZau161dTJeP4k13v/mdzJIAiPr44RRLmQ6shpV13TqBb+wgcDDI9jv+zW2Rg8CAK5/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlzTCGGg+JKgI1k1XXaavWB2Z5WyZ7zSUl/hUSyfIV08TOkCM
	S5scTH/3MP//6KHG3d5YjpiFCnDQnz67zjJDrRkdZXXivQUxmi3MDC1P4YXs1AAO5DTiIK0NZLx
	XA799xKTQ9Olj2aw2gruZUzF7rNIMjDYZf+B+XVJkz+PUhBfKLjCS9X8uezffwTZH/Fs51n1u9e
	jzDSRZqEzgtIngPA==
X-Gm-Gg: Acq92OElL2Zuv2/xoPmwUDunC1zNpBx3Bhxs8OmaICBlg8dLOkKVSCu80NuHsy1b9K9
	vPS4DOFE+UThoHIDF+2QeIHopUgti4iqusXY9CjcAoODxELEek1CeAWNJX/ClAtxrlCCa6g0y3p
	kAaLBpK2vb6QviTTJWPjEE/aR1562KMOy5fVClZfPYjTaf3je2OO/AW4P2D7diLsKT145RsjEKL
	xKNgrMGLDBvETqn6rSj7bg0WuImO7XLtkEyj/J0z0g+sLWDgM75/+pdxzvgpQ7XdQWoet3iFSEy
	yvn7YKbh/qPL0jG300++3CRPeW827s36iAa4nXzfwgNSH0baA+1AMJ3XfKVP+WTYml0pHw4p4sK
	OI9IdqI79dZcf9sCc0oxuPUP+VlV34Gnyh4wzbJaVpr9s9/dlXi5EzlwZ5Q8nX6qXAqdvGqXCMK
	dJPg/Jq1SZ
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr15824950a91.8.1780930327069;
        Mon, 08 Jun 2026 07:52:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr15824914a91.8.1780930326374;
        Mon, 08 Jun 2026 07:52:06 -0700 (PDT)
Received: from ?IPV6:2409:8a00:48c1:ca00:bd04:9263:b15c:15f? ([2409:8a00:48c1:ca00:bd04:9263:b15c:15f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6e828eacsm16073363a91.16.2026.06.08.07.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:52:06 -0700 (PDT)
Message-ID: <79c7ede3-e174-487f-bf0b-fc9347fdde9c@canonical.com>
Date: Mon, 8 Jun 2026 22:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/ftrace: Account for 8-byte aligned
 trace_marker_raw events
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org, wangfushuai@baidu.com,
 linux-kselftest@vger.kernel.org
References: <20260607072431.125633-1-hui.wang@canonical.com>
 <20260607072431.125633-3-hui.wang@canonical.com>
 <20260608181716.726cb9c81d41d49095e7f3cf@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20260608181716.726cb9c81d41d49095e7f3cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/8/26 17:17, Masami Hiramatsu (Google) wrote:
> On Sun,  7 Jun 2026 15:24:31 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
[...]
> +    for config_file in \
> +        /boot/config-$uname_r \
> +        /lib/modules/$uname_r/config \
> +        /lib/modules/$uname_r/build/.config
>
> Hmm, also I don't like this, because this highly depends on the environment.
> Instead, we can add CONFIG_IKCONFIG_PROC=y in tools/testing/selftests/ftrace/config.
>
> Thank you,
>
Thanks for the review. I'll address all other comments in v2.

I have a concern about this specific point. On Ubuntu kernels, both 
CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC are disabled by default, so 
/proc/config.gz does not exist. If we drop the /boot/config-$(uname -r) 
lookup and rely solely on /proc/config.gz, this test would become 
unresolved on every Ubuntu kernel — a regression, since it works on 
those kernels today.

There is also existing precedent for the /boot/config-$(uname -r) 
fallback: tools/testing/selftests/mm/va_high_addr_switch.sh checks 
/proc/config.gz first and falls back to /boot/config-$(uname -r).

So how about we keep /boot/config-$(uname -r) as a fallback, but drop 
the /lib/modules/... paths you objected to. And add ftrace/config as you 
suggested here.

Thanks,
Hui.
>> +    do
>> +        if [ -f "$config_file" ]; then
>> +            grep -Eq "^${config}=(y|m)$" "$config_file"
>> +            return $?
>> +        fi
>> +    done
>> +
>> +    return 2
>> +}
>> +
>>   LOCALHOST=127.0.0.1
>>   
>>   yield() {
>> -- 
>> 2.43.0
>>
>>
>
