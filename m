Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201FC4708E
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  6 Dec 2022 13:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLFN7I (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 6 Dec 2022 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiLFN7H (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:59:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088F3B1;
        Tue,  6 Dec 2022 05:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8C80B81A2A;
        Tue,  6 Dec 2022 13:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80107C433D6;
        Tue,  6 Dec 2022 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670335142;
        bh=VDzhCJWwDi42yIU8wX9s6FDaCsj2cR52cmWWQVk6+ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NzFTt3Y5MSxjSOwpRTT+gmxxpaH4Vc4mNwtCpVn7T68PK9pMGoR3lqeTMDx9r468e
         NDxWFba0j662CtJYrez2VGo1DpGEce8frSBwpLXlPFXvfwFfBhRP16VPzX3t6OZgGT
         sVu7lcpxT355qhmsLGFk1uFX93CL4SdmIyMXiOJ+AaAaOieuux2roDs2EGV+DkjAY3
         3K1+AkKbS6Ec5L6Z5j6rrGCY21x46IcFhjbIvgNCCb3xAsLokUkhlyQr3tqueGZRki
         4OwYuQ/n6kJ3TDWWT9EqCqCs+LLKFBiwQ/L5OAmdyTkNbcvEF3eA0t6MVQrcBna+6W
         V/WcEVECGZ3SA==
Date:   Tue, 6 Dec 2022 22:58:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Fix some checker warnings
Message-Id: <20221206225859.de7c2f68e9e50a65ac7c7c30@kernel.org>
In-Reply-To: <998783.1670333070@warthog.procyon.org.uk>
References: <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org>
        <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
        <998783.1670333070@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:24:30 +0000
David Howells <dhowells@redhat.com> wrote:

> Is there a tracing tree this can go through?
> 

Yes, you can find it in MAINTAINERS file.
We are using git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

Thank you,

> David
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
