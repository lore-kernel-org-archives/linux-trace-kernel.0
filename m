Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2K8ACgR"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C4109
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:16:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1b54b58769so353729966b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701792975; x=1702397775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQzhIqn6N20Rb9xIg/ZWOpbjV4kaWzviVQteSO4jyfU=;
        b=H2K8ACgRrRkoEP8aeAMagyOG8JafMmIoK+lpyiVhabAwp8i084b4goARvY83R/H4wm
         Vue2ty0wYiKV6pBPUwPYyVwlhWM7EJcJuaS/sc4vtbv4T2gyZPsMC82LQ1KAd3niqgy/
         e9wZlGOQcMB7i0S6kCwcHhuA+si5mCnNlf0X8dnO1ULqKy1pDC/KnKXL/Kg0qEaT1iRd
         5wVgaBSCkGxK1mAskfiwCFsUM17nteO37h4QKmifHic47BgF2ABprlfJdtHRg4u9yGK2
         0WWuzPq2pXFCq/Q0qgDksiHiuk0q+FZRwWIzlZcLfNa2QJZa4dbklqpf2S59TIDlYRjc
         So1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792975; x=1702397775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQzhIqn6N20Rb9xIg/ZWOpbjV4kaWzviVQteSO4jyfU=;
        b=r5haX+Jgvyi50nf3AbEL3RU2UhpFBKOhigVli8U7U5/CYOcI4JSxWruHn0G4GoCCT2
         GkU0BUjeoJcf/znXFf8smrEo4XYtbmxzpjBlPPArFAfEUDchF2OJ8zovDtSsyz1//pnH
         B3VBDXfVm4UkgWQuGK6Ak32s9IggNNPntUITsAwAF14kh4N6NRoTJu2Pccncfo5wGpkh
         NIxqdiUfsdre7ZOgzfMeYT8AWcL5L1kKFFRgxZgtr7UicIW0Rh3bp+zW1P2dVoaddvfA
         BA+TRUyfhx8ZoVAeIlbCeViZe5FGTmYRxOs5QZaIY2CLItDmZENHdFUHCHMVf8tpP8hr
         7zzQ==
X-Gm-Message-State: AOJu0Yyy4dfMAFVkq6CsWQoFuJVrZ5Rp0nnm7wBTvE5sDOW+wmuUEbMO
	HrOdiYDi52yEVx8Il16eUgLu/Rx7L3byo/syKpOwPebG
X-Google-Smtp-Source: AGHT+IEV7FDtROfnK2ZE025N5TruFAYgEWXqxKm3z65r6cifQme8jakJIoP6RonEEeqXbjdm0+ZnNw==
X-Received: by 2002:a17:906:f0c4:b0:a00:772c:c879 with SMTP id dk4-20020a170906f0c400b00a00772cc879mr653564ejb.38.1701792975219;
        Tue, 05 Dec 2023 08:16:15 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id qc14-20020a170906d8ae00b009a9fbeb15f2sm6895238ejb.62.2023.12.05.08.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:16:14 -0800 (PST)
Message-ID: <490c77e9-e3d4-4499-8471-128804fb2e7a@suse.com>
Date: Tue, 5 Dec 2023 17:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231127151248.7232-1-petr.pavlu@suse.com>
 <20231127151248.7232-2-petr.pavlu@suse.com>
 <20231127124130.1041ffd4@gandalf.local.home>
 <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
 <20231128102748.23328618@gandalf.local.home>
 <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
 <20231129095826.1aec6381@gandalf.local.home>
 <d404113e-4ffe-4e9c-ab45-1b076c1f498c@suse.com>
 <20231201094639.03a1913c@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20231201094639.03a1913c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/23 15:46, Steven Rostedt wrote:
> On Fri, 1 Dec 2023 15:17:35 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> Ok, keeping the current approach, my plan for v2 is to prepare the
>> following patches:
>>
>> [...]
>> * Fix the potential race between trace_buffered_event_enable() and
>>   trace_event_buffer_lock_reserve() where the latter might already see
>>   a valid trace_buffered_event pointer but not all initialization yet.
>>
>>   I think this might be actually best to address by using the same
>>   maintenance exclusion as is implemented in
>>   trace_buffered_event_disable(). It would make both maintenance
>>   operations consistent but for the cost of making the enable operation
>>   somewhat slower.
> 
> I wouldn't do them the same just to make them consistent. I think the
> smp_wmb() is sufficient. Don't you think?

Looking at this again, I think it is actually a non-issue. Function
trace_buffered_event_enable() only writes the header part of
ring_buffer_event but that is never written nor read by the actual users
which obtain the buffer from trace_event_buffer_lock_reserve().

No change is then needed, it is left out in v2 of the series.

-- Petr
