Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768E3101AB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491541; cv=none; b=nL4LaGNmAYndrJhh6uldJPBGuAhJlL7+cPRFHosYzYGdhk8k4edO801J1ZiEsm3m2EpMpIBX38A0G6P8+L7aZY8mvSsUnbQ+mOGvpGldEv9HMlSPRnxF45UBb3WfhsBLKKZSeBXnTq5+5icdhpBcTPf2OfTZkGRlEovm0+iKpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491541; c=relaxed/simple;
	bh=qyPmCnCGxSOramXXx5tP3J4r1BBGqAEwvng/Q8csOWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpzNIydj32oaxORwpg+9ngf/4ssX8qo79Y13kkMT4w8rr/0SJVUcyr/Uh2U+eOKTDM8LHwaCMqbSs0sG7lx6RUGTbVbPAjzsZzMXbgKYlBZT8WTsx/1S/5bgtKmjitDk3NLNK7ISdHwfsr49KDxdEDbJy09Hbm1z5AdJc5QQKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/JnAl8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/JnAl8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757491538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q7okfE8N/Cj/cxVYYhlDzMPejqxlMfhSTKL9gD+wIBI=;
	b=N/JnAl8oKwDczuNd6KNerrUm/c1Uv+zk4ss10YDv1O5vEYalqeG+AwfnyT+/eDch67ts0E
	wMZ7iRRVo8cS2jtixOqMO0x72JA/JVehuD/kDncgEDtEtvOKKweCJHledcv/wrEYbOSqDP
	LWifAXvwxrr8p5IAIT9mbRs64XfeyQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-45zYS1ykNXKQwZrY8vP1SQ-1; Wed, 10 Sep 2025 04:05:35 -0400
X-MC-Unique: 45zYS1ykNXKQwZrY8vP1SQ-1
X-Mimecast-MFC-AGG-ID: 45zYS1ykNXKQwZrY8vP1SQ_1757491534
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e753e78902so832488f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491534; x=1758096334;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7okfE8N/Cj/cxVYYhlDzMPejqxlMfhSTKL9gD+wIBI=;
        b=TuwrSSKTtcs+wx0Abpxr/hW3Qavq8HzUe7DCvXgwSyYvpFXDPSm1ztkxhp3B1fUgbY
         Cb/eC/U/hGCwiCYCNnVcgaeLCgCO2RklJJ6+OGu9iAUVrIoMJtrpO/pplAu4I3AcKMb1
         y7p8cdvJ3C5ypo8svDGF9Q6Fx7/I81HXA/B6RNNHfA3u+IvNzw6WrCtQULItfu9fVxkj
         8yDMF4JMDopf0QYyts7YKnExIrM2Ca3OUlAYGkOv7tubdOODYdI3Gg5KFnOBGnpy+CBG
         TXzc1DO+Fid1svJomtY++IkQj6jRUTWpiRyJkw0arfkHp6tI8cE/uIg+Nb2kXZrBCv8v
         TXzw==
X-Forwarded-Encrypted: i=1; AJvYcCUErAr8oCFdkpGL2baqm5S4M5/hNuy+cOVsxtMvHJLhY+plWinzNzjk6ocFaRwNNMSpWFpnRRc0nTTwalkIdRr4dls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzImynvMJTRmZI088TQOXLT7tqGjjSEcbR/BqyT2C+hF/oilXrh
	SjpkwDH3tc/fdOQbmjXaIoq/GFAB17UsJoVc7RWxhLPshO8H5Lq703RwJjw0gWUpAnUHh5e+TKs
	Lvy0NQHjYYJmUH+o2koH58I9Y+/SmciTDYG9vpW/Azl0hThqavjkr3NjD8P2k3ysXsf2IKCU+xg
	==
X-Gm-Gg: ASbGnct3kC5CjSY2dKw4YDd7hQdWq/hpPhLgTJgdHMT0qHRW6nYyJ2odCJbNGhZWV1H
	JaPXlCkeZYNczZSUEtxQMZpgh1/o96N8oLBAm7+5y8bJxygoE7tXMcEHcuntcb6O76OESc265Ju
	+P06UAy2gvLcyrBV+s7u5S6/gn7Eo7ePW5IAv/rg0J90xrDkepRsr3QnsWUdNoWZWdW4FAtqQM6
	GXA2Ee53tpCpt1yr7k40R6CzAiB4EGcyy1uh3ldDEs0bByUAIYbFDHVxAvG8o6AQmUQyZkLyspe
	EjBKp135PaGa0AMfgPEG4iGpZCe9oOX7I68p8ChdjuenIQPsz95J0Gnq22HxCoUbcQ6sKfuWlW/
	+Ti1eCIe6FxftyQRStZmC8QyQ2PpJC0/af/yHWL2KhmJpQ4yyDjbtDisSCqQGot+PbqY=
X-Received: by 2002:a05:6000:1884:b0:3e7:4719:a054 with SMTP id ffacd0b85a97d-3e74719a711mr7904479f8f.7.1757491534126;
        Wed, 10 Sep 2025 01:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCgDtJldwla+vW4jYusl7xeGy3gWWJkq3a9E5eOUYvmRDk2iXJOXjHFj6oEKlPxtGi0M2hjA==
X-Received: by 2002:a05:6000:1884:b0:3e7:4719:a054 with SMTP id ffacd0b85a97d-3e74719a711mr7904446f8f.7.1757491533586;
        Wed, 10 Sep 2025 01:05:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm6221141f8f.19.2025.09.10.01.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:05:33 -0700 (PDT)
Message-ID: <0b1fb5c2-3d36-4fa4-95b0-02c693933228@redhat.com>
Date: Wed, 10 Sep 2025 10:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
To: schuster.simon@siemens-energy.com, Steven Rostedt <rostedt@goodmis.org>,
 Christian Brauner <brauner@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IkLpRPOXrvG2kT1geCL03XjnklQiZM4lG0I9kdBYIpk_1757491534
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 13:36, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree") the task_newtask trace event exposes clone_flags as u64 to
> its callbacks.
> 
> However, ltl_monitor was not adapted, resulting in a faulty callback.
> This also resulted in an lkp build warning due to
> -Wincompatible-pointer-types.
> 
> Fixes: edd3cb05c00a ("copy_process: pass clone_flags as u64 across calltree")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20250904113334.18822d43@canb.auug.org.au/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509040134.bQVbm7ja-lkp@intel.com/
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> ---
> I did further search for other in-tree users of the task_newtask
> callback, but the trace macros make it a bit harder. Yet, as far as I
> could see, there are none, so this patch hopefully resolves the problem
> for good. The other matches all relate to "tp_btf/task_newtask", which
> seems to be unaffected.
> 
> With this patch, ARCH=S390 allmodconfig -- that originally tripped the
> LKP builds -- now builds without further -Wincompatible-pointer-types
> warnings.
> 
> Sorry for causing this trouble, and thanks to Stephen Rothwell for
> testing/reporting.
> ---

Not a stable commit id I think, so it should be squashed into the 
original one.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

