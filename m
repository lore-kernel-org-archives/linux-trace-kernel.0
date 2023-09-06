Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6ACEE14AC
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  6 Sep 2023 16:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjIFQQ1 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIFQQ1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138BC198D
        for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694016940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySBQ8UU2v3ruiAA4bTZ1K97iZuDORkFQAMOFS4JWWBs=;
        b=b7TJ87aQBNI+WTsIwLyd+D1VuFx0oF5wmqrfjPA7Vj4WZBQ39Rugz/F4LKYcRxOg8BfO7U
        LinuWfuQVlQznb2EeDAr0wLDTlp+K8lFPwBTkY7UEy+oR1xvOd4t7e9VWlydXpsbtbic0q
        opEh4UDD15jMvC/0vKQwv48FGgphl2A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-meduUwhgPKCOyXQjD-elRA-1; Wed, 06 Sep 2023 12:15:39 -0400
X-MC-Unique: meduUwhgPKCOyXQjD-elRA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-414bd030211so699341cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016938; x=1694621738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySBQ8UU2v3ruiAA4bTZ1K97iZuDORkFQAMOFS4JWWBs=;
        b=MwV5gpQVcno6e4+3xJB4l7PepkU5gsXy+szvg6lkEVXlLD3kF8FSAII9GaMLf4ABYd
         dYLQ/j6OQ/YC4tVzujgjwREYMMp5Kt5rJXu3y0a/ZeF0m7to8NNiGUt1VhQzfPJe8hIW
         5pV73lx9w7IAL8tfMJW5P78VjpZR4bRJkawkWvaY+dx78LBKpDS15dYcYTR1y/22e9rA
         ApgY79TDZDyOw7XOTzXFHyGZTmBa75xwLr6Le3emf5s8Tz2HawHqP0U60jVYElg+x9pI
         fsW16DyafxUSdwhIYrVqNHlgnGhV0yGxVvl2fNd06zjtFow4M12a4P56StO8+rwmijvx
         3xww==
X-Gm-Message-State: AOJu0YyMEUZFoKE1quTXyz0q1kBKf3jh/y2aZaRGdlXVfWbyr6nTFIlG
        8zgDsDx/HXGSjj66MRusaRrCI2sUzcutO/OMEfG8U7SBSPNb5PzH60uWdNDwbAkJ2ndOVf9WK+m
        Rt3O7eouKIlYsllk/E3K7suVUSyEuqF2mBRFkmJ6p9LABJHU5iy2DuGa0
X-Received: by 2002:ac8:7ef0:0:b0:414:ed76:bea1 with SMTP id r16-20020ac87ef0000000b00414ed76bea1mr1132369qtc.67.1694016938577;
        Wed, 06 Sep 2023 09:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG008JiqeqVkvqHQZFk51x1f9Ml14ocAwGpDZbzp2uKfdk4jeAuXVQtoHjOvPCQ5l9xRL/5vzpaFT68eIIdCAA=
X-Received: by 2002:ac8:7ef0:0:b0:414:ed76:bea1 with SMTP id
 r16-20020ac87ef0000000b00414ed76bea1mr1132349qtc.67.1694016938191; Wed, 06
 Sep 2023 09:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230831063129.335425-1-leobras@redhat.com> <20230906140947.GA33104@noisy.programming.kicks-ass.net>
In-Reply-To: <20230906140947.GA33104@noisy.programming.kicks-ass.net>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 6 Sep 2023 13:15:27 -0300
Message-ID: <CAJ6HWG7H1EtWRcNLc=Ka-PGnJ9MRQ0Ft8PHBRnwadRNRSUxjEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 11:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 31, 2023 at 03:31:28AM -0300, Leonardo Bras wrote:
> > call_single_data_t is a size-aligned typedef of struct __call_single_da=
ta.
> >
> > This alignment is desirable in order to have smp_call_function*() avoid
> > bouncing an extra cacheline in case of an unaligned csd, given this
> > would hurt performance.
> >
> > Since the removal of struct request->csd in commit 660e802c76c8
> > ("blk-mq: use percpu csd to remote complete instead of per-rq csd") the=
re
> > are no current users of smp_call_function*() with unaligned csd.
> >
> > Change every 'struct __call_single_data' function parameter to
> > 'call_single_data_t', so we have warnings if any new code tries to
> > introduce an smp_call_function*() call with unaligned csd.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>
> Fair enough, I'll go queue it somewhere.
>

Thanks Peter!

