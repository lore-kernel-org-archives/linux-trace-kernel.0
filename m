Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53313C69D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=tdJrZpeizKFMT3WkfbmXtsmMOHm9V8BuGMPOiesai1ENjCi/W1aqarUSQ1gj0dNul+PB7JCeQNhWeDl6ooQto0ZD4Gsuubif1eGPtLQmLQ3Dk/b0TrGF/I9ss/y9Qu7xZXGC7KgKXugT1KCJXHkl6IHBeZS/bcZ3I7dpZ4/ns44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1eI4ZhZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1eI4ZhZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso5498231a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450949; x=1718055749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=N1eI4ZhZlPjf68UnhLGKgEctRtMjOntNIkVhWbizskPmuiRECFIehLROdwxyzTQ9AH
         S9cP0MBrkfaqe7srvrEyx01OYady8bCw+zGe0+e6RweNuBb176fwD8b5ZT0cNBTt5D0R
         vn7DjORx+6oRGzNKhQi4sA6ri3UvO20Z+ast4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450949; x=1718055749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=xD5RwZXTFoqBsk0QBSi+J5zit8eu0JQDG6n2hS48bX+K6fxFbxtP+RnFJEDJYJyiQF
         IVp3IqNG0mqw7rYzBDPRGjvIuo4RZBbn3bydLzM201jVLb2+vGXyQ98CGYNvF6rlftb3
         AY+mH2ZNxZ70zIrkbG32zbkS6AR/46DlsTH4w8diQ5etQaBfnr+xS3mtsjXOWjEiQ/Gl
         oi65Vfhnqs1/5JWtSE2Lg4WyV1sm91DYZjtUbLlaCMQ3+IuiRd4Rcjb5aCAjU171bg3x
         FHo+zvyBiNNllFSS6xp345nvzemI7BN6NecKdbh4G6wEXfZMoA0QhW9lCx5wzHorFCNC
         pFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdhPZz8HMXZS3yeY7q/3GLHfmgxSJBsf7S7e2rhOD+ZB1TdISBkctqowvxZwaGoMlblEGRmkvlN0WaSwXDHleBO/C7fECXXHizz51YoLHLg6hx
X-Gm-Message-State: AOJu0YzBzehAWkNVOd6Zn+VAQuRYUGAl8mB3HiOmn2nzvGcE6oVwV5cU
	mSZD8Zd4RgHD8RG81OwSBGxaRlNbZswvrzsZghPfr03BwDub/YxSZ/urNC8mp+TdOinGEZnt3x2
	jsi8=
X-Google-Smtp-Source: AGHT+IFtXfSmhVyQyR9CV3r//+y2i/TydSs0pdkAPV7cr33pbbmooM5dMsyFXXcVfbUNwOT37/Z8rA==
X-Received: by 2002:a50:ba82:0:b0:575:954:7ef with SMTP id 4fb4d7f45d1cf-57a363460c1mr6587526a12.3.1717450948888;
        Mon, 03 Jun 2024 14:42:28 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6b2b6606sm1352682a12.89.2024.06.03.14.42.27
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so368617566b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnwrGjRhhex81S5fi7MNEoHmY5YasspM68GzGMRfjNTojHFOl8U6H+aVeleMVcvRHQQ+W8bO3VbIa3Q3YTw+mD+2jRRwcb5tsaE5Pgv3wqWmu/
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus
