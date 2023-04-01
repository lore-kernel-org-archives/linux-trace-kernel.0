Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F196C76196
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  1 Apr 2023 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDAWES (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 1 Apr 2023 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAWES (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:04:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECEE26275;
        Sat,  1 Apr 2023 15:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A11B80D95;
        Sat,  1 Apr 2023 22:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB5C433EF;
        Sat,  1 Apr 2023 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680386653;
        bh=CLqLBHeDg33hin5CXQIorMaJsFgSptjcHpMkJE5afS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uWR7Dec1ppg9NOxS2uvSf3ASZ3Az+Zc8atwKZAtBua7kumMcc+zPBU642v1S3lt/s
         5yzwq9ZMPJSjw1PvgdLLEEDqvXwR94gaGBn7IMGZVU6DEkiIL432czlu/pEUzg6UEN
         mFyIuEJCqmRulgoTPayIg3P5nR1CwXopgBaKGvku8peL6K3aisounVrfxeAvP1fhDG
         ct9BTYPMW5s4P3ov78EmtLgQgkYqa2Mut3QPjRoXhZsrmDATx+FhP/oYbu9CMabPzp
         Tnslc5ZJ3p18LyW3KfEELqS8AScZfiQPzJ635WolKcn0AAT/0tmyHsejrUdVk5ZbZJ
         XCGcQ/w4bEzdA==
Date:   Sun, 2 Apr 2023 07:04:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 8/8] selftests/ftrace: Add funcgraph-retval test
 case
Message-Id: <20230402070406.177f09cc34f9860baf3e6ec2@kernel.org>
In-Reply-To: <ba23c2429f1ef798946ce65e21c7a7a2bff0019e.1680265828.git.pengdonglin@sangfor.com.cn>
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
        <ba23c2429f1ef798946ce65e21c7a7a2bff0019e.1680265828.git.pengdonglin@sangfor.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 31 Mar 2023 05:47:44 -0700
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> Add a test case for the funcgraph-retval and funcgraph-retval-hex
> trace options.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> v10:
>  - Fix issues in selftest
> 
> v8:
>  - Fix issues in selftest
> ---
>  .../ftrace/test.d/ftrace/fgraph-retval.tc     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> new file mode 100644
> index 000000000000..5819aa2dd6ad
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function graph print function return value
> +# requires: options/funcgraph-retval options/funcgraph-retval-hex function_graph:tracer
> +
> +# Make sure that funcgraph-retval works
> +
> +fail() { # msg
> +    echo $1
> +    exit_fail
> +}
> +
> +disable_tracing
> +clear_trace
> +
> +read PID _ < /proc/self/stat

You can use "$$" for self pid.

> +[ -f set_ftrace_pid ] && echo ${PID} > set_ftrace_pid
> +[ -f set_ftrace_filter ] && echo proc_reg_write > set_ftrace_filter
> +[ -f set_graph_function ] && echo proc_reg_write > set_graph_function

You should set the required files for this test, so that the test result
is always same. BTW, you need to set either 'set_ftrace_filter' or
'set_graph_function'.

> +echo function_graph > current_tracer
> +echo funcgraph-retval > trace_options
> +
> +set +e
> +enable_tracing
> +echo > /proc/interrupts
> +disable_tracing
> +set -e
> +
> +: "Test printing the error code in signed decimal format"
> +echo nofuncgraph-retval-hex > trace_options

echo 0 > options/funcgraph-retval-hex

If you require 'options/funcgraph-retval-hex' file, you can use the
file to set it or clear it.

> +count=`cat trace | grep 'proc_reg_write' | grep '= -5' | wc -l`
> +if [ $count -eq 0 ]; then
> +    fail "Return value can not be printed in signed decimal format"
> +fi
> +
> +: "Test printing the error code in hexadecimal format"
> +echo funcgraph-retval-hex > trace_options

Ditto.

Thanks,

> +count=`cat trace | grep 'proc_reg_write' | grep 'fffffffb' | wc -l`
> +if [ $count -eq 0 ]; then
> +    fail "Return value can not be printed in hexadecimal format"
> +fi
> +
> +exit 0
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
