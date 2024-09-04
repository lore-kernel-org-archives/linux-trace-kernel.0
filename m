Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE414B95F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484193; cv=none; b=MiWdY1JcoT1mM/j4GTFvOf2OZTt7qbxb/qr4OwLJKS9KeeWlo2vEpe95Lv+xa1x9rvo9k0+ioB05j8kVX3JqY6nBpttCIN88vIy7PvakyElLCmWqs4dX32QJm4VKGjKFFSKHRf0LaOnzX1tAbVqoUNnvAkF+Y3HXun7GBnUlXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484193; c=relaxed/simple;
	bh=th5iFwBAi8yOaXFpylDbD6g6XyDctJyukgrxCXOBuvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NENAO+wCBVL29HwOPHUx45om4a++MiDmyS+HJeWxUDpBKPrVryPPsRi+6UDe2TTZZrMasXH9CKMVDySEyiE111x0dhmGeogJSp/TgxJAfUt7MiYvKSaBPtnFEuGk2D1lvKhs14a1XvcJ9BlP2bHWRWTogdUBGsQUpNwr1NdAJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmFLZqP4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UmFLZqP4"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a22127e97so284939f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725484191; x=1726088991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=UmFLZqP47zG0MMay/+3BjM9alUNHPaW3Az0vcjV2v8rYhKHqhWv0msdtXEt6cTQNwY
         ZpKt9xXv6wZF3mkci4nqHRZvNkoOegFDrknN35NsbRr9C9pFfchV6S1ADslGCSWm9K5d
         C2OH7wtgNFqw6gtTjVxRpcEuODGzq5lf258jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484191; x=1726088991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=LozL0JMCoB6MpFNV4pKFr+Ppc8lmjJbm/25saovrbrCOHO5dVKlO/GuuXCSoN0Cj4w
         M4gZxZBMCqHmGZAMRIAJxSReI1Gu04iXv/slZFr5ky4PmCDrvMlVRIGgvc65N7KZvro5
         X9mBtZeNFtAe60dekAm4mj/Jwy/a6SuflXHghvDqKQRW3ZVZdIyrZDd5FhJxyVnuq5iK
         lj7N2V60hVqJZ4p3H4G0f5YYBhNfugtiJRknJo7lUPFaQ4KgobyQeSUBkhNXN51tBZdg
         qoQv9mmYdCEm+KvncuUd0E1kiXMYvr+D4w3o7vJ0h5inUGVxRarrsBkZZSFCEMZ5l4bk
         v04g==
X-Forwarded-Encrypted: i=1; AJvYcCWjP8qzmBPfokOcxhKDY8qNcYAIBIUHg761KhQR4FVepFPFPcG5P3aId+xXkEOm5346oitiQRCVoONDRKnNPjcCkTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYwlfm0uycwhMx7YeYJgqZ05jTP3icHFI2ecdgpxPjW08ChUd
	j8hsB/n8qYOgLjdy/kMi2AOLkFzLudVe4KYcsuUe8PhEOTkIQC5xtULmZZWo1ZA=
X-Google-Smtp-Source: AGHT+IEfDe4u4BqHTyGI1mF/XmQ29mH/QL31meG++atpanxeHeLUEhv5iB4KvLNk1QflEYwaT49BGQ==
X-Received: by 2002:a05:6602:3fc8:b0:82a:4033:1f64 with SMTP id ca18e2360f4ac-82a648a08a1mr852385939f.6.1725484190844;
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee86d1sm3281241173.169.2024.09.04.14.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Message-ID: <4566ee54-63a1-4b9a-94ba-42625c0ed343@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:09:49 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix eventfs ownership testcase to find
 mount point
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <172546382097.224182.6471842111781551515.stgit@devnote2>
 <20240904122055.71c4f38c@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240904122055.71c4f38c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:20, Steven Rostedt wrote:
> On Thu,  5 Sep 2024 00:30:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix eventfs ownership testcase to find mount point if stat -c "%m" failed.
>> This can happen on the system based on busybox. In this case, this will
>> try to use the current working directory, which should be a tracefs top
>> directory (and eventfs is mounted as a part of tracefs.)
>> If it does not work, the test is skipped as UNRESOLVED because of
>> the environmental problem.
>>
>> Fixes: ee9793be08b1 ("tracing/selftests: Add ownership modification tests for eventfs")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thank you. Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah
