Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262E34E763
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918679; cv=none; b=l2oix9IVNtvfipHfqxXYaHEkt1GJTq1zRdxw5AklLNXYVZCukg30Rpxn7Pn1DMOAtbpBpl99fM//L3tmNDBbUx6EJaAEmK1hyUCBtzMrwRTpkqu1oB59WJyuZ1bSOj3sqV1fhMM2tWJqq9EUXpNYEJacMqDtehwxsL2ztqJhUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918679; c=relaxed/simple;
	bh=LflzoFEAZCGohBe6+8suK5icx8InddD6Nep0mFpxNEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkAdDUNcFJAp+rAGCUVKurQT7Fca1VInrSl+X2LlJAwyI8MxF06EUPplD0S6rl5cv2WqXSCAvr2W3ok6Q2j0vAHjwCjvBVhgG4liEveBQmQK7tFu+vvIVLkmip5ixir1YYuWRJakpirkMOx4jAnjUqnTN1rT55kkwfWzP/4uqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtlCqUGP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtlCqUGP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca0c5799eso27348915ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Jul 2026 21:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783918677; x=1784523477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2Wy8lwvqhiTKT55Dm2cNnX9AvjqZigx9HgdgElZQis=;
        b=GtlCqUGPSo1dD7lcdBJPovpyrDvaFv/SbTgD+LXsaMLMeibe/KTPMpm4lWVw7pnRTm
         +yS7LczwVYtLoy7tMmzK0ROUg6/T9Ft+9JL9bpjWNcVJ1Oy1PdwRWqcDxStLaZ3BGAQT
         zNKV/Z4TpcsK+jCgUAh90EWBUnbMt2d2YJbAcYnU+RgnSJZQ1Z1V+wep1MdXY3RgK/jl
         PGFtC1s2iogUozlGxGmiIZaSZCapAoAGM6+100Eff6Mj3xIdfTPiJaS7LmyqzRRz8y/Q
         fOJPt5AXvEF/Tm8FV2fLBnRsoxdE4oCFNljQ0rHZ4Q0iOucXJe6w0izOjNxT8p5wIAhX
         oU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918677; x=1784523477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2Wy8lwvqhiTKT55Dm2cNnX9AvjqZigx9HgdgElZQis=;
        b=L+bdQEoXdYny98Q3SBZV4fzgqg1yNqoXZylqEen5IIZrgoew78DYbHhPi8zfcs5hF4
         Ps2X3Xo2kynP2gOb/qCLWfl4vZyv5SAtRD9GOcCJkgm+ur3Ml5iplMOc6gYiS61aZxHA
         mOUrbsnZWT/fbY3i7pcZvLbQw2fFYr06bMxkTTg5d/dXVHXLqEVWnZAMb3AgTUDjb5ed
         l8EugNewhCqJJOEgdEOKc7Rb729UD8mY7Nl1RsNmzyogLAchQkvqG8yjZifFKwTBmIxG
         lxVlQpGgoH6yGTzK+2GB5mmKeB0lT6G+kFuntMG75gqdn0/w8cAe1lIx9CfU24CFaYzh
         r7RA==
X-Forwarded-Encrypted: i=1; AHgh+Rpc5eoL0EFHa+Su/RtoGqrmHmJSt++W+3ZUJ9FRvsz4D5w/lhat+NDHsDLZfkO7618xweA+6o0wc/GKGUW8dVCLySU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwwwlpm/nXo6bdE6NLAVCTzk3W7WCWlJpVv2ePKTE94AkuZzKW
	qq0v0ccA08fkXVR1YxjUl2fEqdaAzuZ0MXHos7JVUHnwIu3BkzqgkSjW
