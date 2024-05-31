Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9157CA6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166464; cv=none; b=padaYlarCYT2HwnFqzYkbJ3NKXAljZgOsXWRxuxWXKxf2kCCooTIRc1uKwNbJHe57a6dwdQes82F5uJA5IdJTEpZFUSQ36zYp9T86aIBEBoJR3DQub3mwcl5IwdVevMMet35H/lqzupEyNaEdGyM2dK7xhkO2Dot+SpwUtPJ76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166464; c=relaxed/simple;
	bh=EA1snWN6KFF5x58Kt5WwrvhXqKcKC51UqvoEgW2mLYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eB7/GOZTMuBjPDvIlQ8rnP/DKSHsUDsMUha1Ixq21dwA/CnBlnDSK0LW6ieLKLuPVGux+MHkCk+zGHogW6HA4WGfkPPyhohjfy5b6X3JpzOIcZjs8GtoGnQNpJ8WlMSENryU5bblH96NY2tq835AeCUpZ5snUv0hlsNZVn9SwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvrDWyHF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvrDWyHF"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e8e5875866so10728139f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717166461; x=1717771261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SomH4SrINp7a9UmlUPOr1vNpjB9i9zy5D571kfh3Q3U=;
        b=MvrDWyHFpzDBF2dtBnEeWlWw0s2mB1nwQdvyPyym6tMbE1ffjMiRssvYzdk6O6rslw
         1W4ikXaxAiIkgJHEb3NZ3GiSDCV3CfS8i9MUJfKOPOYy+OzgaBvJdG1IaUeqGrIi1r1v
         rg6Q83dpvTs/69GSlGu6d8As/dYKLlUmP0Klo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166461; x=1717771261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SomH4SrINp7a9UmlUPOr1vNpjB9i9zy5D571kfh3Q3U=;
        b=Cc4SoKqeFo8W3gezhVSMQaMMs4lG4cbQTffa5RuZbHJdzzepahXT3SdnpBOXO/mlHb
         XjJetzhYT3hekedusGmoqL00U+CaC9oUaP8h4gv9mxfKU/Ld77TGDpADtMJFU0Wa9iPy
         OWVLLAjmhWrWkbgCePe8t2v3RXUtr3LC/VqT+t3bBSInj52rQ/pekwGVZStSNOAmHpSX
         91ySuH2zeH0FbaB6KpSuMufmkdjtErQMDOGqJ4mbzgF4qO45KRfxebX9curYLjeBp5cx
         UDsFj48bq+HVVStq4lj1g5hSZUAMzGz0qpM0EQH+FhYxYEZyvGG5R61VR8aNQeS4wVJQ
         hjPg==
X-Forwarded-Encrypted: i=1; AJvYcCUlNVJZIfJr+5u3qaUv84UjN5vg/zCviwp0kz82KdQ1IrdEyiqz4FWeqyZVY/Obzf0sm63OgLZ4i9ySO7+9NkLIuBaYpo+Yw5W6MZF2+DcqKwL5
X-Gm-Message-State: AOJu0YysLKyvnD3UIzBhkii9Yk6CN5vSfiSiAF0iW876Z/fjp4sVJbWH
	3VniGyfKWRMCTsepbPjavr2WpubT9difWmgG1BX/vw4xF9sCFy9bmh/w+P6vors=
X-Google-Smtp-Source: AGHT+IGsUGKjhnM1nomuA4q/rSCCqjBn03K1FeDVNYNScTmTrlQPUOkSjVi7mrCm63zBW4n0fHwJ+g==
X-Received: by 2002:a5d:8485:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaffdb5092mr236846439f.0.1717166461094;
        Fri, 31 May 2024 07:41:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48cd01333sm496174173.161.2024.05.31.07.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:41:00 -0700 (PDT)
Message-ID: <85472ab9-aa2e-4f5e-869d-5ab42e47c8a0@linuxfoundation.org>
Date: Fri, 31 May 2024 08:41:00 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/tracing: Fix to check the required syscall
 event
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
 <171714862700.198407.14000969067636098427.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171714862700.198407.14000969067636098427.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 03:43, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since test_duplicates.tc depends on syscalls/sys_enter_openat event,
> it must add the event file to `requires`.
> Without this fix, the test fails if CONFIG_FTRACE_SYSCALLS=n.
> 
> Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> index d3a79da215c8..5f72abe6fa79 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   # description: Generic dynamic event - check if duplicate events are caught
> -# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
>   
>   echo 0 > events/enable
>   
> 
> 

This change is already in mainline. I sent the fix up in my 6.10-rc1 pr?
The short log is a slightly different:

commit f6c3c83db1d939ebdb8c8922748ae647d8126d91
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Tue May 21 09:00:22 2024 +0900

     selftests/ftrace: Fix to check required event file
     
     The dynevent/test_duplicates.tc test case uses `syscalls/sys_enter_openat`
     event for defining eprobe on it. Since this `syscalls` events depend on
     CONFIG_FTRACE_SYSCALLS=y, if it is not set, the test will fail.
     
     Add the event file to `required` line so that the test will return
     `unsupported` result.
     
     Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
     Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
