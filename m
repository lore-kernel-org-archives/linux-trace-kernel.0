Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97C1272D1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480297; cv=none; b=boO2iLQUoO1U+2y74rj3dTs/cwAAV+C8015jHJXKvGiHwOcLQRWJLAaJZVWP7y1VYxxNLkj6nfiAQltm9gLZjE0pRj8Sh67XuzDitv6QnaC65wX4TyhkSg1/dbXiflUpL8yd9JNhHIYHb4Pg482VdQySb3rJv8hLur47m1qtvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480297; c=relaxed/simple;
	bh=QYDgRENIXEI85G9R8xF704NL0wTrZONuhjzj9Bnl3vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzYy1dDKRuDaedLgK5HuPAqImhI3Uj2ijB/Ridaeu6z+wd8fkrngiFLCyyNZ9IWZyJTUB7s82RWCs26PmAYZgtCIz/urHhQsTqM+8ayksG2MRFln1u68KHefnOU2jAgRHqlqPIIyx5llfHJSu8NUrlJOSZta+xk7N7wNTFyFI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D566sm17; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D566sm17"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so85363839f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711480294; x=1712085094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOOIg4fnBVQVzpITt0LAPmk2lV+qZdZ0QtbirxPziUI=;
        b=D566sm176RpsyhHVCGbEYsBgERAWwbsY3y5VrH5OWl/5td1qjEihHRBafZP/tixb7O
         FtGmmDTQaD2kJBFwq0r0DPKd+gdAKkVeZO/ri5LLV7/JtbAdXN7rzaCsJkeQYbgtVPOv
         v9pXkOQ/1bBAHmmE23JsqZ+q8wU0A04PCHhu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480294; x=1712085094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOOIg4fnBVQVzpITt0LAPmk2lV+qZdZ0QtbirxPziUI=;
        b=a/dRr4aEN5By0dHE+txiJ6ubJ7ocT1KOFd/22eXK5XEl7vBqKoui7q4eKQwavJHnqt
         01DSLZ3IJiwSqxvgU/4WNQq7LD60NSlFUQix4v2jDtDgYF1EtxgUbWttNiUsWsegaC7m
         kXu260LBPfkw1GxsGNkrAnFEwWSHOX2SJ0hOROhJCCYIyO+TsI0R+mHFDagAAdF915AP
         gyPQ/4R4yXTtYW3BvDhwOYLCRGBaPpmVSDqUbUJvQ3o/iVXAxBbsDR0oEjba0M/cjHBK
         4olGQdt2s5eo1eEDCr3P2wq+QV1nukvFkdorHqUSKsiQYpED8zyC6p4w/oNi1gyPiuxf
         AtcA==
X-Forwarded-Encrypted: i=1; AJvYcCVILB9hLeaqno2NoDIt1oHZxlebjY9OrDkV9pAhsqniRyKnxH4E6UiEqRgxxW13S/PEtYevSRt5DovU9jv0ZCzyUMP/f34j5sY0DEen59Uzy0zv
X-Gm-Message-State: AOJu0Yyc0a3Z6lt3G217TabJTtTyaCb6Xk5AwuJ5aPJUO91O8FebDEwt
	v1qLuGneVb6C9ZEaVxwyRjnz/jv0CgPOWv5jr6dfDE00SKCDJ4pyZ3APdSLjM24=
X-Google-Smtp-Source: AGHT+IF0w9Wc40cX/qVwZQVH9Xyx9E64RhYhYfEHp/4dKzFTvF5EH2JkMjB7Taj8HdiA95PCqz20jQ==
X-Received: by 2002:a5d:81da:0:b0:7d0:4d78:989b with SMTP id t26-20020a5d81da000000b007d04d78989bmr7856945iol.2.1711480294293;
        Tue, 26 Mar 2024 12:11:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y21-20020a056638015500b0047d68340fd9sm811705jao.32.2024.03.26.12.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:11:33 -0700 (PDT)
Message-ID: <e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:11:33 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
 <20240326120809.09574951@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240326120809.09574951@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 10:08, Steven Rostedt wrote:
> 
> Shuah,
> 
> If Masami is OK with this, can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 

Yes. Will do once Masami gives me the okay.

> On Mon, 25 Mar 2024 16:15:49 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
>> This series aims to improve the usability of the ftrace selftests when
>> running as part of the kselftest runner, mainly for use with automated
>> systems.  It fixes the output of verbose mode when run in KTAP output
>> mode and then enables verbose mode by default when invoked from the
>> kselftest runner so that the diagnostic information is there by default
>> when run in automated systems.
>>
>> I've split this into two patches in case there is a concern with one
>> part but not the other, especially given the verbosity of the verbose
>> output when it triggers.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>> Mark Brown (2):
>>        tracing/selftests: Support log output when generating KTAP output
>>        tracing/selftests: Default to verbose mode when running in kselftest
>>
>>   tools/testing/selftests/ftrace/ftracetest      | 8 +++++++-
>>   tools/testing/selftests/ftrace/ftracetest-ktap | 2 +-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 4cece764965020c22cff7665b18a012006359095
>> change-id: 20240319-kselftest-ftrace-ktap-verbose-72e37957e213
>>
>> Best regards,
> 

thanks,
-- Shuah
