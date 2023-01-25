Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4E4C54E94
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 25 Jan 2023 22:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAYWxv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjAYWxu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:53:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A04609C
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:53:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso3654215pjj.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzKJd/pAr8vlH5fq51CxhfYmuwDJzJDL/ZN0MVn2ctw=;
        b=N8qZ3TIjLd1a1cyOwf5gSPSSoGeQOP1dsNx4uUe2iAmggItX87WNxmDbTDqyeVffl2
         ohOD5WmwPSmpgrUeP7JIs3zqBdDbegt64g9rht2hiS6y82dDW+DAxPzC8OYK+5PCR1BN
         aNSfLZRnJOKoDKCi4DvtcRAWEH2RaSukX5O6FfUthDhH3vLPaPFrHlIFr82p2DKPoJ5q
         AuyRPt6en5R2iaevUBEa0D0xFzLd6VyAVmJu/FCBPVTyPAjKz1nY5u2cxDKqWQGwBUln
         q7aIDu67F+R+Z9PyxYhVeIeGX8cDoHxyOWChbAuPhkrCCRX6XZXHcD0vA3mH8NIGWOGw
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzKJd/pAr8vlH5fq51CxhfYmuwDJzJDL/ZN0MVn2ctw=;
        b=t5oj7kcUOXTqXZke0E/s9F45w58whcT8QczawvMrFJy51efzHgntC/nvjqDr/dc7i+
         LFawufoEITyEigG7BRTg2zrMrqSqEsuQ3KIUcuuUNRlTOFABFKMSSk2WHGQz7FOMFc+e
         QypF7O6RLskI9do2tM3iAom3vzhkssEtigLaSXvO+ReSWdg6vW4v8yNPw7Rm98k6+6Jx
         bF9S4QH9cbn0READLBvCQ6IRUDSXiVhwSAWb1gKmf5/WHPtkDoQklGMDzH2n2jD2r/Kd
         OLeXkpNzOuq7lhSJ5Xoj60pawgVyHzqebRfVhg9+1CW61hEJQPbWDfXRsX1DqXFO7NRk
         uKEg==
X-Gm-Message-State: AO0yUKVR+en7SqQPoNtOIU9XMbcCN0cNB7O7QvhU8sP121FibHywQo7o
        InPIev+60sTzWcBbQvke19DIqrapQERPrmDjBneI+w==
X-Google-Smtp-Source: AK7set+D/kkg3tME1AaRlECOzc1VlwZnKyZA5Duza9+E/vvU/S92E7RSlmhiVDLZ9NqaZuvI9LXL+0T6TqrlsWzS9uY=
X-Received: by 2002:a17:90a:6e4d:b0:22b:ee57:725b with SMTP id
 s13-20020a17090a6e4d00b0022bee57725bmr1486529pjm.159.1674687228484; Wed, 25
 Jan 2023 14:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20230124095653.6fd1640e@gandalf.local.home> <Y9AG63mgkyzSEbSa@FVFF77S0Q05N>
 <20230124140617.4a4fe106@gandalf.local.home>
In-Reply-To: <20230124140617.4a4fe106@gandalf.local.home>
From:   Chris Li <chriscli@google.com>
Date:   Wed, 25 Jan 2023 14:53:35 -0800
Message-ID: <CAF8kJuNXo+cDTVWY+pDa-Py3zAbQCi3gs=M0UX2AsEPDyKrC2g@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Show a list of all functions that have ever been enabled
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> No problem. This was more to help us debug something, and we are currently
> just backporting it for now to our kernels in order to help with the
> crashes we are seeing. No rush to get it upstream. But I figured that if it
> can help us, it can also help others.

I just tested it against the tip of the kernel git repo. Works fine for me.
Feel free to add:

Tested-by: Chris Li <chriscli@google.com>

Chris
