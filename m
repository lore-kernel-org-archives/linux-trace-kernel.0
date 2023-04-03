Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C19C761A6
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  3 Apr 2023 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjDCNqO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjDCNqN (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:46:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306E30CB
        for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:46:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so19881415wmq.4
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680529570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipyyxvh6f+ZHMWP9Nn0bjv9iTMDMZAlb6ODNq87FtNY=;
        b=VTIWZtQNbFNrMac9/hSFQZea9NFP0EMagHa7wXagrc7rvE54YSQwDUW/OG/U/uoCUV
         mzpSJinkCxQ6HpzIRPsvAH6u04SPcIARTMJT7hMVsWY04pQtds0fXX33AWrechjh1iIi
         cWAhcCs2mx5zlegkjDBf+4Oecv/jGEJAd7L07qbP9TPIiw1akEROmc+JHL7xkF4Lz/Wn
         WBU0QHbLY0aHbyxMpSxE6Zj3saUQ68fJ9RgONoxiDQBSWtZdFaf1GeY0zCtUMMZWwpnO
         D1TheXglbETx2VQE5PPrPUfzys0XPdV5Cb8TxjftZsA+i7G6II1PZRAHQBYrN639HIBl
         zbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipyyxvh6f+ZHMWP9Nn0bjv9iTMDMZAlb6ODNq87FtNY=;
        b=Qv+kG79z3ZDGPlLW5rTj83L7MkMyYUGxQhLML0nelTTIc4NT5NcWCKCjGaijw3pkBw
         ZkAWQTp46cpwfu0FYpoaBv4L8/q1hFdTIuT8Jecy9FhldaL7/veujlMds9lrppankFom
         va/tMywRsSUJPUyYkOZJDVtSNfILmKAqeZq1NsfX+jhO6cuSlva1ADT+8UFPq04GKOfY
         Bgm5I/dGQw6j9d64PhdxzP7oTgUr4/5CrxjmNgPtsljRgutFoPQZdGuN1VG76N37poER
         XLxPntJgOsXv2+tgQdviz/MbqwF4J9lC548+F6DIsNyFSH+UnkdV4yd0BsrNtPRPJsMx
         V1Xg==
X-Gm-Message-State: AAQBX9cd+CmOe51KWl8w/X2VUjuTedGiQxgpEuIY7rO7iXZv6RwexI5W
        +qUa2wileWz0w8dPdHYZrc5CzQ==
X-Google-Smtp-Source: AKy350YV7RRggR1HFegPWTmInSD2qSH9zVEWpDlIsw+lqFclPHpabjPW18cz3QyjaTb+dLQkP8JJPQ==
X-Received: by 2002:a05:600c:2198:b0:3ef:61f6:d7be with SMTP id e24-20020a05600c219800b003ef61f6d7bemr22880445wme.35.1680529569691;
        Mon, 03 Apr 2023 06:46:09 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b003ee9c8cc631sm18957935wmb.23.2023.04.03.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:46:09 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:46:06 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [PATCH 1/3] sched/tp: Add new tracepoint to track uclamp set
 from user-space
Message-ID: <20230403134606.amdxfmr5fb544xnv@airbuntu>
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151843.14390-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Lukasz!

On 03/22/23 15:18, Lukasz Luba wrote:
> The user-space can set uclamp value for a given task. It impacts task
> placement decisions made by the scheduler. This is very useful information
> and helps to understand the system behavior or track improvements in
> middleware and applications which start using uclamp mechanisms and report
> better performance in tests.

We do have uclamp trace events in sched_tp, why are they not sufficient?

	https://github.com/qais-yousef/sched_tp/blob/main/sched_events.h#L233

Do you really want to know the exact time the value has changed?

Would it make sense to introduce a generic sched_setscheduler tracepoint
instead? Although this might not be necessary as I think we can use
register_kprobe() to register a callback and create a new event without any
additional tracepoint. sched_setscheduler() is not inlined so should be easy to
hook into and create events, no?


Thanks

--
Qais Yousef

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/sched.h | 4 ++++
>  kernel/sched/core.c          | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..dbfb30809f15 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>  	TP_PROTO(struct rq *rq, int change),
>  	TP_ARGS(rq, change));
>  
> +DECLARE_TRACE(uclamp_update_tsk_tp,
> +	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
> +	TP_ARGS(tsk, uclamp_id, value));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 488655f2319f..882c92e3ccf0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> @@ -1936,12 +1937,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	    attr->sched_util_min != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MIN,
> +					   attr->sched_util_min);
>  	}
>  
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
>  	    attr->sched_util_max != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>  			      attr->sched_util_max, true);
> +		trace_uclamp_update_tsk_tp(p, UCLAMP_MAX,
> +					   attr->sched_util_max);
>  	}
>  }
>  
> -- 
> 2.17.1
> 
