Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F47C76195
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 27 Mar 2023 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC0UlL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0UlK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C310D1;
        Mon, 27 Mar 2023 13:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A2B614B0;
        Mon, 27 Mar 2023 20:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE63C433EF;
        Mon, 27 Mar 2023 20:41:07 +0000 (UTC)
Date:   Mon, 27 Mar 2023 16:41:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Improve integration with kselftest
 runner
Message-ID: <20230327164106.0d1270db@gandalf.local.home>
In-Reply-To: <1e2b5a9e-9e92-6394-74fd-18dae2ed0712@linuxfoundation.org>
References: <20230302-ftrace-kselftest-ktap-v1-1-a84a0765b7ad@kernel.org>
        <20230319232438.786c46feaf9bb7ddcb78a731@kernel.org>
        <1e2b5a9e-9e92-6394-74fd-18dae2ed0712@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 27 Mar 2023 13:43:15 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Steve,
> 
> Okay to pick this up for the Linux 6.4?

Fine by me.

Thanks Shuah.

-- Steve
