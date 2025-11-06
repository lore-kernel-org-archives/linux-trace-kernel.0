Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6D26ED29
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467944; cv=none; b=cc2GJ13xPA861Yn4ERHntWAxpFXiWjmspOsXc2/oD9WwdhxcQIbp2gJMnWyXvRNo5QI+9nD9n7un2MivRNe72Fhf+FYUzL2R7/VfNCEYHhy5geAMO+C2QXFlicSSGyC3P9h8n4roT1rrl7VR98YFaWfEP8yn38pHho3B6XiqIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467944; c=relaxed/simple;
	bh=c3Lbyug0B8LC1SBsLJoiXKtGPHiW/sjp9Vcgo1geYE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peAXLnxQU6QZ4O4pEIWThbiogXmc7TLvp9SLOtHyd+Uk2AnpTg3byw3zdhi5MGRbpoU4jX0cHA5SDR1696rugkkFrfMUN0vBlou+lE6O8vV0hLOdR5j4EUsYeUgicdGrDqnN4zJdvUQpYVXrHUQQheW2NTYs3d+V5Maz84jHg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJLY+pre; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJLY+pre"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9486d008fdbso5012039f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762467940; x=1763072740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=cJLY+preBPJZGlZ3bZLeWjLc3o+HaU47ziG3X/uFLhgBj5kWfPQ5mnUz+Lhfv6xlXt
         YSwSPoHW0q+h21J0GQ5vJKj2GMcOZajq8Vh9+p54Z1v7G+urMj6SXnlXdRmAMY9RUpSP
         8r0LG8SO2rtl06djLxZwPqibigGRqk+Jqi7jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467940; x=1763072740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nojW/UFZn0qbslE6OPGihe1YdAm5O0z1Y/2QE55GUN8=;
        b=Bj6DNEFTikZxfNYTEOj6+AsKLwzH8TD0WWsaPQ2S6AX7hrU49wlUFw8cPRf8hzgrGF
         UpE9QVx3jBw9Kb1ncpMlQQbkXtfim20s30hadEEYtdhg6wkIPx4Ek3SJHD9qrtH9zPIO
         eHnO8tDEkuxNaYIDsn6Iw+Bf2+Hgec16f341n7PEBfdoVmpdpD6gRU1BYXAnhcutIbI+
         rmwA9qU3BxGsMsc1BErWHZIT1wJYxqkbGHF72PKwKEN5gUoKk2k2eNiWY/Jk143WP1Ri
         Bp8+AjH2yv7UAlal2eZbxNCID4pOkmU9cfsVeRE/TPt/G9nRBiyKEkOTdY6VeCOEb9ym
         CeGA==
X-Forwarded-Encrypted: i=1; AJvYcCWOfIZHnmYwYQKQ7yFdgajoX5dOL9L9PtDpCfcFP7FUZ+BCJ8TzRzimEQb9C88dxjoyIzOvkY4LAHVnFS95Dy/b2Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RtndTWa8UY9J4iLWVPIEJa1zb6clz7FOetujkSOAdKaR0b+z
	wLZzjU1XiNn8BBRdw1rqeQRMQJpjUww5CJJ09dYyUmAd88UBZS107j+g5oPtXG7VCm+vfYI3RO5
	ulKcr
X-Gm-Gg: ASbGncv7q7yit7V+VTgIoyYL3gXCXm+2QIjs9RhYBzsyl1aRah+lVUrZ16s4I0y6O4C
	w5FqODZJ+FyD3SwP+yTvZGV9iDEw9NV6WgYoxQZi9WrkNB8NUpNTo5nWIa1Kl/6LWX7Qu8KfUy8
	JWRPqnwRLO1GQv6LCkplxOmGIoxmxExA+60d0vWMYFAoUW/hV01dYzp4OzJ7zXxSlbMuvA4vb2T
	B3/xj894VWnxSy48UZzBR5cRcotR3vMkxFC9LL6YWLin1UJQIvgKDJlKw/FzT4YyQTxVG3FKNKf
	wm0VApfkRKOQPd+YGyD/RBl2rjzkd4wzJicf/Hr5GJn75aA4mQ5axIKM2+zY/Ini5yWpH+VIIFg
	rTxECFgouE+gusO7A1NXCtqaa3L+Do++V+l1YCivgQXodg3CtwToqJh4K8jKKwDDFrNVS972xk2
	WxhFZiEEzwGOOe
X-Google-Smtp-Source: AGHT+IH0/3GJ4ianQvzZFggnE+5AVLuBjfhvBYg0/6brP9mgyD+T6dTbpZArnCJ/fgMPmOmGaPjq4Q==
X-Received: by 2002:a05:6602:13ce:b0:945:aa01:bab7 with SMTP id ca18e2360f4ac-9488870ec4emr224804139f.5.1762467940613;
        Thu, 06 Nov 2025 14:25:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948889fae8dsm32195239f.0.2025.11.06.14.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:25:39 -0800 (PST)
Message-ID: <0abf9a34-232b-4840-b592-672aa277509f@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251014145149.3e3c1033@gandalf.local.home>
 <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 16:47, Masami Hiramatsu (Google) wrote:
> On Tue, 14 Oct 2025 14:51:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
>> user space") made an update that fixed both trace_marker and
>> trace_marker_raw. But the small difference made to trace_marker_raw had a
>> blatant bug in it that any basic testing would have uncovered.
>> Unfortunately, the self tests have tests for trace_marker but nothing for
>> trace_marker_raw which allowed the bug to get upstream.
>>
>> Add basic selftests to test trace_marker_raw so that this doesn't happen
>> again.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks. Applied to ksleftest next for 6.19-rc1.

thanks,
-- Shuah
