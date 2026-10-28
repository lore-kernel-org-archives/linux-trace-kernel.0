Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221604;
	b=hmK+0fjkce1DzjeadHoP1uegMGfc01CmDUAc2r2VCX4F0dyIfBqxOyqdptaL6SMUB6EL
	 EIXjckWwBkOQZtswblqd3cB2gllilu/SHHfUFnFyYDRlAns18k8OHKo8L3IbdK3vGMzKl
	 tx3pnWeTXbUuqVRlDU0iYOPOLwUsj9UZm65bSkvp0K2mCrglQg+ahdGGcW7WD+EdKnNhM
	 tiABz6zcSahWbbFzu7QBXjwHh+LfwBHQLyU9uIJaUTyntFq25o0SDmtYKIhcKB7HvsmFz
	 0pcRaGDccrJ5YqI16oaE+ZvBh9IQtnESgw+B6WSvly9JyyR2LHBWHx/deFMJNdgbH1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
	b=X//haSuF48TpsbsDaDvG6rmAbMQDd7VELwOOKEv3xPGEUfKIG0B2urLU6uwVgumFWVBr
	 j0/igemwXqPJM3wKtUv7kt/KFrT57qwp7uTSWui3jyQ9meboufJCmlucjd2+0x2CYbcC7
	 lhMvGMxXcEeIxsKlvji+70gnWQAud8l24t2NIEIzsS/aoFcQGCbonXRuoCjYUcXnmFNP5
	 HdlJBCvGz0uZP3TcIpDKx3MW2Cu4/kQGFBlkMQCUbaeisqJfnMJPFTBnx/ioOLCBJTHU3
	 ctsBB5kGT4U+xCjABwPIjvllv7rJqZpqxMRTCte9/z4eI5ZrEAgz+1PcAMo/mciAN6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RZKnL3TU;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA5606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBA5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RZKnL3TU
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a75171af39so408269fac.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793221602; x=1793826402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
        b=RZKnL3TU91MknhH0PBI6QZVMUcwt1SUpPSrfgEKjkIikcI2UgLeVieNt6W/vKdD+ni
         ZlzEvAK8j+4uYNKqrUDlDHihQtPPOUoBEy0s0xfMsaOvZ8lBWNpEMl2uWLzPY6g38BiG
         HkEslqoetMhPitOO7lA3e/fOsmOLctT24KIE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221602; x=1793826402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
        b=TbajiHYROZO9PVBiYNZpD2Z/1wt6fEdu412oFfu5/KG642nUUFwCwQbt+p8cIXCcCp
         aN/Q6g/AP4ms4oR8Ylql4s1SxpHBYZJwfcEm2a8AM4G7qsVHIhOxWGKbDGyGWHbi5ntU
         5uHYgyVqcNnY2djDmMhtTQCPDjT0I2ZkxSP8fpurx+2rqQtVWjyf5i/S4nBoZdXd5NWa
         UefRInTI9bRCHG+VgdInUpjDX06Gzjn+FRNkQorq4e8pCgc1UZ4MqTWwDW8RRP4WwYlf
         0Ee5aW1OMiJq3sIqctkg9YJl17LYvU3k7PVPlXVMkZmggvTsInsUN3FkI+U3+9hUbSGc
         xLfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxeZKV5/ekaIVbRwgFLMtpOBIZXS4Smy30Kv3hJaM/uGiMtCyFqVnED7f9v/qsMQp/5/uhuvVCYHHUeSkpyUZmbkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKAIcGDhfVYU0622sj402/UOND51EMo0LM0yMs1f9CdguhjT0F
	cAs0TCQ2rLN7fTUV3Z0ddK905MiHszIA2YZNmwvkchTswgXi0Ab0HzDxfVdqjPl1hgo=
X-Gm-Gg: AYBFou2eF/mVrZjP9KPvZhnfYu0T67/I1FftLJJHAMXee3FAY7sTFOa6P/Cg66UVr5S
	XrLF+LFcEsZUY3VjRM2YJP8imWDcb4wZgyNwxWD08uLRULVUh3xTBUqyVvQpzecqNGm9AWV2GRK
	703vYabWECa7NAam3p3ZrfcYdGQnVqx2+u/KgSlqzrDejXzy3eYIWiGnN8DF0+lIsCbqIYG/bed
	b61jug/omDZJ0gPK5WZbWSjoe3cFQvRq1zr09RuBI4njqruzS7VGnbiPpEuXqWLI+9rkmxR+EMr
	DfbfyoF5RCifPaaRqkiW409KiDVMAO7bpWwgqAe4Swgla1+khy7DBDHz6v4EZ28gNNlShDGPDlO
	2UU4H+n9w2Sa2cXn1hnGJ+MShS5LUefqAMV50zYEU/UBOMWYPMpiiC10hFNT0nWKhWJrBTeT9YB
	HGySSzTYKuk42IyT3U7klYuPN3sUeABtr01Tj960w9iNoeKSlVhErnlcPiaYWcqcLdkWY6EP9jZ
	Y7GrZYVjjuTNSte8okaIjyPeEHXyWEztmtS32rxQJg2zsLRrmgCj2qizvZTg5lG4bgjnXIGR4Kl
	9Y+nyXfbvfHbN3D1gAz6ib6rQiRtj7WvMzaqkQA=
X-Received: by 2002:a05:6870:d184:b0:49e:4ed0:11d4 with SMTP id 586e51a60fabf-4a8bb701e65mr2458445fac.50.1793221602376;
        Wed, 28 Oct 2026 14:06:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac4e4sm3068523fac.3.2026.10.28.14.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:06:29 -0700 (PDT)
Message-ID: <9c65a285-9144-494b-b4d8-e3d0deb671c7@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:06:26 -0600
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
Subject: Re: [PATCH v2] selftests/ftrace: Add missing spaces after ! in probe
 syntax tests
To: Jaewon Jung <jaewon8868@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261025075044.1750113-1-jaewon8868@gmail.com>
 <20261028011923.2050009-1-jaewon8868@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028011923.2050009-1-jaewon8868@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 19:18, Jaewon Jung wrote:
> Add the missing space between ! and grep. Otherwise, the shell tries
> to run !grep and reports "!grep: not found". This always skips the
> conditional checks without checking for kernel return probe argument
> support.
> 
> Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v2:
> - Add Fixes, Cc stable and Acked-by tags as suggested by Masami.
> 

Thank you. I will take this for 7.4-rc2.

thanks,
-- Shuah
