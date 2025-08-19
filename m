Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895402FFDF1;
	Tue, 19 Aug 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624889; cv=none; b=YJEbArznmHyxTjY/uh7C7UvD9XfKXZO0fLDD0SZkN0kO4w1cEEBpix0gYkUReUNdiXBcAFeEmrMU7Wbt4GY6e0UeJB3jwe3LaLlJn6CU1EAlQ03xZyxUanohfLqovIQ31EpLNls8AQGfe+3naxoU8+JCHTMmJXmIfEogKCvyx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624889; c=relaxed/simple;
	bh=bwY4RqvIUVjti8nFxW11inLOnUPd+lLxl6GuRe6CLck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7TrweSQZ42mZl19oOCY2Lar/OjzmebSR3X25JCIILZzEFvBwwru/nx+MW4JrjtjBgG8Mr5bNv1962x62sRS0sEQWyeSTISXRps7GamP3KnTfFq9ruY6mL489eSYaW8jmF0gl9ome7pZqvUwHa7jvdyIsPfQxIPOqZa57zp9jbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YumlooBg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YumlooBg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9f22aa4fdso389415f8f.3;
        Tue, 19 Aug 2025 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755624886; x=1756229686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS2Vjoh44icWptyNurpvy4S1A6LcVdl5tDdwEsptosA=;
        b=YumlooBghPmiY0QsLTN+OaKCv5FMqXTtmWz6ZpeQKHEHqxZunlYErj/tXey/WZ4ebC
         AotVsCenySCUIDgszho2oTR6bXoOR1TaPWUKbHCJLbeCXIcabyTfJceQpkowVa3r1RnI
         91xrYEwvEThf1Ydm7F2/YvuMEfBXTKNnbDffgNCd9McTE4mXDJL8K41biGoE/XeHNmCh
         vsF2vSfpF1NL2w33Nw5lZXlFzo1QtdVijZGwg4Vk8akDv5bc5/11iaRaDAfE9GMeqMP/
         lEckH2xD2v0eKWpREJ9sOXDoyGhrdGXh0eIvJbUrSP9flwx6K6kJ//5Ud0YJOeMrUHeT
         qeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755624886; x=1756229686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS2Vjoh44icWptyNurpvy4S1A6LcVdl5tDdwEsptosA=;
        b=H6chxBjrg1cbPbPfPHCRAHJWREf6sa8siDm3R44jdyJUEFKBDlK8luU7KyiHmQRLAh
         OBvAv6CJdavGAS+YWyWSe+VzDNPx9RiY4JqiAAtgdcEFcJ68yUhyMKVbzGtjYrt3qf/F
         9Hoz+pDQEcaRMAXdf6JJkyHvdBi6c5fuPm3PLDhvZsOT/FotK/hMJZyUe/HNgNhnSy7v
         t/UuSoKXhX633ICP/EjWFSKOenUrdpuuwA9h7ECf+KExWdEkqMmoxDtkefNwvTi7gm+o
         +fyW3FJS/Nk35KqoRO0UkxZU5fReY4e1oYdUIwpsZcYnho9a5rKyzOVrKQ1SI+l7KabD
         aN7A==
X-Forwarded-Encrypted: i=1; AJvYcCVpHNobcMqiPTpG0VeiCSYtWp7A9VtgMk+5d8Jc7XYRsP+bq1eiIHm4TLtiN2E+eAe3Sye89ob1/Po=@vger.kernel.org, AJvYcCXXEe0Vq8EQzuouvej0eYA1Pohq28kA5ghH3ZyjalQFnfbbC4iOG652421jYCAbInDs2LQBtEXTNMKC2tI4KopiR/9b@vger.kernel.org
X-Gm-Message-State: AOJu0YymBfQdg2u6jyLEfR5kWdVn2vKaianK8vrQSwidL+hxR9b5AuLB
	WcE3G+5vzc73Z42dJAY8pSjrFwqQSm/eNT9DJI6f+OjN2j7yxzphaU+9
