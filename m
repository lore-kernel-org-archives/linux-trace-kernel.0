Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D7C41513
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 16 Aug 2023 05:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbjHPFfY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 16 Aug 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbjHPFfJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD91FCE
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBBF63402
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E69C433C7;
        Wed, 16 Aug 2023 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692164107;
        bh=pywADE9V9RuzzhabnvQtmLP+BQjt0y4dPE2qHzApEb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhn2QjehdqPYF5CK7BRpIB7XCCekCHsqA3iyK8heoXtu5bHW3KzU5G9nbin0t0/RJ
         kyu1pU7nm748+JD0Z9hC1vir7kRGASztojNwUFNkdMWIb7hDV5/0tqWGkjy6Ar87iA
         nsAkY5/PNluHnckMG8AYJpkZlYkivi/w4LxHetgfMRdW568lkHPvnsHWIWsIhFpJI6
         wmnQxTrbTlM3EC+9jxKKCM79ptIT34TV3Ll5BkwsNhezNmdtgm5ZBS5l2w5koeCb/a
         kmnI+xwWt5aPOjWYwTGbFmMtbJHDji4+zIr7nzDjHY3gOTUrtsmncRvLjHKmdfk+tX
         ZyWY8pzlAIxLw==
Date:   Wed, 16 Aug 2023 14:35:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <shuah@kernel.org>, <liwei391@huawei.com>
Subject: Re: [PATCH -next 2/2] selftests/ftrace: Add riscv support for
 kprobe arg tests
Message-Id: <20230816143503.72253dc8339df90328869fea@kernel.org>
In-Reply-To: <20230815085912.701356-3-liaoyu15@huawei.com>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
        <20230815085912.701356-3-liaoyu15@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 15 Aug 2023 16:59:12 +0800
Yu Liao <liaoyu15@huawei.com> wrote:

> This is the riscv variant of commit 9855c4626c67 ("selftests/ftrace:
> Add ppc support for kprobe args tests").

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 3 +++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 3 +++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index 3047fa96a7b7..3462c06d29b0 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -31,6 +31,9 @@ mips*)
>  loongarch*)
>    ARG1=%r4
>  ;;
> +riscv*)
> +  ARG1=%a0
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index a4f8e7c53c1f..9bfd2e488cea 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -31,6 +31,9 @@ mips*)
>  loongarch*)
>    ARG1=%r4
>  ;;
> +riscv*)
> +  ARG1=%a0
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> index 1df61e13a812..8f1292ad80ff 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> @@ -44,6 +44,10 @@ loongarch*)
>    GOODREG=%r4
>    BADREG=%r12
>  ;;
> +riscv*)
> +  GOODREG=%a0
> +  BADREG=%a8
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
