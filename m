Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AA2D481F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593021; cv=none; b=fyjx3JW8UaPW/FCGcBdhBbax0xCq+wAFvu1bYnGS2I7KhJ6zipss6o7y/5E4KadhbGMvV/jk+q7X/2dE8bUqaZjXodneCVaccEthPKQSMqBJqnd1zLFDpRf1iZuHpWUu5g18MkFsLtRPMatB/02IdJO0KMwo10p64IomFNH6giA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593021; c=relaxed/simple;
	bh=yOCbSOXUcf42hI7Et0TY2otuu3AGTL7xxB5sc17Aou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMNbLMmE7dhfugW7eolbde9FVOdgbcLRsbmNx1z90MlODEJzIOgiso8V8ve6K2DTulkNXqB6gP9jrxvdPr9Co+wbJQcoPAO3XUwFb1OY7IsNHcNzjE58a/jhRXdEVCHwwbkRU8wS2Vw3vaPAg8gNIDjRbrn9XMdZGIU67CGb8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S92gXX6p; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S92gXX6p"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4332381ba9bso1546305ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 14:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763593018; x=1764197818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9Cihjz4mIMaTQdMejOmpXxdqpfNp4ZNHdlB1PDzoK8=;
        b=S92gXX6pxAQBeagLbG3zFH8hEM2F5YtHeVvGCQT13Ri+OdtVfNlS67Wo1mgTHsY8iQ
         OPEjX6pVj1bTMjH4xZnx3XYXHCIrwYvbLXoDEzMWZVJe2U5ugqjBj9gn2N4hnLz0Gc+S
         mtjAM0A1q4Zqi2RMw6I3/yI0LIgEunrYnljb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593018; x=1764197818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Cihjz4mIMaTQdMejOmpXxdqpfNp4ZNHdlB1PDzoK8=;
        b=qruH1CuvYVZgnjFttzy9ZpWfTltUJPOb6FyENEIlLImcLUUAHQRqutlTEE30kyEg2D
         0Kanrrd81Y02aAPvDwd0sAU4B5pXrBzptC/+1PuesGFdIzEZXUxLGJ1JNMCdwel38KlR
         QiZGIF6xmApsSzTq3ZpcoDoWsziQ+KdBubHJlS6RkUxuWa/yAQpxL9odz7ac4n/+2cly
         jD5bx0BLoMHFs/UGvq2N5hH9qTY7eI9KiN9BhNvWEZHH1xccKM5lekzc+nQxf695ca4y
         5hQqzMjQ71/5uR4+Etd5Y5v9C+H6lsk0wp0K3g7wBbZ/3vCiDpfryTJeLF8XDynbZubz
         YVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQJ6aST04wqEq4FcibwOcTxuf+jrmONLcVVA2M/baSHBhnxY7REjxm0jlCAygokmlx+t0EGmx+ftmCCJop1BAV63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQIePJtJAXqhDwgRwORgDjee97cWQ/SL+EycJZl2C+PRz2GXG
	qo3Cwj69dvtFf7Hdzlt/UqcY4ZgCciyucgC9YRMNFHGcoxuEGavT/pgWEKuIsrOVEBM=
X-Gm-Gg: ASbGncv9wYGerBNl/o+rL52AswNjLLS0IQ3KONwIFuujsbOZW40/UvsMRflYZPH/ic3
	AgUwrKW2HmfVetsrBY9IPTFK1DwtM8iR2Ro6+kKtHsVGAMNWTUfpjFombhiMJPPnLUNfCz0Ir4q
	vGP2zdt2TfAP311SBHWw84t8957ptRY06qbOm8EPPl7R+QfrHAPyNPALndfyaoh7mPBeXLYf7PB
	4EEedH6WGKmDrFKs0Ilcr+Qyv1cPUI24+XdqrExdjboNZf+PYpj2DvgRZx2EKJ/3MPsAftvVy1z
	SgYWXlcNX6U2ZDrHn1RgliUmnvlUyp5Xnczq3UxQplIru/c2HnsllbnWuZVw8MdtBNkh9ryTFJL
	sz7lP57CtOA9kqhOybLx3niWnYxblaiH36WIfFC7Yy04qtBfgjauqgeTz1OCpLmrBfTpfVQlpt5
	priDAtef1C0jYB7JF/h7JMm2E=
X-Google-Smtp-Source: AGHT+IF0n9luN6uLPUD0+qtd91vv8ozpZWFR5sEp2+lnlFuJPZGmT1NL1+Q7O5k6hfud7//ALyWKHw==
X-Received: by 2002:a05:6e02:156d:b0:433:7310:f5bf with SMTP id e9e14a558f8ab-435a9077da8mr13911545ab.22.1763593018248;
        Wed, 19 Nov 2025 14:56:58 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90e707dsm3627275ab.30.2025.11.19.14.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:56:57 -0800 (PST)
Message-ID: <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:56:57 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
 <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
 <20251119170611.6eff8df7@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251119170611.6eff8df7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 15:06, Steven Rostedt wrote:
> On Wed, 19 Nov 2025 14:44:22 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
>>> enable tprobe event") caused regression bug and tprobe did not work.
>>> To prevent similar problems, add a testcase which enables/disables a
>>> tprobe and check the results.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Steve, do you want me to take this through my tree?
> 
> Yes please. Masami's an official maintainer and mostly handles all things
> "probe" related. This is his domain ;-)
> 
> Thanks,
> 
> -- Steve
Applied to linux-kselftest next for Linux 6.19-rc1.

thanks,
-- Shuah
