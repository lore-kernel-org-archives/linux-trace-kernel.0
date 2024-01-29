Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265433F9D5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551010; cv=none; b=nTMVdR77f0gRgtLgQx22FubQVsQJtOXyLnlHxMxTt4BR2NMrZNb79O62Kb4rkYQEPFmLa9jRUrJF7JM3Y6g6cUZRmhStSYkkNN/JRvdhhEMwZJl/Y+rGjiElv9P0hhcsAgZNWFymWN2xIUNxB/d2ZSMOt7COGGOe/lHxwgdBfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551010; c=relaxed/simple;
	bh=tS4YyJziMo9kpVlp+pJ1MlqRkete9IXfSfz8JHxqHTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH626DdUb6bkFhVDJCMME8ttxjIEXq2zfwk47KfiX/b0W10hfCeys198t3TKMJjqJ5OdWDnMn0FGdPiCe8Z9VwpBR5gvZ8L65Jr064Tep9pAWP6GyNDkKN9k1lXRWQL7bhibmlG5e3Y4QvP8vbW6sRv9gHnadi+mR1P+biDkALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OyneKBkT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyneKBkT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3566c0309fso215818466b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706551007; x=1707155807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eM8zR6VYCF0hOlY4Lnp7mb0cO2V2uGCLbKBvIv9aWnU=;
        b=OyneKBkT+V7hPYr1zSObEnfZZxK8n4mBELikTjOyYByd1suZviFYm7O6J4CKRakd+N
         gGBeAyurwEuJbZkRw2K4Tv3Hir28wLSLWA0HYCHeenZdO4V8Bm4GGqLywJDXrk7xEF6w
         MLpgO4b6lzuVBwIXFklum6eMdWmc2m/ww+ts8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551007; x=1707155807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM8zR6VYCF0hOlY4Lnp7mb0cO2V2uGCLbKBvIv9aWnU=;
        b=ofQLFx0AFCKWaoRWtSH63kEspAM74RBdqvXNVaZ+G00Wtq/iTyCW5VIhcO7zT2QFqE
         2LYztCrgrJ0ZzbDLOxJZv9TxY7DJNQkVgsr2PAxvf63s7JFuTi55wT95hSE/S7SmJAe8
         YZTzjjmduwwg5tYphUdjvrDTwJ2e7BNF7vkJPKiEtqaavrxk6n6XLb028Ev0o57Smleq
         KJjUis3tY0PKddJYm1iDRSIvz7H2MHu/fB0VByOGGwje6UlNstpU8ZMQla21XqTcqp+7
         m1BgPHK4CCLjlk7KdbtBeoIjVBw/z8iMP/GvY1zF64wJWZJl9XcKAVwDXF9M12luljoR
         Y1iw==
X-Gm-Message-State: AOJu0YxRdesw+Z0Qs6LGvy3Ns9pR2+YNLNo0TLIPztaqvjKbu3Xm6iKQ
	ZlIZKEUBHmfAkiX/opdAsW1F5LF2yLkKjYuIr8plxEdPAeq+YmLciagKaEq90toNn3jlWFfSJ7d
	CtLUarg==
X-Google-Smtp-Source: AGHT+IEo3vnWNPEhWI1YXlPd8SQaczCfWmpIIVlCQC7Xy5iQd5RE5AHdroJdOwQCxOxK0mYgwy0/Pg==
X-Received: by 2002:a17:906:3449:b0:a34:af1e:c632 with SMTP id d9-20020a170906344900b00a34af1ec632mr940808ejb.44.1706551007196;
        Mon, 29 Jan 2024 09:56:47 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm4105044ejd.117.2024.01.29.09.56.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:56:46 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so1340026a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:56:46 -0800 (PST)
X-Received: by 2002:aa7:d811:0:b0:55e:ebe5:f65a with SMTP id
 v17-20020aa7d811000000b0055eebe5f65amr3047956edq.7.1706551006540; Mon, 29 Jan
 2024 09:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <20240129124436.4b7d0129@gandalf.local.home>
In-Reply-To: <20240129124436.4b7d0129@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:56:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPMDeav5B1es50j+fZSK3wxGUc0cWca0obZGR-abrJbQ@mail.gmail.com>
Message-ID: <CAHk-=wiPMDeav5B1es50j+fZSK3wxGUc0cWca0obZGR-abrJbQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:44, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 29 Jan 2024 09:40:06 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Now, I do agree that your locking is strange, and that should be fixed
> > *too*, but I think the above is the "right" fix for this particular
> > issue.
>
> Would you be OK if I did both as a "fix"?

See my crossed email - not dropping the mutex *is* actually a fix for
another piece of data.

          Linus
