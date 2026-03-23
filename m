Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35843BAD85
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281679; cv=none; b=dsrzHak9QcDZiAzRkaLNv/kOsDseLE0arpZxV6hTla+xqXHYy5OlEC8mYVXZUx7ygyxi/HNukC2FLe8CWUu7ZiDOK5XJeFBWjQ+STX9HRJzXIzeE3m/3iGgYshuQ3sIQ3f0gNA9c7Xdb72MiACXwoCZZAnO2RlLyxOvH0oa4WeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281679; c=relaxed/simple;
	bh=55sJcEAeOqP1wUV2kAWxr6Nm9zg3ay3zznJQoatj8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RypSos7TvhJ9kPq3cIdrWHvIjcMui3ZoxipHzjgCDjNZsGkhxEFwodX5yjvzGbDoiZ7PdM/BxNoGodCNQz0QgJ4uwfZqYSWOq/xqh3gW0Hh5HWuaqITe5suhGuiTFkhm8yBcPWF7YmUfGGKdcVVUYUxpQeKWPb/HXhodP6s483s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=a4ALGmuu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="a4ALGmuu"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7fdb922a5so2197952a34.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281677; x=1774886477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gykI5Ys0pP1nvSBMUxU7kJy0pSWFmdTNGK8Js6c+Xs=;
        b=a4ALGmuutkidRTHjTTlgtW94BO3VcLgG9iKFKICeZ1ARAOvZwTWCe2WfVWv/fU/Za2
         6okh+yu9aA4vKT3mU18xe9yaGDGCV+L1mzQSxq95koV6oG6rl8HB4UVWl+GbqAn5fKmY
         7MFIpOs7xYl7Y096u/lsuGr7+OgMODZqWl2QY+O0Wm2MsDBgVNFBnJ/OtYqmER3CzoSl
         5MxDHqknR5Oqyo0Is+InXhRvYvjcrn/YKz4Macs37zlPamwMbz0ytIYxl9Fa9bNQAnks
         hJc4Dq4MEkPJ0ZL5/E6Pm6Pw8V8iTx+ZxF2PK9877Ud+UPk0CD3yGYzh2lFlpqJ1663S
         fv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281677; x=1774886477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gykI5Ys0pP1nvSBMUxU7kJy0pSWFmdTNGK8Js6c+Xs=;
        b=Q09GGsCz7qbAgsIkMGMTt9jJ+L1J5mVF//X6vKjtm+G0+ElvCGaBmFEYpMAVX3j+Pk
         iFxKtBW5EubehAx6iJ0FD4QguJwkWfHQGwNcI0x1Tbqrv28GNQnROkg7JOAnWiohH/lq
         bLtb7CCekbhzD/LKsF6vAEm6Q8l5zjkovxzxUlUtBgjS7Hgnzk20xEAIxGrc44Zv9cda
         flMZtCqZIluq+dCfuQGFpAmlWDomvlkIeusICyPeClzni8YyBjJQXsu3CfJs6mTO5D57
         xw4SuihtCUY2tSrOUNufdedYLsvBnwq23HXjwHhfpGnFGRXywcdVVqqJ3OaQwSQ64EIK
         5eVw==
X-Forwarded-Encrypted: i=1; AJvYcCWWrCHGzkPffkJza32FlUti8J4L/xX6fGlALNVXSZ/eQzLh2krJqpTJp1OZkFE5fF2qVuY6Nzw/gz5gvDrerRxbYoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKhQ7KSCYfvkw/CrH4qCbtrlE6vpbATOuV/atYGp3jTUYkP3H
	fJgK0o2nxsvsKy8skCzWQPEG9ocjYVKsRJPIgyUvA/YLTxVkOkWmirlRNnvNKAoWlRA=
X-Gm-Gg: ATEYQzyxdPZbzi6tMwtYA0A4B/emOiw56qYJbtnNuF96W26+BSPYpVeG41HDwm9K0lo
	XSFsjxrSGw/odRZxAr1q/ELN5uTrLCnpJiPyspKIcQpsf6pEkld99vgd4N/XEWW1At2raKaPUl6
	Z3hxqgY+7rc2g9tZii8McdKFF98TkOJEnfSgVhWAMKxPz+WJR2gviYE5yCA8z0WzfE9xMtNupEb
	BzuK9DKlWw2D8sFNSmiXrrnC1FQesMTsrvVtJM7byEuH9h9omPMLx/Yf5YXzkT4RHE5U/04Ewt2
	uAVwoB8vFzN4jBxWcig+IIfnYoLdpuE9nw2b3QYQIxpLj6BWuV4rR4m2vCwvnQlckqh/tsZVRfZ
	mOxvxYcQLeXHYYMOC4fNiH5mOnH8e9AJEZatHYvah0M1OX+48koOVa81/PyizzOvxA4V23jQcnf
	7TmXFzs3ZUdtKzTKY0fwPR7O0dYuFQLiQTweGQFPD8/XcR9CGzpp0jnrlnZM8Lr7q9DQ==
X-Received: by 2002:a05:6820:1888:b0:67d:eb9e:26ca with SMTP id 006d021491bc7-67deb9e296fmr4032624eaf.40.1774281676551;
        Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 07/19] devfreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:26 -0400
Message-ID: <20260323160052.17528-8-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c0a74091b9041..d1b27d9b753df 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * change order of between devfreq device and passive devfreq device.
 	 */
 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
-		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
2.53.0

