Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D09463
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyiq6CUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A44C433C7;
	Tue, 10 Oct 2023 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696920807;
	bh=3Xd5odMKBFBnhMasD1TN2er1RvKIMlpFiAWIcG05Rik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xyiq6CUp8XABAFw63iIihqEhIcKBDP9iIDfKNRnLw0bmRew0p3XykDoixzrnGvi0G
	 SEOF25klPe33w9qu7OsWH2SBhEGKfgulUt7d52P3R5/bRAIChbNkVBhU1iIayNQAjW
	 GBQz8hjeansSE6fVnv84zI32eKMt6riqPd+LX2Fscw9z0glptCyEk36I991coZaCSb
	 kCvsRIDD3PCakZPebtj05z47ilhqWZjnV+pAbqRJEPOHsadljzKZ0P19YU6B7YiOlw
	 0KxMIwqHBKfMvRzd1cd7+BiNSRN2kPfG+J+MT3qesZwUZ9DrtmaMKreGEYR7dMo5vy
	 zxoI3kQ2zPJQA==
Message-ID: <604a8dd9-f891-368a-3b6c-3756ee6f4f35@kernel.org>
Date: Tue, 10 Oct 2023 08:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] Ftrace: make sched_wakeup can focus on the target
 process
To: Jinyu Tang <tangjinyu@tinylab.org>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: ttjjyystupid@163.com, falcon@tinylab.org, wangjiexun@tinylab.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231009153714.10743-1-tangjinyu@tinylab.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231009153714.10743-1-tangjinyu@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/23 17:37, Jinyu Tang wrote:
> $ cyclictest --mlockall --smp --priority=99 &

rtla timerlat -a <the amount of latency you tolerate>

will give you an structured analysis of your latency...

https://bristot.me/linux-scheduling-latency-debug-and-analysis/

-- Daniel
