Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186424;
	b=HAM6OT1dc4cJZ9dAfCFwaeeIo3LlIKqaxeEUAP2o74ILTvZOuqzqfupWhGSItBjS02hn
	 57KvyS27tqP09mok7EJdwrvILcKQT0atk2EnqIqGtjaQmQfIdMx98A9ICnswpmSo/TEEE
	 O59pRtm8Nu9euTssXwWbiXq+QKr3EVeToQQrvSF0vA198pgfSdwJyBVgiLTtDA4Xpfyen
	 IekyFhyIUXutb8UfY/nsodr7HQqqSjxBXJ8cjb6oLmyjrBKjbSWMvHbwDfjvQVhgYOgD0
	 fXKO8niI/UiSYpntLnQFlbomxVQyyW37R4Kf3jgDYzQCgHPU6NxI+O3CbbK73pSf2Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ajE/q7I1zEJfBxj1a/+xtjsSSjXlOJNoR4NX2ZgCrjc=;
	b=aVzyquuxSIuMKCHTqhlkbfFQU2Vrx8cEThq+0i+jqObHGoycsCtPVIQQv8EBOcf43OpM
	 G5CHfot9Vltuq0K+igOPHhAVV3RlNqUmneucftHxV/Fsit0wPPGK2Kd+0ufZvHSz0SBFv
	 C7/Fk0fShnOjmxvm7yh7ajqUH9YsjdAOZg/WyMM/MX/lQng3PaiWK2kW3v0ihgLBN16DV
	 BlC1tuCJRoF42WOJu+FhyARM/TSPyJMKT/fD0HaJ6+hiF9Dwa27NbABCvBOfnOHCwMvjz
	 TgQuvKpjBUohxbiSj096U2G3sFuQZp84bg9Zc45ithFWeQYVUYmIEPP/qvpj6gZ5aEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f5mMdR30;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF69606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 11:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f5mMdR30
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df54150dfso503024f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793186422; x=1793791222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajE/q7I1zEJfBxj1a/+xtjsSSjXlOJNoR4NX2ZgCrjc=;
        b=f5mMdR30W9cgBi+XZgA2ln5U2NTFxZGbRtrXBHwZZY8F0J/toSCU9sQ/HE6nIAPoRk
         O5McOg/f9i8nwom7WsNcm+NBLNGqVcdXsXXk10a70P5cr2hQC+Q4laX3VCrjn9RuNsPL
         tZDi1h0xCv6kN2o69mJR42wcK/TRM7qzHrFXSohz9Mo/LaiIsvFrZU2QrY1qI2D2BvE4
         BVWphoPn8pyHDq+NPGIw00/erE7qslDAcjvy93WK4eEI+qZ4pAUXYlQZChVRfd0cFqOa
         RJLxYIuhfSWOXRNmxn9A6GpkbbqNHtdOsaBz/GyCJ5oMVvG5qMKHQpfGu8qrKQ5J+JDT
         UmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186422; x=1793791222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ajE/q7I1zEJfBxj1a/+xtjsSSjXlOJNoR4NX2ZgCrjc=;
        b=ogVESMb8XPgmx3H3RpyUkjKyd+KVjyyN3PNocQSn2OWTFnG/o0OXVNTR3W3wS+cZAM
         6OTOvlDNPmkGpgWiEkamWPjuaflTgkREsZust+ZEth270GCnxLCXp56O2lZ/vpF1w6Jh
         9nDtXx484+KyPwFHVLfvR+J9PB/eQr6H5cCYerKSFh5yHPc7gPkM44EPJHNjmOhGfJaZ
         CjZW7VFRe5DyHAbA5r8B+ZY9bA+6Y5wnXUG9c8sczF3TAppzhLZAqYV0ssraSoqXUJpU
         X+LQcIbJyxKoLEqZVsZkragm3kA67+HNi3To78cLgs6SbafKioISYklBD3QDIPcf0tnr
         43uA==
X-Forwarded-Encrypted: i=1; AKwUvBxycB2lyZ0OsymwkJfVY82HJ+0oamVeC4+PWsObmTn4uiads+OOGBVevl9MEFZ0584fNgf2wNblavN7EZ290kLc7f8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrUPXHsPxT+JDUe2tPiyaLbbVoqhUwkenwE6QjADeleDFB/lmj
	Lr2X6W994tdGXZWG3O5Qy1a8H3rqntDzoldayQozaMie7TwU+Y6Dk75hRVe948Lxiw==
