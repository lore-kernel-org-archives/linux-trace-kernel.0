Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77493A380F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315572; cv=none; b=am0J8zY3g06HZXtfsFsh06nfR8MCx5H1neDuuhWb7+yX5CzRCN6FLkFisqxcJxs/vEfGrayBd6KAJ4gmYEyLfdWPMOsAMRpESBRuZRvS5SKRu6IiHujUzwr9+t6nQyD2C07LYQDDEU/9ZIpDo2Ha6E2C3BGOar9CZGupB6TsDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315572; c=relaxed/simple;
	bh=pEwvMUJsepobqM/3vXS6TOOOYqnQno7hOFHDhKeSARw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsPNsrr77gaV6AYinXQmJRVl6MD9TdQCmphq94Iwovmkb2HSCtvbD9us8PxOrBzvY8u8c3SBuGTuo89VNh1nbfjTyASCwKI0RBoQnchdCP1NCtgDcUroeCc4Pl3Dh7p0+pa7gw+5UWY4HIXeJ1ZTHwBH2CC1qRgqFoiV4rr9/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQqo4VVR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQqo4VVR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773315567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4keLUCD36GmhOpd1Y5wJ67cTPSgRrvPHrAizfQ/GUjk=;
	b=mQqo4VVRitmOlYVcRGLh/Iwks4syeurg8+k61C5yJ9A5ry/Q+q7juvaciJH8Zs0iRpOJke
	H8L3qi/5ZPH4zeOmM6d0JM5v3E5A7Dhnm7ju09Bxru7BwXO26Sv1x3fRqFdV71cp1SU9Gb
	ZXM+6WBxoTcg2I/MUa32v6loCb6K8jw=
From: Usama Arif <usama.arif@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] locking/percpu-rwsem: Extract __percpu_up_read()
Date: Thu, 12 Mar 2026 04:39:21 -0700
Message-ID: <20260312113922.2118105-1-usama.arif@linux.dev>
In-Reply-To: <a065fd88990c0091a168b1d6715cd0cae8e9066c.1773164180.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 10 Mar 2026 17:49:38 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Move the percpu_up_read() slowpath out of the inline function into a new
> __percpu_up_read() to avoid binary size increase from adding a
> tracepoint to an inlined function.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/linux/percpu-rwsem.h  | 15 +++------------
>  kernel/locking/percpu-rwsem.c | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index c8cb010d655e..39d5bf8e6562 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -107,6 +107,8 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
>  	return ret;
>  }
>  

Acked-by: Usama Arif <usama.arif@linux.dev> 
