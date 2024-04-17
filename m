Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA06364
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317366; cv=none; b=EhshcQ2VYV8ztN1GOsvRpu39hDuze0J0SVasgRcSGy4mzYwGRKHE9ZUyy3YUgbaK+xTXmnsoQ7DVGv6FqnoPBi1+/IJY+ve479qTh9fLRBCm7TuLv9i7omBAJRU2CEga/BpDhPZ9Luz/IqsPU1h7KzevLAoqx4Y5Bu4QPp6kdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317366; c=relaxed/simple;
	bh=wNqJWqG29URSyGNTwa0pT4T70tImo8bOF9bPqSnaF+o=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LxWbeOOJ0N8j8b2pA7xAixm/McePqGN1sHZzxjZLr1OOVmOWsD7tl8Ex7ZdEwSLPtDPbxwqB4bOWAcjOJYQZpLkN7qZlkSs44/w6DGfqeX7Hbg510s7StmjV9GftfAPGpJWNlFG9LCEfbXdMB+B6eCMNCaWUliSwy7yQwEKvzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Z+TIYxBY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Z+TIYxBY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed5109d924so4302179b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713317364; x=1713922164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjuhst609j4ImBXLka66K2BgKWqdoWcRbFtt/DCN7yM=;
        b=Z+TIYxBYusij/cfDbRpJL7xNdnyQ8sPxF/rULvQ0EJcDiKy62OLFrfr7cZq7tMpAsj
         nVkKWfFH2Eb1y+KwOw54727COPyPjhYROhC4LQ5bofgNkyKYUOEGJOEbhhrLoFNzaRKj
         vPW9q3+SWP1pOJlzHls8FVmG7ScSwMm+F7Fwjm9uTYCBZksFIHIDq+QIUYPHSuMMwHTB
         Uir8Rtpcp4WQNASownRFN+RnPX0l61rKn3Z06wgSezoPNn7P4sIOvwFDgRWZ4KZrAELO
         OtTZiO1mzsSg+NZz1s7Iybgi06ThEG95g4O1C6OebBm1pO1fREm89HzVKDqjZK9KX8iS
         zDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713317364; x=1713922164;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjuhst609j4ImBXLka66K2BgKWqdoWcRbFtt/DCN7yM=;
        b=f7KVxz447bbDmeiRet2wwiWE+cR/KCmT+ljbGYAUwiH4rPVDPvHXVUK4ft0ng5zFkn
         xgzMgPVfprW2jjPQGo6Fm+3mWVY4H47WKKgr1yQ5eSDZNulhvitfDIHva/eyj9v0XJRr
         I2SsBIwT1k/dcMx2cKurein6l2rYp6HatG1VIvNkBpjzkSxBxfzWOtUliz9oLpMHLvY+
         6Z9IOWElg8z3F9qWvH+tk80hhni24+F0XafV9VsdV2kaPTKP3FQgkgdL92fsVbilyo0+
         iR28wgtp11DthgWCOo1r/bziG+4FDl1Su3TKKYdCUY+kj4MXNc2LLpKzm+iEkbRXKa9U
         NQlg==
X-Forwarded-Encrypted: i=1; AJvYcCUlSOy0k+lNOfMX/nSLlXlLJB3d1OSJTg+2PIktDAqOrUGEDo26TSZugffCOMf4f93C8otKMwNJHgF84G//dZHWxpzv6y69PnEQM60K0MeBqdFa
X-Gm-Message-State: AOJu0YzwHwjJzcMh8+lEa6WNzSyepg56UWDMOvS6ovDA+QUPce16Mdgl
	XIdHGNQQIgSt+jhlMpBX99LZ8xc0HSTh0AMSonvC+lBrjLxs9hGua9q6OGBdSFU=
X-Google-Smtp-Source: AGHT+IHI+wCzl78CeqvUChLxQhdF2cffkJLj8Y9hhcpgjt77nMQDWk74rPpAZoZWqdPfe8nd7iHbXw==
X-Received: by 2002:a05:6a20:b923:b0:1a7:57d9:9358 with SMTP id fe35-20020a056a20b92300b001a757d99358mr11408064pzb.16.1713317363589;
        Tue, 16 Apr 2024 18:29:23 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001e2a408df30sm10342463plg.273.2024.04.16.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 18:29:22 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:29:22 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2024 18:29:10 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] riscv: Remove superfluous smp_mb()
In-Reply-To: <20240304-aptly-surely-ab9ea7d82337@spud>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Andrea Parri <andrea@rivosinc.com>, samuel.holland@sifive.com,
  anup@brainfault.org, rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
  parri.andrea@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-493ab98f-27df-4576-ab29-90254bee34d0@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 11:25:33 PST (-0800), Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 01:10:55PM +0100, Alexandre Ghiti wrote:
>> This memory barrier is not needed and not documented so simply remove
>> it.
>
> This looks like it should be patch 2 in the series, not patch 1, as it
> is cleanup rather than a fix that needs backporting.

IIUC neither is actually a fix, as the other is only exposed by the 
IOMMU driver and that's not upstream yet.  So I'm just going to pick 
these up on for-next.

>
>> 
>> Suggested-by: Andrea Parri <andrea@rivosinc.com>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
>> ---
>>  arch/riscv/kernel/patch.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index 37e87fdcf6a0..0b5c16dfe3f4 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
>>  	} else {
>>  		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>>  			cpu_relax();
>> -		smp_mb();
>>  	}
>>  
>>  	return ret;
>> -- 
>> 2.39.2
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
