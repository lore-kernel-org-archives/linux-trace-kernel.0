Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B776048;
	Fri, 11 Oct 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632051; cv=none; b=sko6p0ci6aVNFBs0EFzCiZwrwgCbhkuSfxRVwwrFz4a12k/AeI5IJv8+90klbxyR/50euWPVHDwrcAm7IUxAa5pU3vqckODF6/Vk/TTcClwiLOSU3YnCUfr8yg3uyiNbQ2s9YLb/4r9tQNSH/+7DinDAm+VauKyBThOE1w0EREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632051; c=relaxed/simple;
	bh=96gBgJAwKMTx1DqCVQgVveHcuEAWiMQBWnQBuSrmI3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P35OrHWWwCFCvoxdP72rvgovkfy9OOZM3Xmh9xn3oP9lDApN1VmtWV1ZeUmIq0rrOGFUj3XAellYIm6sXHn6AhuM5jc+6gWeqt7HfSPi8O1S2GpTal0WFHWTSIpLV79PSltQulkYcn7gM+9fSAnidvHi288BLdYDQIUY/DoHpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpk3e8Ke; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpk3e8Ke"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e05198d1dso1255542b3a.1;
        Fri, 11 Oct 2024 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728632049; x=1729236849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCrxCbJh8H06lXlf/53sOZsirE/yyb/iMyNk6THicmQ=;
        b=Dpk3e8KeAzrYzicVjwbPAc7fJDCStgdZgWgDrD2VzmX5avO2mhN8pQRwHWo772FR6k
         J5WAbKxfZnvsFgI9qQV8LAKfK6a+OIaTodE2zvT67jKHzcVdk2KRGbc+O0WxAu3eXQcd
         Jd/DmOPAyUUPJAmiyWi0Yl0iMOZxv/SutrPn+7UE32pIq6uRd9JaeST/P5zcYuPVI9ju
         r7BtJboMKpHDVJnlaUS2vUsmRo+hXy0thxvIrPTjMgexUPheUjhWRfIohu4omSdTwuAI
         Zl1bwItrs6Eiqk/3BwlRJKwT3PAmkyvl+wUDhdpJU6KxanXsfyY8QoK6D79kbtuSvuxm
         MCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632049; x=1729236849;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCrxCbJh8H06lXlf/53sOZsirE/yyb/iMyNk6THicmQ=;
        b=NiNAIZ8QzFj5At/lx95/8CA0VouYI2dX6fNqh8JxjJ3iWlaWalbJK6+8Tq8ArUjVzL
         BCbOl5tfPP4pJ8MEcTrhe85FFSPfZGK4hHiMyHPs/w+XRkJTLE+W5TmhXeDtls7wE+bM
         lZ8fzDGmIV7TlQ77rFiGX+H3ayQq0yrd8C2lQ+yoGtdajt9xcxNlUGUhPpF5FInE+c3L
         xws4Cdsws98VO+Ig4Mbmsykvh05vTM5uD4RA2/isRjwYpWEm0l5k0KS7Owjsqd+H+l6n
         JX8RuZSyJpynr8TyhWQmRryoKLkxRtEc0gxnUk2WgRxagxpcW82HnbkA3wpshdx3MiYi
         oqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFoDVoYT3Vwgk6VZmAWdFNHh7NQYvxxZS3+CPf8r7FzCaJ/1piuA1zxRN/D7IUcH/ZdZsflsJAlkvWXp+wbpmcaX93@vger.kernel.org, AJvYcCXCpHQvclM9nv2riLH6xZw3Qs967WYfOCO29iosFE3E2ycerSZei9qo9luo9y3caSo/vpOLtcYbLLMpIkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6LQHbSJrmLkG/N3H3ky8ZghvzCX4wAsHdPWHurhu79zbc6GO
	OpnLlVMsBFmcvGzdkNsGYrYA/G3b6R07itZlrxRITj7v6OkmF5ec8/HrpF6e
X-Google-Smtp-Source: AGHT+IHUSxkdyJjxOGlLdOMvCTWdxeTFxjbT5VS8gpWUEilvd401obgAf3Q441sNYSQaJVDwraDx8g==
X-Received: by 2002:a05:6a00:888:b0:71d:fd40:b484 with SMTP id d2e1a72fcca58-71e380c5033mr3109001b3a.24.1728632049094;
        Fri, 11 Oct 2024 00:34:09 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a5b4c40sm2104753b3a.0.2024.10.11.00.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 00:34:08 -0700 (PDT)
Message-ID: <c180285c-c79a-4a32-b899-553345ad46ab@gmail.com>
Date: Fri, 11 Oct 2024 16:34:22 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tatsuya S <tatsuya.s2862@gmail.com>
Subject: Re: [PATCH] ftrace: Fix function name for trampoline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
 <20241010110233.4f9bdc34@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241010110233.4f9bdc34@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/24 12:02 AM, Steven Rostedt wrote:
> On Thu, 10 Oct 2024 22:02:59 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> 
>> The issue that unrelated function name is shown on stack trace like
>> following even though it should be trampoline code address is caused by
>> the creation of trampoline code in the area where .init.text section
>> of module was freed after module is loaded.
>>
>> bash-1344    [002] .....    43.644608: <stack trace>
>>    => (MODULE INIT FUNCTION)
>>    => vfs_write
>>    => ksys_write
>>    => do_syscall_64
>>    => entry_SYSCALL_64_after_hwframe
>>
>> To resolve this, when function address of stack trace entry is in
>> trampoline, output without looking up symbol name.
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>>   kernel/trace/trace_output.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 868f2f912f28..32a0858373e2 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1246,6 +1246,11 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>>   			break;
>>   
>>   		trace_seq_puts(s, " => ");
>> +		if (is_ftrace_trampoline((*p) + delta)) {

Thank you for review.

> 
> This is not reliable. The output is called when the user reads the trace
> file and the ops may no longer exist.
> 
> The only way to test this is if you call it during the trace. Yes it may
> slow things down a little, but it will be accurate.

OK, I will do it.

> 
> -- Steve
> 
> 
>> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);
>> +			trace_seq_putc(s, '\n');
>> +			continue;
>> +		}
>>   		seq_print_ip_sym(s, (*p) + delta, flags);
>>   		trace_seq_putc(s, '\n');
>>   	}
> 

Thanks

