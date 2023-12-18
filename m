Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785977207F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R97vqgmz"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35faacfc938so1705765ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702932563; x=1703537363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYPt88pj2T74K9fmBn4rP1VeeeJodupmtqgeHgWnKoY=;
        b=R97vqgmz/b02wNEWRBKir3DI/FbxOGk4ua+P1Puz2MInhnsmj9x/cs062uv+iDFG07
         S3qfJ2M2BwtJXc4u9cVWLRirGlEPn/00wYT3uXaSCmBo+7z8WcEZ2yBFkZE9BK5UwHGv
         KxtYmM9DdZ4IrCHfYPndPG427RtR7NnqgcbBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932563; x=1703537363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYPt88pj2T74K9fmBn4rP1VeeeJodupmtqgeHgWnKoY=;
        b=VbYCqOYSYJHFvX/lj4lOL0wWrRHuLr2zZVnB4+mPsOPJgki3DO2KIChQ9MUn4IvXJH
         u5kUJc2tXKr9phYCeTv9PrTR2b5iq+fjOgO3VI+VpoG1b0oOmedyMa2nw+PftfCDXBA3
         eYouwrSmBq7VbJOQXh6vG1TWCqXFsfORqYYMhKnVhewjyr+oqva0in0YTSsQHmcdGVv9
         AnhFNJHG6qce7hjWd2E+YqSf9DSFiLfOUu2Od44XKtMEfgaP4VWjEQeikscTJ95f9Vxo
         o775WNUyDlkD18xuffUrVIlSORfP1tUX/JRRGx52NuAw6jeDKrhdW+Crh5o3owouX62D
         o9UA==
X-Gm-Message-State: AOJu0YxqVm4NCcF43Nem8jkF+1wgcpuFJeV7pgfwzmKdsjFRTnS6IX6Q
	TiyWuKxW6LzvL+7soQbKsV4EcF4CzWs5Fg9EP1c=
X-Google-Smtp-Source: AGHT+IFBKoR4bA6tNRKQfsEUuZjiVZaEpX3AtmKcSCIhUu+SMSZYs4QztVBPBrDNi84cG3Bhx8Ua/Q==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr28614854ioi.0.1702932563645;
        Mon, 18 Dec 2023 12:49:23 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f36-20020a05663832a400b00469262e9f14sm5557049jav.130.2023.12.18.12.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 12:49:23 -0800 (PST)
Message-ID: <9978c0db-ec37-4d99-847b-86098bb0ba98@linuxfoundation.org>
Date: Mon, 18 Dec 2023 13:49:22 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracing/selftests: Add test to test the trace_marker
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231213111527.6a4c9b58@gandalf.local.home>
 <20231214075926.e3969c8746068953fe910ed0@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231214075926.e3969c8746068953fe910ed0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 15:59, Masami Hiramatsu (Google) wrote:
> On Wed, 13 Dec 2023 11:15:27 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>
>> Add a test that writes longs strings, some over the size of the sub buffer
>> and make sure that the entire content is there.
> 
> This looks good to me. and tested.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Assuming this is going through tracing:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If not just let me know, I will take this through kselftest tree.

thanks,
-- Shuah

