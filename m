Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHoMmJqx"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E881A7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:38:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cd85d370c9so1651709b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131908; x=1701736708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=CHoMmJqx2jS7RlyJHItzIsplrhkC7rN3aK85plOL2Lw2gY+KncgWnls7PVO1wvMEVq
         4aYi5rZbGcaErAxVkuJzQfUjp5xN0qoVe5b4FOh+F+ut/KvxZVVh2oyBIFWYzwGDfMVo
         rfrW6qRFOMcCC5wqPKSovamCLNZYzVlIikCKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131908; x=1701736708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=QX/uAD/ZhZiJ9q5vUmWz1MUffBFnJUggwanrts7edP7Al68+gypOSm3+yMDgDALqQJ
         s+gkSvHlCfcjmnZ6Bw3cSJFHdbyhaaEQ5OXvgthvU6yiPHLu3meEd+h010yPaBbbPI3M
         PCSdWEUau7LVgiBRbE8H3dMpdgo5mrjDIWL1tI/atiFrd2V30N6LQXNqECU1OBFtuhtt
         PcAFqqU7qWqf+DwzhQ7ECM10VVsUohULl0g9Yw/IY0LJ9FTK73U47HJGkM8ucADiDDrF
         3lR7mZffBIJ9eBEw6TLYid3oNpQ83At9X7vPnijqEjeKKTwK1r8H9KV9CHOXxbReqvJ6
         3cmg==
X-Gm-Message-State: AOJu0Yx4/r7AEyJ7oyssi/RUy5Pb5BX0zMO8McIH8sow7hDPqwONtE6x
	pgkfs/uNbA4GXqZ8OJpc1aNxBQ==
X-Google-Smtp-Source: AGHT+IHAitSTcXoIZlZjvSV2TgClAiDRvzC+m7Xe4lYvQu41xQFuy0SB9v8Un1QuYXWLLWDiwFuTWw==
X-Received: by 2002:a05:6a21:3514:b0:188:1df7:9afe with SMTP id zc20-20020a056a21351400b001881df79afemr15530469pzb.30.1701131908573;
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b00686b649cdd0sm7815539pfa.86.2023.11.27.16.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Date: Mon, 27 Nov 2023 16:38:27 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Message-ID: <202311271637.38C4FD46@keescook>
References: <20231116191718.work.246-kees@kernel.org>
 <2023112751-cozy-dangle-3f5a@gregkh>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112751-cozy-dangle-3f5a@gregkh>

On Mon, Nov 27, 2023 at 01:43:57PM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 16, 2023 at 11:21:22AM -0800, Kees Cook wrote:
> > Hi,
> > 
> > One of the last users of strlcpy() is kernfs, which has some complex
> > calling hierarchies that needed to be carefully examined. This series
> > refactors the strlcpy() calls into strscpy() calls, and bubbles up all
> > changes in return value checking for callers.
> 
> Why not work instead to convert kernfs (and by proxy cgroups) to use the
> "safe" string functions based on seq_file?  This should be a simpler
> patch series to review, and implement on a per-function basis, and then
> we would not have any string functions in kernfs anymore.

One thing at a time. :) This lets us finish the strlcpy() removal. But
yes, replacing all of kernfs/sysfs to pass a seq_buf instead of a char *
is on the list. :) I think I see a way to transition to it, too.

-- 
Kees Cook
