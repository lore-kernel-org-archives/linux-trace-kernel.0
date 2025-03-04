Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD25F988
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110557; cv=none; b=C+Ui1Cs2mukpmxhAsfXuTv/mrNMlsqZ2EAyh5xmYX311EVbgjDChKhSuuOHvjFBd64e8/plglPPctFi8bD26bvzhI36eqgMe+vysKu/3EHde+cWngxJF9baopQbmORa6sUJkFMLgIYHlOk+jazWiPK9h/+EJPwryMqBx2Pkp+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110557; c=relaxed/simple;
	bh=a/NsExaXFh0brcXTlOrd7Y9Oa2VoHQLFMML8Cnz3x8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4xU6HW5MzEKuwpQx9LZe7Szv2WtuYbEagD3mzflI5bxlImwXZRtVzIja8aQGv7TAjhlE9rPoBXfkzMb3xG1TDqm19/C6DFqtYl0ou/6V/mkmF0m1ORddWtGHWigd67w0Kz8Kp4UK8oUS9wwFBacGShgYRhXcqD12/C0NP3bOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQzlvL4P; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQzlvL4P"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85add67e9c1so1799339f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741110555; x=1741715355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=NQzlvL4P3ffJyregCzibatB6h+EOd/9u2ob2LaC66DSLUJUIY0VqvLWeSBQwpA7Ggh
         DQSZB6HVAAigouET/dQOPg/d3ee4W8vzvujgEeQnJVIrCEH4YfPLzpIhRDoF7VVbD1z/
         vj43j9Lvc5JzmBO513KbcxbUwZIghQsTtThkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110555; x=1741715355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=JhQUcAunjJvpZKhfKPUB6ecjcOuIz/CK+STmk4ZzyGBm1pDh+gBJm9qHGbPXKh40Z3
         kjoGlW7eYQ2ghi+USNmk0WYZP+j7O2Vikd05mL7kPBhgKIIobOS82EiYh0UgnskcqKZ+
         iiKeYg98SutECDsVD0+1gia4j52OuhH4FOP2smwJKUanNEm+9PC1J+YFU7w/sXw3kRx7
         cZ4SLzyy+Jcr6qXmxKNeJsmvPifXHqdLf3t3CW5hctTy3Lq7Loac65+gj1KkOcb8WJB9
         fb/v2doAf4cNw8hcce5O5+4n/IclclDrI/z4+2+zMbQq85RKF1keLfd5efgAQ4sN74ul
         bIwA==
X-Forwarded-Encrypted: i=1; AJvYcCV+0txn8yA5xSKL8j5Jg8etMNZhKHuVtsOdi3sLqOoC6n1x//FGT31nrZFcP9t5/2k3MQqhHFzy2B6KqQ4bG/gUpos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+RspQ4SOmLm7zU3o95B1Cdib25zmFsgIoQ2uFsTZ6Y9D49p6
	I5lvh3xe9a5hbWQQOpmhM5jykxxx76ELsPNDoUKkunYu3bsP82cwQN9VofGKwqg=
X-Gm-Gg: ASbGncsR53IbHjOUeN923oO8qStAkG/v4JRsxIQaeqWd38jbOLwUuyRC0hQmSApavTp
	hWMdo6TOKOoqbQHkOEXu9gHTE1tNyI+lG4y4RUvsxB5quSQOokeRU/fqgmqtrx+shpShMSWhbDF
	xc+MsOhYN2jicIbHbBcsOgwwnh5eKCXhu4ZGm1IBawJ2uMbZw/qJPs1N3ZW7hv7nxu6MMxTelR1
	QX9AU08FMWMKiYQTZ975fGCdaPyW2dbgJMx4GDpRt3Xu6ciPOjkIc9pKV+4tIVQDNKJ5o7mnp8e
	U7VJO0j1fTpLnjZ2iMx+71LtXZ7r5rOOlB2R7ogi4u18/XokWOigxZw=
X-Google-Smtp-Source: AGHT+IFe/EZGXyCyM4u01MW+pkyp+aV9q8tehK9bM2e7HADyRWDjWbe46QsDS+SMYJ3Ljp5Ifn3NgA==
X-Received: by 2002:a05:6602:370f:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-85aff6300a8mr5572839f.2.1741110555067;
        Tue, 04 Mar 2025 09:49:15 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875133ebbsm295183839f.28.2025.03.04.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:49:14 -0800 (PST)
Message-ID: <a9628a00-2bf3-4d86-8e41-c596079cd8f0@linuxfoundation.org>
Date: Tue, 4 Mar 2025 10:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
To: Steven Rostedt <rostedt@goodmis.org>,
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
 <20250303183625.5acc59ec@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250303183625.5acc59ec@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 16:36, Steven Rostedt wrote:
> On Mon, 10 Feb 2025 21:31:34 +0530
> Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:
> 
>> When building this test, a binary file 'poll' is
>> generated and should be gitignore'd.
>>
>> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this for your tree?
> 
> Possibly with:
> 
> Fixes: 80c3e28528ff9 ("selftests/tracing: Add hist poll() support test")
> 
> So it should go into this rc release.
> 

Ooos - I applied it for next for Linux 6.15-rc1 since it is just
a gitignore change and not critical.

If you think it should go into this rc, I can apply to fixes and
send it for this rc.

thanks,
-- Shuah
