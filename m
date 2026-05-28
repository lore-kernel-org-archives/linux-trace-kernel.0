Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0038B7B0;
	Thu, 28 May 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958616; cv=none; b=tAoEcsAO58iYXtBb0R/iUASI6cKiHfaa4QAi4+8pt4oWVH7HTDQQggFWnopGmpWrXno0waAfPQfjbKBq7Lff8R51yMnxKc1ks205QKfs+LKOC/bbq4mtouenvcGQXkEnd2zhTqjDMpM7d51kmI/alRm5ov58IH3qo1UwLT2OfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958616; c=relaxed/simple;
	bh=DxZXHjAmE+XSe14Z9bAAzWKcyuGjkpZPsH/KHKvT4Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUQ0pfxBLQ4VsF54su1dtOEFezm5qAZvS+J1/MHeGGv79jAcKQJlx8y+qeXoCCKgtq7aur1yhPJUzEvAQcfBBc/gwP5EWBG/MZNAfSXeojrvRvVF7LxSR5N72eQLkTMpQdoj4DOStbdk54MaxGmhR/lVmt/pY9D51MnFtdAb760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ey/xgxea; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Dan7rdF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ey/xgxea";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Dan7rdF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779958610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxZXHjAmE+XSe14Z9bAAzWKcyuGjkpZPsH/KHKvT4Ng=;
	b=ey/xgxeadU+SQ/JO+QKHecgar89ck+1tC7wBYD1YUm5kNZSuHtv5mxYVs6RDwFMnC8+pGe
	GOnRoeaMxidBrvMdQFkcIobSMfgnts43SSeLm1jDMAXDyfGG9TGindbrF0kzu8/cM52RNA
	6DHNynx0Y4ls+Zn+vr19uzMzD8y2PxQ363w5yQkxgTfqD0fJT7xmtc7mFrbOhaPbvDiqww
	+sLVRTnFWha3Ri6Ia/JoqORt9kM7xmiqMZheThNT2C/OmYlwlTAFmZeTEyBxhNFi+Xv+ZP
	zNQVtxj52vtfhcXZwvzUduBFkM/LxVREmCx+ko/sNG6zd93B5UAWqFxX9PFHKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779958610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxZXHjAmE+XSe14Z9bAAzWKcyuGjkpZPsH/KHKvT4Ng=;
	b=1Dan7rdFNnBEDMPdijyQZcsbpp26w3Om53feYC8sdvt+fSkWmPX4GIupnCRRxYU4k35bKD
	p7DCR495JoRwYzAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 04/12] rv: Prevent task migration while handling
 per-CPU events
In-Reply-To: <20260527062313.39908-5-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-5-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:56:50 +0200
Message-ID: <87fr3boqst.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Tracepoint handlers are now fully preemptible.

Would be nice to mention the commit that did this:

a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")

> When a per-CPU monitor
> handles an event, it retrieves the monitor state using a per-CPU
> pointer. If the event itself doesn't disable preemption, the task can
> migrate to a different CPU and we risk updating the wrong monitor.
>
> Mitigate this by explicitly disabling task migration before acquiring
> the monitor pointer. This cannot guarantee the monitor runs on the
> correct CPU but reduces the race condition window and prevents warnings.
>
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
