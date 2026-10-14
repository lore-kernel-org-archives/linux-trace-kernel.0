Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA29545DA6;
	Wed, 14 Oct 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987710; cv=none; b=XiKQ+jIbhGhyLYoYKHZAzZ5wUEnytqMvb+xk2mGGoD0JZHGReb6TlHCgy9S/jC8qVzVAVpN6qyaTh1FyaAmLh8yPgAtdJjfyJDYYd7egZApbvmlq5omNrrHT3oXuGs260aKW5KZS02ecyZOAJl7il37DT5cGW29RfRljgH1hSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987710; c=relaxed/simple;
	bh=5NHPAF97DkL0X/gfzlrd0HF5Qcde9OlYHKVXK2myTmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=WaBRIBRq60KnX7mRThR8rE7UJ08v3mO4tD0doaeQ68TTJAhmc07SVh/3nsMgyP7JYKd0eKLVxHF7C4AFaOULv+0Y998AQeA+tpciUCFVEPekWPdYt1wPqfgiZJexbTuqiDfWqnPocFRQ8oWIk+gGexoKSQRSIYRAMBqG3zm97dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4TqzVGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4TqzVGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB11F000C4;
	Wed, 14 Oct 2026 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791987708;
	bh=xunAHGE3LO+JTpQuCM/8AZSo9Z4HbtBsbAtFSeVBs5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4TqzVGmrMZE60Z/e+IL2DVpGIiPA2rlkvLDPy71/PURvbf2w8wq7w8oEfjXKI891
	 kiNNDIUCKI+cV+20hR9nqMSmh3YAsc3PieyPzDf1VWxVATzGmknj6rYSvP68gj0QJv
	 ppjI7bF2ohEoU7vpABMfePUUsql3pYV1zEngpvfJaXLisOFUAXWA8q2eGs/R93Q3lj
	 z08BjImqz4je10/wv60swCEbjom5h+aQ4n9NsC8mDgpdgEwimemnKbiRTuSQx/szLJ
	 Csx9HvIyPJNhMLKZm8vJf8Qwz5S3MUFkEbpVsztzTwWbM6ncGVAsK/jK8VhEF+YW7t
	 6AkDFgeA0YFDw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Avoid unlink error on first run
Date: Wed, 14 Oct 2026 23:21:45 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261014114839.6258-1-jaewon8868@gmail.com>
References: <20261014114839.6258-1-jaewon8868@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261014142147.95DB11F000C4@smtp.kernel.org>

On Wed, 14 Oct 2026 20:48:25 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
> On the first run, ftracetest tries to unlink a symlink that does not
> exist.
> Use rm -f to avoid the "No such file or directory" error.
>
> Fixes: 7dc1e125f07a ("ftrace/selftests: Add softlink to latest log directory")
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>

Looks good to me. 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, will you pick this? 

Thank you,

> ---
>  tools/testing/selftests/ftrace/ftracetest | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 246d7e1d015c..95804610e079 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -243,7 +243,7 @@ else
>    mkdir -p $LOG_DIR || errexit "Failed to make a log directory: $LOG_DIR"
>    date > $LOG_FILE
>    if [ "x-$LINK_PTR" != "x-" ]; then
> -    unlink $LINK_PTR
> +    rm -f $LINK_PTR
>      ln -fs $LOG_DATE $LINK_PTR
>    fi
>  fi
> -- 
> 2.43.0
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
