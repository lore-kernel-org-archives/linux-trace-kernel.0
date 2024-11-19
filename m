Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC81D221D;
	Tue, 19 Nov 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040710; cv=none; b=oXgtBMHcsgJlJIlNXFKyVDWey64JGHTnyH7gvFzzILZE16UGcQaA1Ct6GbAsxEViIhzdKIHn9ld7HVXPK/j7dXrO+b2X7b2r9Lx8DuSMeqqxBbJ8hAxxweDcgC2cxwmo8j6LEjr+Zont5t0pEC+Vb3gTj2zwtPvLQOiGwK95SCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040710; c=relaxed/simple;
	bh=3lCPMoGWzLtjPygigc4f8Qery8A8aA+i1q7jzItIXhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zml9fjhJNZFunZFZfRN5fVrEqcGpJL0MY7tHN8cBeATx+GYor7NiGtKOc5O72bDu4ukNWZ37EtrANSfsPSOIGq2ObFppiwzdOqvoyV1Z1qUReAZ3mXhP/fWTmXv0Y2jddZvhTYggFJHG7CXK17fHXcoOk9ssKNqL7RmDbwjbzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx/AJNGc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx/AJNGc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdda5cfb6so42658075ad.3;
        Tue, 19 Nov 2024 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732040709; x=1732645509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZEJJbqKhA6/rkUUDEL+09UZPYvKjISi6zGv7/oCUow=;
        b=Rx/AJNGcGh1VMM16t/x/ZmjxU8HDQBJ1fmTsyTB+8Lvn7iUxjVKz2OPQnceP0A7lp3
         5kXYy/ucMOn/1wFqknTtdOBpDqBIQOw/x2dihEeamfrUDFuSyTc7Bs5WIEhty5JtPCTX
         AJQVWQFmByvYO8kktcZVaHoShVGra6wCtrdF7pBprXLVLOjd56zW6lqi3sFJFWJz/632
         8IVHN46TcmOYhFR6F///VF7Ahg6hgZ4+63uBAm4fvuGqZIxBpuVUd6duVPDztMRhuWQq
         3pYIbdRarxhPqHTwRl1FY3hTFhQJuvwFhV4Pq9eAUMllSpWb0VoI3KK7Erz1a0OhrNeq
         6guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732040709; x=1732645509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZEJJbqKhA6/rkUUDEL+09UZPYvKjISi6zGv7/oCUow=;
        b=nD2NIxJITkJwW+sCb5w1qZsim477rfacMS562KBtEN1t0E92bGzthi+NM+kRecBSbr
         1PvVVZdEUbX5/x8s1HwfvwnHOZffGmmMK6ssIzIynQ2b5ak5AEGIbGoKBlKy8DSB1mrb
         m405o75V6zRy+FgN4SvnTzfEtj7JxEzeM0BenwIvV4VO4cLYnAqj/UONND0ed3kktfq9
         EFgHKSInau6NrTMwgFQxCQm136waTM8KFpL1aKeORKSsOU8/E8zBc1jqH4qa6xLC4/kg
         KmvHVWsg6mUT6iGImty4Xxf/pfSHLWZP1xU9DCQ4gIJJxiYoFyDZBB4EZqSPByHJG16U
         CtWA==
X-Forwarded-Encrypted: i=1; AJvYcCUCHw8sSQHLdDlPPE+NwCNpGeD9l5qweWcexPZIG9yNrskDqyViyiNBHxqdWspV91/fEdBIOQ1CenaavCY=@vger.kernel.org, AJvYcCXY3Vb6up7bkdx85R5gTkgaW9drEi5PQu9lfYptSn9XgIHTvrYL1klNqEa/5xOq2oBWreIjI3qWp+uoowu5KIYVHMnA@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNruI0Wf6Zd8EiIZVVfrSDsQ9NV8Kfg6uBPxs4tuyBfKNWhV8
	um0fS7bVSBf99z3Xiw4niyB+5XxeVh40gVpD4r0JFBbFxb5vdCnR
X-Google-Smtp-Source: AGHT+IHEKPK2gDXuWitcGqHFUrYnkJinjSfF+0szEdvRBnZ7yxgNS1534jjas5HYKrE1D6v5KG3XfA==
X-Received: by 2002:a17:903:1381:b0:212:3f36:cee6 with SMTP id d9443c01a7336-2123f36d4camr76832785ad.33.1732040708629;
        Tue, 19 Nov 2024 10:25:08 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:a422:b23c:53c7:43fb? ([2001:df0:0:200c:a422:b23c:53c7:43fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21268a24db6sm1535505ad.13.2024.11.19.10.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 10:25:07 -0800 (PST)
Message-ID: <1fbfc00d-27c0-4486-816d-50291bebc842@gmail.com>
Date: Wed, 20 Nov 2024 07:25:29 +1300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Tomas Glozar <tglozar@redhat.com>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
 <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
 <20241118152057.13042840@gandalf.local.home>
 <22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
 <20241119102631.76363f2a@gandalf.local.home>
 <20241119112850.219834f5@gandalf.local.home>
 <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steve,

On 20/11/24 07:06, Jean-Michel Hautbois wrote:
>
>> You reference two variables that are not part of the event:
>>
>>   "mem_map" and "m68k_memory[0].addr"
>>
>> Do these variables ever change? Because the TP_printk() part of the
>> TRACE_EVENT() macro is called a long time after the event is 
>> recorded. It
>> could be seconds, minutes, days or even months (and unlikely possibly
>> years) later.
>
> I am really not the best placed to answer.
> AFAIK, it sounds like those are never changing.

m68k_memory[0].addr never changes (that segment is usually where the 
kernel is loaded to, and can't be hotplugged).

mem_map is equal to NODE_DATA(0)->node_mem_map on m68k 
(mm/mm_init.c:__init alloc_node_mem_map()) and won't change either.

Cheers,

     Michael

>
>>
>> The event takes place and runs the TP_fast_assign() to record the 
>> event in
>> the ring buffer. Then some time later, when you read the "trace" 
>> file, the
>> TP_printk() portion gets run. If you wait months before reading that, 
>> it is
>> executed months later.
>>
>> Now you have "mem_map" and "m68k_memory[0].addr" in that output that 
>> gets
>> run months after the fact. Are they constant throughout the boot?
>
> I don't know.
>
>> Now another issue is that user space has no idea what those values 
>> are. Now
>> user space can not print the values. Currently the code crashes 
>> because you
>> are the first one to reference a global value from a trace event 
>> print fmt.
>> That should probably be fixed to simply fail to parse the event and 
>> ignore
>> the print format logic (which defaults to just printing the raw fields).
>
> The patch you sent works...
> But, it fails a bit later:
> Dispatching timerlat u procs
> starting loop
> User-space timerlat pid 230 on cpu 0
> Segmentation fault
>
>
>>
>> -- Steve
>>
>
>
