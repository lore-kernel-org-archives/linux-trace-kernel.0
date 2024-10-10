Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C011E32BA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595462; cv=none; b=QQtGzbAwH1+Ognynzz8WhqLL7sT08O2nMvUYf9CKOhzsMTGGRCG5rjjWdn8eJwaZawpQWeur+7pQ1EGIJxWw2XidV/pCp0XQQR1adrsoqGU9aE5Y8nCBWlPezpSPjViKxKcc1ghNUEA1ZinpAeJj8vlKrPSzYO8t/ZHRS1qaicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595462; c=relaxed/simple;
	bh=IvXBq22p6qcwQpaq5eTge6FDXANkdgf7r8d8TkHkgHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp00FYabFBO4eaElbQ/y+NHI4qsUxVocErxSewsMTCVLtqBhnktp3vmekWNxufVoGNmnAfoYiZD/9OmQyRUYOJEbHhHZvPoAT4Zf14my8oKihwlg75yrValbnxHV55/zX4d9e4fA6k+nuPRSlXWOlB1mdQy4hkmOqul+I2dn8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3AkH2dR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3AkH2dR"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3a03399fbso7486245ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728595459; x=1729200259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=a3AkH2dRu5bBnfgc1V8oAhte1wIURt1DzWv5DLVaj0VHLi18xY1OAqOJFYVHTsFzp4
         RiCGH8ZmxHJMKslrf727pIFtVI6vGy5ziIoydridCa6qMvMLsjT6uodrHYCEa10hlZ9n
         8cx28NejJZDLqdU2StoKIjiUTDWvnELyenrPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595459; x=1729200259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=iR2p1+mFg2OCoxreNvCPAxHSnY0YcXUrzrIriyqCgLwJjOLQn1bP2PNp/1ejXnp7hK
         +zFIFBNfF9L60iSIyXVLbtkYOyTc0BEuQf67msQR0DzAw5IEazhQqV3yAGy+y/kkgQcm
         D71Rb8JdmoISjbtUIzYEX3jJl38Bq0NpOEI226eu/i7lIv61+VJWMHNuhHdYtq8OA7h0
         Bk0vate7JtWfGrS1RDWZvOdtHL9hilnSdPX2vuA9mU4QQgl+M44u0B5r8nZ59+V+Vvk0
         wMfNCRU9danlrZF5UKMBlL/F8VK2HuDC6zMqaCbNwVHwhDTk5jWNbi44hoR3h9pdnqph
         Ev8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6347An/fuQt3BU/OplEYCzs66qCXPI9aJn1bG8wZAsd5kNQHAAcLb2xAy0W9MKZmpNjv4/ucvaxH9vlYFcUx77dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvqejXj/5U8r+V6G/rSuIpJoUmz7v7m+BsMvbCgx54CJ6giLS
	u6w7QqZ80S7q/hUFaFWX6Uu0UWsoMiYdAFf7pxpOH4AhxSrx6z8L8JwGcY3dYWI=
X-Google-Smtp-Source: AGHT+IGd8YjULQ5BgNmgPudrci6pRddPv1aAy6Zho1lX9ktZjptVS9rb0mbIN/F9nZopayfpk8di4Q==
X-Received: by 2002:a92:ca4c:0:b0:3a2:aed1:1285 with SMTP id e9e14a558f8ab-3a3b5c7bd20mr4241855ab.0.1728595459638;
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa8cb2sm387245173.123.2024.10.10.14.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Message-ID: <0ba33212-d38d-42f1-9864-010e1802a7ac@linuxfoundation.org>
Date: Thu, 10 Oct 2024 15:24:18 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010165235.35122877@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010165235.35122877@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 14:52, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami reported a bug when running function graph tracing then the
> function profiler. The following commands would cause a kernel crash:
> 
>    # cd /sys/kernel/tracing/
>    # echo function_graph > current_tracer
>    # echo 1 > function_profile_enabled
> 
> In that order. Create a test to test this two to make sure this does not
> come back as a regression.
> 
> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://lore.kernel.org/20241004145618.18436d7e@gandalf.local.home
> 
> - Fixed grammar of comment
> 

Thank you. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah

