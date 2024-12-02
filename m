Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4491FDE05;
	Mon,  2 Dec 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143997; cv=none; b=gyXd0hk2+NcdYWlUoQjPH48PCU3+5+z774otxQBy/nkBQY/VXDRU0WZDBrVjNLvdm7IVoujC3MuIUOEN/yxLy4KM4aBVRpI5QUGuewsJmgcImBZeg8RBwtB1y6+0vCapCLKGyH/V/CuoNSeYuHgr2WoagCgsMrMTVht2r/NlJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143997; c=relaxed/simple;
	bh=Dcf1mBDnyMc8unddg5GNv+kcRpzPFQKquzmJIg3OBco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDU/W2d3+2wCv8uwxBHUvOJmHs6TlD4H/YTGPcTvfIs1lhAuC4X/PWaN29dZ0/JBwNd0sbMkwL+Q1n5Qtg7jxwjicTIq4m8hnspqYKWQ1cXfwaGj2UiaMcZYn2/SaGxVEByZrMPpRCipFm8aDlkcGDAIGSmKdHGhzdya2VsX9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=l/BojXVr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="l/BojXVr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8222540008;
	Mon,  2 Dec 2024 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733143986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HF06qhv15YyjsEs1KTqYjzgSe0v0sSFbfiFa7jg8+lc=;
	b=l/BojXVrEtKh8e1cL6rF3kGY72seZV66sXSvmIvNxEtFa/UwO30RELZJxSctzE3ziXngoQ
	zGHI7pOkrS8wN30eGwD3FTgywGLJinLzAWEXa3Z2++/EbsQtRGrXBMFoTZFNXpUw+HkZte
	IsT6jSLM7eHC2nJTJn2jNnbRLR8SNdCRTJoHDKLx24cQpZ2PM+3Jn7Sv3ucmA8qq4AynEv
	l/RDsITBKECtWsSxXTnkUDLta1rmloKDD5DwsTpxDF0gIeckFaRK33UWEMK05TfhtyJCp/
	mmxxjJ6tt7bvE9q5yQ56pbPSb98EWsR8L0VqJbaDnqMVrpcmqCXJ8c1zzZ2+Jw==
Message-ID: <c2d5cfd5-8bdb-4060-a974-18f9c2b9a2d0@yoseli.org>
Date: Mon, 2 Dec 2024 13:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
 <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
 <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Tomas !

On 28/11/2024 16:25, Tomas Glozar wrote:
> po 18. 11. 2024 v 11:13 odesílatel Jean-Michel Hautbois
> <jeanmichel.hautbois@yoseli.org> napsal:
>>
>> I had to modify the source code a bit, as it does not compile with my
>> uclibc toolchain:
>> ...
> 
> glibc added a gettid() wrapper with version 2.30; earlier glibc and
> uclibc do not have it. That can be fixed by conditionally including
> the inline function if on glibc lower than 2.30 or another libc; for
> reference on how to detect that, see how kernel self tests do it [1].

Thanks, I will cook a patch !

> As of the FOPTS changes: are those necessary for rtla to build, or
> were you just using them for easier debugging? AFAIK rtla shouldn't
> depend on unwind tables or stack protection for functionality.

Well, my toolchain does not support it, so it fails at link time:
   LINK    /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/rtla
/opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildroot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld: 
/tmp/ccih6k6Z.ltrans0.ltrans.o: in function `err_msg':
/home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:30:(.text+0x1a0): 
undefined reference to `__stack_chk_guard'
/opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildroot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld: 
/home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:39:(.text+0x1e0): 
undefined reference to `__stack_chk_guard'
  <snip>

That's why I removed this option.

>>
>> But it is not enough, as executing rtla fails with a segfault.
>> I can dump a core, but I could not manage to build gdb for my board so I
>> can't debug it (I don't know how to debug a coredump without gdb !).
>>
>> JM
>>
> 
> I have seen a similar libtraceevent-related rtla segfault recently on
> ARM64, which was fixed by updating libtraceevent to a version that
> includes the fix. Such issues are caused by the files for kernel
> tracepoint tracefs having different contents on different
> architectures, exposing bugs. I see Steven has already fixed one of
> the issues on m68k [2].

I will try to use the very last versions of both libtracefs and 
libtracevent and see if it is still happening !

Thanks !
JM

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/nolibc/nolibc-test.c#n1008
> [2] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/commit/?id=45a9b0647c904b7bf1240da5a11fe3a1ffd1006d
> 
> Tomas
> 

