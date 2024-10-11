Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AC20967E;
	Fri, 11 Oct 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630744; cv=none; b=gLRueFtB1nWRVU3zSZHbGnCgmSkHSZg3oO8Md6amdbud5H3I9JoF4misSUL6hXqYk6KM0sYSkAFqJfTCpA7HaOBao22qRqCBDfDPjbH5QcyJaKiCOBQ/opbaC9XiHH4qJDMSrK+TCFGHsbX5OSW2sdbqttp824Yhu57+gSbOhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630744; c=relaxed/simple;
	bh=tY4TYXxX/WadAeNKarfkA3AXEpoRczdft7qlw/eTD8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNCnD1ktXE3zrEmj37MH0mDcUKkZZ0aqfLRX5mk2XoCzIsS7wOyZ8fEIQp9lgcb0kgbeVBMQ5aC5yXqI+lAfuGDYu9+hqqefl2q/ixUadENBwSQ3eeo9hN+DhoHVKnuZIBQA4KcwVCI1FZ4eP501L1qpDJEACK9Sx3X47djuCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjVTwDlu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjVTwDlu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c693b68f5so17453775ad.1;
        Fri, 11 Oct 2024 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728630741; x=1729235541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF7M0cebwJ63IntgzoRMWt16PVXK9O5OCPTAkQex8RI=;
        b=hjVTwDluv1aEkscT/lvYwZ/4Cf6XSjscs0I/T+oeRcAUWQ+uuxt2hXGXG4vJ+ZjaP0
         2NUSvdNR5JUTGy0XXcDRlDXV4NZ2aORDqmI6nfwNUmiLdTuIfbmH1jBSbJMeX5Mr4xnx
         xzAyJKFCn+ydgmhhb0PRQxec+v4b/aAOZTDKWlq/nDNnvjUEtaFlW1S3qQ0BFD4IV0of
         kJTUdRboA1Oz0bf1UTqEyXPpScgQPd03+m53Mdl3UUf8YtlhMOspAx7OZEXpdOM8Eyi6
         Yup48+0KSdJpq7eyTlCY+y5ysAPYgsIqApY9Dx9Ac4nKNRzwS0Jk4nHQa20esUXiFcRL
         UgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630741; x=1729235541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF7M0cebwJ63IntgzoRMWt16PVXK9O5OCPTAkQex8RI=;
        b=LxswpN1tLdKDvbuueJd2USrDkijUk9A7Q/jLwAeaILQV20tf6eFhDq/a9g3mCtXhrf
         xEmGAQjXQ9QjGD0o7f4YT3zrNxI9VTUGj622Tq1Ffnnwd3X0OaIi81OFjolx1OWtFOA7
         xVTpNVoTRR83Bgy35AZ5PrHiSef4ghRoGViTE4RoEm69Aay6Hz0NBcZB7qS2r4Jx9QwN
         ZHkas2hzEeDFMrbx2nAyIJThAiINIhTDlzZTVVZE2AgwrI+ZxgBdHAbl9Ssdoge8+H4K
         ULsqedi8oRfTVjEbPcBplJiUj99bknzhVHuQP35U+CI3fYVoXwyxflSLWXWrD+Cir7hY
         gu6g==
X-Forwarded-Encrypted: i=1; AJvYcCUijNgc6V90C2V+0KZ7R6/HPgAbgSnG89HD7z8ZjlEBTLp3DpesIGAcl7HwXLPVL5BeOt6MpovRwcg=@vger.kernel.org, AJvYcCVk7aa5Ey0ol1GnNjNcdXA8ZXeieD2QjhBpf0BMcpxguwz8HiMWYL5M3iTxJY9c/UvOHWdHZ0t8ejwR4W13yJ+QlYzc@vger.kernel.org, AJvYcCWhDRSWPj/7Ro+Ye7Xak7EZG0G+rpwksNqv3XXPEPAo17NdPnw5n/p4K6hoasVsInNG1l6pxoxxMjwPkrgk@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPy7hugOTcCO4XrxyMzYlvmF/kLisb059vxmUff+f4X11XR+e
	v8NjFXO2NTA84wBAuPlOf82QpLt9I5FklYiK7gpQKcoSsEAb5O66
X-Google-Smtp-Source: AGHT+IGurRqmXPgBljb7X8G/0d/ADwpqBXAygImRXg3sHuPg55cFVXhCCEzdFL6RWOZYFe6ikJ5dcw==
X-Received: by 2002:a17:902:e845:b0:20b:b26e:c149 with SMTP id d9443c01a7336-20ca1467cf5mr22313035ad.29.1728630740851;
        Fri, 11 Oct 2024 00:12:20 -0700 (PDT)
Received: from ?IPV6:2409:40c0:11a4:8d8a:4468:2628:16ef:9650? ([2409:40c0:11a4:8d8a:4468:2628:16ef:9650])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e74aesm18692215ad.152.2024.10.11.00.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 00:12:20 -0700 (PDT)
Message-ID: <e7851def-91ce-43e7-880a-22dc5752c4ad@gmail.com>
Date: Fri, 11 Oct 2024 12:42:14 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
To: Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
 <20241010154708.0bf658a3@gandalf.local.home> <87y12vzqg0.fsf@trenco.lwn.net>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <87y12vzqg0.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/24 01:21, Jonathan Corbet wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
>> On Thu,  3 Oct 2024 01:28:17 +0530
>> SurajSonawane2415 <surajsonawane0215@gmail.com> wrote:
>>
>>> Add debugging.rst to the relevant toctree to fix warning
>>> about missing documentation inclusion in toctree.
>>>
>>> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
>>> ---
>>>   Documentation/trace/index.rst | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>>> index 0b300901f..2c991dc96 100644
>>> --- a/Documentation/trace/index.rst
>>> +++ b/Documentation/trace/index.rst
>>> @@ -24,6 +24,7 @@ Linux Tracing Technologies
>>>      histogram
>>>      histogram-design
>>>      boottime-trace
>>> +   debugging
>>
>> If order matters here, I'd like the debugging to be at the top. As I plan
>> on it being more of a tutorial for using tracing, and should be the first
>> document people see.
>>

Thanks for the feedback!

>> I need to take some time out and start filling it up!
> 
> That's the order that the links will show up in the rendered page, so
> yes, it matters.
> 
> jon
Can I send an updated patch with this change (moving debugging section 
to the top)?

Best,
Suraj
