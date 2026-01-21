Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA03F23CD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999215; cv=none; b=PRYsMR/AQ5/tH2atibvk2Fy3gtKrn4LYxbMUJuPKJvwnsq5jta92TaSxbda0se3X1zmzFvmCUchK1ZsxJGnEFHX0KfSjWBIMWZrBgYI0RLBnfnM4pcBoLFtlRQQUgu3IgZbIOPsZC0TWysFlJKajgW07zbNgcdqk22V/BzUAtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999215; c=relaxed/simple;
	bh=hJQF517auP26/VtVtWZl6VTIvWady9uP242L7enYoLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6ulFb7v9epXfinTAvPrBLDhMnpYwAdm4lM3NBqXQCzW98/mey/UdTk/tFe4Vw/4TI/v4eolo7nREV14MCten6qPZzKDMsfmi9utEUfYS5twF9xHsiGbvpeOZ3NCem2Go9Pm3wdGVkVO8yp26Hj7pzXzlltCZjPMvbym4YSJqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT5dinBQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT5dinBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768999212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znxjSk8O978x+vktb8h3d+I6NP4+QOKFEauHvCvQd4s=;
	b=XT5dinBQ8MVfg++S5VIP8YBGXS0ePfj3goPRUp3BzQfoR1Q3G9xmHvzSInpBKhQiPmjJjv
	s63p+zzAMr/HLz4vg4eoYpYqFgkGT9Hc5+C5NNXIqW4t9InnnVREAf5YYKzVU4Pm2MIdkG
	zVfhtWYNJF544mQXZ2E4ZtQs6+YeWg4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-BUgkwLf8NVyY9SZO-mJ0ew-1; Wed, 21 Jan 2026 07:40:10 -0500
X-MC-Unique: BUgkwLf8NVyY9SZO-mJ0ew-1
X-Mimecast-MFC-AGG-ID: BUgkwLf8NVyY9SZO-mJ0ew_1768999209
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59b78adfc09so6849454e87.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 04:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999209; x=1769604009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znxjSk8O978x+vktb8h3d+I6NP4+QOKFEauHvCvQd4s=;
        b=HZL+5efZoA/vAoUUKq2EAzELsWCXxDF6h6S/mM27qqTCLtW35fkzZ3Aw/+/PjK7wxs
         UPFDP5nfQKYlNAIC3+u7Bi5mPD7KSSOYKhZFbGL4Ul/UVl7oCxjyy2qcH508zVtEFzwn
         Q7aRAGZjgd6N8j5atUHhW+8XnIH4exTRZH7hUwiAAaAu22Ncd+G2F3ZpTHFaffyvzUVG
         BbLyOTI/lj8ZDq1DAED5CLMEVbwiyhmwhC+wP2tTD5VLwKu5sEUe2OQlQBsspfP01H6T
         STKAl/a5Z6nBrwlrZMsjduOzm/TkkXXBh8KHPp19r9OyB6fSLMeHXau8WxIjmrnsuFhz
         2XsA==
X-Forwarded-Encrypted: i=1; AJvYcCWmyvaxH6Nn9RVR6XYaqshoYK7mCIyYCZc8KDM4x0xgg6Z9q/UfxKlbz0ELeY+lq/zPX4K6v9ykRNt54Rt9v/m+YEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKfkUPdHrCa1nI5biD6Op/NB/Ui2ZAZbdMN2F83qLhqTIOZ0E
	NWGPZV1XQ+KVKTM+6A9dk13zJG5US532bNY7n6y1hxj2w7cxH3UZOCHJvMxZgdZTBk9U5cdpm1B
	zlZuDh3sUI1xLi2dM8lC4o6/QYlBNA+g1KfMEg2qW3FBTIQncPdM4+EcFROoxlc5UdozJjzzt02
	zwCzZj1gQJcXwe660k+fjbgAONGytP2EKVxwQZg8Q8tNrFzI1D
