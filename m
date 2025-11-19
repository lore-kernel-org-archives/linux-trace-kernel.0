Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AE2EF652
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593004; cv=none; b=rsbFwmrOoLwuIyerKE8gM21h3Q8WxbwIUbE4niqew3u9VVF1ATVQD93Lb011ECqxodqPM3KMviwqKv5EAc4xdYK7hYgYdGvthRNQF7ZxhztUFNCNX6rnNq1cnVhNJYmBTlYdCUwBH7s3R6cfqbkfN6tMt/YeAy5k7KY47iiNbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593004; c=relaxed/simple;
	bh=8PxQRRGbRQ8tSgOLa+iJvnsNLzWFk5wnVUDy0F4fD7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSIEWQgmaFe5wgkMFErTMLC4Q9xYoT05MvkKLIJi2JHMGY5QXgbPd4hqA2AmSurQGgYdBcNV6YBoWbcVp/QhHYYdhfhMtsP+XOBEMDCCfq2W4mADR3ERr9nHTLryRjD0mSL7CrOTsIG9UP85oiz/tSrHzQsuXpHv36w8pgrFOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UupqrxhD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UupqrxhD"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-949022f1c85so11008539f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763593000; x=1764197800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wMUH8JcfJUm5VqcHHrATjM5Cu9rxqYCl3FUJ90RvcM=;
        b=UupqrxhDQk2sfQuQGCRVaVJymkBO0gK7LIqQo8ZQFZUtGTc1jG5j0J6NjZxPE/WwJ/
         c2DzKDhzFwuzWQ731eFgfs/WtgS3C3NiPb7vFaLlgbOc68UTjXYVpB5aDO0eS+PH3bOD
         b348yOsPIp0bN5QvIMLBylpRD/sydPrEz//Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593000; x=1764197800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wMUH8JcfJUm5VqcHHrATjM5Cu9rxqYCl3FUJ90RvcM=;
        b=iEPaEkzZb/RfR4p76y/aLDdqPZhWR1K+I9j0WmH3jKr4AWxFwPLyrsmkDEuUDXqdVM
         nk3at4lvJmx7W+xuGtH4EMh/HO7flTSoAOGYp5kome3Nb9XEPMkvqTZRhiQ+PKUoQNmu
         ePA4+9ZJ3DBe3cGp5QJp8sWwq8EYCR5L9AvFQ5jwlXASiOs/LUjglkrPvTtWaozXI875
         I+96G8U9ZN1+8X+8f+Mie2f2M0bUniWI0VZvU2AfqCmPhPW6MLPTF8G1PvCRjkVcPG6F
         oLXXssBl4o0NDItLDtfKJb826JgvgNcMoqMFLQlCG6WJllULVw81h0Hw0Wecu26qaQ7Y
         rB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiP/lkKIywgEUAMumHEIYxWh4Dxpz3PLJtarDaBcr3iCgIPRMjwKn4oikAIKq1dOQVy+ec4T3iNuSz5OiEdEDYbHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWnfnc6+Z0dhyzPg2WLGNZv/mVSk4n96r5sdtgG6FVzQ3BdJo
	UVErvg5O1mvqsd4zeNnWiQ6PxV+BF/O9iE00ZbnWv+mxNXqd169e74mIGkYCkTuj6ck=
X-Gm-Gg: ASbGncvYZuzCvPUGWTiF3H/L+WGqIiIUs3uqMbN5Z1Fr75viTDCcWqBceSMSE/wQ9eH
	5SAivUgGj4cqEIoggqP1PnNOJ6WgEeHrxQuaUK0BbDFL/yybjnIb3SWJC+mpPXQIAV+o72I4S1e
	GFmHhYrQWHZIKpFl0TfcDXCNkkbkJe9qIhizr9OrH02l+ofr6CJuUP3ffyTSVZiY19NBkk/b/Fs
	VOA+5C99b1XBwI61PY9N5coEZ10XQpuQWnkYtUEPeka8VQPlQDTjw6thf3TKYUb/QlZkn4eIACz
	FJE1aJGrPeHrE+Y4cNxPBehHxSrSm3Fqzxi1p5zS5Lfp8D0TcErwxC+/zVCtnmVrODBhN4BqluY
	U31jvWdlD2gt7ko2FpZCDzL80mMZG8QuZ0MVrgx0Kl748C0rQmzEbapG64p3a5KRNgzfRnqo8oo
	pYaslZq793dYZzThAoH7c8ownoOIBuWVUUow==
X-Google-Smtp-Source: AGHT+IG4tDZ4F/fO1HiCiZs9PvKdwalM+q64M6x5lrXzcVzNi5nKpIozkdFoGwtK8Z0gwdmZmTuSaw==
X-Received: by 2002:a05:6602:8211:b0:948:a37f:6eb6 with SMTP id ca18e2360f4ac-94938a1bcdbmr58375239f.4.1763593000456;
        Wed, 19 Nov 2025 14:56:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949386912a9sm27794539f.15.2025.11.19.14.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:56:39 -0800 (PST)
Message-ID: <9f6f5434-3650-465a-9f67-eeab11954c30@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:56:38 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Update fprobe selftest for ftrace
 based fprobe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176295318112.431538.11780280333728368327.stgit@devnote2>
 <f6831d9a-4ea6-4100-9b1b-716ac93e1cdd@linuxfoundation.org>
 <20251119173441.3aa33415@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251119173441.3aa33415@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 15:34, Steven Rostedt wrote:
> On Wed, 19 Nov 2025 15:16:04 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/12/25 06:13, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Since the ftrace fprobe is both fgraph and ftrace based implemented,
>>> the selftest needs to be updated. This does not count the actual
>>> number of lines, but just check the differences.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>    .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   18 ++++--------------
>>>    1 file changed, 4 insertions(+), 14 deletions(-)
>>>   
>>
>> Steve, do you want me to take this through my tree?
> 
> Yes please, unless Masami thinks otherwise.
> 

Applied to linux-kselftest next for Linux 6.19-rc1.

thanks,
-- Shuah
