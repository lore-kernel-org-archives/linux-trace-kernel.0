Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67B1C2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mb8yokjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C302DC433C7;
	Wed, 13 Dec 2023 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702436607;
	bh=KL+YGefPMQWTJUJcgEiowZLLsMSBdN8/Uc2RwgmG8Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mb8yokjfhmyagSO86j/flHconRVGwvnZRvEmkn87TiHpnoDWMlcNw0uHeU4RdvE2V
	 5g/pUbK2OkMCGmRz1Vvnnlco40uP4s0TLvn4sfeMyCajnldHB898CkCfSnharG9ciO
	 AiZIKqD0vUTfJWDQKS3jjPvQ/fzi55h9qFtl7RFA=
Date: Tue, 12 Dec 2023 19:03:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
Message-Id: <20231212190326.899a71c20ecfb143b84e93a6@linux-foundation.org>
In-Reply-To: <20231212032640.6968-3-cuibixuan@vivo.com>
References: <20231212032640.6968-1-cuibixuan@vivo.com>
	<20231212032640.6968-3-cuibixuan@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 19:26:40 -0800 Bixuan Cui <cuibixuan@vivo.com> wrote:

> -TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,

Current kernels have a call to trace_mm_vmscan_lru_shrink_inactive() in
evict_folios(), so this renaming broke the build.

