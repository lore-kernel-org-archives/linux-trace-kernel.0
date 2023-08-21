Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066BEE4996
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjHUPli (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjHUPli (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:41:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03143F0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:41:33 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso2719936a34.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692632492; x=1693237292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeGfHwRGwwRYbXeeefh7iQ7yCYz7KLAfKCabKiv94CE=;
        b=BMezuwTASDt/+FL3cE7ffudvgMNTJuLkhTniMQXciQ0PmJ+wNKDp9r2xDdzsZhwrhW
         hfXEmDHtJYYWgS4VL4+Dx/UCmJtQ71B0oQGulzLkAu0UUDN7Fb14Xukc39yjwXQ6jT+S
         g3jkV60YJkXZaNGYvqg3z01CAbYt1L7VgpDQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692632492; x=1693237292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeGfHwRGwwRYbXeeefh7iQ7yCYz7KLAfKCabKiv94CE=;
        b=LNZWELSGCEyln4nScL6bAaqBrVZ8fV7887AFgDGLZHSMDIKGHRD75KUyd2uR2aFTxT
         JFAOYsvMcfvZezj4YWwHZvYxTE3Z0tTtk/1CzXIiKZYEf4VfPt7HGN3ZtWjv6r7ow0P0
         JEH64+I2M0B1V3b5zibnuHrHgyOIpfEv4ZYZ4MUT3lj8/FKP7y6DLQQom6wVjsN4VRUp
         7NH6+Ix6EPv4wOa6NtRQxUOH+V6pHHuD6B6op+upnpsrVgrw6z9TUbJTdg3QszA/+x9w
         OsRB4dheX9lgkQ/YiIdwJ8Co6MpElRV4DHaVmO71YA1J3S5HA/94xB7+Ri/oM7iLfrSr
         fFwQ==
X-Gm-Message-State: AOJu0Yxzy6UN1KG5jgVBGac3cS4aADeR2WegI0CmdCOk+bNQ4+K+LKfM
        PowICYTi8KIWfFZ2MoFYDTtbZ9y2ifbr7LvBYiTmag==
X-Google-Smtp-Source: AGHT+IH1Qszox9Yk+3f1AeTumdyeECq5APECIyqTkTxYrkNnnsDkCQqCztmHIwGTkcSKfC3RtYdz3wiDu3cledIoISw=
X-Received: by 2002:a05:6870:8594:b0:1bf:1a58:c4f with SMTP id
 f20-20020a056870859400b001bf1a580c4fmr9923689oal.55.1692632492370; Mon, 21
 Aug 2023 08:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 21 Aug 2023 17:41:21 +0200
Message-ID: <CABRcYmJkt3AYL1T57415JBLa7kT9LWuWx-oGZf5Lvn9nskyhSw@mail.gmail.com>
Subject: Re: [PATCH] samples: ftrace: replace bti assembly with hint for older compiler
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 1:10=E2=80=AFPM GONG, Ruiqi <gongruiqi@huaweicloud.=
com> wrote:
>
> When cross-building the arm64 kernel with allmodconfig using GCC 9.4,
> the following error occurs on multiple files under samples/ftrace/:
>
> /tmp/ccPC1ODs.s: Assembler messages:
> /tmp/ccPC1ODs.s:8: Error: selected processor does not support `bti c'
>
> Fix this issue by replacing `bti c` with `hint 34`, which is compatible
> for the older compiler.

I see this hint is already used in
tools/testing/selftests/arm64/fp/rdvl.S but I'm curious why it isn't
used in other parts of the kernel like
arch/arm64/kernel/entry-ftrace.S or
tools/testing/selftests/arm64/bti/syscall.S