X-Gm-Gg: AfdE7clikDCbWXJun622nlgPmIuR3ncMMh9DqDc3ZCgQdO50lyFYsjxT2lIW7WBLaB7
	K2XlD5uIA1G1ARBib/hV2xWNZuINjBRguZYQvCNxO3mIUJMPchxFOesdmsRV1VNANyxVgnqeN4z
	PcM9gXqDdWyT0pXCq2gLvhWAEMT1k6mIh/ROTbiZK/VIg963jNIDNinn/MWXoqZ/JoZtvfnZEmt
	97Y+n3EgxJ8LoZuC7yrKYvYDQcqAYAoO49/L2h5PJHu9w9cTghm+xWgD8d/FxTEDV8bcWSBPIHC
	fPER+uNKZoiEW8a7HUKWOWAoNdn9npRldON9tJEfo4sZGztNQjKD9AbZPXaqyh7t+5uUl0Xp+xv
	GtGOybhvCkc6coxsoy9aYafQrFDdj7XkI5xOT3kcsYpcS2P0yR2MRXmtvoKoTGQkJv+Rsfm29wT
	37BnCMj8ro2fclbE3K5O0gKyy/lUWnMjmb70szojUFMiBMCtJqsEvFJQ5DSOS1G2F8JWqWjOin2
	ggC6fFelvyvDLk=
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id adf61e73a8af0-3c110b33403mr8347974637.71.1783918677163;
        Sun, 12 Jul 2026 21:57:57 -0700 (PDT)
Received: from ?IPV6:2001:fb1:db:5c33:7066:708a:3018:7aec? ([2001:fb1:db:5c33:7066:708a:3018:7aec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cabc7b2aa4bsm2033582a12.10.2026.07.12.21.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 21:57:53 -0700 (PDT)
Message-ID: <79f36674-5a35-4aaf-b5b1-bc6189c222ad@gmail.com>
Date: Mon, 13 Jul 2026 11:57:46 +0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Use seq_buf for string concatenation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com,
 jkoolstra@xs4all.nl
References: <20260622094623.18469-1-woradorn.laon@gmail.com>
 <20260629143947.2216574e@robin>
Content-Language: en-US
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
In-Reply-To: <20260629143947.2216574e@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/6/2569 BE 01:39, Steven Rostedt wrote:
> On Mon, 22 Jun 2026 16:46:23 +0700
> Woradorn Laodhanadhaworn <woradorn.laon@gmail.com> wrote:
> 
>>  
>>  #include <trace/events/sched.h>
>>  #include <trace/syscall.h>
>> @@ -4500,14 +4501,20 @@ static void __add_event_to_tracers(struct trace_event_call *call)
>>  extern struct trace_event_call *__start_ftrace_events[];
>>  extern struct trace_event_call *__stop_ftrace_events[];
>>  
>> -static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
> 
> Keep the above string and just assign it.
> 
>> +static struct seq_buf bootup_event_buf __initdata = {
>> +	.buffer = (char[COMMAND_LINE_SIZE]) {},
>> +	.size = COMMAND_LINE_SIZE,
>> +};
> 
> static struct seq_buf bootup_event_seq __initdata = {
> 	.buffer = bootup_event_buf;
> 	.size = sizeof(bootup_event_buf);
> };
> 
>>  
>>  static __init int setup_trace_event(char *str)
>>  {
>> -	if (bootup_event_buf[0] != '\0')
>> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
>> +	if (seq_buf_used(&bootup_event_buf) > 0)
>> +		seq_buf_puts(&bootup_event_buf, ",");
>> +
>> +	seq_buf_puts(&bootup_event_buf, str);
>>  
>> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
>> +	if (seq_buf_has_overflowed(&bootup_event_buf))
>> +		return -ENOMEM;
>>  
>>  	trace_set_ring_buffer_expanded(NULL);
>>  	disable_tracing_selftest("running event tracing");
>> @@ -4766,7 +4773,7 @@ static __init int event_trace_enable(void)
>>  	 */
>>  	__trace_early_add_events(tr);
>>  
>> -	early_enable_events(tr, bootup_event_buf, false);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), false);
> 
> The above then would be:
> 
> 	seq_buf_str(&bootup_event_seq);
> 	early_enable_events(tr, bootup_event_buf, false);
> 
> Don't typecast a const char* to non const.
> 
>>  
>>  	trace_printk_start_comm();
>>  
>> @@ -4794,7 +4801,7 @@ static __init int event_trace_enable_again(void)
>>  	if (!tr)
>>  		return -ENODEV;
>>  
>> -	early_enable_events(tr, bootup_event_buf, true);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), true);
> 
> Same here.
> 
> -- Steve
> 
>>  
>>  	return 0;
>>  }
> 

Thank you, Steven, for your review. I've sent v4:
https://lore.kernel.org/all/20260713045249.69942-1-woradorn.laon@gmail.com

Thanks,
Woradorn
