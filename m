Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9DEC001DC
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGaKXN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGaKW6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:22:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E0198A;
        Mon, 31 Jul 2023 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3olJnqcoG+dSEyqkVXsNpGCuruI+R+cUdds5o12vzk=; b=rCN7+iHYALx254uPGl2iN2H90X
        46IZ+G8M57NaDq96xcefuxCkpUiUpH7mbBq9vJv6UCACqQfJyw0PqPhqJOTpALQYfjtq1/z+zDDlz
        EECuYMZ++B/WiP8ztp5a0BG5qIvmQRgaITgElhFx7hkvatsy70U6lmwpgKvh87GBNkLvZ735sIV4M
        q4QowNp+oIwZEMKYGgYcwBpPtQcehCwbA2bwChc9VaJP2v2vuIZNW5a5UBHRh8cd0luza66hSAXRe
        UPCpkhmPzk9BDXkqqIoUHxwSIrdTHgbyXS5/z0v1tZgqUsukn9abmEDqdihRa+ZsuT8ERcxtSsJjx
        8I5XA5sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQQ2c-00CZrI-2o;
        Mon, 31 Jul 2023 10:22:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 342D13001DD;
        Mon, 31 Jul 2023 12:22:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21A6421071367; Mon, 31 Jul 2023 12:22:18 +0200 (CEST)
Date:   Mon, 31 Jul 2023 12:22:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/retpoline,kprobes: Fix the
 [__indirect_thunk_start, ..end] range
Message-ID: <20230731102218.GD29590@hirez.programming.kicks-ass.net>
References: <20230711091952.27944-1-petr.pavlu@suse.com>
 <20230730001435.ed2b12649d5c98d42981daf6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730001435.ed2b12649d5c98d42981daf6@kernel.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 12:14:35AM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> Can you pick this series to tip tree?

Will do!
