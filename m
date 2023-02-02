Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD5C05027
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Feb 2023 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBPWi (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBBPWh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:22:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC966EFA;
        Thu,  2 Feb 2023 07:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D265461BDF;
        Thu,  2 Feb 2023 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F2DC433D2;
        Thu,  2 Feb 2023 15:22:33 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:22:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        jpoimboe@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: ftrace: Include the nospec-branch.h only for
 x86
Message-ID: <20230202102220.05fe0d0e@rorschach.local.home>
In-Reply-To: <CAAYs2=jq9j9j-Qa+fexfDX_e=pETfL5j1-n4iy5=0CgDKrYukg@mail.gmail.com>
References: <20230130085954.647845-1-suagrfillet@gmail.com>
        <CAAYs2=jq9j9j-Qa+fexfDX_e=pETfL5j1-n4iy5=0CgDKrYukg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2 Feb 2023 10:19:46 +0000
Song Shuai <suagrfillet@gmail.com> wrote:

> Ping...

Note, the "ping reminder" etiquette is a minimum of a week. Not 3 days.

-- Steve
