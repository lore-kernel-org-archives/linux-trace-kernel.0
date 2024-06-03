Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0213CF8C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454321; cv=none; b=pAuMV1GfMOtNpYBB801Hx5qyovF32AQHTEoF50y2gjmQpgK/ESTpcWtCUIIhUBYcuxOaENQS4TapbF8iAyXCfoVN2Izkp+67fPTT62aF15PW13u9vLcmjheYE05xLI8feeSlI4GokzZnR/q6JsEUyOMLTpBFAC/rMl3m5izp1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454321; c=relaxed/simple;
	bh=ADQ686y0LUmppB8hKb1UqpO0JQXUA06qEhc0vs+CvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1NvGvvHn4H4umGs29xu2SVf7h5g3sUjHrnzPdz2ggtYStp1r4AipWMLrqarbhbPPe9bOIVJlQjcYbI6gSpBDAW2y9G6gGF6TzuLKdiG5dJnR/PGSSKhrleWO3H6jlYGQ8lXKfkcM52Nxo+ZODLRYHC/hC4chfvak507Ea6lcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GlLbdUhx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GlLbdUhx"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso51548731fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717454318; x=1718059118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=GlLbdUhxMOvfv07UbuQp52IzwdbLEpzUyMLKXMF+3Sd3FveyGQ9kiponRzzOcpMI6T
         emqgoJVIwu8WT9FqW+p07vqBAyXhgq+fwevyFcKUJiULsxWdobvwl8b48coCz7mCa9oe
         PdXEK+mV0+PmDWLF5beeySzOz0sai6fZmW68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454318; x=1718059118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=d4atFrHYBsJ5eXW7cbo7TNBuK8hl/Jb85ZyPrzG1I/K0JFmtv55W96TakpRtAI6D8X
         09f8li1E2JdtXHztx8bFh52ugSz8+60Wdz9PUPmEtDVqpRtdUhUwsMub4ty1SIb04FXS
         gS0ZBn/6/QiOt6CB35PU0Qkvrf1wddLCy9UWdxjowNSKul5YONlfzFsacGMtXy/fsVRo
         M8HivlHgY6pIBHYHNGzrZYIEo1hsDmKSQwrLxgn4HEzmNs8A8TnFSE46k/xa6EZNX8sn
         UWAVrDnBcZCCMjU53iXbQHatVVNcXv2k8zHXXt4VCehXOmmYI9YuM24CK2XVvw9Qc/zV
         jwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUpmCPLnOvfCTQA+vXKSxCBz+Lj0V16Vxbm/hiuBqzCho7oQHOiFq1PAw1d18pQxa6eFp+j/ODJDiWgsseoabX0ByxQq+zv4Ti3lLRhVsxv42fv
X-Gm-Message-State: AOJu0YwsGt3WPyfl68tCPevONX/nzO16eoXaWOexYDZH8xScFOYeJ8Qo
	h6qClrSpVejmtN02TkvYteB52QPIj26vq8IJmtOJx1lgFb/NI3F063qCHBbYCIlPhp3I+GoHxKj
	HXu/lfQ==
X-Google-Smtp-Source: AGHT+IH8GxI/zQQChA3GBckpgJ3hOanypMtqIYDHtQ/36Qc4ctrKjAKwKXXxI/c5ezHAwYpPOemmgw==
X-Received: by 2002:a2e:a7d0:0:b0:2e3:9350:a7d2 with SMTP id 38308e7fff4ca-2ea951ddccdmr82748741fa.52.1717454317897;
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc7bc4sm12818771fa.84.2024.06.03.15.38.37
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b912198f1so3691343e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCdnrbgbuajiP/aTgvsviDi1Ib8Oevba0TuJXDngPqQP30O5gaVdpKcui9sgAfu8OhPJpdk63qgmB5fmgfZIr03cmOEKPv/lVJ4g3TN4C58uLs
X-Received: by 2002:a05:6512:159a:b0:52b:9f37:3ec2 with SMTP id
 2adb3069b0e04-52b9f373f5fmr1374809e87.11.1717454316895; Mon, 03 Jun 2024
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's actually a 4 byte meta data that holds it.

Ok, much better.

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

Ok, as long as it's an actual improvement, then ack.

            Linus
