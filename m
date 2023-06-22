Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D35DEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 22 Jun 2023 20:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFVUYK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVUYJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:24:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 771E11995;
        Thu, 22 Jun 2023 13:24:08 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.126])
        by linux.microsoft.com (Postfix) with ESMTPSA id D977D21C20AC;
        Thu, 22 Jun 2023 13:24:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D977D21C20AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687465447;
        bh=NeibX9LIwGoST56KfbPrH75vbGuqTfTOqKUoB4hTpMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DI2JGIz9a/qU9E87TuQ7pUS/EMJIpyly9QeqGdxNYxG19k3qzkV2HOCxz/+Sj+X1H
         TGW0QTXwwP+vT8yfuyDQ8fVmwFFLtTxIFi55fn/GWiLvrL82soBH4NcOD2hsDc37wb
         LTnqsryiV6/GEj7jgVWdOCmdsTFkr0ppoiU/CCx4=
Date:   Thu, 22 Jun 2023 20:24:02 +0000
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, kelulanainsley@gmail.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] selftests/user_events: Enable the event before
 write_fault test in ftrace self-test
Message-ID: <ZJSt4nDATIm9r8WR@CPC-beaub-VBQ1L.localdomain>
References: <20230621063438.154271-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621063438.154271-1-sunliming@kylinos.cn>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:34:38PM +0800, sunliming wrote:
> The user_event has not be enabled in write_fault test in ftrace
> self-test, Just enable it.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Good catch.

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks!

> ---
>  tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index abfb49558a26..d33bd31425db 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -373,6 +373,10 @@ TEST_F(user, write_fault) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
> +	/* Enable event */
> +	self->enable_fd = open(enable_file, O_RDWR);
> +	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
> +
>  	/* Write should work normally */
>  	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
>  
> -- 
> 2.25.1
