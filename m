Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF538331E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538715; cv=none; b=sia0w/shylgTY1O5McT28oaQqm2Mf8wIxSQXgYrNZrobO4RSgylE2FQnIew7wsG1dMZ2l/vHA8mQNcEPwN/d/sBa0fQAcwdYGrF+s6iHbQRSDSR6c44mpG/IbsHI8Dt6DiWBjioGHhB/i+qzunwAXDLlCPrsBAqmlBNzxN9SsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538715; c=relaxed/simple;
	bh=VuudsUiljFSxKeY1XyzkPtiCdtwiQY8KMpShx5GPy8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=M9AKhinwrvMKhM0yIPJPBhLZUorkNLk3U4hgnxm15D44SZjNARglDrODjAgJhmI1l6DFNAY+/Z8j6Ukkb4m8T04Mzt0ZS3sYb0V4E+BmsDFHdkkGZgQGdm6rj7UJCUFjdw/kWa2Iy4SR93YAMO6uLcEd63fdlIQ0YPX8pqEEhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7Rj06Bu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7Rj06Bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778538713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dznPu1VVwFrrNZ7nl/7IGgr8yt72Ye82USd7L2QyA64=;
	b=f7Rj06BuvGnDUbn8e0qa/34VFK68BYeXLpDJyvhH1aoyFEhL7gv5EGE763anIm69OngcSd
	eBrL8YYqGEAui8oSBma9Drs35O7T+pBLojswbKUtsUsqzaGc2FGvLw0tpB+nHvSwG+uOY7
	bqJUMo4pmp9fvYcdy8rrSjfjKbdCO8o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-yTz6UcCaPMupuJOwM-363A-1; Mon, 11 May 2026 18:31:50 -0400
X-MC-Unique: yTz6UcCaPMupuJOwM-363A-1
X-Mimecast-MFC-AGG-ID: yTz6UcCaPMupuJOwM-363A_1778538709
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso86473621cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 15:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538709; x=1779143509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dznPu1VVwFrrNZ7nl/7IGgr8yt72Ye82USd7L2QyA64=;
        b=p+pL6hopqdlLWSBE17jumKennM3p/fTcP/Ndtq8SUqTVBcpH7eQ/fFnGRwMA48EIGi
         VSo3Zk35+uF5664yfoCSOLMMN4MVkLWe2sRugRCfQBzSF+mzx2WrH0e2C+qMajzS/CDj
         INSeqXf7eNJci5YrAcNf/eOYdZefnZF6HWIhnwcC64gfuB3pinGDu2j6qbHwCNL3XfnW
         T1feBKWPELKF3YbCRQGdVVD4gt0DgY8lbM4wBvukaq4Fn5VZrnD/tpX+kyJ8pzlk4Tv/
         PJCOhs97092BvmKAxNdbjp46/GfahR+wNeNHWA7x4Z7ZeFSFxwAj3A0UXyEInDCjvgQK
         ocvw==
X-Gm-Message-State: AOJu0Yz6TpPTeVBfqPDR207GwyO47UIJId9cJHHyYQcqlfNoF2P7UXMi
	xf28l7GJ1d5EtBzE0aqjwtWQzUkNXFZgTfWnwn2GMi4JV9QC1YODTqDnBzoICOhbLd0s/iY0tf1
	Iepms18uq8ZzIt459z5OHgjbZ9Mao5QZKBrJs7ONRVDu8Pvt8U/dFv+GEo8cM8CQz1pE/2N/FcQ
	==
X-Gm-Gg: Acq92OGldL/ShR66FlSQ+AwgWPPOFyUuEcOryjGJPVGgGPYgvgXFYep3WjSlscqlWMZ
	mDYZ87xL032TMvoriCtxYhZ/q9dEt2+iOxwB3CNKhw5FsLlArGbTuqYlhtwIIIffKtNmp/6CGzj
	992mME7ckELhgDHzYX3A/rcEpV3KSe1BKVZTCy6Xuu+ZoUcJ7kVDsl/6vs3z3zi5Ovwzbuwl0tN
	d2aytvZRyD8/XRf95QgRKSJsQfH2mBehr27gEUG5kzqjphb7P7z/XJZdD3EtcWYFs3f1ToR6kQR
	uqDD/CyvsXTS/bqWFR95G9M5wd44WWMQqjd5ROkz17ob6bsiN3J0oj8EeGPBePOe6Qy5ZemGA69
	XqUK+x5T15pldTdW1UzQcaqbzvBZa1uAEkWRm/SB7uimxOLNCpe5TCQ==
X-Received: by 2002:a05:622a:5cb:b0:50f:c2f8:4075 with SMTP id d75a77b69052e-514d1c4514dmr9792481cf.1.1778538709245;
        Mon, 11 May 2026 15:31:49 -0700 (PDT)
X-Received: by 2002:a05:622a:5cb:b0:50f:c2f8:4075 with SMTP id d75a77b69052e-514d1c4514dmr9792321cf.1.1778538708689;
        Mon, 11 May 2026 15:31:48 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e655d65sm103723081cf.8.2026.05.11.15.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:31:48 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH RESEND] tracing/osnoise: Dump stack on timerlat uret threshold event
Date: Mon, 11 May 2026 17:31:43 -0500
Message-ID: <20260511223143.1477332-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JzSAy_WJxiWHLhSCHUqM0gRym-PdQdnSRI1wn9VPswU_1778538709
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dump the saved IRQ stack trace regardless of whether the event was
THREAD_CONTEXT or THREAD_URET.

In the uret case, the latency presumably had not yet crossed the
threshold at IRQ time (or else it would have dumped the stack at thread
wakeup time, unless we're racing with a change to the threshold), but it
may have at least contributed -- and this is possible with THREAD_CONTEXT
as well.

In any case, it helps with writing reliable rtla tests if we always get
a stack trace on a threshold event.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
Original: https://lore.kernel.org/all/20251112152529.956778-3-crwood@redhat.com/

 kernel/trace/trace_osnoise.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 75678053b21c..62c2667d97fa 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2544,9 +2544,12 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		notify_new_max_latency(diff);
 
 		tlat->tracing_thread = false;
-		if (osnoise_data.stop_tracing_total)
-			if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
+		if (osnoise_data.stop_tracing_total) {
+			if (time_to_us(diff) >= osnoise_data.stop_tracing_total) {
+				timerlat_dump_stack(time_to_us(diff));
 				osnoise_stop_tracing();
+			}
+		}
 	} else {
 		tlat->tracing_thread = false;
 		tlat->kthread = current;
-- 
2.54.0

