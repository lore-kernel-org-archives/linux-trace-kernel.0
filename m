Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7058C7EE2F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Jun 2023 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjFLOKn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjFLOKm (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018510D3;
        Mon, 12 Jun 2023 07:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D3E629A6;
        Mon, 12 Jun 2023 14:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C126AC4339B;
        Mon, 12 Jun 2023 14:10:38 +0000 (UTC)
Date:   Mon, 12 Jun 2023 10:10:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftace: Fix KTAP output ordering
Message-ID: <20230612101036.2c20c86d@gandalf.local.home>
In-Reply-To: <20230612143316.1851a0fd7a49971f1b2209bf@kernel.org>
References: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
        <20230612143316.1851a0fd7a49971f1b2209bf@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, could you pick this?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