X-Gm-Gg: ASbGncuQW9mzDXnmkPFjw7nCU3cUb6Wppu6ec+50X79SHNlbwgT9YhrgpRFoJ8Lj+Cw
	wVSlCLpGTPV6p4u1RAOAEOKc3QeK1kC+yBRh1zDADUohGsyVlgy0F2981e8fjIqmm8XHenfzqAT
	yPDl7VBMe0PE6bSWkuaLtzq19DErhRakeW75X0TtHBQkZOs5w5Fy141C1g3axzfPmDhwANzFdYM
	rbpGQ7qay1DPdM4OYKspVGveZfuHmoiKHacpFP5bW4HvPxw0rCmjT+MfS+RZumncTJLgVyrjmWU
	m9cM4jqjdUM9M33PpMVn+GJ9q89kdR8y+Memu+idsC4shqxn6IMQPnhZOvc7dFpE/o+rKIAx3hG
	ODUNwvh7FsDWIPlvc43ODq486Ujs9PqK8sjsoNvXu
X-Google-Smtp-Source: AGHT+IEEpKSOlOQ4ujkMr6cPIJn/Ad1HradS+o2SX4VhEmxA8lpfnAmVBIe+dKKN2qxJSFevTX6MXQ==
X-Received: by 2002:a5d:64ec:0:b0:3b7:892c:41fc with SMTP id ffacd0b85a97d-3c0eca48b3dmr1039170f8f.9.1755624885649;
        Tue, 19 Aug 2025 10:34:45 -0700 (PDT)
Received: from [192.168.1.16] ([41.231.66.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm4514073f8f.48.2025.08.19.10.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 10:34:45 -0700 (PDT)
Message-ID: <f5eafdfc-2ecd-4212-bb88-b93c34de7673@gmail.com>
Date: Tue, 19 Aug 2025 18:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Corrected typo in trace/events
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: linux-kernel-mentees@lists.linuxfoundation.org, mhiramat@kernel.org,
 rostedt@goodmis.org
References: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
 <d14df81f-989f-4467-aa0c-5c65009fd66d@infradead.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <d14df81f-989f-4467-aa0c-5c65009fd66d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 6:18 PM, Randy Dunlap wrote:
> 
> 
> On 8/19/25 1:49 AM, Mehdi Ben Hadj Khelifa wrote:
>> -Changed 'Dyamically' to 'Dynamically' in trace/events.rst
>>
>> under sections 7.1 and 7.3
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>> ---
>>   Documentation/trace/events.rst | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
>> index 2d88a2acacc0..18d112963dec 100644
>> --- a/Documentation/trace/events.rst
>> +++ b/Documentation/trace/events.rst
>> @@ -629,8 +629,8 @@ following:
>>     - tracing synthetic events from in-kernel code
>>     - the low-level "dynevent_cmd" API
>>   
>> -7.1 Dyamically creating synthetic event definitions
>> ----------------------------------------------------
>> +7.1 Dynamically creating synthetic event definitions
>> +----------------------------------------------------
>>   
>>   There are a couple ways to create a new synthetic event from a kernel
>>   module or other kernel code.
>> @@ -944,8 +944,8 @@ Note that synth_event_trace_end() must be called at the end regardless
>>   of whether any of the add calls failed (say due to a bad field name
>>   being passed in).
>>   
>> -7.3 Dyamically creating kprobe and kretprobe event definitions
>> ---------------------------------------------------------------
>> +7.3 Dynamically creating kprobe and kretprobe event definitions
>> +---------------------------------------------------------------
>>   
>>   To create a kprobe or kretprobe trace event from kernel code, the
>>   kprobe_event_gen_cmd_start() or kretprobe_event_gen_cmd_start()
> 

Thanks for the review Randy,
appreciate your time.
