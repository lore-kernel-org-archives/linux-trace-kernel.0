Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283BC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  3 Nov 2022 04:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKCEKe (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKCEKd (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662A13F2F;
        Wed,  2 Nov 2022 21:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659AC61D1F;
        Thu,  3 Nov 2022 04:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92219C433C1;
        Thu,  3 Nov 2022 04:10:31 +0000 (UTC)
Date:   Thu, 3 Nov 2022 00:10:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221103001029.1cbd7a8b@rorschach.local.home>
In-Reply-To: <e925893e-1099-777e-7485-6dc8f1f37333@huawei.com>
References: <20221103031010.166498-1-lihuafei1@huawei.com>
        <20221102232334.0c1ae93b@rorschach.local.home>
        <20221102232437.6e2b1ebd@rorschach.local.home>
        <e925893e-1099-777e-7485-6dc8f1f37333@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 3 Nov 2022 11:38:30 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> Yes. There we have the DYNAMIC check.

Yep.

I'm running it now through my tests and if everything goes well (and my
tests don't fail on someone else's bug again), I should have a pull
request ready by tomorrow.

-- Steve
