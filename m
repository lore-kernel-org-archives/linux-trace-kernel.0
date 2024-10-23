Received: from welho-filter4.welho.com (welho-filter4b.welho.com [83.102.41.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9815B551;
	Wed, 23 Oct 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.41.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674042; cv=none; b=nsKsm0npMjf0zsJh6bNWMkjfxCf+HZt8WPP+0XTW7gT8xlRnuMJFwF9mn+Wp/SaSJVOsFEZaLRo+1wMQ3mc0CcK+nNCQJZbIeBmqG9KZe+oEiqO+pHlLuZqPT7tStbcAhKOVKIVk6yi6gScvOhGx7UkmI/zJYp8R4Tq16gsvEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674042; c=relaxed/simple;
	bh=707harTW5tzCIIcuiFXWMKBFAXzppTNwi+XJz+v3URY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrGT0amZKJ8kjsZAe3hQUiC2r1uSoGJoF0TJ53aSbYqu1xRnM4HiJduUBrnTdO9l9JnS46BGJzwap9b1uPuYn6xo2qUbS4nfD73iycyQ1lE8ZMj4Ate9hy52cNhw8uaaV4wNFVzwitOYv9MiJKAZVaMvhY591vhDTNYDWOFPyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; arc=none smtp.client-ip=83.102.41.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Received: from localhost (localhost [127.0.0.1])
	by welho-filter4.welho.com (Postfix) with ESMTP id 5EC4467BBB;
	Wed, 23 Oct 2024 11:52:00 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from welho-smtp2.welho.com ([IPv6:::ffff:83.102.41.85])
	by localhost (welho-filter4.welho.com [::ffff:83.102.41.26]) (amavisd-new, port 10024)
	with ESMTP id 7Nu6OtO3kx19; Wed, 23 Oct 2024 11:52:00 +0300 (EEST)
Received: from [192.168.101.100] (87-92-101-239.bb.dnainternet.fi [87.92.101.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by welho-smtp2.welho.com (Postfix) with ESMTPSA id BCD7472;
	Wed, 23 Oct 2024 11:51:54 +0300 (EEST)
Message-ID: <36c3bd1a-f025-449d-9b17-8436987f4639@helsinkinet.fi>
Date: Wed, 23 Oct 2024 11:51:54 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <4ab85330-5a50-bde1-f014-99a8e7cb28cc@gmail.com>
 <86eea4de-2696-4485-9c16-cd3fbbd1aae6@yoseli.org>
Content-Language: en-US
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <86eea4de-2696-4485-9c16-cd3fbbd1aae6@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23.10.2024 8.53, Jean-Michel Hautbois wrote:
...
>> There's one similar site in arch/m68k/kernel/head.S 
>> (ret_from_exception) where interrupts are enabled that would need a 
>> similar change, if you want to enable this for all m68k.
> 
> I won't be able to test it though ;-).
> I see there are a few interrupts disabling in 
> arch/m68k/include/asm/entry.h too ?

I would suggest using Hatari for testing it, as that emulates real HW 
more accurately than Aranym, and provides better debugging & profiling 
utilities than either Aranym or real HW [1], especially for kernel side.

(Because ColdFire is close to m68k, Hatari can help in debugging also 
issues that are in Linux code they share.)

Here are detailed and IMHO easy instructions on how to do that:
https://hatari.tuxfamily.org/doc/m68k-linux.txt


I'd recommend using Git HEAD of Hatari [2] for testing though, because 
there was a recent fix to handling prefetch during bus errors, when 030 
MMU is enabled, and without that fix, prefetch + cache emulation would 
need to to be disabled for user-space to work correctly.  If you disable 
those (--compatible off --cycle-exact off), you can start with Hatari 
version from Linux distros though...

(You can mail me directly if you have problems with Hatari.  Getting 
ftrace working on m68k would be interesting.)


	- Eero

[1] https://hatari.tuxfamily.org/doc/debugger.html
[2] Upstream: https://git.tuxfamily.org/hatari/hatari.git/
     or mirror: https://github.com/hatari/hatari/
