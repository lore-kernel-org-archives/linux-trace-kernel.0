Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DB4EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Jun 2023 16:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFOQnx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjFOQn0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2142700
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686847360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rj+HZrGceh1/5T+xxc4svlJVZP7112zLUTsVEWs0gK0=;
        b=Zoc4uN6sFIC3smxa0akVmoc7vUMIvTKK2Junypv/BsOdssNlLvlHevkMQoNB0Kp3QwO1JQ
        5HTYGixKYlLt4LnlgOezrWKiKzhTAgwzS6J5idA/ebWUgji2yXN3gn/h318hq6ANUTXvnX
        rNQHISRb2MEwSErxakjbsPoniQgqf0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Og9Dbf2zMUeIQFrQygJCEg-1; Thu, 15 Jun 2023 12:42:39 -0400
X-MC-Unique: Og9Dbf2zMUeIQFrQygJCEg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3110f149dd5so819235f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847358; x=1689439358;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj+HZrGceh1/5T+xxc4svlJVZP7112zLUTsVEWs0gK0=;
        b=FjDCiaLBfyFkhFUKO7c2BygBVmvLo6nKr7tA3Lp/orTT+HgFRsaYOKBi/UPzgFL1Qk
         +VqjX+OH6vvstYczHIx84twhG3UMWRgMuBMSnUFS3ZUfAYwbL6uH512YOyFcVfCvVOzk
         +JassTsHKeRalsim1xfhyFnXcQY/tJwvF9+8DgeN6ipu6J2yOBLH02uD6dCja1sKaMuJ
         E7ekgsBPguzfccfXaUPZloTDznRzlhEqsBEKnKsthNRapYSdY1p0+v/GX5zZYCXnupre
         PStpmCFf9Vfv3I7/5Dr0uHrG2R5kK0Yn1hLg4QiGozRnSWkJOqbzI2EBx6ySkXx1d7kv
         viFg==
X-Gm-Message-State: AC+VfDxTjAzHz2RMhr8YtlQssJ6GRFCYDKN3G6UJUn/CVzlyNZMFSUBu
        MhZJESoIWo/5Lu5q+yfZd3eZenQSC47e1dF5fQRiYHHvG3djNDwOowIe5tThC8eR1JszSTAow9N
        ff9wCzbD80i0rMcXwYJgWRMlqZ/RfYR8eQ36SmuBVvdThynEB7Z/5C6jEE9YRCmn9Izn76QBu1K
        yLBr0PhZ9kG2WYr8EN
X-Received: by 2002:a5d:6949:0:b0:311:101f:6c17 with SMTP id r9-20020a5d6949000000b00311101f6c17mr3191754wrw.2.1686847358517;
        Thu, 15 Jun 2023 09:42:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6huGVDbjkL6h5ZmquE64pBw+y8CBHR4bn2cBEEEyfJXfF0yPF+idvDgy8YSHCA8GN8yo54TA==
X-Received: by 2002:a5d:6949:0:b0:311:101f:6c17 with SMTP id r9-20020a5d6949000000b00311101f6c17mr3191731wrw.2.1686847358091;
        Thu, 15 Jun 2023 09:42:38 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm21375624wrr.103.2023.06.15.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:42:37 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/2] trace,smp: Add tracepoints around remotelly
 called functions
In-Reply-To: <20230615065944.188876-5-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
 <20230615065944.188876-5-leobras@redhat.com>
Date:   Thu, 15 Jun 2023 17:42:36 +0100
Message-ID: <xhsmh5y7oy8w3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 15/06/23 03:59, Leonardo Bras wrote:
> The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sources
> of IPIs targeting CPUs running latency-sensitive applications.
>
> For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
> sufficient to find them and work on getting rid of them. In some setups
> however, not *all* IPIs are to be suppressed, but long-running IPI
> callbacks can still be problematic.
>
> Add a pair of tracepoints to mark the start and end of processing a CSD IPI
> callback, similar to what exists for softirq, workqueue or timer callbacks.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>

