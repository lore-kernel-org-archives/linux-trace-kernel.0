Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C73EE4993
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 22 Aug 2023 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHVOJM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjHVOJM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE410E3;
        Tue, 22 Aug 2023 07:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9826C657C8;
        Tue, 22 Aug 2023 14:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F7C433C7;
        Tue, 22 Aug 2023 14:07:31 +0000 (UTC)
Date:   Tue, 22 Aug 2023 10:07:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-ID: <20230822100716.2dd867e0@rorschach.local.home>
In-Reply-To: <20230822000939.81897c0c904934bfb9156a59@kernel.org>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
        <20230822000939.81897c0c904934bfb9156a59@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 22 Aug 2023 00:09:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Can you review this series?
> I would like to push this to for-next.
> 

I skimmed the patches and played a little with it, but as I've just
started my vacation I will not be able to do a full review before the
next merge window. But I don't want me to be the cause of you not
getting it in.

Feel free to add:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

to the entire series. I'm sure I'll be playing with it after it gets
in, and we can fix any bugs that come up then.

-- Steve
