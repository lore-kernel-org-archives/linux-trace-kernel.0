Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90678C6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 22 Mar 2023 16:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCVQwt (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCVQwr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:52:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A265DEC0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:52:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h5so10185344ile.13
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679503958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3zjB9M2d0SQWHDN6AWzzgIm2jt75ssYc9u25xKl8IE=;
        b=hZCnPQWdr3tCG5xo0v92lpLk+DAmOiy31UKY1ztRu4DcmVfTcbbEZoBAx/XTFbMhVa
         z95qnrw654vLf32Me4P1KY8p92d6nBBn+NVuDFzOjUlTq/NXl1GiPQ/mEfIl/Akf9gZ+
         HyMaQPAUP6VaYutn86OT1tsv9qBvMdyYXXF9oKVG8nXuoDc5I0In0pt+UpiAh5XYPhgL
         U2DLcpVKUoenwMm6iQx8Toz4D9xWDcqkstJpYVU/Ee2Unm0P59dB06Y/aJ0OPlway83D
         8uSFduRk16DAZbshMI3ViMcX5wZeIJYP1bRXG7vG1ZVEy+tQs4jLvFxbXiJSgFP+6PQ4
         KMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3zjB9M2d0SQWHDN6AWzzgIm2jt75ssYc9u25xKl8IE=;
        b=1qRdRj30g65V4jRLPNGAz2PqkveH3lw+NEQnwaUWYR4LIvIOduGrrDi1j5hgnQXom1
         aVo3lacdTHJluKzRFBe23HiVbhiBjB3qhfdyESxCi6x05+vTAkWOpR9C+xTFl2qf/4qg
         T2D8RXn5PA1ohd3IMW7JgJfB05r+Zh0Qmgm0WdPIiO8aVAaLlL5r0KQeUizgzR4X3Di2
         K2nuRPvnsRML14Fty+3HXPl4Ticgg96x8sIrdebG/8qkxzVKPDeXDJWu1zSZPotQGI+L
         UuwkQWRus3+a+hcryl+jtiWRuoPH0gjGao+gdHPUTvw3X0CMdEbfFw6Gr5wz3rwRaD3u
         Rd6Q==
X-Gm-Message-State: AO0yUKUZJrKhBoB/Un2wGZ+Tftqj2SySzGcF9HDNfCYvdCEYVK1TDajh
        aSdb+aBH3K7XiGZXNH162V7OCg==
X-Google-Smtp-Source: AK7set/iHwdOxGZxb/coQap30EbwOdQq/VzCyxP9uY03QDMRgrI+8cfcaLD/yueaYS+BqRYm395aOQ==
X-Received: by 2002:a92:db10:0:b0:315:4c1c:f9db with SMTP id b16-20020a92db10000000b003154c1cf9dbmr4947711iln.19.1679503957782;
        Wed, 22 Mar 2023 09:52:37 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7419:4945:3325:dd1e])
        by smtp.gmail.com with ESMTPSA id t4-20020a025404000000b004061dfd9e23sm5359438jaa.19.2023.03.22.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:52:37 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:52:33 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230322165233.GA2583234@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230321223139-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321223139-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:32:46PM -0400, Michael S. Tsirkin wrote:
> On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> > Changes in v2:
> >  * Dropped patches which were pulled into maintainer trees.
> >  * Split BPF patches out into another series targeting bpf-next.
> >  * trace-agent now falls back to debugfs if tracefs isn't present.
> >  * Added Acked-by from mst@redhat.com to series.
> >  * Added a typo fixup for the virtio-trace README.
> > 
> > Steven, assuming there are no objections, would you feel comfortable
> > taking this series through your tree?
> 
> for merging up to patch 5 through another tree:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I'll merge patch 6, no problem.

Hey Michael, would you also mind merging patch 5, the other virtio patch?

[PATCH v2 5/6] tools/virtio: use canonical ftrace path

https://lore.kernel.org/all/20230215223350.2658616-6-zwisler@google.com/

I don't think Steven took this one through his tree.  Thanks!
