Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61C156975
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687154; cv=none; b=pveEAzTL9AI1RpEw3M8rRjv0FRJ2IRJ+/ceFperMmDJECkJOlmbs3fv3A/io4Am6ftfFpP2nLqnkX3IZKnzGBwi7Odh9N4Pvg0IIb79FmaoQfqhmqoJ7knCxlU4B+susd5WsjQBRofKjeWJfQ/EV2nBu8cVKcw8JXLPlXd7GshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687154; c=relaxed/simple;
	bh=QMgUojTl/i/srSNF5GIKUc3oeUgKB1hhbEyskGreugQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ify5mx7jAoUBlj0X6g5RmohdGy/hrelc17UO/Vwx3IND97Gapwc8sjAT3ekTVa8c0xkEXzJG8/bvO0nyqo6v4sG5Fg/JrdrUZjVg/VUL7CAXKNkhS2xcvbetuzab1xKWXUGaqy5TOkwEmwe7hofpB8OjjLiq2Nkd7p+JHG8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdz3kUsk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdz3kUsk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4169ebcc924so9297935e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712687151; x=1713291951; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMVnTlKzzIBXlOvhWSp8lJbGWUU4Q1quhbk/89hlgNY=;
        b=jdz3kUskaRhIyLfry1ywef46UKT25IrEf1ZDRfeGYTIPgXlVkVOvvq23fBvp/5h+fS
         NoC5hfpyQHfXr2A30pUXZbyOqk6dQE7ciEXINpE9VgkrEBQUol/YK68vkhD6M2QWhOpA
         zYNeTAcrmgrO2cALypsljVhLvNaHWoVcwzbODE8wLEJhHeZJdWFxFDfCNCrNr9cP0cbs
         x4aS36S0xGBvhgfDCq73vPrzN04RzosRfe4HeSnhQ/2PEOZPgV9McCHHAKZLUATwr7l7
         swY4Fyy8+2XktNScsU5ynklI25D2x5KxjtXLivhj34QnFyCl93C2nlHe2BqyEOo6xv0w
         O69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687151; x=1713291951;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMVnTlKzzIBXlOvhWSp8lJbGWUU4Q1quhbk/89hlgNY=;
        b=cKsPpJ9Z4mKN+mMaa/NPgpKzNvLXCQeW5K+cPHQrVkVzkX6yoavNezpeZZb5USqkNH
         F9s7hEbHjkQlHTTFnpYBIXv1KZanSlMZf3EjmnCR3rHm7mKnqg6LidDYVPbndHSRzKNH
         bD0M2GQGugYDAWp0T+m6AshjI52DKJx34Ssrw5GjPTe57oJs5sMJboseGW+U9t5nYiDh
         SHC50DP2wvFc0mnZEZF4I0T5OMJq67b30OFLIVbPfyoNIYdhdwSM0bUlGIh+fEZy3Smi
         MoOzbjO1DIhHlx5h6u4cCyVbJAKDeBb3/VKMQ3AHj4LnfOygPsleSaaDd0FtSyBoXmuE
         gsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8xEMpHvKIQhGzCQhtKZL7QESAOa/SHzlxff0yavlxeGTTZ/ZNRgFiJZ95iCM+K1khtD5QhlQVl7wMacugRjraUL5Cr5+tF+2IYGGbdhyaRPQ1
X-Gm-Message-State: AOJu0Yzxde0ciaQDa9APWUgSTgMoPVpyHXEJ9ey81ww/UOtQ4Bacq3Kf
	L6eu5Yq37M7aTNHX0AU6VrlEv/x6D3zi4ZMer7OympjgFHYeYLQRPv1fhfMp+g==
X-Google-Smtp-Source: AGHT+IFHEnlsqznP4KTV21mQuVExIU4Ie6hLZRtrEQN+FAIK8t6xpdewmL+c6BcHdbPggT+DVYeCMw==
X-Received: by 2002:a05:600c:4707:b0:414:e0af:9b9f with SMTP id v7-20020a05600c470700b00414e0af9b9fmr337610wmo.30.1712687151262;
        Tue, 09 Apr 2024 11:25:51 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:ae75:6122:b198:210f])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b00416b5f63822sm2048888wmo.0.2024.04.09.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:25:50 -0700 (PDT)
Date: Tue, 9 Apr 2024 20:25:45 +0200
From: Marco Elver <elver@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <ZhWIKeZuWfPOU91D@elver.google.com>
References: <20240408090205.3714934-1-elver@google.com>
 <202404090840.E09789B66@keescook>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404090840.E09789B66@keescook>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Apr 09, 2024 at 08:46AM -0700, Kees Cook wrote:
[...]
> > +	trace_new_exec(current, bprm);
> > +
> 
> All other steps in this function have explicit comments about
> what/why/etc. Please add some kind of comment describing why the
> tracepoint is where it is, etc.

I beefed up the tracepoint documentation, and wrote a little paragraph
above where it's called to reinforce what we want.

[...]
> What about binfmt_misc, and binfmt_script? You may want bprm->interp
> too?

Good points. I'll make the below changes for v2:

diff --git a/fs/exec.c b/fs/exec.c
index ab778ae1fc06..472b9f7b40e8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	/*
+	 * This tracepoint marks the point before flushing the old exec where
+	 * the current task is still unchanged, but errors are fatal (point of
+	 * no return). The later "sched_process_exec" tracepoint is called after
+	 * the current task has successfully switched to the new exec.
+	 */
 	trace_new_exec(current, bprm);
 
 	/*
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 8853dc44783d..623d9af777c1 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -61,8 +61,11 @@ TRACE_EVENT(task_rename,
  * @task:	pointer to the current task
  * @bprm:	pointer to linux_binprm used for new exec
  *
- * Called before flushing the old exec, but at the point of no return during
- * switching to the new exec.
+ * Called before flushing the old exec, where @task is still unchanged, but at
+ * the point of no return during switching to the new exec. At the point it is
+ * called the exec will either succeed, or on failure terminate the task. Also
+ * see the "sched_process_exec" tracepoint, which is called right after @task
+ * has successfully switched to the new exec.
  */
 TRACE_EVENT(new_exec,
 
@@ -71,19 +74,22 @@ TRACE_EVENT(new_exec,
 	TP_ARGS(task, bprm),
 
 	TP_STRUCT__entry(
+		__string(	interp,		bprm->interp	)
 		__string(	filename,	bprm->filename	)
 		__field(	pid_t,		pid		)
 		__string(	comm,		task->comm	)
 	),
 
 	TP_fast_assign(
+		__assign_str(interp, bprm->interp);
 		__assign_str(filename, bprm->filename);
 		__entry->pid = task->pid;
 		__assign_str(comm, task->comm);
 	),
 
-	TP_printk("filename=%s pid=%d comm=%s",
-		  __get_str(filename), __entry->pid, __get_str(comm))
+	TP_printk("interp=%s filename=%s pid=%d comm=%s",
+		  __get_str(interp), __get_str(filename),
+		  __entry->pid, __get_str(comm))
 );
 
 #endif
