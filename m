Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF12080D4;
	Thu, 13 Feb 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443920; cv=none; b=iXP0f3w+6gmA3kmfWACx8Dwr5EQmDL4MhPyqhjlSkQT8CPsS1YXd0XkcWaz18gFwqdQsQ/dKtUiF9PApTRmx4Qhb0VvXIdxyuLfDo7DClaap/XsHeU39MU51Q7wkP8H6kzJs7OS2H7sE61xQ/t4RxoEDDgrccw7Js9vQ6Ff7lgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443920; c=relaxed/simple;
	bh=77jGrMg0lzb1Lx4EuTwC/BwLlLpMF3/BjBLHWYbPpw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idUzC819jMP/X4dBiiUfSm8c2nHXu/hbSCu7GAWoodbyZgUkFq2fLD0CqdP/d7dhsd7i78pzZhqNwSEgmX4JQAlBQbVRzTnPL8YqwhvVz0weovw4F2s5iOyuvSIpxySmWgdBu4H4tQiFpY3qvWTwddehG+dC7NaSW86RBZmND8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JfSp7zC+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JfSp7zC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=WW56zeZiK66xxYMHrihXMHHhYZ/t9VB0Mu1z7KI8U48=;
	b=JfSp7zC+MFy3UKREYRZ3+T35oKXvdcyCSK4pwBh6+3Ud0eSpdbnfz3VuCFTX/y
	m+C8/k1lw0NyZTqQSr6DliSAjAIDEZWzINXElFJYoq6PctAD64fINbaxQoYpuYsz
	JlXDBYpp6Tca2cn66PWQ9BIsSnViaWvZ9EwTDXpl3uynU=
Received: from [192.168.31.211] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHoSuEzq1nWqPCLQ--.41111S2;
	Thu, 13 Feb 2025 18:50:45 +0800 (CST)
Message-ID: <7f1606ac-23fe-4dff-bf79-ab1bdc84a35e@163.com>
Date: Thu, 13 Feb 2025 18:50:39 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Gabriel de Perthuis <g2p.code@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net>
 <20250211105002.31b5a517@gandalf.local.home>
 <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
 <20250213100836.GC28068@noisy.programming.kicks-ass.net>
 <08422aab-f4a9-4f67-84ef-82ad3663b01f@163.com>
 <20250213104014.GD28068@noisy.programming.kicks-ass.net>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <20250213104014.GD28068@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHoSuEzq1nWqPCLQ--.41111S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1UuF1UGr45XrWrKFyUKFg_yoW8GFyfpF
	9rurs7Gan8J3yxGrnIvr1avw17Xws5Xr45Jryqq34YyFy2qr1ktrZ2gr4a93sFyFs8Ka4U
	XFWI9a4YkFWrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXrUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiSh7ya2etw-7JkAAAsj



On 2025/2/13 18:40, Peter Zijlstra wrote:
> On Thu, Feb 13, 2025 at 06:25:41PM +0800, Haiyue Wang wrote:
> 
>> It is header file include indirect :-)
>>
>> https://lore.kernel.org/linux-trace-kernel/20250206131711.ea536f165d5b5980b3909acd@kernel.org/T/#t
>>
>> File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
>> adding the missed declaration header file can also fix the error:
>>
>>   getasmexports =                                                        \
>>      { echo "\#include <linux/kernel.h>" ;                               \
>>        echo "\#include <linux/string.h>" ;                               \
>> +     echo "\#include <linux/uaccess.h>";                               \
>>        echo "\#include <asm/asm-prototypes.h>" ;                         \
>>        $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
>>
> 
> So this is simple enough; but the thread you link to also has another
> hunk, which makes the whole thing unfortunate.
> 
> I'm not entirely sure what this GENDWARFKSYMS nonsense is about, but it
> should not clutter the code like that.

By my understanding, the GENDWARFKSYMS design triggers the missing
header file, even this is inline function, but it will call another
function. It needs to "see" the header file firstly:

So this also fix the error:

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -1,7 +1,7 @@
  /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/ftrace.h>
  #include <linux/uaccess.h>
  #include <linux/pgtable.h>
+#include <asm/ftrace.h>



