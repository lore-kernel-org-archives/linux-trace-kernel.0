Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF346BF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030876; cv=none; b=n2yM/XGgRW/g9p/AYziMI8v0gQ0cFpFg7zKr1j8RbqZTWJdwtFLknVH6P2H78PU2uhONhiouIdsH1Uix41zzs9CCG5PQh0M9yT62Lr+4W4Seiyw54KK7AX6jFRP1/A6Z9vE4YxdKo+LrjaCer5b93tNKiNx7Ip5DCNlhw/18Bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030876; c=relaxed/simple;
	bh=yFw7GSoA7js572MPjYiS3vwK+FkoXdACgw47nXbfQBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDHWTyuOr0PAa61iiKH80N1O8laixZ6g05oLsvCYQeskN/g4tbQ3WTEgMbbG7/0voKbGJwvSJTeCmoQHPB4g5XwjcJMFHbU1tsIBn5NIxlYUG29if1zRXE7ZbWlZVx2/aOOV5QZf6dqLdmc8dStIoF1dFChjk1+PaDmyt16eW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XCuWywgm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCuWywgm"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b1f2fbaed7so411533285a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764030873; x=1764635673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQU+EAlNyeAvvUQ4yLH9CM8/BO69UfCU0DNxzC57JlM=;
        b=XCuWywgmgsGPfaTXxTnyKTnVj3v2TwGvzVwigJSN+SqgOCswnjvTgdgVoTvyZrdDZq
         eVY3MCiVUUZjlJVBqvRynZbv6Z2UUlq655e2LUhqfBqPxfc5p+8ba7zqyR7gBb0rJvWG
         pM0o/Oe0aXp1bjAf3gVm7nFpU2IxLZ8Mfi9tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764030873; x=1764635673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQU+EAlNyeAvvUQ4yLH9CM8/BO69UfCU0DNxzC57JlM=;
        b=mRxu3xagXMj5p3mR1TZHiuVsI+As2jw7zLleh45mMO6Alv3iXvGEPxkaMGyW+YQJ/+
         oUiFFX8eLMdIlw9nzQf7yO5Y7Tdx9wyiLhtOrqyxjG0DXtc5O+dF1ib1//p46qdLAO6U
         sxU9eXtCS8PsKOSH0PIdE4NrTPwcvHHaqmz7TDzk9J8jnb4w5CKtsrqSZn01OERp4xY5
         jKNuMg7eyujcbkFPdvi4SrYC6zlYECvYRPf2GZQqKvc+DgcxhhXMG4p8n8+fIrP3qAjc
         PjstMMT/6jtu6UrvaFhkfIZA8NJ+jctg5Z2GE7IpswtcscYXclFThBn5vGpT9mnNszVc
         lBzg==
X-Forwarded-Encrypted: i=1; AJvYcCXscFrEvahB7pakcIqA9n5zNzkVls2hCc+dZXJVolXStMV/CNB/kZWyAGtfRdXD6UAGYWed6R5Y5ABSEsEzcULqfK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eC5pCSqKsNnES5zIiPv44Biq0BYJmBaa8jTalVIVF6dmv6Qx
	iHo3P6M0FIih5153oC1X7toDBRJqkPUEoqq50os5ydpfNRE9Lw7hBRQLDkqiEsFokFc=
X-Gm-Gg: ASbGnctpxDkdmlm1sNlAUABxk24OGvx0MCCetBZlxJwwdRfJK3Git1fndrQqSa9hkaZ
	W/hzA0tzCmDmkqOOcL+T18w58n9QazvBVyIKp5ykowOKeS7ECBxds/6QZwjwgtf+8fB4D7pJDJU
	IuPNgVeFjM3ZVOIBPYxWJwgyGlwUyq+ZydtJW55BI3jnuW+4inUQnNIzTG4e3awB/d0DPtglFAp
	a55iLU4WMViOniv3Q2UaXdBM4RFyxma+CvAbWs977yeTSJedrKzzwDFLYnWsXjdUJIWUpWI2krw
	UZncV4SdEtPTp+BK/nHMXMK9D3dGgSdmRlsE9bW+a3qTDbBMNtU2j1XrEBimb2Nj1y5H5aQi70l
	YKhe3mCrMI+AOPl20mh+SBZnIn5uzDG576+3AXFc6ER6ix5ta8VH8reFrgwYw/XDGhVuhIzBdqX
	/QT2HXND++nw6RDvEVwrh/lmucA2ITnfDI6pwtRmK7aCC/n5M9UzULC5Yz9D5a+9e6UC0y6oYXx
	f83S/EWdVIZCFIIN9VTQ+B9Me01SW/cSg==
X-Google-Smtp-Source: AGHT+IHWHAZ7qDxEqKri3FtLO3ksIMx/Wmys5wAWDjD2N8qAC3PnbTH6fESzeDs+xdcM6vdqcb7uAQ==
X-Received: by 2002:a05:620a:372a:b0:8b2:eab0:629e with SMTP id af79cd13be357-8b33d60e24amr1764104185a.90.1764030873523;
        Mon, 24 Nov 2025 16:34:33 -0800 (PST)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295de540sm1055974285a.42.2025.11.24.16.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 16:34:33 -0800 (PST)
Message-ID: <9ec09081-28b6-4eb9-bbc0-3e48309cf063@linuxfoundation.org>
Date: Mon, 24 Nov 2025 17:34:31 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
 <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
 <20251119170611.6eff8df7@gandalf.local.home>
 <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
 <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
 <f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
 <20251124153930.336ef162@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251124153930.336ef162@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 13:39, Steven Rostedt wrote:
> On Thu, 20 Nov 2025 09:40:28 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Thanks Shuah! This and other regression fixes is better to go
>>> through selftests tree because those are checking existing
>>> features. Maybe better to add [PATCH -selftests] or something
>>> like that?
>>>    
>>
>> Let me know which ones you would like to pick up and apply to my tree.
> 
> This one and I believe this one:
> 
>    https://lore.kernel.org/linux-trace-kernel/176295318112.431538.11780280333728368327.stgit@devnote2
> 

Both these patches are in linux-kselftest next.

thanks,
-- Shuah

