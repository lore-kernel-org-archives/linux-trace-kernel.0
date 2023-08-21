Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6AEE4996
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjHUOEq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHUOEq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:04:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4410C;
        Mon, 21 Aug 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bzEiVHOrHwxgsH8/5d+D3ydaDZ0OK3YDR9Ve+FNnxZ4=; b=cQThuChSXi+tbLGRq9JRmAluiS
        TlhpyQ5ZOKEhOcSd9FzGErQw9EU/k53vGl7PL1t7LTdEtUm59bh1sBZ84lCaaZmhivFWpgASW+T5G
        eWjtXfrKQ13nD/1mlIRN9wev0NcLeJfCRfXnKbUd3w0Ltu3VB+o+3FROIU4ACFqvNGDS7DWN99wQb
        IAHCG2VHukeq7B846FW9GP207/Ibdt1kB1pQMjueJBeIAL4jLvypBDil7rklkVS4g47G56z4MPipL
        qnIiqVMc5UXa+y9Z1VxG9TUnwTGANeNcDk1lfPdhXLHf6n/2G7LS/QqTvNi9CpR/C4w3vPEDnbd71
        LKdTQYMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5W7-00Ab04-QU; Mon, 21 Aug 2023 14:04:27 +0000
Date:   Mon, 21 Aug 2023 15:04:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: Re: [PATCH] tracefs: Fix kernel-doc warnings
Message-ID: <ZONu6+WAjUXNKn7l@casper.infradead.org>
References: <20230818201414.2729745-1-willy@infradead.org>
 <20230821100146.5379a9c2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821100146.5379a9c2@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:01:46AM -0400, Steven Rostedt wrote:
> This is one of the cases I disagree with kerneldoc. I mean, this isn't a
> public structure (it's only in this file) so I don't expect it to be
> parsed. These three fields act as one. Having them in the kerneldoc format
> above makes them look as three distinct fields. Perhaps the solution is to
> get rid of the starting /** so that it's no longer in kerneldoc format.

Yes, take it out of kernel-doc's purview by removing that second *.
I don't think you need me to send a v2 patch to do that ;-)
