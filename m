Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47FC54EED
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 24 Jan 2023 22:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjAXWBP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjAXWBO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:01:14 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7CE4FCC6
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:01:11 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8361599C;
        Tue, 24 Jan 2023 22:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8361599C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674597666; bh=MRcXfRT3encc2WhT9wUAe6vr0xv440A2voNd+2qi1gQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dzT7X2HcbGjWTXJwTXhHK/5++x2j1Q/Vo7JmOsccGZQ16qdCf9eev73fgEp/ESkeT
         ISMSKuWKtLfGZ7RMVH39t7ch8E61ap5Xo2k6fajsRNZdL24sZmbEnQnW4FAteNMGID
         YK5MRokishBudR5uVNCla5Z7guqTb3mZjZHBE8iF0iY8WSBrYN1xve8fuWaDyeIcxJ
         wrNtnNFKeLcOujBE8fb/HjUHIL68fBczkbpIDr/U1rrdJ3xPnyLb8VWt8JmvkaQQsW
         PEWODXn65japhyyuPrgzwvtBy3qag9hAUPefHLoraeXtE46ATzVALGuxxNU75f706i
         qePSjhiyxNKxQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
In-Reply-To: <20230123103341.56f42e72@gandalf.local.home>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
 <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
 <20230123103341.56f42e72@gandalf.local.home>
Date:   Tue, 24 Jan 2023 15:01:05 -0700
Message-ID: <87v8kvfv8e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Jon, care to take this series through your tree?

Done, thanks.

jon
