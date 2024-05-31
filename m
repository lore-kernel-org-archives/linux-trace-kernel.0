Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EC58AB9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166518; cv=none; b=eXexGkjBshUmbYjPmy34zrKnX6uFqppioXxZOYpeoI8TvHccLnhIlLjYYpQ2n1gcPvdCc2pMRWZLmnKP/3+HFpkK+kP+unVmgIz6HvoEDw+b0gPSNM/BdNp9GDChCRVGqpljYSFHpeFJL93xJO+Lh6jb81K1X/7/804RsSyPwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166518; c=relaxed/simple;
	bh=8N4Uy4hfNGQeJYMhXwYP8HHYJUaM4nwbu6ME4Nq7pIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/2ktjiFLpsVhRxXpnemOx7RwfPWcxFhLBFo6gTN8mVMvKBHOAWzXp0ixi4l0Yy0Z2ePWruIAn07CZs/gpni/ubVodh0cQbKhA7N776j2g/vcGIqrf6RdusAG5izzE1E28NCFuSaMX1C0lPjWv/68JnFOJtnkElK/ghzv7+KUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btPSd/5c; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btPSd/5c"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e24bcce578so13173039f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717166515; x=1717771315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPAJXLuoxd2SK/byJSfbPIINKV2PiEIqB7HOimxozzM=;
        b=btPSd/5cgXep/twtjBxlN0sPFoMYyY3x9BmuVog5I4yhFr41kzKqmuEEhwAGVTFxiE
         VhJIHuZi9d8ryj6m+dP/6J1yhVmEqDxkNZLO0iWqw4IdjTYBU5FtB7FeP/2L4XyW5N0W
         DcIDt8fM6RnuE7T+zVJAbyBWPS78ZxAw1typU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166515; x=1717771315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPAJXLuoxd2SK/byJSfbPIINKV2PiEIqB7HOimxozzM=;
        b=ELG6otdJ+rwL4ijn0AensqD5MNuTPkBhtt5gVE/8j54yTkiLGf+U8sVpg5qPbwOz2d
         ERRITsfvqfa6JVkOmPNgQ70zvET4CS1T8J7QO8e3hQAtKvb9vPIIAdwg7dJojqpm4oo0
         qf3UoNJmeajse+ZD5HpxSm3jNDsBbVftDtlzlXRZkxyrWxs09UTUWfV4HRT1vOvua8g2
         p/0sSXwRPnP+bVGt4prOsnjpPCdx7b2604fRhQBsp5GCiFxa1Wb6+/kMGZ5Bjn1cTDnE
         5xZaMGm31aVcp6h272g27Q2F24sHbOgcCSY9r/jTyd171YMyUgTTYnRTU4xWFiEpzeAZ
         uRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ttmqggSiuwbbBVECXOPdAlk05GgPuk5wQRCmJFOtL5ehFRombJHHBNfTMXGi5LXYjaoR7odEWExXFRI+EN3lmc/4RWAKSLga0oNMkYRD0mdS
X-Gm-Message-State: AOJu0YzZYaMCM1aPJIfl+W3xa0lbRV6ZDJWZZnEtcrCCAnZdVzMgabKb
	koIFxtov9J/fmz3nxyVFReM45MOjSr/d4OBucVILnP2TPRanPkdEEFHtgMs7EqQ=
X-Google-Smtp-Source: AGHT+IG3dnxtFX/O6HOtneBr+kVaD6kMk7E+Nl3USYm/ynLDRSimUh2lFGqyh96b0i8s6EO6E3NYIw==
X-Received: by 2002:a5d:8485:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaffdb5092mr237075339f.0.1717166515426;
        Fri, 31 May 2024 07:41:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48c4400afsm503109173.136.2024.05.31.07.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:41:54 -0700 (PDT)
Message-ID: <c59efdb5-26d3-43ce-8390-fef349fc9d1b@linuxfoundation.org>
Date: Fri, 31 May 2024 08:41:54 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/tracing: Fix event filter test to retry up
 to 10 times
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
 <171714861780.198407.16488694516653649947.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171714861780.198407.16488694516653649947.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 03:43, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit eb50d0f250e9 ("selftests/ftrace: Choose target function for filter
> test from samples") choose the target function from samples, but sometimes
> this test failes randomly because the target function does not hit at the
> next time. So retry getting samples up to 10 times.
> 
> Fixes: eb50d0f250e9 ("selftests/ftrace: Choose target function for filter test from samples")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah
