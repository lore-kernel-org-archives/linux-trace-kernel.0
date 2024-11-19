Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A81D278D;
	Tue, 19 Nov 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039610; cv=none; b=VeazHYT81frrqEqhzXZRkx2gMRIOkQwyFC5doiESZ5aw7058Fgs3T0ojk+o6vaYdZLpqd9Zyo0D00ibpAPWaHXS2p/GsqQfg0S4Kxk+wlmzugZ6EIf/rgzEYjJBrB5twxeL7/hqgdWN/gkptMPCoDtL2ccVE1Cpz28kv1fNy4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039610; c=relaxed/simple;
	bh=QGqkVr+lQ9tBWFbPJo39TLz38/s3nP9pyzYhLxzIoEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgjBvt9+7n90MfYzVsXM7vm7SXG1+SoROn31yuoYsukKEH5lUP2MZ0ciQ3NyIK1O/MjdL8+Wku7qxHmCy5ImWj7C/wtoflrLGIOsXb4/jOTrbbTmBBEGfIwzfm7cTwqlKrCON7DbDDhZeaFPc62aP30SBjx94KOQUmoQYHT6rt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=fNvZb8my; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="fNvZb8my"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C094E0002;
	Tue, 19 Nov 2024 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732039607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIePdDXuaFGMpm0Cb1pmK6uomOfslkb6cbYOV8b2Dv4=;
	b=fNvZb8myioZG7rUSIxE1yUJ15beYNimdXxfwf9oj1NKy/gMq3U5aUs26+qxTLXECrRk1t9
	9ylGjGHmPaDuyYunz5ZYdcxjY2syJrWJAWMZEwr5U9plw+qL8FCZCdTU6coa/AMZUX9NGZ
	P0v2uxT81RvPimH7FSoXwqYv6pz1YpRDA7ncgq0fsRwH7zT55fXMENXgrl5c9buBx+DGzw
	Nqd5e/ljMOEwPPoCiiJLD9ska4LU/Ph+/IiBsEFTvEakrlBJf9j6ntHYV1WvYRIxhg6lM1
	f7e/siKGtF4QBX1NPXe2XBshnFx0/3eymyltAa6vgWKbw4ob/9GvY0CSDywj2Q==
Message-ID: <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
Date: Tue, 19 Nov 2024 19:06:45 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Steven Rostedt <rostedt@goodmis.org>
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
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241119112850.219834f5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 19/11/2024 17:28, Steven Rostedt wrote:
> On Tue, 19 Nov 2024 10:26:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Can you do me a favor and send me privately a tarball of:
>>
>>   # cp -r /sys/kernel/tracing/events /tmp/events
>>   # cd /tmp
>>   # tar -cvjf events.tar.bz2 events
>>
>> You can't call tar on the /sys/kernel/tracing files as those are pseudo
>> files with size of zero, and tar will just record empty files :-p
> 
> It crashes on parsing this:
> 
> name: mm_vmscan_write_folio
> ID: 198
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:unsigned long pfn;	offset:8;	size:4;	signed:0;
> 	field:int reclaim_flags;	offset:12;	size:4;	signed:1;
> 
> print fmt: "page=%p pfn=0x%lx flags=%s", (mem_map + ((REC->pfn) - (m68k_memory[0].addr >> 13))), REC->pfn, (REC->reclaim_flags) ? __print_flags(REC->reclaim_flags, "|", {0x0001u, "RECLAIM_WB_ANON"}, {0x0002u, "RECLAIM_WB_FILE"}, {0x0010u, "RECLAIM_WB_MIXED"}, {0x0004u, "RECLAIM_WB_SYNC"}, {0x0008u, "RECLAIM_WB_ASYNC"} ) : "RECLAIM_WB_NONE"
> 
> 
> It shouldn't crash, but it also found a bug in your code ;-)

In my code is a really big assumption :-).

> You reference two variables that are not part of the event:
> 
>   "mem_map" and "m68k_memory[0].addr"
> 
> Do these variables ever change? Because the TP_printk() part of the
> TRACE_EVENT() macro is called a long time after the event is recorded. It
> could be seconds, minutes, days or even months (and unlikely possibly
> years) later.

I am really not the best placed to answer.
AFAIK, it sounds like those are never changing.

> 
> The event takes place and runs the TP_fast_assign() to record the event in
> the ring buffer. Then some time later, when you read the "trace" file, the
> TP_printk() portion gets run. If you wait months before reading that, it is
> executed months later.
> 
> Now you have "mem_map" and "m68k_memory[0].addr" in that output that gets
> run months after the fact. Are they constant throughout the boot?

I don't know.

> Now another issue is that user space has no idea what those values are. Now
> user space can not print the values. Currently the code crashes because you
> are the first one to reference a global value from a trace event print fmt.
> That should probably be fixed to simply fail to parse the event and ignore
> the print format logic (which defaults to just printing the raw fields).

The patch you sent works...
But, it fails a bit later:
Dispatching timerlat u procs
starting loop
User-space timerlat pid 230 on cpu 0
Segmentation fault


> 
> -- Steve
> 

