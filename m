Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295092;
	b=ohAqgIQuwqBh0cJs3fKRg2iITyGbW4+/YPm++M4XkZ46Ic3h+9ImY7Ww2Ma7K5VP8sFW
	 VPbklMr9o2S+LWC+SND1FyALPGcF8QB2pMTBSnh3RG3wYgtS+/yaXcGe0fS4QVcLk9yWD
	 CESKrv2eDzf7nEphaWCzZi/uoz8XaqjYfZGeOdNExYa3PJ6ysY3tmXIsWVz8lIMVsRWhj
	 GTZ8Iw7sWYvDTLlkKyvlbf+S46Y+L9Ee2g+uzoms+IkpjYGzAlG8jcFKjNzBMR8eWq4Ib
	 D+z9MrIj7Qb9QkrY3wIo+VzCti2CPUJ+BFoY8YEKfL8/mV/9yTRDju5fZWBhlXyH5xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=77OMp/0RKdeQKOVvIsvn+1zTLaU1Gb/6YMZNIkI1ZZg=;
	b=IQUYtEBIgX17VFU7D4crvI+yVf+WatZU+yBPx11H6QWjCiu/VNFm+o2DMiLlHeMJqDxd
	 SBY8ZnrFt1oD7x/lQ62TR7pU8965NhEF7qJ1KJKcRd4sHmYPyOTt+vm4HdXWp/mZqu9lX
	 zgF85qJbvJchhf2VCaMXVjj07Ozf0hYBGhuTM2TiWYRjlyOTGxlSsRmhKHxus+0ehkOUd
	 e78Y7l4IIDEhOJ0OoEt8PZCoYY7qPEO8uf6XY505LIF6MWxvsH2UZS7VI0l54hktZ2Cx/
	 9HzLFLg/zt8rebhVssfYeiXtDgUHXF2LS2gELJWf6D1qSW6IlVliDiq4IyM3LvAracg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEBc4HTr;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802D606A324
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 17:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1802D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEBc4HTr
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so2770076c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295091; x=1793899891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77OMp/0RKdeQKOVvIsvn+1zTLaU1Gb/6YMZNIkI1ZZg=;
        b=tEBc4HTrN67zaTaZFfqoEWfgdEhGwrxC/QqC7gVvwYOGZ6D+rLHsTpFCWRU9B6z3Ym
         S1MV/1+EqFbEiTYDPM/kkX9AWG1SEC+z1j/uPji42T2zjT2gm/iWX7lZqq9qbIiRxMye
         eg/CZ0/awlu9bv/vW0Z82RRMwBWy9x2kS/DHd72Bp2ei8sUegaVBkAlJ0PSDjBhtXOB2
         cEKMoZT/tfnEzGAi8GLB3dUEHRw0HKfVAoGQNvSglucv2/vW0ZcNtKtbvM3CZfS3e1qc
         pcK4YlfcLwb8f4H8O+uc/kSVlbQpEuL/qJWR9VU118Ve2sP4qIS3tcNlG86lmLKLd3t7
         gMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295091; x=1793899891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=77OMp/0RKdeQKOVvIsvn+1zTLaU1Gb/6YMZNIkI1ZZg=;
        b=OqzZoJNQkpKgrt5GK+nPSgbsybNhsj6cGGc0Gxg5CUOj2+58c9b2PPBmLidrCmkDiL
         u3kuEgExvvfIiKIR6qf4/+tl0C0sqgcYCk1gGHkx3j3dCEHOt9mJnLgkeqPxTIZqP/CQ
         fpKCxD5wLpGH8xQY0VTetuphWkdiNd1l6cybSctM2sUH5yX6Yc9rSXi6FGNp4ZO0Mc7C
         YRBl9eRN8Hf4YqrzTy9RwCC7KTmyt02ONojPF7/18S8J5zBrnIkvYnWVKNzDj9NBKC6p
         Ip/QSgGqea4cH7Y/J9HoWIMByneaTvk6E2XQpCyShv+l+HV5ybbrHwUn/De/N/ZGsS+y
         688Q==
X-Forwarded-Encrypted: i=1; AKwUvBwa/34SgxdGySxunyxP8EOeVlK9ObNe/wNHj+phh1E2+6ZMkbMHdIctsCVg3QwMq3iVJrsozMYIMskTnUkdAUtNe+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlbIMb3XAen/FAR6rlRTE162X0WwMle25UuywMvPe55tMxlNJs
	+nyaUMipNvJt06ckJdEN3FMPdS0thOnjk0cLaJD2KeArXS1l/kGzOImtAmESpqVMxdI=
