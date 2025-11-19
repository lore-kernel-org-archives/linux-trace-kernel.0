Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893B2FB0AE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588667; cv=none; b=TCCXspLcMyOPD03jh3YSRxjsE9LvDDu+ftDrL4kB7w1KWxHPBVYXM4NtfItO8BzUrkK+ZWrApVRbtxoQGdA5CW3XxFb4tHvKlxGBdkn4B/bp7rc+sSiBHyiz4raqIbr23GMLEfkdDPiKV0AUAMO5RzrrBur+NE54gE7w1myDZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588667; c=relaxed/simple;
	bh=wAWPerYA174M4j9byJCSFLMsKyW5NX85WcFSUMI8ETk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJUFGCoNZLZ/wLxVa1aY6dwfyVhWmbKKVO/NpfQp4LKuzIHiVq9DSZWZPvNEhNuPMn3Q+q94zahSy0IIPtgxJRUnrxL53T9UbKLzNCPGzq5Er+PBT6bhpoVnyzwTdFdPXu0ZrNNINUJXkkjLBK2HooemG5WFj95aLE7dvcLTtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaZObKwT; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaZObKwT"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9486248f01bso8119739f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763588664; x=1764193464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzlXhKld4nT0xL82yzn50M+W55+QbiWaolCWYFDzktY=;
        b=PaZObKwTabxWASocyEhxxg7gUxqtsZEf+i64JBSFw/dMY9LCheCySmew+ECflQxTBZ
         +S+h6uWFaPB6YZfUhs3FthI0bdqku3e+uJkVnxKnLaWGa5vxXVTCOPG3HkXO5dqIMcIM
         bG0kdhX8NdA4vkaz/CDke3L6kXRnRcro85e7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588664; x=1764193464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzlXhKld4nT0xL82yzn50M+W55+QbiWaolCWYFDzktY=;
        b=rTRwqXeiFKCwEdPPRDcYKp8X3g9YmjInT4/X96Qo8vE680kTqGlhzQt82kZ/K+rZQB
         7SDZmlKmlP4+023dtUXJrZLg35aWIMZpJnKdchFttsmiQ8RoqDb3VrgjFgpK72PmD5Ku
         m54zcYQYlcCK5a6L+eEGTXNXTN80RH86kDn46SL3HJxuPH/VAGxzXiDQqYnaf35EK/YD
         IsFv19eoVMunKV48OF8XhdHMytuQPW9GCw2tvFC/XKdfnG7oOScFBkgWa+WcD8Oxw+i2
         eNbBVPb0UWX17gB8rzV23HlDe7BPzWbOWh3ehZQ4S23Pmk7t4o14QZN3rruF9zbgFKfA
         l9eA==
X-Forwarded-Encrypted: i=1; AJvYcCU02Dc0r9ZgmVmANtjmxb075jRBL5LrgeXKucTcd23006FGvVIWVEcwfhd4k+yY+sb+xPk/ZV8DK8BuNWSrgNYbJiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8EoomcLMi5bNZGfRvNj7fZPyy0CASWDi3Cowkf7snSqO5dBY
	+aODVZI5xmuWHXmCN4kxaNoRtvat009NmZp8h9J/B8A/sj8Zq8NroFYKpQ86pS50pAk=
X-Gm-Gg: ASbGnctX0ryiwKpKEw40r6jrbGL2zUcKb2BVhPav8tIquuQBxJXFBRQIrKz8AUOeI+P
	okWvr77NCkCKQXvC84xEk2GKllMYM14+ha4TEhRPFatdK4kl8i/Cj7CUrmqP4nKsq228LXfbw3H
	R9dw0XIY6aPlIaZopKT/rdt+UGiZEp1+POWNIGiSRwpjwgYX6hiTjl7fHs6/jo9hkpeCU5JFPLH
	/sRqkcLPS/lyayp9rxdVwHgurF19oFcr9FSujh6QYGJ5OgwT2Noj3JamX/jO0RYK1C7iGv6KOaR
	yXoEAf8/EpB6HjgCu6omXhkUfbi9ziTeTKoiAABG2hYAljfwXhghen5EA3Jhb//au2lpbzUC0YU
	fL84uYTmENSzyGRyq20va9kne3vIcNu0sseH+/YxJc3SUtRi03+VeCLZV5eGU1UKIHJhjano1Se
	CInGBmofynshShRehMY8GbOwxaNmpXkPaNog==
X-Google-Smtp-Source: AGHT+IEYqeylwrGRDCIwfcCgECknaWrcBPocfi4nhpOHNSC1ufLbnIci76b9Bf4WGIE5CVi73ijqlw==
X-Received: by 2002:a05:6638:292a:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b954043c72mr566133173.10.1763588664058;
        Wed, 19 Nov 2025 13:44:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm172340173.33.2025.11.19.13.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 13:44:23 -0800 (PST)
Message-ID: <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
Date: Wed, 19 Nov 2025 14:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <176252610176.214996.3978515319000806265.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
> enable tprobe event") caused regression bug and tprobe did not work.
> To prevent similar problems, add a testcase which enables/disables a
> tprobe and check the results.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Steve, do you want me to take this through my tree?

thanks,
-- Shuah
