Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2119EE4993
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 22 Aug 2023 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjHVONb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHVONb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A610F7
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA34D633AF
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73039C433C7;
        Tue, 22 Aug 2023 14:12:05 +0000 (UTC)
Date:   Tue, 22 Aug 2023 10:11:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <bristot@kernel.org>
Subject: Re: [PATCH -next] rv/include: set variable 'da_mon_##name' to
 static
Message-ID: <20230822101153.18e89373@rorschach.local.home>
In-Reply-To: <20230809040937.1011766-1-liaoyu15@huawei.com>
References: <20230809040937.1011766-1-liaoyu15@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 9 Aug 2023 12:09:37 +0800
Yu Liao <liaoyu15@huawei.com> wrote:

> @@ -262,7 +262,7 @@ static inline void da_monitor_destroy_##name(void)						\
>  /*												\
>   * per-cpu monitor variables									\
>   */												\
> -DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
> +static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\

You need to fix the backslash when you add text.

-- Steve

>  												\
>  /*												\
