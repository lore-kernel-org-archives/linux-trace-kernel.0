Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2D391E7A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734942; cv=none; b=It8LxNyfviV7fJuFUQTiaNDCwF5FkmWlKeTblq5d1lZ11nXUsSXrraylwkq1ANPGoTpP9vGyELDH29EK775b1SGVz4x74/E3nBZ3rDCIBNZJtzrWZBPtl0edFgcNwx66DopAVevUiUj15b/L/ua5FDiV+05mKXkPgmN0OqFTrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734942; c=relaxed/simple;
	bh=f9ltjWijChP+XwlEfqLXkwLf6HWaXOC5djnNtTmN11E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6mq+/67A3NgeV8EN/czueJJtpaqWiFKRZZepAncB+VikOKlb9qwCAyCiLFTyJNGBKYAZGoRcOaEOmzdmiQbQoRfqRKwVfETfBdCEzyHagu/Tv3fJoK7Oym2aVG9XN0XpXZUpJcq4nsKc5DWk3/kjW0ZZoJ5fKg6VjhLLINHCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGNf2bsu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGNf2bsu"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4866834f8deso107754b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781734940; x=1782339740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTXpAyQa5yxfc977tpz0ZoWkhTqW+Yu4kmTVOCchAW4=;
        b=fGNf2bsuUxZwgA+6ZxlSMRi2ip+2f7gbiME4RjQMqyxAqh9/tZKsW2TClyq63QDL9M
         isGj7/2ZuATaEc455C5vgzjAfWcMDa6Tn7Gc2WpOKkGHbwF5qa0NIK2rbcj/gZNzKYfm
         3UxFyDUqo05G6OnhBITfs1hbvEzMZCY8a8u50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781734940; x=1782339740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTXpAyQa5yxfc977tpz0ZoWkhTqW+Yu4kmTVOCchAW4=;
        b=qoMjgxNvQcV4COViUSYWUu2M/9jC7mkx9UTAXZCzUmPfwmc2OLz4VWuTHyBXd2OKcO
         b9Uv3J/ECxu5rFiJd1NqA3bhHply01J2tKRXc9Rbeh90ibm5oh9wa35AGszXHfhl+USv
         +g1CEipbcaBoIGOiM4/5HjP68MGpUrsVznTeETVafRDNSEV7c+RSLCl+lRjA/nlB9bSW
         zXjUVnFme7Q/FXoOBVtRLE+p3X+OEzKu+53iKvbsfgpTBXXX9NVa6WzD+2F7c4Z21snJ
         KQVCCONfandql0dGUey8kPzGf6Ubd+2aruSY4aMlzV2nhPpBQ0IEIYY8Tufe6u1jxBQr
         GCVg==
X-Forwarded-Encrypted: i=1; AFNElJ+L8KljH5QM5kboiB6Mb6w71yZeSTDCxW3wUk4zWEFNm7CPngV6Ne04SUf6UVih0rMZJ4r6mFpgNit5n3FKJVYwOwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwblZQU6Q8NsdikkL1SB8RYYIhNCHwez2xcCm23+oaQIYUwnB0
	GM+ey6AQt4Fl4OhtXLesug2N7ZYXugjVgQaZFicSH7IRyWqhYa3KhVvOhUqMtGAuubA=
X-Gm-Gg: Acq92OHwAkbIuLR+QKkWhUG2aG9PQ6J8JYes11nZCt1JhSI9GrI9Q2dGTPGru+l9u1c
	c9hCg48b3qJtlIJi+qCIn6ZBTDJHwssI1atLOYFy76JzUCLiSuZKZHVnhBWSozOPX3H54grTaBz
	5Z07tRr89mH3WbHQqT5rhl3JVjUllx7iM/X4i8kw+uOiyQecMF4XW545qu07kX4oW4aeAVh19zD
	EZmXOgft5wpcOPk6XKSeSmIyiHLC5l81yiReY9t2hmNR8IOVHx3HPaOwKD5kxwNyn3Do/tqNSsZ
	d13rRXkWBYm+be8pQdY0StALEs5Gi2K9XfUQbBpR6iuOdWSb3YSZrTFWBRmOoD9gvTjbHdMqyaj
	+hLN+OIWaX7sPi8x4dq9k8UCexJQoGMQ8BhQ7uf4+qSNR2WmAbX3Nohy2k4c/iCwFRRATQzqvCH
	gKFGcixOPan7mnD7NQmC21
X-Received: by 2002:a05:6808:1483:b0:479:fca7:4647 with SMTP id 5614622812f47-48944472537mr4208022b6e.2.1781734939814;
        Wed, 17 Jun 2026 15:22:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875df8284asm7093338b6e.11.2026.06.17.15.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:22:18 -0700 (PDT)
Message-ID: <787e5047-04cb-4fde-9563-2d6eab23cf64@linuxfoundation.org>
Date: Wed, 17 Jun 2026 16:22:17 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Drop invalid top-level local in
 test_ownership
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: CaoRuichuang <create0818@163.com>, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260407102613.81419-1-create0818@163.com>
 <20260407203727.442b583c@gandalf.local.home>
 <20260601133146.b16b0ad7c2204adcc168c945@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260601133146.b16b0ad7c2204adcc168c945@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/26 22:31, Masami Hiramatsu (Google) wrote:
> On Tue, 7 Apr 2026 20:37:27 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>
>> Shuah,
>>
>> Care to take this through your tree. Probably could even add:
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 8b55572e51805 ("tracing/selftests: Add tracefs mount options test")
>>
>> As well as:
>>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
> 
> Shuah, here is my ack too.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks - sorry for the delay. I will send this up for Linux 7.2-rc1

thanks,
-- Shuah
