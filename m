Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BACA0FE2
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 31 Aug 2023 23:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347848AbjHaXU3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXU2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:20:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7110CA
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:20:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d20548adso1190092f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693524013; x=1694128813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWZZJ4W2c1JEb6sxHZjM2rWbFiQYVpX5RM6za8+8n6s=;
        b=2p7Rsowql8DWRf0YXiAUawrq76ymvQmb3JdU1QoYvxHQFP/NEKi1nRFPElq+99MZf0
         Z8F+Nvvl4/ZXFtPytxZcqBTgit5m0QUTp5pSqj4A0hOOFfrbi3pL8cFSPzZ1OMTHrZ+3
         y8FLwM2oHf+tWtfp1862AlMTngyYmqWfHenZtIbSrQmponF/BPrIwwipDPhz/W//1wsM
         Qxqp7vXkgPeTVJuXUCxjGJhL1IZcV1NJDtZWD+AzkkMZ9uuIjT6EQf216eU5x8FwrjnF
         fkH4NqpLyOv0oIO0VsmSqWvnpATcGmx3eLaMW1Rl2TRstS04wP3Ig9RgAH3QtLqW8/SK
         neXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693524013; x=1694128813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWZZJ4W2c1JEb6sxHZjM2rWbFiQYVpX5RM6za8+8n6s=;
        b=lBCTNbtTnKWRt+vuDtdA17yGXzHjEQ5l1kzeiyP1MxmiVZXwSb2oGWeiSK3uf8oFM1
         /rZ/97/YUWH7rsey6klkl2LEsy2+tYUJoFF5Se6loOzUPreRus8z81aG+hTovw2jG6HJ
         47gd4JIN9+aJk1nvFmM7MT1W/5xPbaeuRoYRhOnyGsDsKfzhvYc5AMRmfYMJ0PQBD2G5
         6oJfowyMQ82N5lbVcHjcCPRoZ3Xg8WYIXVG2xvqMU5gJSv0i/DrsK8KPGJvi5SMxDLT7
         PsCZTAJJYeJYS23f9bq7UYgnFTO8sFRA9b/C19Q7Mu9iMINjUFKnt9/WZGJgRjVr2lmM
         +HpQ==
X-Gm-Message-State: AOJu0Yw1RPSGC6eGgjAKa8PJMYkSSrD3UFPvN2OLb8vCHvrJxF/9y3G0
        78xFEXYyP1MDFNK5EzVJxR3vrKS3xh4+quHwj8qjVQ==
X-Google-Smtp-Source: AGHT+IFY/qULbZslTUFY83I+dyYF857ayC4OzKQ7adtPZGuXyLPjh4tXVAQxgl2KHb//SBEIgqvNsv53UX8QmJLJrCY=
X-Received: by 2002:a5d:4b51:0:b0:317:5b1b:1a40 with SMTP id
 w17-20020a5d4b51000000b003175b1b1a40mr619080wrs.49.1693524012629; Thu, 31 Aug
 2023 16:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 31 Aug 2023 16:20:02 -0700
Message-ID: <CAFhGd8ruFyv=eL6XXY3FQWVAa3SAy=uBebLReGog0oSwE6XUiw@mail.gmail.com>
Subject: Re: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:42=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/trace/events/task.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 64d160930b0d..47b527464d1a 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -47,7 +47,7 @@ TRACE_EVENT(task_rename,
>         TP_fast_assign(
>                 __entry->pid =3D task->pid;
>                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
> -               strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
> +               strscpy(entry->newcomm, comm, TASK_COMM_LEN);
>                 __entry->oom_score_adj =3D task->signal->oom_score_adj;
>         ),
>
> --
> 2.42.0.283.g2d96d420d3-goog
>
>