X-Gm-Gg: AYBFou26paCbQmuV9oRBO8HYrygJp5QhzR/jLq/MeULAe31V5aDJMXP9Qs9Kkp9s9ri
	Ay4t6aatd3u4Aje597E7KmOoGvP67my12AQfZjmxwe1vd14pjPsTmMamYt9avoMMROhhNd73NWI
	GXjy0Cjs6zXLP0h5hx0M0tNwZ3Dcuc1cPJqadJUfhroj34HArcnaq0E9h0dkirc2vOvctGBpDxK
	uWFkZh7hP2f1+1HRijNnPPS1hNXuHUjRIOrNlHWcuLYRt1axispVR19I/gIz0+JtqD7yinLbZyx
	TMqc/4LblgI+JEp1lAsCEGJ5arBQ26NMwd2/qro6jpX2BhO3GyxVBWH6ShVYbLPO9BdWqSqoq26
	/9f8Fdz/VGlcvTNQ5NyFGkG+/uJ8499DHVcmYKVyubGWK2wSzP2VYcZ7R9YDoFNyaZDuzHg39NX
	X/Ch/6uU/i5TXwFF1cdijDLrxE7nOEi4AQg9qqyPJvWqq4RvWz4plGGYPd8dVCKku077k1ZKKnn
	dD73ZOIL6+ukxt/oW+sq1W7Q6b5AYLD/dPQM36Hta1WYijRFhvNbCMc0OHk0g2kZG0Katv50VFd
	pJaCq4p+Gv2sJYelK3HvfnNEWmA3qMDzPkDjiN3NBUMzfA==
X-Received: by 2002:a05:701b:42d1:10b0:1a2:6b9f:f7e1 with SMTP id a92af1059eb24-1a6ced8ff72mr8827239c88.14.1793295090098;
        Thu, 29 Oct 2026 10:31:30 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm228707c88.0.2026.10.29.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:31:29 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Free tracer resources on instance creation failure
Date: Fri, 30 Oct 2026 02:31:27 +0900
Message-ID: <20261029173127.387835-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025165250.65363-1-pocj8ur4in@gmail.com>
References: <20261025165250.65363-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating a tracefs instance can allocate private tracer nodes, copied
flags and option arrays before trace_array_create_dir() returns. If a
later allocation fails, trace_array_create_systems() frees the trace_array
without releasing those private allocations. The failed instance is never
registered, so normal removal cannot reclaim them.

Free the tracer nodes and option arrays when trace_array_create_dir()
fails, then continue through the existing trace_array cleanup. Share the
option array cleanup with normal instance removal. Earlier failures still
use out_free_tr because the tracer list is not yet initialized there.

Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Changes in v2:
  - Add the Fixes tag requested by Masami Hiramatsu.
  - Share option array cleanup between failed creation and normal removal.

 kernel/trace/trace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 97a058623f94..faa90323809c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1456,6 +1456,13 @@ static void free_tracers(struct trace_array *tr)
 	}
 }
 
+static void free_tracer_options(struct trace_array *tr)
+{
+	for (int i = 0; i < tr->nr_topts; i++)
+		kfree(tr->topts[i].topts);
+	kfree(tr->topts);
+}
+
 /**
  * register_tracer - register a tracer with the ftrace system.
  * @type: the plugin for the tracer
@@ -8751,7 +8758,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (trace_instance_dir) {
 		ret = trace_array_create_dir(tr);
 		if (ret)
-			goto out_free_tr;
+			goto out_free_tracers;
 	} else
 		__trace_early_add_events(tr);
 
@@ -8761,6 +8768,9 @@ trace_array_create_systems(const char *name, const char *systems,
 
 	return tr;
 
+ out_free_tracers:
+	free_tracers(tr);
+	free_tracer_options(tr);
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
@@ -8914,10 +8924,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
 		vfree((void *)tr->range_addr_start);
 
-	for (i = 0; i < tr->nr_topts; i++) {
-		kfree(tr->topts[i].topts);
-	}
-	kfree(tr->topts);
+	free_tracer_options(tr);
 
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
