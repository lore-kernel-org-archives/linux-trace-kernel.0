Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E4EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 30 Jun 2023 11:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjF3LuF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 30 Jun 2023 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjF3LuD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:50:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537B3A92
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:49:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3094910b150so2030813f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688125792; x=1690717792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aV93Pj7PJNqMcvHis4EehVYWQIbC5KjF9IGBt9XYebI=;
        b=EhSKNtwyisKNX51LLM/M+VxWHL1QwCxpeLYSyJAO82zbUEbfW3j7hF+zyqrxQUoSlT
         rcqD+TLErHYlozTv2knm4OCvUd4tSgQlfO7LtUoQj8cI8IlmH8LtEVc5+CRwsAwUO34y
         kV+2Rk7ociO5c+zbPDR0Zjmc7avOCocNyzJrYuDcRp5zoQxxhKVwT3AaOH58s9VveAme
         9kf8PStDerdBF0N90DBJV7SapFcIw9QjKdsdKsOkv2kvfJU+gpm5UnEL8o+djT/t6zOw
         1RgOLd6/F3aSkNpY1s7l9TCcOt8w4O3vZcC5vZFRv/l0c0yQwqK618G6ZcRIQZ1FqDiY
         aGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125792; x=1690717792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV93Pj7PJNqMcvHis4EehVYWQIbC5KjF9IGBt9XYebI=;
        b=f5zKy3h2Ljpg4u3AOrDfq/L3ottYzmCIYjh23zZdV+5N5Zfz2nRWDgYhSZ10h3skVG
         fsKYozWIoXsqtS9nTdh3xcGBUilUtwFsLr1vzikvd457ot+GELjSXLVGuTvxi6an3meJ
         +nru5/w70I5dJMYR+tV0Pw76hdZzNGO3jz8i503UO3qxksVAPrqcFlVOdj5NZBH5CcM9
         hkkjOcq0iNrAB58f7wZQ9cobKYypvRNv18/g7lH2MOtIXIamprACbIm38kKf1fDNFV1P
         RG8d3W+aP7GOlV554YieIBBNoXISBTPkpM5WdpJVIZHRjstbR6IUdx7UWuXOdpM98wrw
         xSFQ==
X-Gm-Message-State: ABy/qLbIatuLgPMHI7oqIi05Lx3GE2KLm7zxk5vHDUyXVI5v9CPIr9Hp
        nmpOhtbbp1O92u2Ma66qK+KG7Q==
X-Google-Smtp-Source: APBJJlEpoJr7gjdrf73HXFl+g7/G3sJlnHp1EHY5GZSSFaw1ghdEDAtixlE4eveZuIKa36joGXONJQ==
X-Received: by 2002:adf:ea83:0:b0:313:fbd0:9813 with SMTP id s3-20020adfea83000000b00313fbd09813mr1900057wrm.28.1688125791847;
        Fri, 30 Jun 2023 04:49:51 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id j8-20020adfff88000000b0031412b685d2sm4628258wrr.32.2023.06.30.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:49:51 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:49:50 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Message-ID: <20230630114950.zoocytnpvdrxgnss@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
 <20230531182629.nztie5rwhjl53v3d@airbuntu>
 <20230621122513.2aa3bc0d29321197e3d38441@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621122513.2aa3bc0d29321197e3d38441@kernel.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 06/21/23 12:25, Masami Hiramatsu wrote:
> On Wed, 31 May 2023 19:26:29 +0100
> Qais Yousef <qyousef@layalina.io> wrote:
> 
> > On 05/22/23 15:57, Lukasz Luba wrote:
> > > The user-space can set uclamp value for a given task. It impacts task
> > > placement decisions made by the scheduler. This is very useful information
> > > and helps to understand the system behavior or track improvements in
> > > middleware and applications which start using uclamp mechanisms and report
> > > better performance in tests.
> > 
> > Do you mind adding a generic one instead please? And explain why we can't just
> > attach to the syscall via kprobes? I think you want to bypass the permission
> > checks, so maybe a generic tracepoint after that might be justifiable?
> 
> Could you tell me more about this point? I would like to know what kind of
> permission checks can be bypassed with tracepoints.

Sorry bad usage of English from my end.

The syscall can fail if the caller doesn't have permission to change the
attribute (some of them are protected with CAP_NICE) or if the boundary check
fails. The desire here is to emit a tracepoint() when the user successfully
changes an attribute of a task.

Lukasz would like to have this tracepoint to help debug and analyse workloads.
We are not really bypassing anything. So to rephrase, emit the tracepointn if
the syscall is successfully changing an attribute.

> 
> > Then anyone can use it to track how userspace has changed any attributes for
> > a task, not just uclamp.
> 
> I guess Uclamp is not controlled by syscall but from kernel internal
> sched_setattr/setscheduler() too. Anyway I agree that it can be more generic
> tracepoint, something like trace_sched_set_scheduer(task, attr).

Yes. Which is something worries me and I had a series in the past to hide it.
The uclamp range is abstracted and has no meaning in general and should be set
specifically to each system. e.g: 512 means half the system performance level,
but if the system is over powered this could be too fast, and if it's
underpowered it could be too slow. It must be set by userspace; though not sure
if kernel threads need to manage their performance level how this can be
achieved.


Thanks!

--
Qais Yousef
