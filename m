Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471410;
	b=SaDkZZ5+T/y2+lOWdNJdWpCb5jXSeNLyLETIaTMUsOPtzAgPOxaOGbboTfGuhfr5Z3KP
	 HJIf6pDT0bOZuXEbUZ6ElGkcYerMmuvseb7s/V49Yodew1bEhqqRk+gArWvZ//cxEeE5t
	 ISQ5veWH+0ZRRtqPVsowiU2IK+gegUMlVUQctbX3jdjldmGAuR3e2Qj7GbjRzK566qVql
	 UHnKqy7pcWGiq/sRUS7ziAvo/1wXxQC2QMYZE3HmELtfzr1A/v6Ezh14k8p/Is7NdWkDf
	 oOr+WwORJDtDLhWTbt3SP4iRi4nSlVq3O9+XUKukvANSqepHt7q+tDRWi//AsPNFlEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
	b=GV7F5yQR5t8L4Z+pUJUxDMh33U1DojWe84GR/wi2XFSIuV3XUUGy7BgL0sTqHX5SKjUH
	 aJHxuWHfVBXucKvcjjNEsmZCQvQXBSM096sdBeL7mFnq3OdfBeS5TbN/dWwz3hi5AFZpx
	 oycWnHdMzqtXDH+B4JPh3MSU096vukHWsgSTC19uMSLwhWXR2uXU+JuX2QYE/LceIGAbc
	 lZWtu6reTSH5JUqW1h0eEBbvEx6MFs1auWhnx3+OcyPJCfgvLob5OmtFvBroHaSfstBWP
	 3sC5CowdzAvgx/JpRyv+TckyS528LzaU9bG4/lSPBbe4SA3No+nEyJToSgBYTVgga5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPdHi1B;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE2606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 08:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPdHi1B
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso23905075ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471410; x=1795076210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
        b=FoPdHi1BEIGYGOBQ8jpJJIMmkvpoD/bZN9zxseg4DWxtKOIMnkgyW2NgswJLpCTZGz
         p1+TfM59lcC2EW57qxPryBMIphXUQabOQu4Jx3o0cQEA5eVZW+q3z4oJDaTU65prWjun
         xPePBDtG7BRbz22ciNdE54qMSG4epM5qM0kXyzzkDipV444UesJJDbPG36nehwmBBehr
         XpRkNix741MvHry8gMqmK4NqzYLWkh2hZ5suL84EPYn1Fx0TkWq1AU+EG6SsbPXWULUX
         KOumUjbA6kskBFStVoYgOt8c9Gmi/rcShFFGhETqGd0IDRbejzeHrKPwCPTnsu1EVgph
         a86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471410; x=1795076210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
        b=RnkfCEQCE4vpXs1MBumVcj/ztwwM39mbRElKMUhwZK38gdszSfe7l7SANl7wECLDZn
         aP5D2f1QY6izTYCC8GodwnGQO8IaVFHOOcx9MchSQpfKgM7ki585Wqc/9X2fp7pUhT5O
         0JLyP9MUHEJ+jWkbtM12xXNsatqON6YabT1ecl2U8RLkhBvmQ6meh7j3QdFRuXm6bsvb
         1z5lNwN4c+i3PKMaHXgSecBeG0YnP8mQ2BUHUDtQVr9/L9Awb6yIrbKoQgLLwfkTosVS
         PeFZEZdZPfSOiKaJRv5x6kacuAsJSpYSPYYTLnX44nOo4e/adTfirCksN97GRAFO4hmK
         TZnQ==
X-Forwarded-Encrypted: i=1; AL+hErH+1veUXq10AMiKkUz4C7bgTrrO8RUdOgXCr5ua245L48JhUACqSULF/PRA2+1hoCVzdzJyUzr68pjxY8mZMT5zS3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yOl/h9ef0Hr5ZrEBbKnz86yQgdnadWbdiKytcJS4WuHqAS3Tz
	fhHxeUS7ZaDfaqtR073YSm5JnQfrFnlEgeVsRdbreh9XUQY1S+gd2XFK
X-Gm-Gg: AYBFou2K9IhL3/stC6wvPRBqOnQ2VR5U3+txUlgHnP9aJu45CM7VkFO8SoM0a09GVML
	XQCV/UyqPlCwpIcacfqNlQkB0Mua9fKDXMRYVmxBYnt/MdWXSLVQxDPFs4R5fUsb8NLBWHLNcDZ
	B9wNd/IOYzErjSai/8EXDGyV7AKrUxoCqtmxOReGHSCCLJEccxxjl4mNoog6ziUlMxAk9k2j1xG
	2EIEw3ciXZdEDbfovZUo+bHCncYYzLW3FvyHrkGRuyEn99EnZhEil6NTbh17pGjwdxxRWTYmtJc
	2dtSMENoGzO1aLXP0618K1r6I36jZmsSCAl5Oi1aKTXIx0EcvHGa4CAKlPFgr0ZAohT58zXY8DS
	Rf80uo44w4m+6LTDLMza2x9b9qtlBrPZhFoXhiq++uFG3D3elkaY4hLewuzNUGsEarLfJT8s16u
	VUu5G6WvI4D4LFCxpfkEM8/ZF1mSWeuTtshBMoEY3uKjmEq8W0WY+JuQrxtqkCaq7iU0xwymkQ+
	uEkEFmtUbC3NsvFFvxlmJaRxyx6g6SbXjuiFGjWJllTJ4Nw/QXbWwIzsd9F1Nvb5KDZsoGDhH+o
	GIX6MaugfSMT7aDMeo3OCH1qtc7gL+rVF0OgBzRT7X8+RB+YxOTOdds80EFO4raGYG/7brkdFoq
	u98Z6q1Z7
X-Received: by 2002:a17:902:f707:b0:2e5:38bf:cb43 with SMTP id d9443c01a7336-2edd7432537mr55445995ad.2.1794471409521;
        Thu, 12 Nov 2026 00:16:49 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4dc3bsm29970705ad.17.2026.11.12.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:16:49 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] uprobes/x86: Emulate ENDBR as a NOP
Date: Thu, 12 Nov 2026 16:16:42 +0800
Message-ID: <20261112081643.3983403-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112080406.GA2668804@noisy.programming.kicks-ass.net>
References: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com> <20261112080406.GA2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 09:04:06AM +0100, Peter Zijlstra wrote:
> Uh, no. We must not allow uprobe on ENDBR. If we ever get userspace IBT
> (people are actually looking at that), then putting a probe on it will
> make indirect function calls #CP.

You're right, I missed that. I'll drop this patch.
