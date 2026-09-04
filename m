Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DF34252B;
	Sat,  5 Sep 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624658; cv=none; b=OJpChYDHaG94uGr190lav2O2vhuIzqWlj3H4yHjHyeFqChfxwy8WBFUfar6rUigctHvBB8b6HhSNC0eooPUdRD8gkzP78oeXXuylDfE2vlPvR0nItZctZcJ/plbYscJkKpPYTNB2QZhedOlFxtAZil/E91ruHinXPepx8YKtdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624658; c=relaxed/simple;
	bh=NeJm4gBAmuyWOuFdbTcREqjROX/Ie+mGb25ye/f9+Bw=;
	h=Message-ID:From:To:Cc:Date:Subject:In-Reply-To:References; b=Eaq5g7M3hrod5n1NubZ/3fDwX/PdEUzzcw/H0+VupZlT+xtn4Gd639GtpttO46aHF7JidRANMMfEwGahQK33sty0qtNMeDmLntD41mcwyhSEEnfqlc9CpF7nMcncKkcV4Wpl2wAMe+TmL/bAqXJSz0G62A9J0/BpxVWepK8olX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlooSvki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlooSvki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5242D1F00A3A;
	Sat,  5 Sep 2026 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624657;
	bh=FVdL+I0TF8qzjtWwKDqf3kQJjvZoMHDpNE1C67iFE2o=;
	h=From:To:Cc:Date:Subject:In-Reply-To:References;
	b=VlooSvkiYqXE00unPM8+p+Gk6LR5jyWyyxAUCi80qRTguIcPUcf9TTelQAySySw8k
	 RBjOC0a/Xp4VMH0d8+ugkg9dBevJpt87Wkc8qVSqysqqtk1If+WaNlVOI8keeuK+vF
	 GhAolSMiKjYrPX7vezbQi0tF6AHfgtv9+CH8Z72sQfW2o32H6WscKQsH8mE2QNYlOX
	 O4iD9vuMh/24o7b4oax1Fz8Za4wJYehfe9t/yiyFwOLwr5k3fL0LpshRxmaqh6lwju
	 D92UKSmw4AmT4i7bVfuMw/8zHOLVrfn/l2bFq53idvW7vjgv+Ga3pL0phdo7CQoHhH
	 T2j2qCAGkbcgQ==
Message-ID: <d742c094937b76304fe055d06d7c8cab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tj@kernel.org, jiangshanlai@gmail.com, rostedt@goodmis.org,
 mhiramat@kernel.org, osandov@osandov.com, neelx@suse.com, sean@ashe.io,
 marco.crivellari@suse.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, leitao@debian.org
Date: Fri, 04 Sep 2026 10:22:45 -1000
Subject: Re: [PATCH v2 0/3] Add telemetry tracepoints for CPU hogs,
 distress, and BH budget yields
In-Reply-To: <20260904193447.247502-1-atomlin@atomlin.com>
References: <20260904193447.247502-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hello, Aaron.

> Aaron Tomlin (3):
>   workqueue: Add workqueue_cpu_intensive tracepoint
>   workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
>   workqueue: Add workqueue_bh_budget_yield tracepoint

Applied 1-3 to wq/for-7.4 with the mayday interval references removed and
"executing CPU" changed to "pool CPU" in the BH tracepoint description.
The comment adjustment is below.

Thanks.

-- 
tejun

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 12ac24586835..eb97d4dbb5b4 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -169,9 +169,8 @@ TRACE_EVENT(workqueue_cpu_intensive,
  * workqueue_mayday - called when a pool_workqueue sends mayday to rescuer
  * @pwq:	pointer to struct pool_workqueue
  *
- * This event occurs when a worker pool fails to create a new worker
- * within MAYDAY_INTERVAL and requests the workqueue's rescuer thread to
- * process pending works.
+ * This event occurs when a worker pool fails to create a new worker and
+ * requests the workqueue's rescuer thread to process pending works.
  */
 TRACE_EVENT(workqueue_mayday,
 
