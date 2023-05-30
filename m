Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FEC7EE23
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 30 May 2023 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjE3KhJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 30 May 2023 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3KhH (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAD11C
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685442980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YHytPvfnkeWnuCkOajf7O+c3bYpxCqL4BosxRYRJEM=;
        b=SeXGtftpG1Rhx3S9XIvKkcdxR62EvUqn2P9wdh1HCMRhH83lIReV5080CqOUTIuoCor39C
        shJklLXgwqKgGoi/q75EaEZsbT+4CgPDMXjUERrc+B/M3eyWzL330x1gd0gd2i0neVF4o6
        qNF1q4wIcWStMGrnic7/OAmK7/iJgaM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-kOF9_ktjOMqmda1-L2YsqQ-1; Tue, 30 May 2023 06:36:19 -0400
X-MC-Unique: kOF9_ktjOMqmda1-L2YsqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso27086435e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442977; x=1688034977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YHytPvfnkeWnuCkOajf7O+c3bYpxCqL4BosxRYRJEM=;
        b=DtRQJ800N/srygjvbzsIk1UuNoZfC7YCWeuJZPltK/o91picEmsdN+tAR38em3xKfh
         ssTFVHP9mdOzTNOFMkuD2VKhOkzjkTSRNi9yjK/V8hrDrFgSouyRcaTLcerVg7dqmvof
         eCQAu8+wrqteXzlOKDRrMEEw2ypQZCHNtRmreuLI5Et+jigiyWfDT1vQlHUnhH5+FZAQ
         9Gis+iVrHiSkD8hpUB31wM9L9MraH7PK2ukuzRiPTZtP2v8d8WnmNnk2eZBM/Uc9SWsT
         IqHrg/f85TZFXuIPeD/Lrs0v9+F/GhiMEqzYH6fmIpfpHAMgGGL8mbH++lDbv9lGsesj
         NfsQ==
X-Gm-Message-State: AC+VfDxavO9TDEOA3LKDY8vTaKRPGXy8Zsyvpo5Nqqv2VaRTj3NJxb59
        xd46U9AyfLoQtWBwd/NdjW4v5TZe47urw1LYCVEF9ZjYGeOG+iMGB/X+goGwDMAy3zfNqL5EF65
        6HkLyKoYUbAEYDTRVhsGy+OLFhfr0kymh0ypAhBGv6u+rvlqXCA+UBCw8yVBQgXV4GRxy8ouLQg
        taNDeddhjjSLXqewnh2Co=
X-Received: by 2002:a05:600c:2304:b0:3f5:6e5:1688 with SMTP id 4-20020a05600c230400b003f506e51688mr1284642wmo.2.1685442977731;
        Tue, 30 May 2023 03:36:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51yjtghwN6gnYHTSu1gfgT6ds7TGsfgQyKhlxCFVUa1ZeeG1wFOCBXeSxRJeHuGZegDSuPiQ==
X-Received: by 2002:a05:600c:2304:b0:3f5:6e5:1688 with SMTP id 4-20020a05600c230400b003f506e51688mr1284614wmo.2.1685442977398;
        Tue, 30 May 2023 03:36:17 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b003f606869603sm20588191wmi.6.2023.05.30.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:36:16 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] trace,smp: Add tracepoints around remotelly
 called functions
In-Reply-To: <20230515183045.654199-2-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
 <20230515183045.654199-2-leobras@redhat.com>
Date:   Tue, 30 May 2023 11:36:16 +0100
Message-ID: <xhsmh353ep0m7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 15/05/23 15:30, Leonardo Bras wrote:
> @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
>               csd_lock_record(csd);
>               csd_unlock(csd);
>               local_irq_save(flags);
> -		func(info);
> +		csd_do_func(func, info, csd);

I'd suggest making this match the local case of
smp_call_function_many_cond(), IOW pass NULL as the csd when executing
locally.

IMO this is required for postprocessing with e.g. synthetic events for CSD
delivery measurement, otherwise we'll try to match this execution with a
previous CSD enqueue.

>               csd_lock_record(NULL);
>               local_irq_restore(flags);
>               return 0;

