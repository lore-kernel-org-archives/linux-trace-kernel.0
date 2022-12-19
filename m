Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE467C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 19 Dec 2022 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiLSU53 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiLSU5Z (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:57:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D18DF78
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:24 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o8so4035917ilq.6
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHLoLmIiSoPJZR4YAxyoxo6homLq85o/pXatGwtOBd4=;
        b=M5IvWyti2zneCdkihUCbhFIXnDGpDURNdh8G/pL8UOONPP0dpLk1YETOXcgQIif9ZW
         Iz3kYjieWW69i7MLTSxbSqvsbTfeoxTLPrjS9/RWd6rtn2bMANtZMWpBpPAmh4SEbt+Y
         eEwigiKbpnSeXluNX5eIPfyGXFWs1luPa4IKI8SufRfSZRYcSQbysLRRyL2oVHXoXGFp
         lJQ3XLTawpGMvNhdKZPqaIlbGYocFgYVRPngsJXxrc7uN0xsyK7BrUmK8KR59U0Rp5N8
         uMi5V412Rqgp7t7GkDWE2gZpxd1FZ4DrMlYBUxiPCxKSWJD3XOwLgve+7ljuezEbnxAJ
         MWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHLoLmIiSoPJZR4YAxyoxo6homLq85o/pXatGwtOBd4=;
        b=prI8/sopiHJMq4xAyP83kcpcLUIwqxiB3PHZrztbSxAop8uopEd+tpJnpQvi4D/bRi
         rRV5WgqCHZzfkGTNmRBlIKtkLA0WPGEzixyuVL1Rr9Z9ZXp7UPXt+iYPzAwPam+bBaof
         AZ2GzIchOE3TlHsLhajGFGZDlahU08QgzsZ7a9i8Je4p93TM8/itZvJRcqi5o5wY9P0T
         616Ji+GQke5Xonp7ZiFtgyvTXVcST0hRZKihWVWT6Gd5NmKEaSgGhpuRZMx+AnaOL0xq
         DyJpyTZJkDEM0i3c4TtaiQgqIHAEdlFl/ybNhyR7aQ4ztHuUZcZ3MmUC45v4bA5aKm6f
         aR4g==
X-Gm-Message-State: AFqh2kpL+3SAxMG1Rbq1jckVCz9rEFgbdiR2S0OFoucgsBCXynqfwYgF
        XB0+ISx2iNM9/n86lfSsO4ICHw==
X-Google-Smtp-Source: AMrXdXuDDYR+DHPnYc6sGD78qAsLbyttwkWPBjanNGn40a8uT3LNC2mXQyhlFqcHpqZJ3pL9mxe8+w==
X-Received: by 2002:a05:6e02:512:b0:302:c07e:49f8 with SMTP id d18-20020a056e02051200b00302c07e49f8mr7541450ils.32.1671483443381;
        Mon, 19 Dec 2022 12:57:23 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6550:fd9a:e118:25dc])
        by smtp.gmail.com with ESMTPSA id v25-20020a02b919000000b0038a5af5e831sm3965386jan.100.2022.12.19.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:57:22 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:57:18 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [PATCH 1/2] tracing: Add a way to filter function addresses to
 function names
Message-ID: <Y6DQLgVYHedPB+F+@google.com>
References: <20221219183106.518341498@goodmis.org>
 <20221219183213.916833763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219183213.916833763@goodmis.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:31:07PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There's been several times where an event records a function address in
> its field and I needed to filter on that address for a specific function
> name. It required looking up the function in kallsyms, finding its size,
> and doing a compare of "field >= function_start && field < function_end".
> 
> But this would change from boot to boot and is unreliable in scripts.
> Also, it is useful to have this at boot up, where the addresses will not
> be known. For example, on the boot command line:
> 
>   trace_trigger="initcall_finish.traceoff if func.function == acpi_init"
> 
> To implement this, add a ".function" prefix, that will check that the
> field is of size long, and the only operations allowed (so far) are "=="
> and "!=".
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>
