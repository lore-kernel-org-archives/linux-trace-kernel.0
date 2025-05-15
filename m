Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81EE21ADBA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333049; cv=none; b=F8NULLqqQqGXgDS/Cx0szayLeqCuqaK8A1pB/tCxU5QKatM8vr8ivim4VquLclRcFjSm7XzFkT7Rxdi5YgDQf9cLliNJX3ceqitlBLvr0ParSkpACgLCm5+FYenM73Jfxw+5yHXdC/N/wH4ZH4aibpcrnnzqM58lAnHf21cMJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333049; c=relaxed/simple;
	bh=s/QjyZzY/EnfUUvNKb7Q7l8bqIG7rG8gTYAL2oTY5W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeMDGb9HflcR69k+Q8wJfAcI3kGyXUQCgQLNnWNSixvhv8hmIdeu7DUZTZlcm/DWfheVrwT/cs1F+ve76brYNdC6FxJ9u1J/6Cbxe6vz9LtymTPDkG7aIf/qM8udqg1eX6OSMJWzr90AzgF4AGXIy3ZbzGcPZMLNrXwe5mdY3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Aj6gsl2a; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Aj6gsl2a"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3db7b3de375so5961525ab.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333047; x=1747937847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=Aj6gsl2aoiPVZ3ukygcyl5oN1kPU/CgVxCQo9MsXm46SK4pgfrHpRchelmqUUJS2Zz
         kSzZGDZq8jQBJ5Cx10wUWKqLU7LxxnR+pntOCs+gBNxKxgY19gRD66XpLG0BKKelZ2sN
         E4iuKrtB1YvtRYD2AoOPHoqEOq1ck0i0Zp9Tm6Lzszmd5NvuB5uERxcRxQ98+sxeGl+G
         byKH4QUUihJ6eDeuTpM38fFd/Kv+ti0IAGotbsMbRei0vk2N+TOPnzfPkjbX/nZd+2mK
         KjqCQRoVp5y6aLTDdUMkMP45ETiznVBNcgjRZrx488gfTKpP6GimDhEp0mzVqnCdbu5V
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333047; x=1747937847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=UfAPKnGArldhIYi/pSVBKRb9eovK0oZRSHZqcKrHlOuNU5/IJbQDm507++DQIdrKGF
         Ot60CDMrSUTAnld9LFh5qvAdpS4y8MRS6VtxuhjwsM4ujAQrmAohx3WAFQAdqDclF9RC
         9JUPfKT6m9NT1IQBXbK9S5EyM/YLebg0EX0t8iqnWZX6JMr6Oa7dzmV0KdJBymxRY0o/
         VhepH9/MYXU/VPVoM4mzohRBXtl+ecHZgc22ORDk/w8/hrMM+93UYRgXkLOiiNAwlNJ2
         CNbmoCoRFF/KmeNtyaaiy81d/R81Om+CWFwrWBpYezdUnGWCiOjNPd6TSQNyt/m4YRbd
         iwYg==
X-Forwarded-Encrypted: i=1; AJvYcCV72eKRo9Z8wqWxezJT590+By8uj7amMEt1orM/lM88QZmtDAB1GNbQIDD2l9WurGPc7+taYLUN1OOqiZBPGKudVq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwf6qohH/NPVqIz9L6M/c1dMxOWKobBriGb2YF/CfNNVJoWji0
	l8Q2htQ/4BjKvFWqnsEBPUId4JkIDF2QjY2CfIOe7izbPPabDqOHV5BeRgslSBVTOec=
X-Gm-Gg: ASbGncs7m33MrEfVq/vZb91Fk9J7qgE8Jks+eZS5TV37I2f0WD8fPkeu5pxheTK61gG
	Q4B10dI2+sfqRHb6UFM8ylWD33kW0HYFk+nidKAifPYgPLHMMHxeQR1qwcWA7oy6g551QhnZkOs
	ubMMCcgvxzz0h4YFcoPbe9KeGovcPX69HK0MzVTDCdqmFQ8R0eiWgMX4H1IrbiJ/oSL+afaMpq/
	dZh3fL1HH2GSComPyIBGlKEuBqxMvTdjyPFvYNe4KgUJYsjjmAVT/tYJ37lRppK06AWudgfHUSB
	K3jjjhtaHR0xNFOnYbWWSRu+BwVC+SifsU9fy6Ua87/Up34=
X-Google-Smtp-Source: AGHT+IE/ytiwQTQqDjKBKn/luh+g5/cfEL1pQKdZeeJtRvFqy5JaffvCEnw/tVJaBrXBsyOabJJlEQ==
X-Received: by 2002:a05:6e02:17cc:b0:3d8:1f87:9431 with SMTP id e9e14a558f8ab-3db842e3820mr11103815ab.12.1747333046867;
        Thu, 15 May 2025 11:17:26 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843cfa4asm722965ab.8.2025.05.15.11.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:17:25 -0700 (PDT)
Message-ID: <d5372cf5-ed0b-4db2-8b31-5fd4c7967377@kernel.dk>
Date: Thu, 15 May 2025 12:17:24 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] relayfs: support a counter tracking if per-cpu
 buffers is full
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-2-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515061643.31472-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

