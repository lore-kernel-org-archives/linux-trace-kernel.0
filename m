Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5082C5479D
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  9 Jan 2023 04:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAIEYB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjAIEWr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:22:47 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B671403A;
        Sun,  8 Jan 2023 20:08:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4c186ff0506so98552227b3.6;
        Sun, 08 Jan 2023 20:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lfUhAfUe0FxJ8Sp+tdCY6dlywrY7VMCs/cNi7AdgZBE=;
        b=FWZ9Jaav4qQ3xMFoOzE5o/da//oWHKnPxg6us77lQFCo1YP3pYLcDR4Z75IO8BrD+n
         TddMH92Kef6dWP+gU82sQFPKp6s3a6XYLsKiGhC+gZLzrr8Fhr9Msbfhvw1+SuPqVLb9
         iIYtbv+W1g/Y08C9QDGfcRtKMzOpK1cScTQRVHhJXFxDUFa0h2AQpN9o1+GaJ0xcCM04
         gNCnJAXJkh4Kco+3o1DmB8GFNMw37hcHmEOcqleQAU8gdcei0AQKkHQEYkvrTb56lNHP
         GbIc5aLoNbMzWH9m9PAtiRuNX2LMwzcPt0EaHEEEFDXPk+aEpfn6BYuEpGmPjvyb2nMr
         J35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfUhAfUe0FxJ8Sp+tdCY6dlywrY7VMCs/cNi7AdgZBE=;
        b=XaUvZzYhI27vuxqh5va6vcf2b4pUJOrmWx0H0ZadfE73J9NZmVMlCa/UeSMLvC4VZL
         X9/uLg1brPKPJ81X+03/Z+UJaWfEivZMzGhxtEafOZ0X4EUil1YrBxCFCmXqHzXN+yVF
         iqUhUKJSpEIN/Xoq/hBe21tTwLFe8ynOuJwu5VUCfLs0MAX/iLLgZNfsCwfWcGVAlZ54
         l0/Fus0G3ypRFMGESEheRxCHGXOx67wy+tQC0O884LS+Q8jkqGzlkg/dtSamzTwq6c6v
         nHLYh22DONze0GiBc7tK3xfQeZSI7Onfj8LxRcvgohsjC2ZO2MfSJXg8pZFT74uh3TCn
         /T0w==
X-Gm-Message-State: AFqh2kpkDunGwR+l3DG6YmsBe4VoO3Z9piouwvKS4q6RRJBO/7UPdd8Q
        DpiJGDTnrYYV4xQPzXdzU12CEYkRLp7VAPsQ7JY4PtXM
X-Google-Smtp-Source: AMrXdXtAV3XuYW9EwESQWJEEqwtYRsWSm5opH/aqm4YBdqrG5C4OL/1TuMY6Nf2In1l9GHy+AjrI0T5h+ksji3FvR3s=
X-Received: by 2002:a81:a53:0:b0:3b9:3977:596c with SMTP id
 80-20020a810a53000000b003b93977596cmr1515431ywk.271.1673237257372; Sun, 08
 Jan 2023 20:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20230109033213.3220884-1-quanfafu@gmail.com> <20230108225229.1cef1a67@rorschach.local.home>
In-Reply-To: <20230108225229.1cef1a67@rorschach.local.home>
From:   Quanfa Fu <quanfafu@gmail.com>
Date:   Mon, 9 Jan 2023 12:07:26 +0800
Message-ID: <CAM4UoyqtOBXRD29x_M==KJtnryC87FhTs2tW65AnDxCc7XgY7g@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/eprobe: Replace snprintf with memcpy
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Thanks, I'll check it out.
Thanks !!

On Mon, Jan 9, 2023 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon,  9 Jan 2023 11:32:13 +0800
> Quanfa Fu <quanfafu@gmail.com> wrote:
>
> > @@ -923,17 +923,17 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
> >
> >       p = ep->filter_str;
> >       for (i = 0; i < argc; i++) {
> > -             ret = snprintf(p, len, "%s ", argv[i]);
> > -             if (ret < 0)
> > -                     goto error;
> > -             if (ret > len) {
> > -                     ret = -E2BIG;
> > -                     goto error;
> > -             }
> > -             p += ret;
> > -             len -= ret;
> > +             arg_len = strlen(argv[i]);
> > +             memcpy((void *)p, argv[i], arg_len);
> > +
> > +             if (i == argc - 1)
> > +                     p[arg_len] = '\0';
> > +             else
> > +                     p[arg_len] = ' ';
> > +
> > +             p += arg_len + 1;
> > +             len -= arg_len + 1;
> >       }
>
> The above is too complex. I mentioned strncat() but you could still
> just keep snprintf() too, which adds the '\0';
>
>         for (i = 0; i < argc; i++) {
>                 if (i)
>                         ret = snprintf(p, len, " %s", argv[i]);
>                 else
>                         ret = snprintf(p, len, "%s", argv[i]);
>                 p += ret;
>                 len -= ret;
>         }
>
> -- Steve
>
> > -     p[-1] = '\0';
> >
> >       /*
> >        * Ensure the filter string can be parsed correctly. Note, this