X-Gm-Gg: AYBFou2QSXaJWceS2NdfSKMQ7dTrOp0lsjTxzq+yC0orf0rntjwMaE+tTzj9ZThB9zB
	JONOSfelhbFkfJZAJqznXmqtXvM9A1r2JzVH4KnkzQArq9CDeAYsRfSs+C0jGSbfttILyyyfUcR
	YMbKn0mWZdgK8gj0zE/uxUwGTZFXnzL/jjPejJDoqOKCDqeIP0Arp7w2+HlZ7TuaruCfc+UetIO
	3uoFpDea/oOdvNImA79wY2IYin9z5iP2fxGA5t0f2TExPylK5nZvoBox5X26jeaTJGKfHc5kuya
	D9H1lSjGUttFibwxsb72YN4JvU4nBTrpa7jav/9ZnCgNgCMoXYp0Bl9oJCgCtZHJmbydWNnmo4w
	jol267RfI3rf97aELt3/MP0qgE30sDpNv3PHXmqZuVi+iF40JfeGk8Z0+w7lOUCDFSXL2SSyyfK
	2uUx21Z1M0/cTfdgtX7XFpxHXIXsSwTqD2/mYgffo9jIaQO49y2v+A8KXHm7FOaAAk5E321UnVi
	PxqUhlmIgqZFryUPt1Qf6qElJuVB73ahGGhtRWxkVSygNwkKGHgCGK4kJbRXilXYjnEL7Vxzbub
	0djD9rCo3URyNcI6mgxaSr8O2fUgzm76haG4Ysj7QlZj4Q6HpMgIGEA/k72Fnf6UFw==
X-Received: by 2002:a5d:6f0d:0:b0:48d:f851:ee5f with SMTP id ffacd0b85a97d-48e5d5bf164mr5101226f8f.24.1793186421919;
        Wed, 28 Oct 2026 04:20:21 -0700 (PDT)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdf9bdsm26871943f8f.55.2026.10.28.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:20:20 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:20:16 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiang Gao <gxxa03070307@gmail.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	=?utf-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?=
 =?utf-8?Q?l=5DRe=3A_=5BPATCH_v4_1=2F2?= =?utf-8?Q?=5D?= tracing: add
 ring-buffer memory usage statistics in tracefs
Message-ID: <auHacGXSJqCe983K@google.com>
References: <arJNSjKsJ3bK40dH@google.com>
 <20260924102755.02084435309be26f664e3333@kernel.org>
 <arTlRPvmR54Fa71o@google.com>
 <20260925100908.66c46353e5a2abeb73b1e15a@kernel.org>
 <cb0090dd1ad84a5b833e9323fd2b05d5@xiaomi.com>
 <51b25b1c996d4412a0c43d94acea98df@xiaomi.com>
 <20261014091839.11488a0c@gandalf.local.home>
 <4f9c82054c46459688d9a69df58293d1@xiaomi.com>
 <20261024080423.069948c9@fedora>
 <be9ca24989634d79b037f8ec1d16ac65@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be9ca24989634d79b037f8ec1d16ac65@xiaomi.com>

On Wed, Oct 28, 2026 at 11:14:40AM +0000, 高翔 wrote:
> Thanks for the explanation, Steven.
> 
> 
> May I ask when the next merge window is expected to open?
> 
> 
> Thanks,
> Xiang
> 

You can refer to the estimation here https://deb.tandrin.de/phb-crystal-ball.htm

And spot for v7.4-rc1 

-- 
Vincent

> 
> 
> ________________________________
> 发件人: Steven Rostedt <rostedt@goodmis.org>
> 发送时间: 2026年10月24日 20:04:23
> 收件人: 高翔
> 抄送: Masami Hiramatsu; Vincent Donnefort; Xiang Gao; Donggeun Yoo; Mathieu Desnoyers; Lorenzo Stoakes; gao xu; 印闯; linux-trace-kernel@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [External Mail]Re: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics in tracefs
> 
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> 
> On Sat, 24 Oct 2026 06:59:28 +0000
> 高翔 <gaoxiang17@xiaomi.com> wrote:
> 
> > Hi Steven,
> >
> >
> > Just checking if you had a chance to look at this one. Any estimate on
> > when you might be able to review it?
> 
> Sorry. You sent this out when I started my travels (Sept 15 - Oct 10th)
> and when I got back I had a lot bug fixes to handle before new code,
> and then the merge window opened. You're patches are not the only ones
> that were postponed. Any new features that were sent after Sept 15th
> are delayed to the next merge window.
> 
> -- Steve
