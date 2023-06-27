Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E7EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 27 Jun 2023 05:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjF0FVw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 27 Jun 2023 01:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0FVv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:21:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C610FB
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:21:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5847497f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687843309; x=1690435309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jaeLVQ8cKoY+y8cPo5BXpJfIHKd+bAYhWvUpOvOMtU=;
        b=IFIGs1l0qRFArsqDt9u+8cyAnujDwTG3oMAw/dQfgps8oWGvSaqgfhvRvrhUY/Vecn
         zeEoj69TIxMc7cjjc8HQpIemmffjupc/VijXbikexzB1OZ9N4l+bkKzr1F/Xh33Kgqhm
         7ZfSx/Ya7qK1QaDk8dxETu6V5ELGPIR1N/qspDw6RSMiVI45n57SOGal7Mhj2tcNU+Vk
         j673RdDn5gUefedZKZnm1KtnGPkg/Z5uCFytqWGImtAYIKlyDVXahlm6GFpyBv7ufxYf
         yksubkTbyfsk3bWKrZRkyZwGbG+1J+Lj+/X1VI14lotrqckKoOy7pWzdOFGTL+epX8hK
         4Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687843309; x=1690435309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jaeLVQ8cKoY+y8cPo5BXpJfIHKd+bAYhWvUpOvOMtU=;
        b=jhBjtU1jX2BcLhbZ7Y+eCvru7lfKVlg3JXXN0/KrodRagJdAYCHDiIsM0hXPj+UXKe
         1IuLW3OjMWZcUzmNwSM93mv5BvjN8rh6tnuEuFWUmhoLLOumE/NLbjtzUMRdVshl12yP
         wjmxlG0ti6+Qt5W2Vu62A8/K5z5e6SDkd//O9YmIinqmULV+Fqq4JMEEL1lIYf4KkG2B
         qOY3TjaJzPvLeS7L+vanQ9aNJES0G4pChe/mTnaWLtSddJiCAIh+qy2ORw8l71F9diqd
         ikChYrM8lmzFGkUakF3TUF10YYNf3ZVWYRoBxtuuco+H0WPhu3xRMzzhv99dH4qkc7Xq
         DaIQ==
X-Gm-Message-State: AC+VfDx7GVJX24DjoHbG690pUCtaM3Kdr87+ouW3x+xAHULWMuhhCyBZ
        f8JUri2Ez9N3fbsgUexNH60Wmg==
X-Google-Smtp-Source: ACHHUZ5Elhf5H3/ehHtkBEk4o80/+XqziRfhC2s9IkQUU+0u5T5lDDim5Inpva3wvShUQMNV0LBB6w==
X-Received: by 2002:a5d:590c:0:b0:30f:ba85:52b9 with SMTP id v12-20020a5d590c000000b0030fba8552b9mr32327232wrd.37.1687843308884;
        Mon, 26 Jun 2023 22:21:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm9276888wrv.74.2023.06.26.22.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:21:47 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:21:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [RFC] tracing: Cleanup the correct ep in enable_trace_eprobe()
Message-ID: <d1397f75-1091-42e1-8038-b6844757de79@kadam.mountain>
References: <72b05526-4dda-430a-b4ca-2ee4f26f2185@moroto.mountain>
 <CAPpZLN4ACVRrDXofO9jNQznEuF+CK6KNbCCz=5t93kMzESbZGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpZLN4ACVRrDXofO9jNQznEuF+CK6KNbCCz=5t93kMzESbZGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:39:17AM +0300, Tzvetomir Stoyanov wrote:
> On Mon, Jun 26, 2023 at 4:35 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > If enable_eprobe() function fails, then we call  disable_eprobe() on the
> > "ep" that failed.  That doesn't feel right.  Shouldn't we
> > call disable_eprobe() on the previous "ep" instead?  Or even better on
> > all the previous eps (but I don't know how to do that)...
> 
> Hi Dan,
> There is no need to disable the eprobes which are already successfully
> registered to the given trace probe, as they will be disabled using
> the normal logic. The failed epropbe is not registered there, that's
> why it must be disabled explicitly.  Thanks for digging into that
> code!

Okay, but if the loop fails on the first iteration then it won't disable
the first ep.  Is that an issue?

regards,
dan carpenter

