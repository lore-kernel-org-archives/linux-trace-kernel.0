Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09501F03D9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315656; cv=none; b=JKd818eC932/DZyHHo+fpPx4wE9qL7sldaUtJw6m8B+m9QefUxQxUHbux8PhfT9V1+GQZEfmL3peVcrzuvSGSFqyXY1lgDJT65HRAW79vFxL3yTTUeU7SRLmnOrOHmvR25o6wPvlPiSHMwhhncQzpS42ev8Qfa/s1Mq4XP88dek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315656; c=relaxed/simple;
	bh=3td/4pzvTWG4IxGOMMNe4K0Irv/bKmWmSKQjnrJ7WY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxrrYVCQcir+Fw+IP/XzCB8pM3TpYXnnHfYYA9Lkue5PSybgJWURf9G4RMUtMROMfFIFSC0sSpPKck+D84iYwvA6IsYTGQg9zzQY1O9neQyK9qAcUiZqbOFicmjQ6KQ771esiwmQPkvgP+S6qf3Xd+5G1o3sQbL0rYjjLnSAX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOjAvnR+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOjAvnR+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-356337f058aso4944278a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Apr 2026 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315654; x=1776920454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIZUNYBIfgLTI50i/59UGonoLFUcrsjmVah5AkMbODk=;
        b=nOjAvnR+v5nQc5wmKAOfI8ucVmnnjOkxXTruBmKkrp4B3cJmsjqRqTyfog7noY7QEW
         XbgL01qhZ5b5Qpua4Bq3FusW4Fu7aogoxJKaVspPOGrb/drXJ9ObPgNv8VyGQSXxWKR2
         VMveO1HYNxuBRV/F0g3SmKRCsJKO6l6BR6OG+uGYOJFqjAwkPh0jotL/ATDHRneUzsq+
         kLYcCoSmddRjKiGaFlmfoEVYLCTCttRkxx2Uso9Opz5vDGK9bwGzo6oWgY/Eis1UTrDl
         oen+e2yzLgXhXts5p98rVU78kt9zrDfz9e76n8ck9z7k19LG6CzHqgsS/dpDOPL85SXu
         /OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315654; x=1776920454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIZUNYBIfgLTI50i/59UGonoLFUcrsjmVah5AkMbODk=;
        b=XfCnsPY/xdpRGNvVNt/1l0ZKbwlPc42VyWdlTHmZZPzV3YrQKu2qGFpuQfPpDZUHgM
         xILvG9vxf6ZevxNV4AQZz47MNFaXeAF81SQkzNbQEQ8Uv6vXLzxtFxjEM+xbMEz9euQH
         kNoRkwnhoNBcfkovTPreLzmRNT8tMXH3j8Z9RB/JJGVXZodToce5NM3kUOq6QZYb0A9u
         xQtshjYnh/uwZlQAWkTXAY71ohzH8k1FIcBCy+Hcv5ilxVH61EGwGDmIKAOYBkCErAzI
         DNMBKrxFd7la/IGFPyI09Az775ex+g8Kb/fCqQL5l6vUFkYDkJB5Y1jvT3Q05qmmS7pR
         Pxnw==
X-Forwarded-Encrypted: i=1; AFNElJ/BXGN0++OYRDSAtA+G7r5wSbYKQ9j/ZxCt/VD/PFTc4Qk+3wHae5x/wIbQrTxcXRbHuuDiBb1DcOiMcOj5Em1k1+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIlK5m6vOLlHxvlq7OqWPnKoZBtoe6rJGAD/48ui5IZ33YiQj
	ZM3iiLC4IalsnRX0kejxo9jjEj9o6kAbd00Lf1RNelEblWoIWE02k69B
X-Gm-Gg: AeBDieuzo1uCNUrQ0cj79uRWuQtvOlIru2mlPRQ5/6yuyrS3uIuGGBA2DOw1+RFWFwU
	JasDB8PIWCXXXFTCaZ4+WqfKyqkZiWVTykq0YydtnABzaBYWXtBI3BEoULk0j8+4n5m/HrAsBTd
	FK/At2aSir7VwJlsrOkfj2ywW41nULtM+APl8RvMESj6vJ5R9CiiASg/QkfR/bKWuqFtPfiyg8Z
	frpA4MFMGthVIxxrrqpyuw+2CSrzP5TglGzD+3HBjyF5EACFGd2oJoGQ/iCrkyOMBrkaIA8HbtB
	hgandbi1uyORgeftonqkaZbEXgjUTK9kywoVWSGnKaoIY6cPop+3U37bufbSsGQ6apj47Q6h1um
	s/AeER6GhQpLfgCK978jHPjd1WXM2vnIs0uVbLmXW2OWlQO59z/sMMW6au7WpAvGjKdhsgtlkVY
	ofowQD1FpcslpsKWspKBHUX9hDANwPh7xKA46sCl8023XXu7s9Iybh0sf7vc9oId92jRFUrrQ=
X-Received: by 2002:a17:90b:3e88:b0:35d:a557:e41 with SMTP id 98e67ed59e1d1-35e4281c1f9mr26138770a91.14.1776315654271;
        Wed, 15 Apr 2026 22:00:54 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56? ([2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1ee59d4sm2124933a91.2.2026.04.15.22.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 22:00:53 -0700 (PDT)
Message-ID: <20b14305-d13b-4bba-9837-4226e064caab@gmail.com>
Date: Thu, 16 Apr 2026 10:30:46 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] openrisc: Add support for KProbes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
 ardb@kernel.org, chenmiao.ku@gmail.com, johannes@sipsolutions.net,
 nsc@kernel.org, masahiroy@kernel.org, tytso@mit.edu,
 linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
 <20260415154826.fc8aeb67f1cb3aa58be6ac48@kernel.org>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20260415154826.fc8aeb67f1cb3aa58be6ac48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 4/15/26 12:18 PM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> On Wed,  8 Apr 2026 00:26:48 +0530
> Sahil Siddiq <sahilcdq0@gmail.com> wrote:
> 
>> Hi,
>>
>> This series adds basic support for KProbes on OpenRISC. There are
>> a few changes that I would still like to add and test before this
>> can be considered for merging. I was hoping to get some feedback on
>> the changes made so far. The implementation in this series is based
>> on KProbes for LoongArch, MIPS and RISC-V.
> 
> Thanks for porting!
> Sashiko reviewed this series, can you check the comments?
> Most comments (not all) look reasonable to me.
> 
> https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com

Thank you for the link. I'll address the review comments.

> Generally, please make better use of macros rather than magic values
> in your code to make it easier to understand.
> Also, use GENMASK() and BIT() macro to define bitmasks and bit.

Understood. I'll keep that in mind in future patches.

> Thanks,
> 

Thanks,
Sahil
