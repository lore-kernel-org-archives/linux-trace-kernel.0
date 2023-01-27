Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DBEC54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 27 Jan 2023 08:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjA0Izu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 27 Jan 2023 03:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjA0Izt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:55:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D8C16F
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8642BB81ED1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E441C433EF;
        Fri, 27 Jan 2023 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674809746;
        bh=DyD2kNytevUjnRK224jtCvE8TwW4QRksLy8XZf1gYqc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=epTprwF51aEG6cK3f7GOxCehQ4iHq8sPA7N95jWUOX5fDKXxBayWRCaEgX1v06Yc8
         EBQvKQ3hXW2GiG+h4J7sXjSgVSYjGGkV9N1McgR+U0htaCpAV9lBNCC6jeCDEvNI8u
         3rlV8+W1WWfyhU1TR+Hgtz9taWxDjdro23DndM3t0iW+0451YIfGeBDzabKlMBf3RX
         Z/6vUuj23aPdGmIP2ZJuNy6T7pK+pISlFiyr/SxnTwz8SHOU4TTGtF/vkBWlsAakDj
         s0Swfk/A6+/H0uIdaKOLfpuzrQCkNU6A5YvO1uoGF5SK6Uy5+CUa/PsxK/uwnR9Nhb
         Ss0g+YVz619bg==
Message-ID: <9c583bbf-b202-5fbf-ed4c-6b9072bcb947@kernel.org>
Date:   Fri, 27 Jan 2023 09:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing/osnoise: No need for schedule_hrtimeout range
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, rostedt@goodmis.org
Cc:     linux-trace-kernel@vger.kernel.org
References: <20230123234649.17968-1-dave@stgolabs.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230123234649.17968-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 1/24/23 00:46, Davidlohr Bueso wrote:
> No slack time is being passed, just use schedule_hrtimeout().
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
