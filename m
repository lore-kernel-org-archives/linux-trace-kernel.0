Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1338F23F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116297; cv=none; b=Rb1mMh4nPZNrA0qZs2YqHPVOMt8xAEoQh50Tpr6BEQZh3ZrLdRMaZNy/FIxsobbd+o9in4lwlNcFRVCrRJNPQkSHUdA1KChJGRU/zcqhxvWnSLej15eKGqPAReihQMwuAU75byc3o7/6frPPAQyghNSkxAslZWO6jMXY4IQs9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116297; c=relaxed/simple;
	bh=kchaHGbuD3Cp5Gw9qsC+6xIIPUpTFqc4APXbX8vshqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnpdT3X/gva0VSGEtljhpzYSbyi9KnmWk73Gnhat7Ri+tHT7bT4kY/LsI9DwAuDa6AFnKsfuUysY/So5wY/S7LEcE2XTDb39do6pi8k5E4jWRaW/urWOeuujKpC24Y8r6eTYLrnLyKzh6rnaNGcVCF/YClqiPbp7r5C8SPccHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIKY3FhE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIKY3FhE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8ec0e0e77aso335930a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782116295; x=1782721095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnzEGAPdTbj50+aOsUk+pqnINR3riAsvsyCwurmkB1E=;
        b=ZIKY3FhE7Vdg0V153R+/Z1KT05YRo7/p33end/71yv6A4jU7Zp1k3MHUukzYSMZOhG
         p9vbEhF2kfF7x2aRgjYyHADvP0EZ3bfyQjpY5cFbb/CVGNRiJZOnu77Csipri3zoOkrY
         ErCwqyROdHagu0wRu8bpZiIm1tqXXmtLjqlBYpnTScRf//RMJsO/fvMvYOCEZG0yO8Sb
         2ffEJawgG0M0fBCpNGrGicM5kZpoqRndxb9WPd2XwGGleqLUnLJocQ5xHvJAwQrG6iQr
         oHMjAhUqzAfiKKmWhkxGmIL22Bobs29hdLJ5hSne87uWfuPKwr5ybCN7AWqaIBrRn5s0
         5iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116295; x=1782721095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnzEGAPdTbj50+aOsUk+pqnINR3riAsvsyCwurmkB1E=;
        b=P53tWWcsg3dfcu4Y+46Zf3u0GjRwhWG8NHVuyB2NavY7eR6dfY28Eg20sD1Xc0ncEa
         Q4+NQxkM/jXNG0aw/zEq7wjr6/WmMlBXOoSZ2BuJW+sMkPdo+KEeOaPXL4Qo7oRyNuQl
         TUDU5GIM2G99S5pdsoliNwxGHdje1k8CgJnm4OtOPZupHBkyDYEaKggCdtjhsHi3kOFS
         h4WK4iQgJS39Ay8clW0wdNIJn8vFuj+x4fvLZHgwZE1+MOqgD3CRpxZ9Z9cfOUxGyH6y
         MVw2K5Ivxg8GtGh2w+hCAl67a7HMNSeCEhL5YEK//mW9D34TEhL7/O3eAwQymTyBQ/bx
         X2Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8FSTWLLoECkwSNpmCYh5FwNF5POShoILi5UpNy1fDWKlcrqkzuEFYrgB2Lz+19yAVscq4w4TZm8OPoOJlJw05KU8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKHbsbmsJ1KDctM+Xi0VaGkDb5/221Ocl/FwSEJuKiHCJOUtR
	pTOlJC3nGOKgpjwbWP+e4ko0JKWcvCSDju1F5WTaDe1b0AgyLQYyCPlx
X-Gm-Gg: AfdE7cnvV/id/3SkQUOdh35TpItlkfgZm3B/B/d0287NYcxnvwQEbH7Lf+N+Hlx0mGs
	pRusUm8Cna6CQB9YheALMC1kNQDuC8kXuVVCbyp81OQXILjS5IrIae3gk6R36nBJ/puNiVKG+Aj
	y5NsVNA983k8eSgkPe9o6BVeVZy/FMe9BQmyfvMRTIuOjNDHuMpC9mr232C9IzHhro7s0nXpPuE
	JqoO9H/fLKiz5GzjMgNUTTeMCm1tkb73454PDiRFlR4Dq4BgyqdY5dXrPw8P082ZxM5yU/9e+24
	vHCx3xl4E1t0WGG5YphaeEYnUENGou/xN8QKKWY8aE1Axyw5gFevzzF/1s4G9G4jNWuvInyM/GQ
	ip4Co+lP02KgzjIU6h8gOpwjMBNh3yvjIAzFHKgQKxcP++qQEW4RDQU5EkIm7PjmGrYpt3e4k3h
	KJvRESBtZ6dr4KBURYXG/UQlfBLGI8SB1C/htTSGN49AtYWlVj+sh1u/ckagrS6sAenh5oYZDZS
	9/p
