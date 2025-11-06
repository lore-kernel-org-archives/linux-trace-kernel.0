Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6B305044
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419139; cv=none; b=VnuoCuPjoeUSY00BMh9BH4wVuhy83owI1y/jjxW+Sb5FJlOktKR57vXdCqkvJi2uZqJhHYx3BpFWEVAd4LWlASoY4j7aRk5uM7mgD0x+xS1qc95mASOLYMhW8J0vP6Vn7zIpGDeCe3Ia0kR4n45iM+7r/qvdkEqde/QHleqHgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419139; c=relaxed/simple;
	bh=uZWUHAju2MgIXw9KZYZtVjROBBtGB95ey+E8B9tXjfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orxfBjGNFYGJw+DHCRN3SDcSyp6RKg6srG1AVlIciczS6hGYN1RZlxnAR8trSIHKxf5369WZJa4OcflTLiwKI0FWBYrHdNb3wli5CTXo5urfRfHmhgmmJjqMhujJnT8JA58eJ5Hmt2u1HBP3H1EYOHs//4Tcdis2LcuP+PPUf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=esRVAz9Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esRVAz9Y"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4298b865f84so337406f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762419135; x=1763023935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=esRVAz9Yygt3hCuqZcxTgYQDNVH6rKsFXX/4Qdu3oBhnLt2qzJ+mSipYUGcLYg96O3
         8uvzXBlsvQCMvhD5Ld7pw5FxjXpmOdgC7TcgAeywG6sE+OloGd7nmuTdzPcUYrRuBmlW
         vtd9IBArDUsG/hN2uL1WoUmzRVETiKq5jfKW3yW4kzHed9AqSpoWQ3R44gZ7PJXVq1ER
         3U7T98Vo5pt4Ify0M8ja8o/LPdROBqF0i3UyHuva97V0lDQAIUEeXYiiNNQ8mz85rXaE
         QSCb494oJZIVwv9z0sGV4fR1SJf5F/OuHxuiJTAcHHpyKKn3NPiGTswpLIC9OfN8+eFf
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419135; x=1763023935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=JoLPhzdZ05PUgFPcXmhR+MNT950xm/1TYoMOG4ZHGVQ22eRWL1twtoAotfJgzIbwO2
         mAxQiBtk1hZn+uSFDBWjiQwbu3KKbW4DQXwUq/h5OQCMKdZLDbxHVqnfKsxXrhPkkhch
         gz15cvjh2EtQuqtXk7JxpTbOokcywdrBaHs1hsBnftF91BTMTVsXFM/i42MMJP4gTAWE
         hTMh/ipq0nF5IQlBccvYx2dRUaTBTSfl5T7XbiWyR+Nu9QBhBLJt209lMVr/+q26S6sc
         MBNhtdzv9E6+5xhLp9FAV107JeXUsiMWuZZwWm3feqGFu5G1UtrGQaneJum1FLJiPsUA
         bQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+6R9W7JDNg4Tbofuq6HMH8f7L5lxFcLscOS+1AgvsFSRSCiBKc57Bzetja0lBggRel+mhGOHAAzL1NWVZ2SVKedc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIrMOgKXPmIeLnPeMHIp1/9Mk530NE5l8FauHwf1nGFgjrkVR
	Wm7ZBIY7s/xRFfnz6WIfx+Tpp1myBrwc2KXofldMrGQ7sw1V3K1Xw41U6OwQmRua6Mk=
X-Gm-Gg: ASbGncs7FMKMReCTn6WWX/gvRgmrwX447qw+u1Ahhnp7FoZOVfTqQtpG2jnA0ix94FV
	qhRSjlObGtpwUctbo9QiQ3/DkSdPu9rZX1809k4LniEMi8Q5un1VZ7ioni+nNZ5ph6+FM64Qc9C
	PhjYlxQx5doCHn0mPcww5e/hnwdSOJdecycc7oSu95q3hT39GZZNpD/JWU99sDQ63pHs3Fqax8K
	NbdcnOWZI4ejD9UnRaNv7gD+qixDSd2etkSpyBuceGNxapOWc+cM8s1wXaXbILWaT3scui8hRbI
	vPxaug/sWsQT/3XqQRYCznoKNZGd4tFqM0TY59QAIrRfsGl0oOv0X9swqWwWRNeQZQnRQOJJW+Q
	pquWQfalGScvNB799a6yU6jb14rKqybPUGKkwZmrXl6uiBDJtgoGLt4v+x1901RH2CFaTbip6kc
	OqWYPuc4dS8BAXvSrBWEM5yr8Jk3NeqIoZe4oirXfirqA=
X-Google-Smtp-Source: AGHT+IE4MYS5Wr19GhmhPW/lBh+nmvHM2VktPve27rlVGZM2YL1NCWMjNGClTXGoBm0OuhF858f5xQ==
X-Received: by 2002:a05:6000:22ca:b0:429:d4e1:cbb5 with SMTP id ffacd0b85a97d-429e32c4b31mr4414987f8f.8.1762419135296;
        Thu, 06 Nov 2025 00:52:15 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771cfsm3584100f8f.30.2025.11.06.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:52:14 -0800 (PST)
Message-ID: <1b7d3311-764f-4e73-94ca-74dd508d1113@suse.com>
Date: Thu, 6 Nov 2025 09:52:13 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] module: Add helper function for reading
 module_buildid()
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-2-pmladek@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251105142319.1139183-2-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 3:23 PM, Petr Mladek wrote:
> Add a helper function for reading the optional "build_id" member
> of struct module. It is going to be used also in
> ftrace_mod_address_lookup().
> 
> Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
> of the optional field in struct module.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
