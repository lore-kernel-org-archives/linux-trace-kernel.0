Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6516415
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848509; cv=none; b=YxDltkiCER5+D0HiHN/r2JrqSzlwyDFehL0JsWh5vvjTC6QVRmqR5BeAi4yMwlk+u7+o9xolf5mn+8lt+NchiPBMcqEinog+sBCrXDc/E2nQYDdm+C/1PR+XdpNdCxKiCOtIMEeUqzl1sna5NV/pfNNjm6zd96o3d1mQDsc3WiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848509; c=relaxed/simple;
	bh=ykrCsBxsPgKhyE3GYL+XJuoXa3s/bXlZI1ZvQ8tnwOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCW/wfcPw4xLu91Vl96fTN6Cca6+8hdpy1nAp/yI4qZhVhYzMVjY7krQgI/ObVyQnfMLMPbqBDunfZXok9e3reYGdTami5bQVkxSKx1aPiSags8WRryrjfc/qw4jtSu+jRdtRM0kKd3ia+jjBh6bz5DI5/8ciuVre+J+5klGsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RhcAV1jX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhcAV1jX"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so6266131a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712848507; x=1713453307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y27o1QGaPj1N7cZ8H8ZqjEg3waA9EItOMXyHWJlIzfk=;
        b=RhcAV1jXYquKsfeQAGdwKyX38/JQZ67w2RROeMkzd00GXyVUy2w5m1/NQ0vT9LdD6r
         /xuwKZO/e2OD64H8Zx8VoRJSgpf8TYgtH6sFlO0XZrb2Sbrf3yQFdFO+i3tzdGmE7Lx3
         zQxjiiydx/fkL1xsUzNnsU4dyOiRUq+Qfa+HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848507; x=1713453307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y27o1QGaPj1N7cZ8H8ZqjEg3waA9EItOMXyHWJlIzfk=;
        b=REptnrbnTJ8WESqBjXEjqEXVyrJQ3uvivzxUiJSNNvS0DSlN+rNEvLFxh/4VhoD3jV
         DG7YJ7kvQGfQX9iU46dGpLYuNGEYrd5uQFD7XVyzoJWKzUrq3sP1pU9tnnw6ax5t3DvK
         m7z83FDCS8Q0XELa8EsnFNVGlAfFkAsVvErZXtr9bfu2ca7hk62qsVCUy4hrNCvZkLzm
         loXgzJdnvxxsdsJwQbOArPJqlvfH7nWN+bVhNi232NaLmokM5S4aCN4YXqxIoHjCcY1y
         9SbouQLaSAk4YxdfSkyYqTg8J0f+JqQCxVqUq8CFvuEnnNsJH0BkFxRiHrMgW1wxlbS7
         YGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeI82yzxZOKDQGyMYXNN8o0AUxYyAtWVNgw6lnllwxGmM10AikXLYnns6a1ck2VXv+stzRKQlID+DkqqDqjZMo/EYO0iMXXSNPkL2NcrUYOSD3
X-Gm-Message-State: AOJu0YzQqTkAZyyZEVTqKNm0zTmAuJ9Ax1Q7vcPNnqzxxCnXP+gDaJ5i
	O2lkENgdjKvuT8iOnU9k+b/N0sQfm9vvp0kbcQrdr9MntZO7eY+UdzNlUywVFQ==
X-Google-Smtp-Source: AGHT+IFXnLf46pENpWqaLeFh27xQfZIeEOpHx3elub8SYDi07FpFtNbcgpbZ5CexGlBw+CMhsVGm7Q==
X-Received: by 2002:a17:90a:bd8e:b0:29f:7fad:ba50 with SMTP id z14-20020a17090abd8e00b0029f7fadba50mr5988643pjr.8.1712848506772;
        Thu, 11 Apr 2024 08:15:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090ac20600b0029bf9969afbsm2963349pjt.53.2024.04.11.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:15:06 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:15:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Message-ID: <202404110814.B219872F76@keescook>
References: <20240411102158.1272267-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411102158.1272267-1-elver@google.com>

On Thu, Apr 11, 2024 at 12:20:57PM +0200, Marco Elver wrote:
> Add "sched_prepare_exec" tracepoint, which is run right after the point
> of no return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
> tracepoint runs before flushing the old exec, i.e. while the task still
> has the original state (such as original MM), but when the new exec
> either succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("sched_prepare_exec" to "sched_process_exec").
> 
> Example of tracing output:
> 
>  $ cat /sys/kernel/debug/tracing/trace_pipe
>     <...>-379  [003] .....  179.626921: sched_prepare_exec: interp=/usr/bin/sshd filename=/usr/bin/sshd pid=379 comm=sshd
>     <...>-381  [002] .....  180.048580: sched_prepare_exec: interp=/bin/bash filename=/bin/bash pid=381 comm=sshd
>     <...>-385  [001] .....  180.068277: sched_prepare_exec: interp=/usr/bin/tty filename=/usr/bin/tty pid=385 comm=bash
>     <...>-389  [006] .....  192.020147: sched_prepare_exec: interp=/usr/bin/dmesg filename=/usr/bin/dmesg pid=389 comm=bash
> 
> Signed-off-by: Marco Elver <elver@google.com>

This looks good to me. If tracing wants to take it:

Acked-by: Kees Cook <keescook@chromium.org>

If not, I can take it in my tree if I get a tracing Ack. :)

-Kees

-- 
Kees Cook
