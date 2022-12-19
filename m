Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D7C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 19 Dec 2022 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiLSU57 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiLSU54 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:57:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874AF0D
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i25so5373090ila.8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=KbhNEFItgqJpUb34PlBkSxussrLfWq638sk0HFl2FLNBYTaK/8B4hTsudLtq1bkC1w
         vw6Mr7C6FMx0V9UJAN8QRJjXtAVRsS8TGBOT5wg10yxC3S3lyss+1REqu2O661mXQsvS
         GhMwTohEAzhRfBnOPffbA8rBfCf3MI+2aQ93m3m48zG2Pi2C9W4eBEbbQ1XHOm3wy3Co
         2Pa7fSPzW6XYStHFMfwq9D1nABzUYP7WS7XSzJbojT+PG/EmyKDqIVBoTlN8rqJ9aBjZ
         WMUaHMyF4BODgsiwDuP18a2NdEZFL4LRWE5/PIE2lXJxqdegoOZ8cHXi7GUSgtRL76ED
         8dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=aGx1GP3dFESgZay7PUZbDqWKQv7ChideObwbEq1xt/n9uvg9t3mGegn9HZC09HgDQs
         H6kBq22mW7Awvr9DAIsXKVkDDmDaFdBzYuOesTaFxiWxlGIRdg+3ryp2zF5inmmmXFk7
         nsG8uQFFymCwjXtOq+wZKp084YB51X9fXacwVL6Io42N68W1D2Y6zLqmInv+ZEhP2AaJ
         UZIzw729Dr2yb0gV+x7A8Y/P/DKEjk+wjyWu4aqjoplPtm9JkEFVSv1+0nX4feGOgcA5
         hvKo236fhUpHkFQ6SabtidsbW7ukFEXt5V5DEhUqKpG+2BD3w4Cc3++SHHRU7J6QWgRR
         3YKg==
X-Gm-Message-State: ANoB5pmluz02hZeWTQjo7x0EqVRPbt6LQY7l5KtLgl6yYYtaPZcx2CW/
        2z+6NONXc6sJFSKCUWVjg/4llg==
X-Google-Smtp-Source: AA0mqf5AJOutoWTrKLNf0NtrR35QSZ3Fj/E2MBNWrinQOUSozCbfMplOw5BVmBmSUVTZpkqDzkVokw==
X-Received: by 2002:a92:cd4f:0:b0:303:410a:f2b3 with SMTP id v15-20020a92cd4f000000b00303410af2b3mr25223881ilq.13.1671483474816;
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6550:fd9a:e118:25dc])
        by smtp.gmail.com with ESMTPSA id b16-20020a026f50000000b003987df8bccdsm1856814jae.43.2022.12.19.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:57:50 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Message-ID: <Y6DQTvOrHRZ8gjDz@google.com>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219183214.075559302@goodmis.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> With the new filter logic of passing in the name of a function to match an
> instruction pointer (or the address of the function), add a test to make
> sure that it is functional.
> 
> This is also the first test to test plain filtering. The filtering has
> been tested via the trigger logic, which uses the same code, but there was
> nothing to test just the event filter, so this test is the first to add
> such a case.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>
