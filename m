Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB7C6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 12:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjC2M1i (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2M1i (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:27:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8573C29
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:27:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso11352271wmb.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680092855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9utD/b0dx3Ld9K9PQeMcjphZnAINU+9inEgYyc+570=;
        b=q9JhWLQtoVBQ8ZY8ontuf+BPWOWLuklLYmdoKdddmdqzR6QAAoE4F82Wp2wt+zVgnF
         ilaHku5vFkl7+gTWWkMK698wnObj1zjh5xGlmgkAesIXx4zrB5zwVM5lagBCsgQWfF2l
         kb+VttJV2uTb1Uies+Zl/nQPpewB1g7gV9LAeTP/o4bLdtCV2nnwB7oBqwRZYRSIIVcv
         coH4cRk19j3QT8+qM3mkMfDpMRAG37VoKRC7rKJyzLYlgUKrsztscyiV5Zly1VoLdo6R
         y+a8m/XxCy0s564Itj4CLwngUTmtAsZ//u+qMdP0QIv9S7+kT3qyZRxfg3kUrTC7BnfX
         WAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9utD/b0dx3Ld9K9PQeMcjphZnAINU+9inEgYyc+570=;
        b=RCGbSaIeNUJXelV5dn9Prhv4ZddAh5rsQyZfhPGE0r3q4P7VmiHR9DRlR1sYOAZQJA
         gZcLOkqHtH8S6bvx6q8J3gO/biWA5NouI1/+5iAbH3meMtwawj5tgzVH0ZgS9Jeh9J++
         OJ5Yrd4OAGxdgnNCKGlAbHFekv1306Xz1DJzfVtFEpJske7iRsbUcTeN0KW0Oe/HMGt+
         CIbbKwJ5GWAOYHKVc8zGRQj41sLHL8Y4sthkSe/CiDWc5fcLWgQryfJ7k2OX+3DQxsXd
         UDmwWbYAMMljGLX82lA0gFqsg5rmG6tdJciCFVG3Mrfwtm5YZ0D8CG9dgKAwq9noVTa5
         Qa2w==
X-Gm-Message-State: AO0yUKU9t0ALKzr1S017MSjOqOMSNZOGMcVbYxZNlw3TtnVXvO0T7aJs
        HUIj//TQkw/B6zkchuGln8yv+Q==
X-Google-Smtp-Source: AK7set9HNMY1Yo3GoPuBErduWgXXAzG5IN+i0ixsLBCno+3Nj1yvZIZpxXgqgnQ+u503ICN6qaN82g==
X-Received: by 2002:a7b:cb95:0:b0:3ed:3033:496d with SMTP id m21-20020a7bcb95000000b003ed3033496dmr14569206wmi.0.1680092855006;
        Wed, 29 Mar 2023 05:27:35 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003f0321c22basm640348wms.12.2023.03.29.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:27:34 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:27:30 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQussSh5h/GSwh6@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329080758.0e730796@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329080758.0e730796@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 08:07:58AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 07:03:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > struct ring_buffer_meta_page_header {
> > #if __BITS_PER_LONG == 64
> > 	__u64	entries;
> > 	__u64	overrun;
> > #else
> > 	__u32	entries;
> > 	__u32	overrun;
> > #endif
> > 	__u32	pages_touched;
> > 	__u32	meta_page_size;
> > 	__u32	reader_page;	/* page ID for the reader page */
> > 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > };
> > 
> > BTW, shouldn't the nr_data_pages take into account the reader page? As it
> > is part of the array we traverse isn't it?
> 
> Ah, I guess nr_data_pages is the length of the index mapping, not the
> array of pages mapped?

Yes correct, data_pages[nr_data_pages] and the reader_page being excluded...
which might not be the easiest interface, as the size of the buffer to read
depends on if the reader_page has data to be read or not.

> 
> -- Steve
