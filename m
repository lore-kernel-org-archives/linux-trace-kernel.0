Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96D315D43
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072439; cv=none; b=hAjHGY0b2ciAcBicbCJnuJE/EArL9t/3L1M3z6OsmtsmhrgkHruYbpj4lpPaisXHc0l0peahLRHNH+d4aCa4wy+MNF4/u/s0Pl6FVxQJ2kczubIvj7WNDsqJHySLghzbEjR28rj/fRnecOf0AefKVd+mUncQn+phu/e1GurFCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072439; c=relaxed/simple;
	bh=rMuxP0+J4OeLHPbWlDZiX97eHli3LW/AfUXJzlBn1ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b06EMiMDmUWThRwiJUPBrKuTjBZjrXCBf1LtU9Wmvn4axJemZruliBo2x4SNBPm13DIzShouIBk+MVPaerWnmnVkoUkI10si/dozKJOoZB2qq1+1Hi3g84QHjHP1WRjO0aIFiuiT+pSR17vjjpX5cVSeHSK6HsgJgwMTgTT58aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOS8W2fQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOS8W2fQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so3138492a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786072437; x=1786677237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMuxP0+J4OeLHPbWlDZiX97eHli3LW/AfUXJzlBn1ys=;
        b=jOS8W2fQ8Db/CSVmwHg1jWxoSpeINRyoHQtZM7hPDL2xvnig9YZW2G8v1DXrklZeVL
         Nh5wLCvZneBZZYqrmAn2b6RHHO6riSJpiHw9WUpwviIKZwpaibJy/jpybWLUeDXAcflV
         iJut9Fb8p9mxhAh77eKgKE9SNEks+KzhA8W2N4U1QahmEElBkgH6mM0sGHfunis02T7g
         4viocDYjWNmhOWrH4ql2KCBNTY4jvsM5ODbYTnKe81HbV2GAtGjSDl9BDAcyhuUmIRqj
         tHPxihw9aLj3gWqSKlGjnmP8dlAN3K6HlggS95g4yweSEUnc62o9fs9f8bfT2anRP2hK
         TfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786072437; x=1786677237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rMuxP0+J4OeLHPbWlDZiX97eHli3LW/AfUXJzlBn1ys=;
        b=aQAuxx+9dLrVUSvI12LWAmYX0dXyM8CAVy99VI4KrwWBqX/Y1i8AYWFhMDz9kiYsYl
         EaLkTzYmJI9PcmnatkYHoogVxssn/wgcvvhhHWDR750ES8VE67MLAZb8Li4Ky4zkLkju
         87YnK59ujILOS+N6yCK5xj8eSNihCddKKFlWhA71k6ilc52jQoA9LlxaMwAbnn7TUP9S
         DRTatgr66i/3jHio3LUwb53ZvZNLBqSRuBimkQa52ngn8Xgybn9e7rOwPmc5++BzD9PY
         R7JCtXC/h3dm9/e6mm7cax2NDHapKTZ8Za/DibMueYSjEt+3H+clUwIPFiHhAXS483K1
         zyUw==
X-Forwarded-Encrypted: i=1; AHgh+RpP82LDIQ/Ai87qeNA88KZDMVwN4YxjUYOihTJsEcmsAJcqnY0cofI2WyEb74MrYOfeAWfO5qGDL5AlqARqjFWi7gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6fWuFyQSIvpM/40M5yM0aKMMeBohfNzFv79jaAqclKygWfPo
	Uaf5N4hT9epKnXxvSXdE3gJBOiH0PkW8QhcUrTGcp4h77Jk8d+85lnvo
X-Gm-Gg: AR+sD12C7vdNYdN5pBkmEetHxWVlyKobfr9VigF9hQTUKixLTg+OtY5yBsnWv/KhCm0
	DPp+0VWzVhXBBIBr+rNpdWIgmrm0iWsgQdHsGl1C3Alz3+TZoKCKV2lPYVOMhVSgws3Ll9ee50U
	49gPdiEjY5cE4MZamEHB6Yxut1bIGjR0zfVbHmdC5TN4XK9FJ4zfDzJbPkR12SalzJO33Egd6OU
	yRqr1LRStWgNALBTU/dbWtYw+AATQCSgbx684gmfyDZdcdPpMCfDLXc9KyW9P5TNSRg7fHMBPb+
	LG0UWDvvWJXXW2/FabjBe89RvXOaX4K8IC0A6minkofMKO42Q70gA9uf/zscEPbi+0aF8+qZeh8
	2jlGKqDYoC8HI1tfmKS49yDX3n/MzsIf+Yu2E81HvgapVKvTuDUSvUChueb6C0wXLRKs4lgek8g
	/5z3nFG2+cthLODjw1iO880sAfGTQaLSxxahZmC+U0VKRR0syITHKcJ4TzIw0naA8IsG2joSh+5
	QHDY47Y1zYixbFv8KfWBF3jxwuGbg==
X-Received: by 2002:a17:90a:d644:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3903c582511mr20343466a91.12.1786072437209;
        Thu, 06 Aug 2026 20:13:57 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b13b0c74sm357248a91.0.2026.08.06.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:13:56 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] mm: trace: decode architecture-specific VMA flags
Date: Fri,  7 Aug 2026 11:13:49 +0800
Message-Id: <20260807031349.3119855-1-zhaomeijing100@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723092905.761037-1-zhaomeijing100@gmail.com>
References: <20260723092905.761037-1-zhaomeijing100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A gentle ping on this patch series. It has been about two weeks since
it was posted, and I have not received any feedback yet.

Would you have a chance to take a look? Please let me know if I should
rebase or resend the series.

For reference, the original thread is available here:
https://lore.kernel.org/linux-mm/20260723092905.761037-1-zhaomeijing100@gmail.com/

Thanks,
Meijing Zhao
