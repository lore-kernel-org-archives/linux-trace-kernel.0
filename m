Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345FEC001DB
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  8 Aug 2023 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjHHVJ2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjHHVJS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D319FABB;
        Tue,  8 Aug 2023 13:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC2762C53;
        Tue,  8 Aug 2023 20:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB7C433C7;
        Tue,  8 Aug 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691526085;
        bh=5eOhZHaNNqxroRtBDR8QfTDMQOAinstiaF9zVD3kTyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ItCIZsdcel9XJb/oUqQWkpxczMxv0yNlzFPKURjy9kT/aiRl0oZhmOT+BCWwCNZCK
         FB5DV/NRgWqJiTT0SMsuak8pjmgiShQM6sEdSHtMwr5MERdKj3EEoKn/tq15++NUy5
         Yrz7SuYcDM+o1gE7ylG4AH5rQEal5AykbjCLPIl+ZKzFJOszap/Wh9DIdiLdd1MedA
         cxp0NbGY7jGqNQ57P7dQzthamShmbSDrikmrVrSpKv2C5wypmM0doSR2Y2555DIbVz
         f7MCgDZ4UCxENsctvxOeIQfId1QoMurwSqUBkpNdSIEtXBzzRyPXz9aNuCsk0XtcuU
         YASDg7nsMa2Dw==
Date:   Tue, 8 Aug 2023 13:21:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manjusaka <me@manjusaka.me>
Cc:     ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        rostedt@goodmis.org
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230808132124.1a17ea69@kernel.org>
In-Reply-To: <20230808055817.3979-1-me@manjusaka.me>
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
        <20230808055817.3979-1-me@manjusaka.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue,  8 Aug 2023 05:58:18 +0000 Manjusaka wrote:
> Signed-off-by: Manjusaka <me@manjusaka.me>

Is that your name? For Developer's Certificate of Origin
https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin
we need something that resembles a real name that'd stand up in court.
