Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77F14A62A;
	Wed, 20 Nov 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118401; cv=none; b=rxSVob5XYxZ91yTypgXNzM5bz/iHFOn1F8PP4Khsst7VLu5VFPBVPdNIwENsXQfVM81+lQvO/NIPnOmdcGJcwjyA1sVVpgVbQvbhaO2ZbQQSFIuqLC+BGZr0BoUIYMHO8t4jR3h19BlFpwXdgqP/lgQHPkeFFELloie8oJ/v/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118401; c=relaxed/simple;
	bh=kpr5rlsPtv+fIRvugQQcmjIq4VFtSfzxuo+49HQBURI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmxf9RkPNszJmYgTppK+BfEy4fuD35RuDBGD8Lf6ok+DsxdNyfZFIZ2qy/KWm28L9LoUgntiryPfLjjxYG2jSFcaJiSz6GIUigoU5nXKe4tEk+v2YT81079fuDxsISOz9x6Uc+E+Zn9WiNpz+zwWvqshX3PN/PAxcmwrW/uKjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=h3imbiw6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="h3imbiw6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8914640007;
	Wed, 20 Nov 2024 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732118397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ryErlA0PvGQrgbyhpvPuUIdB3vNq2IYyQnN2e27c9M=;
	b=h3imbiw63wObrQ9+AHIHBY76Lg8Tasn+VsgW4V+A//02r9vWCJL51yh2UR+jJdxFCRnn/k
	D9fkhyTsGQwKHOq9oLzv+ydMZXgLIp0bisvYXVnE4BdUgt5BrTXbQI5ckcjbZDuA0eFapZ
	gLIuYiI21bZP1Olq9o4OvpM7M1XClEnypXeu6mlVcjhqsfJ8+EMxIaMnc5EbjgBO0fl96k
	3vz6v8bd8PR1t7fJYclVd0rS2BleISgmQ3Qj+CHeoy39dQL1zxM9SYChOrYLBBXpTnIhpB
	63ccD5GeCayHwSBg/OyTed3ycfPxEpZ30hUM0YKb6XqVM8HuVqZrifzZCvwrGQ==
Message-ID: <2dc1cdfa-d33a-48b6-ab77-d04b06a3efe8@yoseli.org>
Date: Wed, 20 Nov 2024 16:59:55 +0100
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
 <66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
 <20241120103150.3442d658@gandalf.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241120103150.3442d658@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 20/11/2024 16:31, Steven Rostedt wrote:
> On Wed, 20 Nov 2024 12:47:19 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> Long story short: it fails at kbuffer_load_subbuffer() call in
>> read_cpu_pages().
>>
>> I added printf in the kbuffer helpers in libevent, and it finishes at:
>> __read_long_4: call read_4 at 0x600230c2
>> __read_4_sw: ptr=0x8044e2ac
>>
>> static unsigned int __read_4_sw(void *ptr)
>> {
>> 	printf("%s: ptr=%p, value: %08x\n", __func__, ptr, *(unsigned int *)ptr);
>> 	unsigned int data = *(unsigned int *)ptr;
>> 	printf("%s: data=%08x\n", __func__, data);
>>
>> 	return swap_4(data);
>> }
>>
>> As soon as ptr is dereferenced, the segfault appears.
>> ptr should be ok though, as the address is valid afaik...
> 
> But you don't know what ptr it failed on, right?
> 
> If dereferencing a pointer will crash, the below line:
> 
>   	printf("%s: ptr=%p, value: %08x\n", __func__, ptr, *(unsigned int *)ptr);
> 
> Will crash before printing, because you are dereferencing ptr. Perhaps you
> should change this to:
> 
>   	printf("%s: ptr=%p\n" value: %08x\n", __func__, ptr);
> 	printf("    value: %08x\n", *(unsigned int *)ptr);
> 
> And that way you will see what 'ptr' is before the crash. Or did you do
> that already?

Yes, I did, sorry I thought it was in the previous dump :-(.

kbuffer_load_subbuffer: kbuf 0x8001d520, ptr 0x8025e2a0, call read_8
read_8
swap_8
kbuffer_load_subbuffer: kbuf 0x8001d520, ptr 0x8025e2a8, read_long
read_long: call read_long at 0x60022ef4 with 0x8025e2a8
__read_long_4: call read_4 at 0x600230de with 0x8025e2a8
__read_4_sw with 0x8025e2a8
__read_4_sw: ptr=0x8025e2a8, value: 00001ff0
__read_4_sw: data=00001ff0
swap_4 for 00001ff0
__read_long_4: --> read_4 at 0x600230de: f01f0000
__read_4_sw with 0x8025e2a8
__read_4_sw: ptr=0x8025e2a8, value: 00001ff0
__read_4_sw: data=00001ff0
swap_4 for 00001ff0
read_long: --> read_long at 0x60022ef4: f01f0000
__read_long_4: call read_4 at 0x600230de with 0x8025e2a8
__read_4_sw with 0x8025e2a8
__read_4_sw: ptr=0x8025e2a8, value: 00001ff0
__read_4_sw: data=00001ff0
swap_4 for 00001ff0
__read_long_4: --> read_4 at 0x600230de: f01f0000
__read_4_sw with 0x8025e2a8
__read_4_sw: ptr=0x8025e2a8, value: 00001ff0
__read_4_sw: data=00001ff0
swap_4 for 00001ff0
kbuffer_load_subbuffer: --> read_long,  flags=f01f0000
kbuffer_load_subbuffer: --> size=1f0000
kbuffer_load_subbuffer: kbuf->data=0x8025e2ac, kbuf->size=1f0000
kbuffer_load_subbuffer: kbuf 0x8001d520, ptr 0x8044e2ac, read_long 
lost_events
read_long: call read_long at 0x60022ef4 with 0x8044e2ac
__read_long_4: call read_4 at 0x600230de with 0x8044e2ac
__read_4_sw with 0x8044e2ac
Segmentation fault

JM
