Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3921A455
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 May 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810225; cv=none; b=bIazKWzGTg/dEqTCZ6Kn63qA14nKjv71iMvwVWLHlO8YVMnetP26yHNzKvYD3MUMfuzyL5uu1A2F7C+GkMoU4lzrQSNN3NbGEYO+M1jKU2WPeInJdzbrn/KscCVmFRDTezWM9XHQ4soQCfi2dk470yEhMXYou4soMAwnz/omclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810225; c=relaxed/simple;
	bh=xBy9z9qoIyBCdJ0TEb3T7p6Ufk8Td87Yc2gExoFB528=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRBZ1/Xt+SEFgMghMsSlVgiO2hw93tRIhLM74znO0Lr6nqSbUpeTXF1UgjtC+XXVmvhdvKCsW8r93rhVwMU3t1ZLnJLZAtfiXCvtTwO0uv4FMDHXSoOaEOWdgF7qdrGrSBnQxmNhnPmKOxpfx/x3bURzLGXj6ly6VQ4mUv0MguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JA7GZt+R; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JA7GZt+R"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85dac9729c3so198312939f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 May 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746810221; x=1747415021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86jg2jZVkyd1MUCPfhL5AkHN1Ejwp/KScOnUCxw+kzU=;
        b=JA7GZt+Rkb8DyjxxBIsb4OH8qzYwbcYTTIYbHULjJVw+uVFjJ3u1CTd4dcWw69PnxY
         Wpp5k4S5kLJOtF0kMIS9dLgNkOL3jDoJfYr2odIz1u2Gh8v+OFV9ijF/NSZy49YYxc98
         RUVfxqvGsoznppMttHqU9j3cmZq7N/Xxog5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810221; x=1747415021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86jg2jZVkyd1MUCPfhL5AkHN1Ejwp/KScOnUCxw+kzU=;
        b=RyCozlYV42CRhkBy25ukK49G9l5Wq4h7Hn4LfgPnDfNu/lWnXSt3SQUjdBbN5Y1B0j
         8Im3yG8ZXDkY5s3SAeTBk1gin+FrZf6bEhIQmATK6dsGg3crWnoYOK1ZuZQpTLWHpA3w
         i8MihfmWfLGnKp3vZxGAfUdKGvPH0ylloz22XG8PF8lt4Do6PkejZvvhWj9J52yNEfkL
         wDYkk0IbQORq2+BxXFL6d+Zf3ARhq5/NzLE+Q1WvbHcqickeIpMjebTgP7qgps9bxRtN
         268c/bNgpobUGINoLF8wmiPPM+uc2RuXKV4iBI8zCEVx73kbVoM0iZxbIUkOKyBFU5b7
         XAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkxS5L6WpMT4vCfPeJsS6v1voLwkxsDh2/2JFGtgE+2WWRkVc1lm1EURsELF+OGxky6ewjQ8nQP1faKB7hz3bzxCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnsDPNuS9oB3b7+QMQ4E5YHoVIyFnxm0I8zL+y6it5KQiEXZ5
	bjQxQOz40EoqeDdQG5ZxfpGN/yJcOluPckRfHugbuv6gR0vOiC3xwP+VltCf2qE=
X-Gm-Gg: ASbGncvx7o7iAaDSF6AwRHCDFIU4zLF42GOs2PD0k5pL0gmvm/6xWddt5DNnBHFeQe2
	N9PCoMEz92JGzsuyFA+2qjMz7+IdyUPRvOtUDonUZhAlZYtPgcb5kiXyzUzDCBohzyFmnu7+R34
	+b7IZ3Xo0K+ioscfYyuI+zcA469Utvsmgc8xpY1+w1xU8f3nNMd3UjMKO+Bz80IE+HQfahO+7p8
	aX7/lIqxnDCsxgKWqD0ECgo16t5xbfX9+MIWfKf5g5ezn5HmLpEW9l3TbXp1TR0uzzvBK+yBwCc
	r3Te2nTbAVShN3juZRj7nmXpmteQg4SP5h3caaaSv47X5O1g9EKQ5CZQd3Cl/Q==
X-Google-Smtp-Source: AGHT+IGTWqfwSqopxk2jtrqUjuYm1w/WdHF2kTGMBDH5rszV8vB2geURSZzxlD0eJ+oY4RWQCxLEWg==
X-Received: by 2002:a05:6602:1402:b0:85b:43a3:66b2 with SMTP id ca18e2360f4ac-867635c3eccmr482377439f.7.1746810221015;
        Fri, 09 May 2025 10:03:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa226535f6sm473050173.105.2025.05.09.10.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 10:03:40 -0700 (PDT)
Message-ID: <4f3eeda9-b9d0-41f6-8a05-b845cf020b76@linuxfoundation.org>
Date: Fri, 9 May 2025 11:03:39 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: Convert poll to a gen_file
To: Steven Rostedt <rostedt@goodmis.org>, Ayush Jain <Ayush.jain3@amd.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Naveen.Rao@amd.com, Kalpana.Shetty@amd.com,
 Narasimhan.V@amd.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250409044632.363285-1-Ayush.jain3@amd.com>
 <20250409124855.4dc8fd58@gandalf.local.home>
 <20250507152653.4af2549a@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507152653.4af2549a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 13:26, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> -- Steve
> 
> 
> On Wed, 9 Apr 2025 12:48:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Wed, 9 Apr 2025 04:46:32 +0000
>> Ayush Jain <Ayush.jain3@amd.com> wrote:
>>
>>> Poll program is a helper to ftracetest, thus make it a
>>> generic file and remove it from being run as a test.
>>>
>>> Currently when executing tests using
>>>      $ make run_tests
>>>        CC       poll
>>>      TAP version 13
>>>      1..2
>>>      # timeout set to 0
>>>      # selftests: ftrace: poll
>>>      # Error: Polling file is not specified
>>>      not ok 1 selftests: ftrace: poll # exit=255
>>>
>>> Fix this by using TEST_GEN_FILES to build the 'poll' binary as a helper
>>> rather than as a test.
>>>
>>> Fixes: 80c3e28528ff ("selftests/tracing: Add hist poll() support test")
>>>
>>> Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve

Yes - I will take this through my tree.

thanks,
-- Shuah
