Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016A1B948
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248357; cv=none; b=Wu9rECP7LOl3jGVLBCkiX2F51Em10/1yE09ET9WsRQG/Te170dBSa5QCib/6gPszsW5PM8nuvBNLOunjp6biMGJ2KC6e0i6MuwdjX9hbbYW0xOvCEXrcWuG26N4kdT6utamj7sdJSR31HC7oQrnZSCRebHwNvNgG5Pomx3t/KlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248357; c=relaxed/simple;
	bh=FaRTigCLQPwODumK/uro6tAr7hVUCu4TTcem6firu4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aal20tdI0or+MIJAeFZWCC8YEMIySAu/ah8CBuske8V0X86RPDFaCtOkrbLENwP7/OtcV1ZCl23OD7Nsd+I83b/v43XGgafLprAQxBk1nmvxR6MmZpyL1LfArpcXTzqXmyOl58/idC+QZfimhLzuMD03tD4IIihHPVQgvyrJOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfyvAADc; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfyvAADc"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d341631262so20753039f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712248354; x=1712853154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnzPx7jQfSANKpYvBZUrsn52XLSYl8iVTFuQscI6o9Q=;
        b=WfyvAADcYPjL1OvggdQ94pH3tSeumrxgy0eC1ZC3MgP9VMoKIAz+kCjCDwtFa0gb7/
         VixEh75GgiG0C2rgsc37nwjKXq9utXfCTysSh/uAnWckfVzlC8eqx+6GXe6YSE23ZX4s
         GDmCzwS3+FU4AWA9Yx23yN3pZuEnWNFG8rxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248354; x=1712853154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnzPx7jQfSANKpYvBZUrsn52XLSYl8iVTFuQscI6o9Q=;
        b=HHs82CR6aGHcYSrxmUqN7D1ZnAEZ0Za8s9W0+2Z+wswjckiuIQgby++wxlhyhiIsG0
         e+TyEUujIVhrrZanDj5smopNQUAfN46i8SZ6UH3ypnFs3fayuVHxiVCOhm4LPpf7z3uW
         5XZ16eh9WHmSC+Y/PFzbziwT5mSgDZfaZDp7g5a8RZEzu+FffxHD8Hb7SArKm2bMFhuG
         VFZQzSvZ8mJnOnkzMBq4mSg0B93uReKUudITc8LEW8/VvzZGOvtlu2sl/lsur/DtTPca
         OsXMJYt1z1MTxrsx430ybOLKYRnN2YzPp/xwH6MUH3MHnOnpiGM3k6qPVlEjJgHh4zH7
         DBlw==
X-Forwarded-Encrypted: i=1; AJvYcCWSl5/CHCald62GDs//w1Ty8UM+nR9N5vjixPr6H9PUC1JjbWHNwoX6NmLWmRTU3pfx9si6z1nonwhyRzRJMxPuk91SYdMbaysTMzaAtNyNHOnm
X-Gm-Message-State: AOJu0YzwDjMRrOKgVILYHN6dcPGD6oV2oAOwLbV6WXnb44doz0TgGrUq
	I/E73KItyiQQFwz37s7tRRnzi/BSBwdMCMUX2JK/ULQHHRb8XLVPdP2Q0FTU8DY=
X-Google-Smtp-Source: AGHT+IG6x3n9pPVk7ZIl/6gWe0CvJfV0aQuqJSosY/xO54MV5MoKOSUCkywMrSzR9EIlLsZzzzQNug==
X-Received: by 2002:a05:6602:21d6:b0:7d0:9f34:9d85 with SMTP id c22-20020a05660221d600b007d09f349d85mr3234193ioc.2.1712248354140;
        Thu, 04 Apr 2024 09:32:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o11-20020a02b80b000000b0047be410bcc5sm4826045jam.27.2024.04.04.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:32:33 -0700 (PDT)
Message-ID: <39f406e4-685e-4371-8726-c7df02299295@linuxfoundation.org>
Date: Thu, 4 Apr 2024 10:32:33 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
To: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
 <20240326120809.09574951@gandalf.local.home>
 <e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 13:11, Shuah Khan wrote:
> On 3/26/24 10:08, Steven Rostedt wrote:
>>
>> Shuah,
>>
>> If Masami is OK with this, can you take this through your tree?
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
>>
>>
> 
> Yes. Will do once Masami gives me the okay
Hi Masami,

Are you okay with this patch?

thanks,
-- Shuah

