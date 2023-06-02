Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6FC77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  2 Jun 2023 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjFBLQW (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 2 Jun 2023 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFBLQV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F475133
        for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685704533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=imQ8hkrYLqR8ckCqlA+Lim20RdkOae7FAIksRB3MKCQ=;
        b=Lj4Iqpv37dBE4eLoM5bFWcviYP55erk9QemEqtd2L/WxjMvU8WqHz6OoG0WGhQLiN6sL70
        PgMOA4ObvgqVyQ5ydhLDFUbNrpuRaPUeCa38efAOowuVDIHEyJjTQr5VBGXqjn6kgx2Gws
        v7JQGc2j20HwgZG7eoJPF842dC394hA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-_UCql0wZN92QX1znFgHvLQ-1; Fri, 02 Jun 2023 07:15:32 -0400
X-MC-Unique: _UCql0wZN92QX1znFgHvLQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso10889975e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685704531; x=1688296531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imQ8hkrYLqR8ckCqlA+Lim20RdkOae7FAIksRB3MKCQ=;
        b=hdnw+owXdldiV1Hm2+GN2EyYpZhjWBvTmLZRCMu/uul8iWSSxzaBGx3n7wrfYLt5Mc
         bo86X5mj6aJZuiEruuMganKxIBris2MVVhi+w0H/1ZxLIuC+peFQGywhc5nuIf1we1lq
         8xbzyItwyqHqd4WC68U57Grt9feI+cdbCyQkvj4+OKdl16IvfVBJUMTofFNba8ZBqVs3
         60BXB2C7TxKCI7zNOjewkwdke8IrUtgWbdh9vsfofeEtjZie1c1o8+idmsY5xV4jcXNz
         RMG11y5QI5A29mCKfEGQkrSN1svbkB+cWVJUs8MR4qJxQoYKpmU1NJg07J1ZvpyrIgRG
         5Aag==
X-Gm-Message-State: AC+VfDzWxfALineg5Xvgdsj1VWjfUyjM4BeMV2SU++hRgCCGmRLp2ECF
        WrW5xRJu3b6LqBuZODbJ8rbGtU/z0WVMU1CCNE8EgjLx9J6zOCZIq+Qzo/fAK/NDj7vRTp9ux3R
        mxyGrQmg9yXiM7e+dByztBBZUWCCZc8cu
X-Received: by 2002:a7b:c841:0:b0:3f7:26f8:f9c3 with SMTP id c1-20020a7bc841000000b003f726f8f9c3mr1064701wml.5.1685704530892;
        Fri, 02 Jun 2023 04:15:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UWcaTAnKc4xQxzU4UjZxKiFiySGLh197x+LFMig+w4H4npT0uQes1m4bOREHyF9AKJ4OAiw==
X-Received: by 2002:a7b:c841:0:b0:3f7:26f8:f9c3 with SMTP id c1-20020a7bc841000000b003f726f8f9c3mr1064685wml.5.1685704530633;
        Fri, 02 Jun 2023 04:15:30 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003f423f5b659sm1630095wmc.10.2023.06.02.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:15:29 -0700 (PDT)
Date:   Fri, 2 Jun 2023 07:15:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 5/6] tools/virtio: use canonical ftrace path
Message-ID: <20230602071517-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-6-zwisler@google.com>
MIME-Version: 1.0
In-Reply-To: <20230215223350.2658616-6-zwisler@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:33:49PM -0700, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> A few spots in tools/virtio still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>

queued this too. thanks!

> ---
>  tools/virtio/virtio-trace/README        |  2 +-
>  tools/virtio/virtio-trace/trace-agent.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
> index b64845b823ab..cea29a2a4c0a 100644
> --- a/tools/virtio/virtio-trace/README
> +++ b/tools/virtio/virtio-trace/README
> @@ -95,7 +95,7 @@ Run
>  
>  1) Enable ftrace in the guest
>   <Example>
> -	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +	# echo 1 > /sys/kernel/tracing/events/sched/enable
>  
>  2) Run trace agent in the guest
>   This agent must be operated as root.
> diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
> index cdfe77c2b4c8..7e2d9bbf0b84 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -18,8 +18,9 @@
>  #define PIPE_DEF_BUFS		16
>  #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
>  #define PIPE_MAX_SIZE		(1024*1024)
> -#define READ_PATH_FMT	\
> -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> +#define TRACEFS 		"/sys/kernel/tracing"
> +#define DEBUGFS 		"/sys/kernel/debug/tracing"
> +#define READ_PATH_FMT		"%s/per_cpu/cpu%d/trace_pipe_raw"
>  #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
>  #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
>  
> @@ -120,9 +121,12 @@ static const char *make_path(int cpu_num, bool this_is_write_path)
>  	if (this_is_write_path)
>  		/* write(output) path */
>  		ret = snprintf(buf, PATH_MAX, WRITE_PATH_FMT, cpu_num);
> -	else
> +	else {
>  		/* read(input) path */
> -		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, cpu_num);
> +		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, TRACEFS, cpu_num);
> +		if (ret > 0 && access(buf, F_OK) != 0)
> +			ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, DEBUGFS, cpu_num);
> +	}
>  
>  	if (ret <= 0) {
>  		pr_err("Failed to generate %s path(CPU#%d):%d\n",
> -- 
> 2.39.1.637.g21b0678d19-goog

