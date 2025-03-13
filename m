Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89948266B40;
	Thu, 13 Mar 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868185; cv=none; b=nfzDnRHyaOlz/WuyyV+0ccNHuZbupeSD2Qf6lttm377H0vq9dTU7lkes8Eak4Vx5C6ibnsMRF5A/X8mY0MNrV3/RuV7OiDdVGGk/SkrhU+8gIfxTQVIW1VvvSjLhZMotfzAZcOlatNA4Ldg+Pd1CtLA54o/lQgot8LtjRlE3leY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868185; c=relaxed/simple;
	bh=+TIjaWLq+k8j709rR1HauZvIDScpqyb45V6w2bWtKHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4HTWp0tMOU+tbOhz3jTO64af19oJHU+TEEfWNR9QC76xP0IlH01/5QsyaxjAO9b1tNlZkrGw0y29jO8gZV/c7V8dZvoNcbBYOu4OcZqXo/PBG2BPCIyD9syWJ4Gfgzr4lN+FF/5LxV3Ba6gGHoqewd3EKsJWYFiQ7RNZrUjcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roxd87ae; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roxd87ae"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22355618fd9so16202495ad.3;
        Thu, 13 Mar 2025 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741868184; x=1742472984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm8fq5i0vpAjTWwW3jwRc1uPshAS1XnTW97HiaXAENI=;
        b=Roxd87aezQfpGPSbvyXc8BDi8EwGZR3BYyrtLSU7dE+60ANO/R9XUSeoB1qWpamM4c
         2gnWCD6uo8MurvmHA57jJbeh2SbyrydJTjPUCHURhI+swI8BOj66w0bmmvZZjVzITsfZ
         oHaNN4PmlT88Y6GwFT4Ltla+k9dEzTyQXp3wgVzGgcpbFvSJxnVN0mhBpWjKzQmzUn6d
         WDQtoC2S/Z6GG6r23LcnM+O0wqVMK1fqRdAYhcac49XcokUqDH+ZZbK9OTyJUiwJGc+5
         HAiVIkgh+0HRq8U/vNM871zvThAuaEYSgMYpxhFlf/4dYmdqe+dAIU6wskhdc6zHQW5F
         O58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868184; x=1742472984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm8fq5i0vpAjTWwW3jwRc1uPshAS1XnTW97HiaXAENI=;
        b=UMBXaW/Qfvcgz5XEVvE82OzNSSigI2VcdA5ElKi/ahBzn46gO6P05Q07JpZnwbWcfu
         w7pv7DkCMlT/DF9YiLMo6+OCQCqmhpWoMXktmUHaxAhoFHJNOzM9P6EJTJQiROY4YmKQ
         WedSWhlfEbfClzu3/mIV/vr8ltX9EPVqyodl8x+oRnNty5hlXuF/4A7YxgNuM2w+rjpu
         Di0KqhLW134aYaNuIwJuL2bh2Wpbb0jX5GHXpVgRGAXgGr/VSE7sJV/qxmTOhn00ZRiR
         cPdK5gNJrsSdDArLs8OsALqYHWja48L/yK9fH3oF4tjtcgnxzCn3XICpp4JH51s0+F+g
         Je6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgCOvhBfMz33cIN4nFNwULHCFVmOz3Tb/JC0d3/ZUtI/SvF2c9WsnSUobWBUP1pl/DITkb2NZiWc8oA794wl+LEiN@vger.kernel.org, AJvYcCXB7ChE9a4cyMBrRbW4MdU3YtaoRr7Mnd/UCbebyRVGhkHi9yc26D+KLHBW5ogbOkwE0MjmvSVNtrM=@vger.kernel.org, AJvYcCXX4uftehqc7Ji7jJW4xbwFkACXdh4h7TGijyQTTJT47NLM31Itwa8NPm+oS33CXenG6gRHmUlUHLC3NiKy@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQ+FJ5zOoTepBQHA0FxPCzuP88JKXq1SWUPzmzaCSBKQWHplE
	dRczVHGSgkh1JbYH5EWvY0p7wcRB7kPAU4Iwvv46NGAg813ABaz+
X-Gm-Gg: ASbGncuo2eG7siTWqafMmhNw8RTg8U/zxL5/dz+ZzazTdjH/Ym29UdkHkt31LElv3ZF
	DP+gjvAm3qi8ANXTfVaFOOWYf21YxS+Bxb/rfWpGDcn/kF71ZG3pioAiZfON9xST4Jgln7D0YMJ
	mai6ePqHIJ3yqt4k+Galn8+XHBqGLKs6NsFskshNzHJU9MQ9h1Z6jlaAD/2uSV3P6cMb+hTkv9B
	JE+CqilUAws1YhQvMpKq/Px8CjFa32Be5MSpoOTU+TtqaeuhR9BpcCb06/LaC+mzidwXr+7NPF+
	Rcp/7ajWhQh4rnoDlxIdWhE60pjlgCmN5mhuf82jxpR3hYRdJtGf
X-Google-Smtp-Source: AGHT+IHQtvAx5vR6EcoVx3cqc3qpwWGM7hmtHRZwrnH2OnV0qoF4IGFFKA3P5vGN9Xmq9qQXGCx1xA==
X-Received: by 2002:a17:902:e84d:b0:221:78a1:27fb with SMTP id d9443c01a7336-22592e21969mr157466725ad.11.1741868183631;
        Thu, 13 Mar 2025 05:16:23 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6c6bsm11691775ad.150.2025.03.13.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:16:22 -0700 (PDT)
Message-ID: <4cc0a072-3eaf-4fbf-a334-012aacf9039f@gmail.com>
Date: Thu, 13 Mar 2025 19:16:17 +0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
 <20250312134907.06d27d78@batman.local.home> <Z9JKqVvG1iw0bFXR@archie.me>
 <20250313070457.647c8c57@batman.local.home>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20250313070457.647c8c57@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 18:04, Steven Rostedt wrote:
> On Thu, 13 Mar 2025 10:02:01 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>> If you'd like to generate a patch series, you can refer to thoughtbot
>> blogpost at [1].
> 
> ??
> 
> This is already a patch series.
> 
>>
>> And you can also add cover letter by passing --cover-letter to
>> git-format-patch(1).
> 
> It's simple enough it doesn't need a cover letter.
> 

I mean I'm directing my reply to Purva.

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara
