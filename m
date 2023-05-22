Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B23BC77B75
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 22 May 2023 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjEVRtA (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 22 May 2023 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjEVRsl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:48:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483910C
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 10:48:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f24d8440c9so4834867e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684777718; x=1687369718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=TVNR7OBxbiFd9F8QVyibICbCMFXK5h21O5agS/2aLyyIYfIHdKQXMdxnaUJqiMslUn
         cQ8jj7dWOvPs2dCDJ2h74Ys6Eeh/k87mRbaBde95VAIN8N8ztpuLAbLLfMf3tj9B6lGN
         MZkIit2ZcFT6jD91MW9Mqa2vwPEGim2GwL0pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777718; x=1687369718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=JDULHOrS5IX28C8DDGbyJCQEX3CBKQyJgsDNIk3oX+tN3UHsogTJduRLQiGa526Rzt
         C5Sm/iDeDz5SOI25ulIT/Y2qU+keoIprkAkkPmIpJMsgU91b9cRNfQo9cpRnO6PSfQQD
         VV6zBVrVjo9D8RNwAkdz1r8No8e3Ns9qGujzZ/atB12NHg3VlIHJo/rAIJp/5tFih9s1
         7Hs4VLYNe3+8juw4eK92KTsKQSqYE3CsZRVA4AUUiLBlHcE3Et4R0asVKUDZTIQBuoqu
         RIcGD1Bq55FvPBqQKXuZx5BhdIv8cBGVNOfHDt5zWYJqEiVBuJj4pfpYBbe5ujghQhVW
         1ecA==
X-Gm-Message-State: AC+VfDy9kdKtlcKSIfxpuSUtH8tiE2rkDm9WIkRpn17JFFlvBBoxI/Q+
        rgE4ZF4c4kH3f0GrEI2OfCSMxEYInIyh+7hhC3JDrlMN
X-Google-Smtp-Source: ACHHUZ59EM6yYZUPKHHQZV2V5U3Ga2URoBDyCtbURnVD1Xxgf216sCXfTtoadgIYI778605tEA87qA==
X-Received: by 2002:ac2:539a:0:b0:4f3:a4aa:eb75 with SMTP id g26-20020ac2539a000000b004f3a4aaeb75mr4039559lfh.24.1684777718231;
        Mon, 22 May 2023 10:48:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25101000000b004edbf013fe7sm1062631lfb.49.2023.05.22.10.48.37
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:48:38 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f24d8440c9so4834845e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:a17:907:1688:b0:965:d7c7:24db with SMTP id
 hc8-20020a170907168800b00965d7c724dbmr9757222ejc.32.1684777349281; Mon, 22
 May 2023 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-24-dhowells@redhat.com>
 <20230522102920.0528d821@rorschach.local.home> <2812412.1684767005@warthog.procyon.org.uk>
In-Reply-To: <2812412.1684767005@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:42:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
To:     David Howells <dhowells@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, May 22, 2023 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> We could implement seq_splice_read().  What we would need to do is to cha=
nge
> how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
> which we then vmap().  When we need to splice, we read into the buffer, d=
o a
> vunmap() and then splice the pages holding the data we used into the pipe=
.

Please don't use vmap as a way to do zero-copy.

The virtual mapping games are more expensive than a small copy from
some random seq file.

Yes, yes, seq_file currently uses "kvmalloc()", which does fall back
to vmalloc too. But the keyword there is "falls back". Most of the
time it's just a regular boring kmalloc, and most of the time a
seq-file is tiny.

                      Linus
