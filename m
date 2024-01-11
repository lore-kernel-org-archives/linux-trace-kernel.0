Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31150250;
	Thu, 11 Jan 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RizTVNc6"
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3C698357;
	Thu, 11 Jan 2024 16:36:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C698357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704991011; bh=KtrQbDccZy6VDtizEuv7xow9Dkk3ZXwrDRCYOUMbhlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RizTVNc6FP9Oy5C0EVitR59P/j0/sqwFleW/iqGbucaSwSoObTL77vO6/aYv1hGN2
	 SaRvhx0GXvPQR/T40UGXaJqn0ydHdAbyGfFZW8pSL1P/Q9ApCcGik+pyd0+5lOWnk3
	 pRhSSas/8sngFPmgTUaL70FVaeUUqP9VMfMEh3ZErUWnBYKxoEzBXdC3jWV4A0SFTY
	 BXIbMUG6Ewl3ylkiJiPxsMDRbEq3nuZdma2R2SW+9ve+Fm0LnBXOeE0mm7eM8luXRg
	 RiyvgM6B4EwDpf7d5y8B53WFQS3Uf5rGU3TpaIQTFRdMW7/LGVW4YB/YD21FjSFCjy
	 +NLXjIUlKCt3Q==
From: Jonathan Corbet <corbet@lwn.net>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Update kprobes documentation
In-Reply-To: <20231219062330.22813-1-yangtiezhu@loongson.cn>
References: <20231219062330.22813-1-yangtiezhu@loongson.cn>
Date: Thu, 11 Jan 2024 09:36:50 -0700
Message-ID: <87y1cvltct.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> This is based on 6.7-rc6.
>
> Tiezhu Yang (2):
>   docs, kprobes: Update email address of Masami Hiramatsu
>   docs, kprobes: Add loongarch as supported architecture
>
>  Documentation/trace/kprobes.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Series applied, thanks.

jon
