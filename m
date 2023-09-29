Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DF516DD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:10:28 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED20FF7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:10:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3232e96deaaso1640477f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696000224; x=1696605024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdqE1QXzZBxC4UvHDnV/0ctc/iRv4fmK/Ej1t0SOJgU=;
        b=DmWx5Lby+OMEk7SnGUHSNC3ed3MDt6Apfo366825LLy8CRvgAfjc2pOri4jmH6VWTf
         UmIAzZOPZ396gq+j2jfwi3qVkNsDACFxY8PDzjmcrEEhJzOyyOegzulIo1WWuwMKb98Y
         yQR82eTlZrHhCOlkHDdLRTWGnY9e99ytWuVJexub5q4JRLYRQsV83mhYNhBqgLNLoLIi
         MkTHYlxFTgtR+sQh4i1YCl42ipnC0R2YdossRZY1gW5m2l2SgQSOWjA2MkR8vk1jmtu4
         87MN9qaZA5NtWC5aVN+lNHxv945QKOFuVy3209IYjkxAzzcs75SZpUr95SQmiJRqbqme
         Alcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000224; x=1696605024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdqE1QXzZBxC4UvHDnV/0ctc/iRv4fmK/Ej1t0SOJgU=;
        b=oLH4Y8EPQcD8Uv/YHbnAwNAl9Q9GjhENFu1sz0VMA22ArYsdodDKOpYqWNlHzTCEln
         0V52D/1q2o7UCR6qQJdQIkw5C6zYg1cyGFsJKrLqxtmE2FsS+3elH1RGaNVVmS7WCx/N
         GkATQlrJ9ynfYpRAQ5iwThQD9YZpk8g9raxpWWK/jRK+Pw45fx8NiQeo0cMJCIgYG9S4
         hhmZQpHt47d3S4Z+/YyzBqDVqgSJMpW2/k2HHXcxS/4ejkWNm2f6l4SmrW80Wdr1Jmkc
         XzyI/CUYlzr3H6kXq3KVgCWWCesZ3cbm+M7nOl7lhbVGKVnhMNbSpKAEChXenV9kHmGW
         j8WQ==
X-Gm-Message-State: AOJu0YwEbMSFQxafU7kMhT1FRpPN7Ckg/aLpasO8/aQSXhXlOO/DcxEA
	7dV85jtMqaSFWxZ6aLvrKQ0R0xfj2DSMTgQJRMhJCA==
X-Google-Smtp-Source: AGHT+IGGcLP1PmINnAnHm98jDP1pP2LDbsZIgncAOogwc4atMmnVWW9wyjgJkN/jTMLma/8YQVlsPA==
X-Received: by 2002:adf:f9d1:0:b0:323:2b68:e0e0 with SMTP id w17-20020adff9d1000000b003232b68e0e0mr3467259wrr.0.1696000223437;
        Fri, 29 Sep 2023 08:10:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:4e67:5f1a:c933:c857? ([2a01:e0a:999:a3a0:4e67:5f1a:c933:c857])
        by smtp.gmail.com with ESMTPSA id d29-20020adfa41d000000b003197869bcd7sm16622036wra.13.2023.09.29.08.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:10:22 -0700 (PDT)
Message-ID: <d20981a4-cf46-4ee5-9f0f-b0aedb9b3d35@rivosinc.com>
Date: Fri, 29 Sep 2023 17:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: relax trace_event_eval_update() execution with
 schedule()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
References: <20230929141348.248761-1-cleger@rivosinc.com>
 <20230929110657.7a4b38ef@rorschach.local.home>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230929110657.7a4b38ef@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 29/09/2023 17:06, Steven Rostedt wrote:
> On Fri, 29 Sep 2023 16:13:48 +0200
> Clément Léger <cleger@rivosinc.com> wrote:
> 
>> When kernel is compiled without preemption, the eval_map_work_func()
>> (which calls trace_event_eval_update()) will not be preempted up to its
>> complete execution. This can actually cause a problem since if another
>> CPU call stop_machine(), the call will have to wait for the
>> eval_map_work_func() function to finish executing in the workqueue
>> before being able to be scheduled. This problem was observe on a SMP
>> system at boot time, when the CPU calling the initcalls executed
>> clocksource_done_booting() which in the end calls stop_machine(). We
>> observed a 1 second delay because one CPU was executing
>> eval_map_work_func() and was not preempted by the stop_machine() task.
>>
>> Adding a call to schedule() in trace_event_eval_update() allows to let
>> other tasks to be executed and thus continue working asynchronously like
>> before without blocking any pending task at boot time.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  kernel/trace/trace_events.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index 91951d038ba4..dbdf57a081c0 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>>  				update_event_fields(call, map[i]);
>>  			}
>>  		}
>> +		schedule();
> 
> The proper answer to this is "cond_resched()" but still, there's going
> to be work to get rid of all that soon [1]. But I'll take a cond_resched()
> now until that is implemented.

Hi Steven,

Thanks for the information, I'll update the patch and send a V2.

Clément

> 
> -- Steve
> 
>>  	}
>>  	up_write(&trace_event_sem);
>>  }
> 
> [1] https://lore.kernel.org/all/87cyyfxd4k.ffs@tglx/
