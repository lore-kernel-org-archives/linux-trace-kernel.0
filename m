Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1929C7618B
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 13 Mar 2023 21:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCMVCo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCMVCX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:02:23 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8A8DCD3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:01:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 4so7617688ilz.6
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678741262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMqHKIxdMm3dM36ZLNxuSyWdPqYMqCbdnka0e38R2kM=;
        b=c+0asUhDcFxvzmeYtT2auKKyxNLrgNCi6dE4O/tx//l/IKbOqKfeoftNrRcgbIcL9R
         NAL5griM8C+v/lG3dIjAQbKVOfySlooiREFyHsCUjxu8HJlPI8+w6v0Qo+U9fejU4ZYK
         wowsUavw0Rr3ZNlRvFLD4XUBsojd/a4k/Vh0PWPmWbJ4wgP8H4DdDvz9lOPKU84tRSfL
         iH2hesvAiT8v+K7U1uqCjCGOumYawoE0UkLuYpysS2oFbwdQimrUR8UlDN88JFJJabG/
         NShFGd+m5Q1QqHpOiesB/J9JtKtxmdHgIzGZ6uk3FEFmDrQF4BH1i3hhIv3k5ba8C6hB
         TC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMqHKIxdMm3dM36ZLNxuSyWdPqYMqCbdnka0e38R2kM=;
        b=fkPgQMqEjCUWUHUPKgZMNpHKv1876a5GwOU5MAOlYAI0gSK7JYGbH5n4kwASF9Quo7
         RMq1QS+Uw/ub7vwwq2zv11K4qQZTARr65ZiCVYyy5pP2xoebbHzVvUaX+l14GycFYpNg
         5mbsZ5VTdoIs7xHuljqjramK1waB8ahNi/Da+hejE5PmiVxzS7g9PUaWellgkGMVJO/z
         f7rcVFEYq9QPMZr0Qhgv5di0W+AXnVjhoX28Ih76+NwYgckFAheBvMC3LMTNOmtAKHvI
         R04sEr0ySBw0sq1Q3aTFN1ReOejMI/Pcg6z8sgy3sn07zi+Lzpg9UYE1OrJ8jcDCGCBp
         cGww==
X-Gm-Message-State: AO0yUKX6bHy8sQqF1G9DJU/zetKsp/1yxbQo6L73bWqy2KHIQHd8nuwH
        OXHJjbK7yQxoLhswzQGwWPPWGQ==
X-Google-Smtp-Source: AK7set87hROC3DrRy/WHpgTl+q0g7aJEMwmTNpv2ADoDCdSubwZnPqmWHhNg4NYrayS39Mj3cpUa+Q==
X-Received: by 2002:a92:7302:0:b0:315:6fc5:ea46 with SMTP id o2-20020a927302000000b003156fc5ea46mr746590ilc.2.1678741261504;
        Mon, 13 Mar 2023 14:01:01 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:a33c:9b70:2c95:9544])
        by smtp.gmail.com with ESMTPSA id e12-20020a02a78c000000b004046f72271esm32031jaj.100.2023.03.13.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:01:01 -0700 (PDT)
Date:   Mon, 13 Mar 2023 15:00:57 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/2] use canonical ftrace path whenever
 possible
Message-ID: <20230313210057.GB592900@google.com>
References: <20230310192050.4096886-1-zwisler@kernel.org>
 <20230313205628.1058720-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313205628.1058720-1-zwisler@kernel.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:56:26PM -0600, Ross Zwisler wrote:
> From: Ross Zwisler <zwisler@google.com>
> 
> v3 here:
> https://lore.kernel.org/all/20230310192050.4096886-1-zwisler@kernel.org/

Sorry, this should have been:
https://lore.kernel.org/all/20230310175209.2130880-1-zwisler@kernel.org/

> 
> Changes since v3:
>  * Added braces around a few multi-line if/else statements (Steven Rostedt)
>  * Added Reviewed-by from Steven to patch 1
>  * Rebased onto the current bpf/bpf-next
> 
> Ross Zwisler (2):
>   bpf: use canonical ftrace path
>   selftests/bpf: use canonical ftrace path
> 
>  include/uapi/linux/bpf.h                            |  8 ++++----
>  samples/bpf/cpustat_kern.c                          |  4 ++--
>  samples/bpf/hbm.c                                   |  4 ++--
>  samples/bpf/ibumad_kern.c                           |  4 ++--
>  samples/bpf/lwt_len_hist.sh                         |  2 +-
>  samples/bpf/offwaketime_kern.c                      |  2 +-
>  samples/bpf/task_fd_query_user.c                    |  4 ++--
>  samples/bpf/test_lwt_bpf.sh                         |  2 +-
>  samples/bpf/test_overhead_tp.bpf.c                  |  4 ++--
>  tools/include/uapi/linux/bpf.h                      |  8 ++++----
>  tools/testing/selftests/bpf/get_cgroup_id_user.c    |  9 +++++++--
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c    |  7 ++++++-
>  .../selftests/bpf/prog_tests/task_fd_query_tp.c     |  9 +++++++--
>  .../selftests/bpf/prog_tests/tp_attach_query.c      |  9 +++++++--
>  .../testing/selftests/bpf/prog_tests/trace_printk.c | 10 +++++++---
>  .../selftests/bpf/prog_tests/trace_vprintk.c        | 10 +++++++---
>  .../selftests/bpf/progs/test_stacktrace_map.c       |  2 +-
>  tools/testing/selftests/bpf/progs/test_tracepoint.c |  2 +-
>  tools/testing/selftests/bpf/test_ftrace.sh          |  7 ++++++-
>  tools/testing/selftests/bpf/test_tunnel.sh          | 13 +++++++++----
>  tools/testing/selftests/bpf/trace_helpers.c         |  8 ++++++--
>  21 files changed, 85 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 22df776a9a866713d9decfb92b633bcfdb571954
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