X-Gm-Gg: AZuq6aLObHptwA/NrmdX7rh8qelcN6WOoiwnE7Q5e1BEAEa/DwZbr7Fn9AqHVQ8z8VU
	KIOAILdH1ZDp/C18Rzvjr9WL8ekmKBEpB3CFus8DFn5ZPP8tEQqKXdhRUyKEc6JHWaMaZb1iYm0
	jafFl4BrxfJBSEVbXB1RaE8wwfwBAuG6Zn1LoFndSEv7REdiXsXKtPWtM+qPPR8tiaD3WjKxx/Y
	j8t9H4fqcjndOz7jZhw2MzX2z+YJIf030lSsq1iQ9rcljbuguqD7Wgpfat8CKM+QFnJCA==
X-Received: by 2002:a05:6512:3501:b0:59b:b30f:301b with SMTP id 2adb3069b0e04-59bb30f301dmr6166521e87.22.1768999209255;
        Wed, 21 Jan 2026 04:40:09 -0800 (PST)
X-Received: by 2002:a05:6512:3501:b0:59b:b30f:301b with SMTP id
 2adb3069b0e04-59bb30f301dmr6166507e87.22.1768999208777; Wed, 21 Jan 2026
 04:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119115222.744150-1-tglozar@redhat.com>
In-Reply-To: <20260119115222.744150-1-tglozar@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 21 Jan 2026 09:39:57 -0300
X-Gm-Features: AZwV_QjWOnkKxmqjV6bleIrjnwQ93ilf0K-nag4S0c1yxbsNUdiq5qUda4AlE3g
Message-ID: <CAAq0SUnNBgG=o=HrkuVDK7+nf+tjPYeoy6d1mYMyup0G8sU26w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Add --stack-format option
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2SQ1Flej1pJHKbmfkvJOwpOcCbNt89-uYb-ruCgoD-w_1768999209
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 8:53=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> In the current implementation, the auto-analysis code for printing the
> stack captured in the tracefs buffer of the aa instance stops at the
> first encountered address that cannot be resolved into a function
> symbol.
>
> This is not always the desired behavior on all platforms; sometimes,
> there might be resolvable entries after unresolvable ones, and
> sometimes, the user might want to inspect the raw pointers for the
> unresolvable entries.
>
> Add a new option, --stack-format, with three values:
>
> - truncate: stop at first unresolvable entry. This is the current
>   behavior, and is kept as the default.
> - skip: skip unresolvable entries, but do not stop on them.
> - full: print all entries, including unresolvable ones.
>
> To make this work, the "size" field of the stack entry is now also read
> and used as the maximum number of entries to print, capped at 64, since
> that is the fixed length of the "caller" field.
>

[...]

> +int parse_stack_format(char *arg)
> +{
For the sake of function interface, it would be better to
parse_stack_format() return enum stack_format...

> +       if (!strcmp(arg, "truncate"))
> +               return STACK_FORMAT_TRUNCATE;
> +       if (!strcmp(arg, "skip"))
> +               return STACK_FORMAT_SKIP;
> +       if (!strcmp(arg, "full"))
> +               return STACK_FORMAT_FULL;
> +
> +       debug_msg("Error parsing the stack format %s\n", arg);
> +       return -1;
... and add a new entry to the enum STACK_FORMAT_INVALID =3D -1...

> +}
> +
>  /*
>   * parse_duration - parse duration with s/m/h/d suffix converting it to =
seconds
>   */
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index f7c2a52a0ab5..80d5ec0cf934 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -62,8 +62,15 @@ struct sched_attr {
>  };
>  #endif /* SCHED_ATTR_SIZE_VER0 */
>
> +enum stack_format {
> +       STACK_FORMAT_TRUNCATE,
> +       STACK_FORMAT_SKIP,
> +       STACK_FORMAT_FULL
... here

[...]

