Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F82571A0;
	Tue, 11 Mar 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694633; cv=none; b=ba8lR9iAgfYyykYH+7nvNRJJuZeCZus4Ze0AtJOev/2CxvHV5gemqvezeLurnXSXVTMkqp1CPcb5l8nmjD78JKv+crg/TaVQS7T9MMTfxWC9TPwofcUBGVGlqAhuKomp5vRKETC4M58J8wMQeS2Xb2ynl1YXw22lZWuNpkGU17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694633; c=relaxed/simple;
	bh=lNB+xluVHdB0sMAdXkr3VICv+cyzUuhxC/f3Rfb+EYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTpqgpN1lyynHt45TUJaacRTYJPV2WQw7+vzcjHItqnX6TGkwFJXFhkZ6ljVxL6YNPHoOrs45eW9fLts8lsxO21U+YE9q4go7x0cc+WnF9svcR5O1RRyWZWupJsx2cpW2hi5FQicYXeKkdXAcDmENWiEuf9jjsfXeQsxFo2u+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKH2YSEo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKH2YSEo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223f4c06e9fso88725835ad.1;
        Tue, 11 Mar 2025 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741694631; x=1742299431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZQCZpAfe5gKaMnJVFSrCHy4twk7KgmPvZpy3BHUx0w=;
        b=WKH2YSEoFZXQE0//T6VOe8UFjJdsIQYWgpJA3QKTlUjh4aAuufedIDCnb10xvOhjOr
         UnDDrs3eF+yapZwZ2Gppy+JxnEtE3+iiCFRQUZMPgdP3kUCL5tEFzIYeEzpjmNrOxoTi
         So1c+QXUSm4lXU3M+K0NDAWLzJwIireKEOuUkZkMjf56YEFrRvu3oD9U7uxfRBqnE99x
         g2hhjZAlaPr4V8YFf5QVik6s4F8mFHIKhToGUyVV8kxLrcfmYNHmC8HqxGaaCqBqk8Lm
         J+eUo073TJ1J+qJPPnYBl6eB8Ko7dStLBrdcq8YHhPwEHsfdiLvWgJ1arHlDwtgNF62L
         Hx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694631; x=1742299431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZQCZpAfe5gKaMnJVFSrCHy4twk7KgmPvZpy3BHUx0w=;
        b=gSRDCh/ybTe0uKEL2lYNj0g+knsdTj+QgYkudmQT4SBCgNxtIkyqAhkHrMLs+yB/OK
         dQ+HnX1DMJqHhNLkGTNBizraPnN6XgwVfnGt6uZmEgiqRYwq+kRgMdSgeQkvYpdO0X11
         iqPg4dr/uSIPfvpirT0DLhthY+OWfgbtN/YcJ0NU/uywovWzFbdNzjJwV8qPyLJbtvwb
         /sjHQtmM9VcWhIHnk/SlWC6M9XMOFTbSz6W5A8kkX8YVs2eJAYxE2ITtcuakpDFxxRUG
         6T9XaQY3eZciuNxomPsktrMUyCMOX5xCOsNfT6DWt6IUR4RWQsHXUUXq99yZ76HnJk5V
         2zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVKi7tGDCSj/l+380KElwnroYXsH+7v7OOYYx/pjpYa8UwtTrXoTg43CssE2O8YljJu1LvVpp2QN5OK+oOG3QBMACUL@vger.kernel.org, AJvYcCVkNOJ0M6QjMruM+4ILQsDVZUpZlbS1ossVpufZP5rw2yLDzDV4BjOuPkzZW9cgtISAbiBxfJ++R1Q=@vger.kernel.org, AJvYcCXRPh3Bz4DF1hVQvJGo6bKx/c5vMIu5EoETUlcD4MfPPdwOVCBp3MgWGNsuK9ZGswJFMtxOHZ6FMQPYl6C6@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4NkyWZyv2Tdoo0//jeeVUzhdDeK1KDF8jTHZ/vgpU5TprGqD
	sV6BYZHi/tSDIXiJ39ZTEYG6fCCITiRuxCGo02UqzbAfxsnDGDcW
X-Gm-Gg: ASbGnctrIswdIG0ynSwq7LbMofdhib26NeSjcYX3EagZkWPQV7FYlH6rQu63gCfUijc
	RmbTZjaLK36PfCsTQ4REI1+fcUrv1JyLQVBhYnQRcgBFsOUILgB5J6NMW+cZORNLy+fxTj9w6Co
	MhAyC78MjnR+NvlDsrXOQpZCJEq9X6t5f9Xm9YJsse1nl2uol6NsODnq3XbhCv0HLENqy4+LIIP
	fz0SKyD5/EyqXk0xSdSzeeNtzTrhBhaH/iM9yzDM3pNa9qNsSAtsmI4dt+BjPW2uyqsIDQMAXgm
	jRtPgqiqosxICeZV92hqkNamk1bmqHL61QaA25OI+uyIGTSwO3CnhrGNAEUywil1IZNubUOvpTU
	OqW0oaAaW2VzvwUKfvQCPjPgk
X-Google-Smtp-Source: AGHT+IFGTZJKgUE85hdQhCUMDZf/YDgvHbNQzVbwDVYAa4WWsCDfLx5Oc+vp9Cn6By0AnN6qgXQJZw==
X-Received: by 2002:a17:902:cec6:b0:220:fe36:650c with SMTP id d9443c01a7336-22593dbba6emr47676715ad.23.1741694631530;
        Tue, 11 Mar 2025 05:03:51 -0700 (PDT)
Received: from ?IPV6:2409:4080:1188:3708:3a3b:1a57:b459:3f2b? ([2409:4080:1188:3708:3a3b:1a57:b459:3f2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aaa9e7sm96219675ad.244.2025.03.11.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 05:03:51 -0700 (PDT)
Message-ID: <e36ebdb7-775c-40e2-9523-37eefee4bbaf@gmail.com>
Date: Tue, 11 Mar 2025 17:33:44 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: tracing: Reduce maxdepth in index documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250217112109.7734-1-purvayeshi550@gmail.com>
 <Z7aczkdNVgLy1NeP@archie.me>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z7aczkdNVgLy1NeP@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/25 08:39, Bagas Sanjaya wrote:
> On Mon, Feb 17, 2025 at 04:51:09PM +0530, Purva Yeshi wrote:
>> Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
>> contents, showing only top-level document titles for better readability.
>>
> 
> Is this patch mean to be applied on top of/squashed into your toctree
> refactoring ([1])?
> 
> Confused...
> 
> [1]: https://lore.kernel.org/linux-doc/20250217110637.6640-1-purvayeshi550@gmail.com/
> 

Sorry for the confusion. I will send a series of patches, like [0/3] and 
[1/3], to make the dependencies clear. Thanks for your patience!
