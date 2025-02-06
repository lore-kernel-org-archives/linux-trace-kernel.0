Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630370838;
	Thu,  6 Feb 2025 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812244; cv=none; b=jjt+D9aprcaUzzihcKmYeaF4Xd+ELfs7QyDfBHAVxNqbd0J7qg+1c5danRn0wNDrtGRAKxqpfDDMBd//x6TPCszTj5WnsocFJUBmEnmLau/eM00wq19C2rk0mQNMYZQrZu4gtFpRMoLM6OqR+TpLf6Kqt74raK2BzJ9hJJ81TXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812244; c=relaxed/simple;
	bh=GN/qgEB3iu+83b4+zqY+4Uy9NmjTGYSRTrcXXIDnSPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+aJTX2Dg/ThPMYjL5CW9ruTxYQ0OS5ver6GZbVbhD9dXCkP4JcAgYhdUVG8qWq0KNAD068eb425cUiurtEc+sRE8+BqhVtc7YuOFE7CCCsrFihudFmYio7n1M5q9zmVMOIqRy3UrCvXVrCevowCZ2Ox02l+jFcKYpvwxV/7qjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AUvoh+wY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AUvoh+wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=0Aqrt6RJByUe1ybDFqadLh4aZHYSY2vHFVbudygDxjA=;
	b=AUvoh+wYLUes/EROgRCLEaosd+30TIwVYU4rxSYiMPZ1tA+LVm9MDxkHyTGGC/
	1DFukM8BehqAdxyUJWaoqNLlW6eO2GsUhUxnh0c/JTwRKaIKz/7DygFnxnLH0nsg
	786bG4DRIjLaWejhbfIWSIY4lDpeiIa/BwEdhBW3OYKXE=
Received: from [192.168.31.211] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3PlIWK6RnBVGrJw--.7220S2;
	Thu, 06 Feb 2025 11:23:04 +0800 (CST)
Message-ID: <767d054d-1d00-40bb-b8c7-0e990b1578b9@163.com>
Date: Thu, 6 Feb 2025 11:23:02 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS is
 enabled
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 samitolvanen@google.com, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>
References: <20250205180116.88644-1-haiyuewa@163.com>
 <20250206093853.4e55405ccfcba7111705f395@kernel.org>
 <20250205195300.42d3e3b0@gandalf.local.home>
 <20250206114529.d2483df2c9d09726f1f3a43d@kernel.org>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <20250206114529.d2483df2c9d09726f1f3a43d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3PlIWK6RnBVGrJw--.7220S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryruFW3ur4fXrW7WrykZrb_yoW8AF4DpF
	WDGrnYga15W397G3yqkw1Iva4jqr98Cr18G34vqryDCF9F93Z7Jws5CrWYvryDAFZrK3WD
	K34xWa43Wry8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXrUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBHra2ekIiKyHAABsd



On 2025/2/6 10:45, Masami Hiramatsu (Google) wrote:
> On Wed, 5 Feb 2025 19:53:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu, 6 Feb 2025 09:38:53 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>> Thanks for the fix. And this fixes one of problems.
>>> Another one is that `is_endbr()` is defined in <asm/ibt.h> but that also depend
>>> on CONFIG_HAVE_FENTRY.
>>>
>>> Let's pick this and fix above issue.
>>
>> OK, I'll pull this into my urgent tree and start testing it.
> 
> Sorry, Gabriel found another issue.
> Let me fix this instead of this patch.
> 
> https://lore.kernel.org/all/CAFEugPfFykYsHqS-J36CNWDn+d34bSQg-e5hJ=AaJPC8=6Ej-g@mail.gmail.com/
> 

If I put the fix above '#ifndef __ASSEMBLY__', then I can reproduce 
Gabriel's founding:

+#ifdef CONFIG_X86_KERNEL_IBT
+#include <linux/uaccess.h>
+#endif
+
  #ifndef __ASSEMBLY__


In file included from ./include/linux/kcsan-checks.h:13,
                  from ./include/linux/instrumented.h:12,
                  from ./include/linux/uaccess.h:6,
                  from ./arch/x86/include/asm/ftrace.h:26,
                  from arch/x86/kernel/ftrace_64.S:11:
./include/linux/compiler_attributes.h:91:20: error: missing binary 
operator before token "("
    91 | #if __has_attribute(__copy__)
       |                    ^
./include/linux/compiler_attributes.h:103:20: error: missing binary 
operator before token "("
   103 | #if __has_attribute(__diagnose_as_builtin__)
       |                    ^
./include/linux/compiler_attributes.h:126:20: error: missing binary 
operator before token "("
   126 | #if __has_attribute(__designated_init__)
       |                    ^
./include/linux/compiler_attributes.h:137:20: error: missing binary 
operator before token "("
   137 | #if __has_attribute(__error__)
       |                    ^


>>
>> -- Steve
> 
> 

