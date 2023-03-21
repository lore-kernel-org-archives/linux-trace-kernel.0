Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7783C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 16:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCUQvC (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUQvA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:51:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7C28E4B
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:50:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w11so8938083wmo.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679417455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfZP5WUwQ2zes6TJwapZ83j4T5feELIfk8vczVnLdPI=;
        b=E0+aVcsylyia6nwcDEPzALqwWBMGJDgGwUYNgRB3rF3ityRUjdO+sK2wUNsTrhiNiQ
         Tu455Dp1ctS7qVOIAmPAfFT4uzhkmjjqhYrL+Ez30y0vyTjuZD1jTcaax/QI9kfSC6Bi
         v90AwVGmHV1r3dBl01ib0cQ67/9cDEre4QigEPz2G1GOcWIolO6VLJ2BoDsuG7MEjlgx
         pFXPRMw1XzaSxRuhtl1EOp6VoTwtsqGhKip4iO7CAbUpH5fB8jfDIDjPDcFwXNuwd4+U
         fPog1MWrWwyIj/1PJzynAkgsrmW8r7j+s7eAbpgyJxWkkJgGLG5h8qtakcFdnzYykMVl
         87oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679417455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfZP5WUwQ2zes6TJwapZ83j4T5feELIfk8vczVnLdPI=;
        b=J6jxEHCAm6GqHITJHhxSid/rHnQ6lB8DetpNOR8Dn2SQ1TRg52t1p3R0tM+Nd5qe4o
         niyTOxuaruIkQvgZqR37F56ti+uVOW5m3jx/jOI0yZl8YT02mFai39LEu5VXJ/qxGcgf
         SRNipWbKkVN3tW+bBjN+dbXpti+hoVUEZhHkIj+30RO1bm/V6I7xSEXmHC/SQDv1zt2H
         T1wAK+fLCZpdhbj3KYVC0Oc16TYUJd6MknBioWdplJiAJpyTO1Qk/DB7+mpfBt3KGM2p
         FWR8iGDEGtuj9rcctyeW1Z7AtTDMxaVKzFzjUECsgTyejmHXVRZywYJLSGMWAYhU7Kjk
         ffLg==
X-Gm-Message-State: AO0yUKUROjXuGL+AN+rf1jbIrV3gY9fNi5RjBsZgUZNq1vyM/MxWYoer
        QfFivryI+1QjXtea3zyACmRagA==
X-Google-Smtp-Source: AK7set/5CTKHv7W42iSkRDz6r+Fv5GwBJzTkDXZQnUC7keFECRTnXqtOMDiGp/Vor20x/ruRFYAKEw==
X-Received: by 2002:a7b:cd09:0:b0:3ee:4dc0:d4f2 with SMTP id f9-20020a7bcd09000000b003ee4dc0d4f2mr463024wmj.41.1679417455116;
        Tue, 21 Mar 2023 09:50:55 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13904832wml.43.2023.03.21.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:50:54 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:50:49 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZBngaarixYOgBCOA@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
 <20230317143310.1604700-2-vdonnefort@google.com>
 <20230320214516.01c18367@gandalf.local.home>
 <ZBnKe55cvTZybZLF@google.com>
 <20230321114047.3432afbe@gandalf.local.home>
 <20230321124425.6ca93621@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321124425.6ca93621@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:44:25PM -0400, Steven Rostedt wrote:
> On Tue, 21 Mar 2023 11:40:47 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > 
> > > Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?  
> > 
> > Hold off, I found some bugs that I'm fixing ;-)
> 
> OK, you can fold this in. I also fixed an issue with your patch where it
> was missing setting a page->mapping and also clearing it.
> 
> I haven't updated to replace "__u32 *data_pages[]" with an "__u32 data_start"
> But I think that should still be done.
> 
> -- Steve
>

[...] 

Thanks! I'll prepare a v2 with all that!
