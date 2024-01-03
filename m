Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B81DA2B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIFhC+JR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a282cb36d37so252722166b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704319624; x=1704924424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=FIFhC+JR94gPZmt6bdpLxo31FgCF8ds5TUEmsVAFCZF9uxJpbkJgGw5zZ87reZHYPd
         vf3zYFoIFENzFZ6RJ8Pkmdtwsajq08Z7/G63WaBrs8dI/5dXE23M+QD6/I+46Uv+2PjW
         Y84l0I1EyLwPDrumVylVnfUjToxh43zm0jts0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319624; x=1704924424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=IhFs0U/7sBX9LzEx5AbC+VtBJxIbzW7BiTZGZleqtIe2iz8zZZoEzvXRxbyziqDGCJ
         sWfe+QA35fxbATmmqBmqWCuHUVJ8uXbMvBdyKTLuQTEOEywfdV/KX7ukKVqO34coP01k
         3RXENNyEIeIQWNTsATNhNHTJ42m0cfatVcBnxSgKEd8J8EsLpKVu1rsFqxeKyoBIRDwX
         0/VKFBYTeclRjJC7KDNdct/rs3a+bglD3hlTqg1poGTsxrlxyY8YWeXfTMkvSBGYdsOe
         lCq7wFQEVc1kcLi4YTcDKoIdPtg+gpEk2vpZ9AMyj7sPWQLm1AGq3jstuL8LfRIfta2x
         U3SA==
X-Gm-Message-State: AOJu0YyeA3O4uAywvtEMlvwSWiY7gwcdmJ3eAoNpFZS7CTO7dt55sNh9
	V+l/vKtxN5pptVrKZzq/dSuEb9jaO/RiWf0Wfa+CKzdmp7f6Esh4
X-Google-Smtp-Source: AGHT+IHdRpAxcgskzp5nHbdVTb2sh1JvoqMENjytnhbpS4o7P/hv5BEDtXhWYB9easB6w3n1nRwizQ==
X-Received: by 2002:a17:906:6dc2:b0:a25:c27:11c6 with SMTP id j2-20020a1709066dc200b00a250c2711c6mr8712811ejt.131.1704319624254;
        Wed, 03 Jan 2024 14:07:04 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id vl5-20020a17090730c500b00a2825a9e1d0sm2536457ejb.174.2024.01.03.14.07.03
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:07:03 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so60538325e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:03 -0800 (PST)
X-Received: by 2002:a05:600c:3c94:b0:40d:62fe:a160 with SMTP id
 bg20-20020a05600c3c9400b0040d62fea160mr5605515wmb.93.1704319622802; Wed, 03
 Jan 2024 14:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:06:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's an updated patch that builds, and is PURELY AN EXAMPLE.

Oh, and while doing this patch, I found another bug in tracefs,
although it happily is one that doesn't have any way to trigger.

Tracefs has code like this:

        if (dentry->d_inode->i_mode & S_IFDIR) {

and that's very wrong. S_IFDIR is not a bitmask, it's a value that is
part of S_IFMT.

The reason this bug doesn't have any way to trigger is that I think
tracefs can only have S_IFMT values of S_IFDIR and S_IFREG, and those
happen to not have any bits in common, so doing it as a bit test is
wrong, but happens to work.

The test *should* be done as

        if (S_ISDIR(dentry->d_inode->i_mode)) {

(note "IS" vs "IF" - not the greatest user experience ever, but hey,
it harkens back to Ye Olden Times).

                Linus
