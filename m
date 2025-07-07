Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31772080C4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924173; cv=none; b=cSmk5b67uwZpP54vZqzR6eyZpuz1ktTP7i3dU3mweAZhxlLHsUWwQUReotF+2M3RgYXuWtgZbNiQwZ+DytVtWqUFXGvRsjvD2Dm0tOCOYzqcaqMJXY3fRe3BtD88gr5IHkIzsRtObEbv6Qi+R03P9LyHOUWGU+6I5TKEytvUXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924173; c=relaxed/simple;
	bh=FoE1yw4PinF8aLsqwiVP49aNTfhL5YfYRDuew1h9slM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3geZHMgaUwVq8OAq4AfEPg9d7deRAFtrfL2s5fPRBEeHttuvCN5aHcgJMsJFBWsBzCtxfS0cMMc756Kf2qJSCqlZU0EK/ijO6VuUt9CRcXkhMgLkL2zLMIECILReK2YdQb7Ao9f/mEXHpYj5o9UNQWBpTjWoXuJqnky00SeOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuhSX/Rm; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuhSX/Rm"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df210930f7so13690035ab.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751924169; x=1752528969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=ZuhSX/RmBiY/WSTlomwxELJK18RRt8o2YaBsq19C+h/8M7Zlqcm88ZN0Z1pWZkUEYq
         x36BN9F9Uqnj0NJTqeXjifoLpCdcuX3wNcM5sEIn3rP+xv2DvJL+0WsfJDD5+pVM191V
         apGnv0fE5VlNtfme18Nc7ZCRU26+jGOppG8CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924169; x=1752528969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=uWFYIAQYjzoOJAinbKW4VK6iPp8yp72isjN356s8IPhfuU92HEVNPwU5/hXGUd+BO2
         djbqOKTpEPT+D6esIiT9RgwDFG4F+YKVC04X34Z2Od69vL1e43V4vpUU7Rm6ta8nJW9O
         SYDoUojcPZESjPQs784orrT/FO1nhS06l4GFYBN5rseJuAO9v6As7F1KZ3/aJUUySKfN
         bCRncjkKv4oRoR0PQm3iN+d8xD4SJ+abc8ST4TerYNqgzHkVBAOEnumSQZnTgRzd4oS6
         jAT2eIWKAm76OeP0WcMGpGuVsSUZPf55y3AxyHtkT/YpPk6ZgN0lktrYJAFAa6inXpfE
         FvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDEzC2bOLNwGDfj+xv3OIX7PqItt1cwL4QUvYOoFSpe/lRyJJX4zCvZPntZd8378CwPt1l9wmoozygxyahAy/TyQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCj+HVSDZQG1lnwZqbMtb1EnX44cRUyeAwNO6g6ymFEOEr49c
	A13WA1StiJ7qJrmp8DRgX6P6iAibrdXP+FyK/ZDb1KD42eHYg5dt+qQhre6RV9TaHdA=
X-Gm-Gg: ASbGncsqtJHOqhRYaAO5/dMAyLCgj/41RxPJHYT2z5vVPENTxe9Yk5JRUe1xFVdUY3E
	cD4ODvlhjvaB8LgGzP8H9+AYBhoI/Qj9WhmYJyxab5sAOo+XR+TctHuKegABOEFW7fpudbOL1pn
	CMdQB20UpF6te9bHROkn2mOzRDy/zlw3mso0aMiz5Jk6u7mcg+Cy7oSwCJCECcU5E2GCRMQiUBj
	I5XYX/UnTS6SKQxQF+M4k0IwGntNL5o9yz9oeAadKV1PGoVhktQuLT7jkoXf48H77FjDIVeHytv
	0GBF0Nj3gvys3KDxTz8jwCBuKMIHlHW/i0KuXJCyJFT/czt9wbMClnseJ2WWHykKX6CW22rBUC/
	x4/EBufqa
X-Google-Smtp-Source: AGHT+IF53byRaWgnL2/6PRGJxd7DTJKFA1T8Wjv6k5cGUjcY6U6GoMsR0lJgobtuehyYtbBQa4iQiA==
X-Received: by 2002:a05:6e02:522:b0:3e1:433e:2605 with SMTP id e9e14a558f8ab-3e154e63815mr2132085ab.9.1751924168902;
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c6d77sm1911718173.32.2025.07.07.14.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Message-ID: <57f72a27-10b0-49d4-8bd3-39b35f422a95@linuxfoundation.org>
Date: Mon, 7 Jul 2025 15:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing glob
 filter
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
 <175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
 <20250703103039.3559a7e1@batman.local.home>
 <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 00:04, Masami Hiramatsu (Google) wrote:
> Shuah,
> 
> Can you take this patch (fix) to your tree since this is
> a fix for the selftest?
> 
> Thank you,
> 
> On Thu, 3 Jul 2025 10:30:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu,  3 Jul 2025 13:26:43 +0900
>> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>>
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Since commit c5b6ababd21a ("locking/mutex: implement
>>> mutex_trylock_nested") makes mutex_trylock() as an inlined
>>> function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
>>> mutex_trylock() for testing the glob filter of ftrace.
>>>
>>> Use mutex_unlock instead.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
> 
> 

Applied to linux-kselftest next

thanks,
-- Shuah
