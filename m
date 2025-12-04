Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9D1A5BB4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764813308; cv=none; b=hmsUktbROn/k1iUO3BhuvFFZCJOLalpE34BkANFI0Hm/5A+lILnbS7iibW7LqW24BhZ4G65x6lt+1PCouDgWinhN0SwMaI7nY5ixYmuqPTHomyYPjw35yag7gImRvNfLFxMU8uwIxUYxbcZLeTr/QejvtcfbQcUKZ8kumoAMCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764813308; c=relaxed/simple;
	bh=jULh/VyQfzn0FPjuWCV2CI+QAn3sKJsueassL5jkw74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvB9szv0Fqv7k2mTguEm/Zrz9xcrFaL57dLRekM01+CZRrIpNvFNNuwd92r25podT3oU2WPZxeRPCSPcsBANZwkRvphs83mRlgedQ+5Hvs4n6HN5knLJ0sZXNY5MnpAZgPBtsett6xbBacRZtYeKy26Xru6Zcz6DQTpcgDHYD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maD+V87+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maD+V87+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29806bd47b5so2453455ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764813307; x=1765418107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9ZKBsX1w6UPefrLQ6j6TJQtLjEj4G2aPJhHSG5VU5E=;
        b=maD+V87+PjGaTA345e1TV/6NHJwE/4VJFzPuvWzlxdDUCAsflCQpGhmwGr+fIqkyAH
         8OiJ6YArmYqxmLDN/xfzxgzslNb4zaKWCS7J/Ip9FtGIWzv/GYyu/9B1E8uCfzg0ypT5
         8/vYHaz8zhzLzUhhVkVDnluYxGOFttQ+7/H29dlLSXjlthW+IOdoFouHV2owtHsfWyGg
         gUK6G/JC4H3FttgrjrkKEMQrA3VpGGSvzoN+jQSYk6Rj+NuSxI7Yu2ONzV1OdYZTy2uf
         0E39YxHB6yDu+4hK/7l4n19nKtsQylz5OPF1puD/RD+hurKju4zZqEE52YqNpq6nH0v3
         O1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764813307; x=1765418107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9ZKBsX1w6UPefrLQ6j6TJQtLjEj4G2aPJhHSG5VU5E=;
        b=fVJt5bi7hQphQOO6NxYA57ScWvCRQS6gRVMB31weIm236Pe1XGGVc3+IvBnJM+FJu6
         AX7YcFIgMOybzGYVjLuWyXAGV/B+rtxQZaSn32B9cRNDLhWYAZ4iLXkHxFrZla/sKpBa
         8VaX8ONiWqMyJ0WmZmFzYX1zm10djOctaMXg6bTUsgFatg4pnRsQa1s0xAdi10FcEw5M
         Dg4HAdwtrQKeYqQ8aY4mLKJOYxRNK3WEf1rwXQDYwrJVC6OBR+M0DSrdoMwAJae4Djaq
         2o0X5c+RuWA5V2MYcEMyIZxxVOP+I1GCjNbDk18bRAYhUK50U5xBd+AUQzk0FLZhYnDT
         ZXVg==
X-Forwarded-Encrypted: i=1; AJvYcCWy1+B0eUXlmmYu7CBadcTkTFR+WPiT5cVA1ldS//5qtIiY4yAAMduZo33isWj8PJB5muvwEqzNJBnT/w7+T4u4J4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jX2DgIEpprlFJctQkzU5gLytafAU8QebnGNH1pxZ2B15u110
	34BBuqndqkbKiD1PnR4uRlqS6R4Rm9LjwUEJfNNjvrjK20bfiB+CQrY9
X-Gm-Gg: ASbGnctuHxiehk5bVcbpsIE+gc1yprQp3SZNSPCAditrLdezzKIiYmczalNb7+hPmGh
	x0aoH3IBO6YXkhjdVun7n03XpRA3BNqxTacEAF4TA9/A+c3CzGYwG07JMUNMFQpczEv67mblAlK
	5GfW2s4bwsEPIP39laszUaPAqZVJqMj8bUe2q2/oD55l/r08zymxlVMJGCYDoZ0WGXKn4PKUBf5
	FB7AER56ZgtJ1NH9EyNTnPS+IkD6qyvisjwrHh90LBN5byoFU3NfPGqRBfVZ5YczaVPJz3ssNjp
	xc492ivcIPGLA4Qe3fg7UTQzf222jTEA2BDipEoVNd29/m3X8HHnJS1clEg4BELd0f4Wx3cs6NQ
	tXh3pYCNQ5LW7ME0bZKV8RSRTUXQ1+gsaQaVoIxkGqa209k8JIJOHPdsf/dcyHSFr4hvHFGcDLo
	vmASE0C7Vm2v7HHAKlsNM7BRiFNS/jKQ+0y9ukDmN0tFD16Eb0YA==
X-Google-Smtp-Source: AGHT+IGq8c9oD3u5GYh05SjANvXBHmmeyohU8q+LRCLY9miurA1rAfYoEUrgRkiIG9sgighxtVHcGQ==
X-Received: by 2002:a17:903:b07:b0:295:9b39:4533 with SMTP id d9443c01a7336-29d6839870dmr54019345ad.30.1764813306619;
        Wed, 03 Dec 2025 17:55:06 -0800 (PST)
Received: from localhost.localdomain ([2409:8900:1be3:8f38:b904:5201:d897:3883])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34930b5a195sm915502a91.3.2025.12.03.17.54.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 17:55:06 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: shivankg@amd.com
Cc: Branden.Moore@amd.com,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	npache@redhat.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	zokeefe@google.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH V3 1/2] mm/khugepaged: map dirty/writeback pages failures to EAGAIN
Date: Thu,  4 Dec 2025 09:54:25 +0800
Message-ID: <20251204015425.66988-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201185604.210634-8-shivankg@amd.com>
References: <20251201185604.210634-8-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When collapse_file encounters dirty or writeback pages in file-backed
> mappings, it currently returns SCAN_FAIL which maps to -EINVAL. This is
> misleading as EINVAL suggests invalid arguments, whereas dirty/writeback
> pages represent transient conditions that may resolve on retry.
> 
> Introduce SCAN_PAGE_DIRTY_OR_WRITEBACK to cover both dirty and writeback
> states, mapping it to -EAGAIN. For MADV_COLLAPSE, this provides userspace
> with a clear signal that retry may succeed after writeback completes.
> For khugepaged, this is harmless as it will naturally revisit the range
> during periodic scans after async writeback completes.
> 
> Reported-by: Branden Moore <Branden.Moore@amd.com>
> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
