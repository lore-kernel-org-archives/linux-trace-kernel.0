Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EF30C36E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210615; cv=none; b=eKGpcFYZFmFr9/cMn9eKN+EmEtwsDqRxRv2myaHWz7FaxzaKSjdmNZ2+rs9QahetN85fXI1Y+zP53SrhG5ckGrIXTObGg6wQny8TPrzhdmkwIZre5QY5JxYC6jHn3ghpcDSgvy5cEgytyNFH+tdENA494UOMzO+j6OZkc61Eqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210615; c=relaxed/simple;
	bh=1nTG02+cFhCSgRt+ehKjArzMkG1sm5NflheH5nhNZqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epvfUEz0TUMjL/OBQ/7LHkTMAwDasDjIjS3bufMr/Pa7BHlcb6g9AYD3k577MLTZH2fOU7Rav5Q687MNTvnhwZMkDu32wHWpwj6zohi/FlgXqFInSJZis6mtyyE0L3c1hxt7Aw7Fi3PTgYvWgdasrTaL67KSpYqwQG0KcQ1aZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAQN1tr7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAQN1tr7"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787d5555274so101539037b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767210612; x=1767815412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maEYF369L0uPYuEDq459k1fu2OdLy1XBNdtHglonY9Y=;
        b=NAQN1tr7iwB4Xaj7bLBF0XQzvcsZPDgUxVtMCkgEFhs18Bk44cTniy7MumycCK39LW
         2H0y2c5L626Uk2vYjMhOUfGLPoD23OYf0+TYFYVZexskgH7fUO3mlvjDMESTKc4wjKRz
         p9+mkfdu/9a1qgBHHH4+LPALCjLkd+CyM3GJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210612; x=1767815412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maEYF369L0uPYuEDq459k1fu2OdLy1XBNdtHglonY9Y=;
        b=Mfjg63pTpMdWuuWulM8DB5M2j2zwHTSWN/O0vTF+kBhxupB3Ye4Nf1G8lNFzI+lRaJ
         HyOgU9aGduitczZUcnao0RhCVZOXOrf4omUTORYPr/ZeaEMfXBS/g2N1ZsNkgoIkQspm
         10Tt5fuWMDhTGleDjm1jh7tnc3E4BUSn4UYI42gFgP2tLM9BBDUs70zbU68/NdpTj5wk
         dOgd/QCInuJVxsf/sVeCfSoOW04g1+7RX4wF8C+ggFy1yNwCvxKU+YuDyyhdPk0kmNQg
         jLU5o1YZ3nnUrvZvTLd7bpoHmvyTOwrmKu/AAFAU5g3jjkM2gIh0ft5l1qqInpyWsZu+
         Bb3g==
X-Forwarded-Encrypted: i=1; AJvYcCWmnlGkJz5lYnwy4190vooX5YifiRauqc7Zc05YHI9C3OSmNe3Etp9b1+p7In/u4pftwfK3JYECizyet4J+5k74QQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7eC/tMDvfK2jsnZZzWZpr9JtXZ1LxfSjl0z1rKw08TmemUNL
	+dvAooBGQkB8793PuaYZOVNnnFz1/URDulG9cgPmnbV3Q4On1LAeaskKOKEMcTKnIyh5/czpHbV
	zQTx9
X-Gm-Gg: AY/fxX44ugwAGZgpTnzeLB04jnN+1Z/g//islYpFFC0/BSetVoXLUsOo8HT2kxwzf3n
	Cvh5V03HMtcQazG2UhoOgD8I6op6ADx3WEV/rFGe/OGqiLcpnGP3tinrXFSWWxLgEj7yCgZMA2X
	nfsuQ+xWopIyMgc/7av0LylOzNhvsW4dFgKtMFqN4aE6X4OGlezOf3Cwtc0uK988mmjFwf+ExO+
	Z40f8KfkganKRsttGsUTQ3SbGXoOWOAjhfAbCIpBOtdTF8xA0HqwER6FfLYOhjSntpzduuz/pvu
	63BkTVk2tSXUDZ/vMFR56ZMGfdVR8nZ96bqH8paCbQaMoLXsmeGNqOFI5OM7aoD6e7vy1eLazHp
	91mUqk6WYs5kCHd/cG6fzhDaocpPkmJ5eGQKQxTWn1JyRwWM6T/IheilK505MHj4/1BBL+2FES7
	gv/mZLxi1uzlk95moagLt7ihc=
X-Google-Smtp-Source: AGHT+IEHH80RGrTfxuAhiuir8H8nSeW1HDOa1c4Ztm/JyOGbm48G01zOg28illc45JuiROUURZwGtQ==
X-Received: by 2002:a05:690e:1cb:b0:640:caa5:57be with SMTP id 956f58d0204a3-6466a8460aamr25140621d50.28.1767210611707;
        Wed, 31 Dec 2025 11:50:11 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a92c5f6sm17853490d50.21.2025.12.31.11.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 11:50:11 -0800 (PST)
Message-ID: <382c86f1-03b0-40b7-aad6-143bdacd8a6f@linuxfoundation.org>
Date: Wed, 31 Dec 2025 12:50:10 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off names
To: Steven Rostedt <rostedt@goodmis.org>, Yipeng Zou <zouyipeng@huawei.com>
Cc: shuah@kernel.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230818013226.2182299-1-zouyipeng@huawei.com>
 <20230821111358.7540bdc9@gandalf.local.home>
 <33503bb2-6248-426b-a614-9f0f92899d70@huawei.com>
 <20251218182719.34334341@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251218182719.34334341@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 16:27, Steven Rostedt wrote:
> On Sat, 13 Apr 2024 10:47:14 +0800
> Yipeng Zou <zouyipeng@huawei.com> wrote:
> 
>> 在 2023/8/21 23:13, Steven Rostedt 写道:
>>> On Fri, 18 Aug 2023 09:32:26 +0800
>>> Yipeng Zou <zouyipeng@huawei.com> wrote:
>>>   
>>>> The func_traceonoff_triggers.tc sometimes goes to fail
>>>> on my board, Kunpeng-920.
>>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> Shuah, can you take this through your tree?
>>>
>>> -- Steve
>>
>> Hi:
>>
>>       I just notice that it haven't been picked in Linux-next.
>>
>>       It's there other issue about this patch?
> 
> Wow, this is a couple of years old (noticed while looking at the archived
> patches in patchwork).
> 
> Shuah, I believe this is still needed.
> 

Thanks for digging these up and others. It got buried deep
in my Inbox.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah

