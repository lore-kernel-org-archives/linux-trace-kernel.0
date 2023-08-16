Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A7C04A6A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 16 Aug 2023 05:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbjHPFfX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 16 Aug 2023 01:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjHPFex (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5813AB
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A41A63402
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201DC433C7;
        Wed, 16 Aug 2023 05:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692164091;
        bh=OhS7YL8wJvLlVva414pOvrBnJ1zjzJHi57yOBU6+PtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Go0zXOc3Y9b/nhjkhAy3FQZL5z8yNuliXQOE4Z9gsLxjmbB6Uc6AYN3TUsMhTeBlj
         PJnSSrJDyalBUCOI0lvCK4+EgDPq36Zy6STtHRv7yRXu80ZkEEUachTlZpoD6YVtmR
         CJXc4aptFzN9HM0+eLQz+RIadxvcgsaZ0cU9wnvWcBMaesSIQmPagf5w+6U4F9El2a
         qfVaC5yolDAbLNbixfK5N5qzxCPT/jOEpcsdav0w1V9IaXhH5Vf7ayuGBBVn2jgRdW
         wC5hO9R6AiuZW5PDBGjvMBkdEYSvD3oRA7c2dk/3fupdf6jfoFGFVXF7Sx0lUmx2SY
         re2GgC9m3q/Yg==
Date:   Wed, 16 Aug 2023 14:34:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <shuah@kernel.org>, <liwei391@huawei.com>
Subject: Re: [PATCH -next 1/2] selftests/ftrace: add loongarch support for
 kprobe args char tests
Message-Id: <20230816143447.388a24617849383bc84b0e18@kernel.org>
In-Reply-To: <20230815085912.701356-2-liaoyu15@huawei.com>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
        <20230815085912.701356-2-liaoyu15@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 15 Aug 2023 16:59:11 +0800
Yu Liao <liaoyu15@huawei.com> wrote:

> Add loongarch support for the recently added kprobe args tests.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index 285b4770efad..3047fa96a7b7 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -28,6 +28,9 @@ s390*)
>  mips*)
>    ARG1=%r4
>  ;;
> +loongarch*)
> +  ARG1=%r4
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
