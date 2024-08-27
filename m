Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3071C3F2C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782985; cv=none; b=sdiBScskgEtEPwAvs7fSfpkRFfEIKBosAbrSoZv0c3hgjJDJP61gbFul9V8gOg844Ej8iRuKj8ayR6/JCCp94Z/HuVH/lo8YrpxjYmfyCVUV7+JTkufV/L3L0XEUqYdICQKPpYr3LEL0rFUExcn3rr2qJtqG56yknW3pZMkOggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782985; c=relaxed/simple;
	bh=ZoI1uGoxZXd8i/fSJfnEN5o7VWbDeLjwVL47Y8XhO/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtKInWuh8O9y/Xhf7+8y2Yvemw8HjQMkaFmljyPxJpc6M3tCTtW2tv7KAnPmmfNgNB/XGRwB5nkhNenWzcyT1L89nHibwFl1OG0tSbFDb6F1E81jIKVcMWG/DdYQboAUZELYt2CMVWJaK/56mm5aGJPykHJ0bll1l+9eo9/g5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1CDZ/54; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1CDZ/54"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-273c8514254so4212300fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724782982; x=1725387782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fY9rWpl0h33IonEPQe2iYhBnJ7HZgDti+YOkKoclRs4=;
        b=q1CDZ/54HU4755F+4g8p8ICfIHOKK0MVjcQD5mnJGyzllvYvEw2rtM0JC5A6CqHysw
         7xOovwDe8Wg5vhNiBmdYppQ75vwnPXh7ysJ2Xq1UMeAKWM7HyAe0WHHLcBIad5ndSe5+
         9wVKF0X+pWW6b1Rq8ShgKpGttPm487yGZzgljelbw//SbIPtRKsQ/f5tsBnyAGWoAYSg
         GUGW6QRaYXgUkzLkZkUHWK8os9TkPI7l9dlIQnSbhO/Ofm7JQwZV8n4Oo2Eb1jHHOjQ7
         jaPdQZgJmy5Webpyldv3uPzHCXwxAh+MjhLZfz6WRtcfCkR5PHnTGnesNSmbh2AqLwAB
         8Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782982; x=1725387782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY9rWpl0h33IonEPQe2iYhBnJ7HZgDti+YOkKoclRs4=;
        b=VMLwwQwOcXbZvpSuLwiRxc7fZm+ba47tbOXlgbQE0E5agzEWxOMlUhV/r7xAA8EZWo
         dhL8gJQNzLrAlXs3ixFc/W80CBfeURW9gSWXBenw9AyWw88ae/N1RVAPOb4lsJ+VYFjI
         ShkpHbdcCrDp7dwcmXX/VnBrbJKu6xx7bVMaiQzWaaa3nGB8IGXWfigycRsVp8y4SZp5
         MRVVr6Pc9VYtFd7+rR5rlALw2ltEzeXjFr8HALdPPCmSzLSphtL4l55P+ozicYqr1uZ/
         auXx0LG6eNYllLFxfRfPYr53Fh/56LooWGmQcQQHftP1bi3CoKDc90hWm3CxKOi7WTUw
         Tmwg==
X-Forwarded-Encrypted: i=1; AJvYcCXkxTjlvc9bqnxGTUfeTYLvYpLmYy10GP1WhUGD6eEy0pZVv8dzVaVogznGAqQWYuVz0vhaU3f3eTIKO8Kev7V0ZI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPa9NTDi3oe+NWDfHPEl5qdYA72ezogXhSwRvi5mdb44OJflz
	LjN3q2DirC/qBUu1GLbQcSKK5RISrcj1J1QpqKVY4ooSPWb188P1FK6qUbu1ig==
X-Google-Smtp-Source: AGHT+IFtoDveiYtYqGjhZKND24rw7GMBLImHCgzxN4thzQQB0OGBHB7MhgZXIykVCbrxyQaQSyQ1Wg==
X-Received: by 2002:a05:6870:c088:b0:25e:1659:5eec with SMTP id 586e51a60fabf-273e675e82bmr14252723fac.51.1724782982020;
        Tue, 27 Aug 2024 11:23:02 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273cea29e2csm3228885fac.32.2024.08.27.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:23:01 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:22:56 -0700
From: Justin Stitt <justinstitt@google.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Replace strncpy() with strscpy() when copying
 comm
Message-ID: <fcwq7rfpbd6zmjvw4cq562ej4sohp2avdehe37yldmiioj6oa6@ovznbkpnocro>
References: <20240731075058.617588-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731075058.617588-1-ruanjinjie@huawei.com>

Hi,

On Wed, Jul 31, 2024 at 03:50:58PM GMT, Jinjie Ruan wrote:
> Replace the depreciated[1] strncpy() calls with strscpy()
> when copying comm.
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  kernel/trace/trace.c              | 2 +-
>  kernel/trace/trace_events_hist.c  | 4 ++--
>  kernel/trace/trace_sched_switch.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d0af984a5337..73cfdc704eec 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  	max_data->critical_start = data->critical_start;
>  	max_data->critical_end = data->critical_end;
>  
> -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
> +	strscpy(max_data->comm, tsk->comm);
>  	max_data->pid = tsk->pid;
>  	/*
>  	 * If tsk == current, then use current_uid(), as that does not use
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 6ece1308d36a..4ee0e64719fa 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
>  		return;
>  	}
>  
> -	strncpy(comm, task->comm, TASK_COMM_LEN);
> +	strscpy(comm, task->comm);
>  }
>  
>  static void hist_elt_data_free(struct hist_elt_data *elt_data)
> @@ -3405,7 +3405,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
>  	elt_data = context->elt->private_data;
>  	track_elt_data = track_data->elt.private_data;
>  	if (elt_data->comm)
> -		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
> +		strscpy(track_elt_data->comm, elt_data->comm);
>  
>  	track_data->updated = true;
>  
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index 8a407adb0e1c..573b5d8e8a28 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -187,7 +187,7 @@ static inline char *get_saved_cmdlines(int idx)
>  
>  static inline void set_cmdline(int idx, const char *cmdline)
>  {
> -	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
> +	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
>  }
>  
>  static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
> -- 
> 2.34.1
> 

Thanks
Justin
