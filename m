Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99C84A35
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341148; cv=none; b=nDTUdlJhwN2GPDb85vuLdK5/3d8BGz7PR/7vW2OvYobH70FL3VaUBOZCtRsbjxv1CetTxul0jVmd1QCgjm+qGw9kUiOUfDvel0+xnAZksGcUqldVag9PQm0SIyXJobXw0tHqJUF0ohN6Pig3igbfo2n4VEtHwgxKuCVeIStiZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341148; c=relaxed/simple;
	bh=XtM19fp6llQW0I7FSfQu/I/iDTjKjadmXVKD8lRQnqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkH1IPAiwrcPMR2fddM6gAdrwVuKOUX7v8kd6UkwSAD3VLS5DSCB3WObvmcncAgsp9r5CX9Ze0CBoMlT1pRV3Fx3FgDfW4VpMd/tYRcpCI9txZpw+UfGTo+OdR6JXa7qPsduc8TTF73poPE9FulY39zGFAmjlSHTK2VxXNKF3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=He1CgaJi; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="He1CgaJi"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so35499305ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745341145; x=1745945945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy5TPkMpiqRKsqQU6VOgWl7+8BuUE5e/MNZHqkVmKvk=;
        b=He1CgaJiwOmbHxvK0q/o+gua1ALmOGVg8Bd49bIDyzzDI0widbOzOja0JmfQX8K75S
         u/BsIoVycC00owUKLjCumkPdlRwFIiJYquERs+2CBRXuWQXzN6avgcHI3MV8DsGo5gpI
         2ebh42wrnNY1V0ve1kvtyUq4tfMIUbug+7/cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745341145; x=1745945945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jy5TPkMpiqRKsqQU6VOgWl7+8BuUE5e/MNZHqkVmKvk=;
        b=t97ccKAX51VyDDQWyWQoI6mRLAhDjm/I5jthnlVdsOjK7vlFdlOoQ+EBiK+dZVGZr8
         vcaXtqujl6FVKv7WyTJxcQEb5Ja1VIoKygRHX6toirxst+CTNjpQzroJi8WOB51uB5i5
         leHA83QYpyZC+qaLzt3GOBeTbM/gC2ty5nevE0MO8cXITfX+Am/l93BBTOcXhtCGpbc+
         bItlzE+4YWWI+7L3cDUW+wZfagtG/Veb9993Wmr9C/DZw8L9glMLQcA7eWtSmVmc0ePP
         h/sj9T0kmGM9oMBKual4bo1CSAGs31JZDUilJybpXYBpQAdZCGC9Y9LkD3ZP667r0YXh
         TnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU8PTBDOX+RShYohwknFfglMrXuSLW/0o584sOyTBgPCnmEeluSCECjCYoZI7H6sdjEyJQAbvt3JBZKWTmQVwMQY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFchHicxiZt2kOQu5BhMTC9PcQvweAVrGJUYHYzyKvzNheHPmA
	YBhfmgVRWs7k0CHJqp5/i08S9nA/0Rou2XqVtt6RLP54P6BywPm+AroTeQ0B5b8=
X-Gm-Gg: ASbGncvnga3IZMQJpslUOPTHMyWpWZS7F61uNAMDLhp50lA7GwQ5ByJU6tc76LBeY3R
	ZXn9L3CFyt5kv7Pxd7FrEGLrllg5UnXcc0Ln0XxCodPJzlpP8lQ0fyFJiTFD9kvuwg/zIM9JgnC
	N3WZ3Tt8sC/oeUwpOQKfEaipLHD5+GUcenpad7wL5Iw0evVqtLcKuTKwcWAzR+ngZw1w+76cZSL
	MqvtmBonvLItIYrUlvqxiZpMWGg4HtJ7jT6DpzIturSIQyNLbpfXxIYV6/4s5qdV+REJfjIJkmn
	2gBn5WyqIq/5Ed6x/XQuSJRS6VgZkjwUUtfGaM4BHWrNZSJv878=
X-Google-Smtp-Source: AGHT+IEWkZs6CedJNt2KE1miQGjqJBAptodtv2M35SklMJZz7zNwT8QqCf/45+jwRTedwK7cIsTwaw==
X-Received: by 2002:a92:c24f:0:b0:3d0:19c6:c9e1 with SMTP id e9e14a558f8ab-3d88ee00454mr153841585ab.13.1745341144724;
        Tue, 22 Apr 2025 09:59:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3957613sm2412786173.120.2025.04.22.09.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:59:04 -0700 (PDT)
Message-ID: <de2a5e52-8061-4907-bd48-0d6d28b83b75@linuxfoundation.org>
Date: Tue, 22 Apr 2025 10:59:03 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: selftests: Add testing a user string to
 filters
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250418101208.38dc81f5@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250418101208.38dc81f5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 08:12, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Running the following commands was broken:
> 
>    # cd /sys/kernel/tracing
>    # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
>    # echo 1 > events/syscalls/sys_enter_openat/enable
>    # ls /proc/$$/maps
>    # cat trace
> 
> And would produce nothing when it should have produced something like:
> 
>        ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)
> 
> Add a test to check this case so that it will be caught if it breaks
> again.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20250417183003.505835fb@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250417223323.3edb4f6c@batman.local.home
> 
> - Use $TMPDIR instead of $TESTDIR as test file (Masami Hiramatsu)
> 

Steve, Masami

Do you want me to take this for rc4?

thanks,
-- Shuah
