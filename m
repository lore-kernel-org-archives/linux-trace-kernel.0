Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3813635F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994455; cv=none; b=HFCXQ4JnzL5LyhV/hCg45sYZYewDAiVD20SKQ6Y15HaBZGpjtKEN+G4a7axP+6KDa/TkdkONQSDe1c6AhBaxmUQ7vPzQBLjPqBjRTJVG8sqSHy61v/WQjIpiyVVWVRmgrpl7gY0jxtUA0JsRmWL1HxnIgNmP1Sfm6q1M6cBNyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994455; c=relaxed/simple;
	bh=q7aUlAO5/MOpZSfzW9v1JQwkZZ72douVaDPqh7khpB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFZNCt+2T4kbA49VyJXLgIFvir80RIkGuLokkYyo94SpFbEMxDsSUds0k1ezkLsmtTo49pmV+0+T6w9GYn5oSZoHDthNUvTeMSWhGOGUjn7GaEhTts3n58CBLPGycfeoBl+4gBUCb3b/2OICFlC9jtsyEImIRQxSbqISOzGbdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tcervsqd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tcervsqd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e59746062fso902517a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730994453; x=1731599253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bj3vIwGn1S4kVdNYQ6mNujveZuFRmeI++CpgKvIkmVg=;
        b=TcervsqdleEspdvmxOaxBRqJoan6xcaDI0vhHb5FRcuSZy1430Zyi6uIUbCCif/6Lf
         aS0zTzYwA7WFORLEFHplVLjA5u0+2NNgf5+bfQ7bcDDA0GrgjoEFoHGh4zSQgifU7KsS
         eN6ZfaJlMzWEQUGhpJ4bResGBObaOax/U810CUnQgXn8qP1ts+KJvjLeq7yAyBIt1yqI
         iCDoLVRQfptB5em2uIqf46hd5wJS8XMbNKlH6uuQU/aNn1R5ofoNViFDN8iWXLGxVI9t
         KDrdeicEPJ3ndGeFwzOfRcuWuZpvKar1R3eSd9yWYWXoZTy5FnSWdwyP9KnGNGtWN35D
         cuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994453; x=1731599253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj3vIwGn1S4kVdNYQ6mNujveZuFRmeI++CpgKvIkmVg=;
        b=Bfo1hOHzmfzzAeXIOBLXOOVfS9w58TmoDs6gWk5hvCuDd2CO/Oe9Unn7HMCVA48ApX
         oJSkSO5PRasdgfxX4gGGH4CHPmLCbo3eA5Py/g3vjYKwAA8SG6PgOmnapzQAiebhtXvo
         3bF3bhNFQ8QoiGXLtN7o7RsbGA/YHqpady4bJrH0RPxgoEnPAPXnPdreZP34vjaeXD+B
         9lEy/htqThAgaj3OkeUnt2OT8gnGxQUGliwuXfvrJTw5j9/sakQQQ1Z8YZ8y7AYNibjT
         vBdGZqJtJDUqATS/qQHrdUis8WTfFPDUUmD5ahG1pYFHI6ufrodYS+fr5HCEWpW2yTES
         53Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUFNjXALInVbZZZ0cKxAxbVKIOGB9Fr+R/0e5Mh3O4Tb4OzPieuxgjhh1nmV9YS/tx3b7hIQAQ98J1Zpg88eUjC2nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+m/YW2a/3tz/rcsK2+NjUP5/XXCZFVyO5mExoQZdBltrDbx/
	V+CwPvRuJhKeeDVFcg99Qn9Sq06e//t3JoX6Wb1A1NkOUGeM8ZiSkwRtkM7mqjgzpx9IXkzAT7+
	42E8TUqTwF3UOmFXqsZGFsMdxDjIcMNw0wilF
X-Google-Smtp-Source: AGHT+IEV29w84+mA5Ghb6DvHqpfh07MhHtO765NcSIgHHok0eidtFkdF8cvUmAonUflKYsr5KtQ6Wv9RdfNBqnD42JI=
X-Received: by 2002:a17:90b:2249:b0:2e2:e743:7501 with SMTP id
 98e67ed59e1d1-2e9afbd3778mr526668a91.8.1730994453173; Thu, 07 Nov 2024
 07:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com> <20241107103410.44721a3d@gandalf.local.home>
In-Reply-To: <20241107103410.44721a3d@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Nov 2024 16:46:57 +0100
Message-ID: <CANpmjNPiFxkZ6HPXYR0Xz0i=0p-ksEH4tC19fsj1fAwP1XkAjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 16:34, Steven Rostedt <rostedt@goodmis.org> wrote:
...
> > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > +              unsigned long arg4, unsigned long arg5),
> > +
> > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > +
> > +     TP_STRUCT__entry(
> > +             __string(       comm,           task->comm      )
>
> The question is, do we really need comm? From your example, it's redundant:
>
>   test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
>   ^^^^                                                            ^^^^

Ack, let's remove it. I will also remove the "task" argument.
