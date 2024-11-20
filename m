Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6371A08D7;
	Wed, 20 Nov 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103251; cv=none; b=jztL7xjq1jQQ8eUDtOblPKeyO8MDQEnhZpkg4Ar98+Kiy9Puzfcp8CfjCM9vmgci3ibdqjiv4Sf8mnjRXgEulVWTP39ta3DA4BdiotgVhA8cUK5DXFXHXIET9hArgY5mDPbR6CgKL24SqwEQoA1v7zyBP1Fz5ORe6tcB+rNikic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103251; c=relaxed/simple;
	bh=XkEffpyIqiEsba7l9Vf6CNWXjkxxfYCKnu1NCVW/Z7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icRuxS7HxQKAwxfySNkUYMTn6qROmmhXuazijhEyoX8vir/1QutIRHDSsP/iAeICFBuufNeEUOJSU/Dy7wjCZzExBKWjD3LAtjKkCZ/+WvUxh4mOUhi1nNIPGOBZj2jHdYtE+aLLk1xE9ht356B/M1hmYe2kB/0fuT5y5jAXml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ns0pgN0l; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ns0pgN0l"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5844DE0004;
	Wed, 20 Nov 2024 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732103241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFUtohqITXGudof2VJAlVLHl8l/Ydbd2GzYsCg1X3UM=;
	b=ns0pgN0lI6nONYq3+O5ZeUIDeerQHw+aKmBsEXYZpve99uHnIzKXdwVzAxvyfnxF/uuZV9
	jD1a8tSwZDJ5mj9CTisrRC2Yp6Ym6RwqqyF+TJvTw0ssRl28PvDaeu1P/baTsin1qGz6o0
	H9TNVLD6vXN/mLEXLs3V230dp71PpNOVsbdyb3s+D+JSywYVlR3CSxbgSLfXTsd7M3j2tQ
	Fno2aZPRcT9Ul7auBsm1daCM1d7fgW0fkch5/teA/7ZQ8uhtDZL6ZANLzQZyB8kjp97Apn
	jOtffHutE1eBFnwwmsetOqO6X03/GH8wbxXNRMMhctlvPQKJ2+xRqh3LxMp9kg==
Message-ID: <66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
Date: Wed, 20 Nov 2024 12:47:19 +0100
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
 <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
 <20241119131035.3c42a533@gandalf.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241119131035.3c42a533@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 19/11/2024 19:10, Steven Rostedt wrote:
> On Tue, 19 Nov 2024 19:06:45 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>
>>> It shouldn't crash, but it also found a bug in your code ;-)
>>
>> In my code is a really big assumption :-).
> 
> Well, not your personally, but I meant "your" as in m68k code.
> 
>>
>>> You reference two variables that are not part of the event:
>>>
>>>    "mem_map" and "m68k_memory[0].addr"
>>>
>>> Do these variables ever change? Because the TP_printk() part of the
>>> TRACE_EVENT() macro is called a long time after the event is recorded. It
>>> could be seconds, minutes, days or even months (and unlikely possibly
>>> years) later.
>>
>> I am really not the best placed to answer.
>> AFAIK, it sounds like those are never changing.
> 
> That would mean they are OK and will not corrupt the trace, but it will be
> meaningless for tools like perf and trace-cmd.
> 
>>
>>>
>>> The event takes place and runs the TP_fast_assign() to record the event in
>>> the ring buffer. Then some time later, when you read the "trace" file, the
>>> TP_printk() portion gets run. If you wait months before reading that, it is
>>> executed months later.
>>>
>>> Now you have "mem_map" and "m68k_memory[0].addr" in that output that gets
>>> run months after the fact. Are they constant throughout the boot?
>>
>> I don't know.
>>
>>> Now another issue is that user space has no idea what those values are. Now
>>> user space can not print the values. Currently the code crashes because you
>>> are the first one to reference a global value from a trace event print fmt.
>>> That should probably be fixed to simply fail to parse the event and ignore
>>> the print format logic (which defaults to just printing the raw fields).
>>
>> The patch you sent works...
>> But, it fails a bit later:
>> Dispatching timerlat u procs
>> starting loop
>> User-space timerlat pid 230 on cpu 0
>> Segmentation fault
>>
> 
> More printk? ;-)

Indeed, but the result is not straightforward this time :-(.

Long story short: it fails at kbuffer_load_subbuffer() call in
read_cpu_pages().

I added printf in the kbuffer helpers in libevent, and it finishes at:
__read_long_4: call read_4 at 0x600230c2
__read_4_sw: ptr=0x8044e2ac

static unsigned int __read_4_sw(void *ptr)
{
	printf("%s: ptr=%p, value: %08x\n", __func__, ptr, *(unsigned int *)ptr);
	unsigned int data = *(unsigned int *)ptr;
	printf("%s: data=%08x\n", __func__, data);

	return swap_4(data);
}

As soon as ptr is dereferenced, the segfault appears.
ptr should be ok though, as the address is valid afaik...

I must say that now I am stuck :-(.

Thanks,
JM