X-Received: by 2002:a05:6a20:431a:b0:3b4:640e:f6b1 with SMTP id adf61e73a8af0-3bb32914066mr14471224637.10.1782116294931;
        Mon, 22 Jun 2026 01:18:14 -0700 (PDT)
Received: from ?IPV6:2001:fb1:d9:863a:1c8e:6f40:7f4b:ee15? ([2001:fb1:d9:863a:1c8e:6f40:7f4b:ee15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5efcb1csm5846563a12.30.2026.06.22.01.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 01:18:14 -0700 (PDT)
Message-ID: <ea5c9577-5d16-435b-9e1c-aa562a1cc6d9@gmail.com>
Date: Mon, 22 Jun 2026 15:18:08 +0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Use seq_buf for string concatenation
To: Jori Koolstra <jkoolstra@xs4all.nl>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com
References: <20260620175441.223342-1-woradorn.laon@gmail.com>
 <70408559.2499685.1782062190117@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
In-Reply-To: <70408559.2499685.1782062190117@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/6/2569 BE 00:16, Jori Koolstra wrote:
> 
>> Op 20-06-2026 19:54 CEST schreef Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>:
>>
>>  
>> In preparation for removing the strlcat API[1],
>> replace the string concatenation logic with a struct seq_buf,
>> which tracks the current position and the remaining space internally.
>>
>> The backing buffer bootup_event_buf allocation is unchanged.
>> Use seq_buf_str() to NUL-terminate before passing to early_enable_events().
>>
>> Link: https://github.com/KSPP/linux/issues/370 [1]
>>
>> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
>> ---
>>  kernel/trace/trace_events.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index c46e623e7e0d..15164723e028 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/sort.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> +#include <linux/seq_buf.h>
>>  
>>  #include <trace/events/sched.h>
>>  #include <trace/syscall.h>
>> @@ -4501,13 +4502,23 @@ extern struct trace_event_call *__start_ftrace_events[];
>>  extern struct trace_event_call *__stop_ftrace_events[];
>>  
>>  static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
> 
> Isn't this now unused?
> 
>> +static struct seq_buf bootup_event_seq;
>> +static bool bootup_event_seq_initialized;
>>  
> 
> I think this can be refactored to avoid the bool. And should bootup_event_seq not be
> __initdata?
> 
>>  static __init int setup_trace_event(char *str)
>>  {
>> -	if (bootup_event_buf[0] != '\0')
>> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
>> +	if (!bootup_event_seq_initialized) {
>> +		seq_buf_init(&bootup_event_seq, bootup_event_buf, COMMAND_LINE_SIZE);
>> +		bootup_event_seq_initialized = true;
>> +	}
>> +
>> +	if (seq_buf_used(&bootup_event_seq) > 0)
>> +		seq_buf_puts(&bootup_event_seq, ",");
>>  
>> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
>> +	seq_buf_puts(&bootup_event_seq, str);
>> +
>> +	if (seq_buf_has_overflowed(&bootup_event_seq))
>> +		return -ENOMEM;
>>  
>>  	trace_set_ring_buffer_expanded(NULL);
>>  	disable_tracing_selftest("running event tracing");
>> @@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
>>  	 */
>>  	__trace_early_add_events(tr);
>>  
>> -	early_enable_events(tr, bootup_event_buf, false);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
> 
> What if trace_event is empty? Then setup_trace_event does not run AFAIK. See the
> WARN_ON in seq_buf_str too. Have you tested this?
> 
>>  
>>  	trace_printk_start_comm();
>>  
>> @@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
>>  	if (!tr)
>>  		return -ENODEV;
>>  
>> -	early_enable_events(tr, bootup_event_buf, true);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.43.0
> 
> Thanks,
> Jori.

Thank you, Jori, for your review. I will send v2.
I tested both empty and non-empty trace_event cases with QEMU, and both now boot successfully. 

The logs below demonstrate this.

Non-empty trace_event:

qemu-system-x86_64 \
    -kernel arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0 trace_event=:mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss trace_event=:mod:rproc_qcom_common" \
    -nographic \
    -m 512M

[    0.082316] Kernel command line: console=ttyS0 trace_event=:mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss trace_event=:mod:rproc_qcom_common
[    0.083324] bootup_event_buf: :mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss
[    0.083413] bootup_event_buf: :mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss,:mod:rproc_qcom_common
[    0.083689] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes

Empty trace_event:

qemu-system-x86_64 \
    -kernel arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0" \
    -nographic \
    -m 512M

[    0.085213] Kernel command line: console=ttyS0
[    0.086458] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes

Thanks,
Woradorn
