Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C21F0E34
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653565; cv=none; b=nejZB/kP1O4F8b0cxfvoXsh2WhUstHXvWaJQU5su4TEtDp9w7FeLzC0UMtDranIJl8BwKhlGbJu0Ppr1h8wVfZpWsiwIFqrZyu+GuwxYBpUYCn6Ie6wtqmhe57R15zX2hvNzcFgdGihH4G7nuldC543vobDtVeBArtcn0ns9Z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653565; c=relaxed/simple;
	bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GHCJh+/GXMCnamliy4RkPLAbkrCuvzjCyqHTVnSNWF9UcOltmNKCEtUru5P63wgyUTT5TNYtUJv79gup1eq2dD+MK4qlvhU2qUvmRSu6bJxqrXB/2y3gKdeRntRw3pSwirMlMwxWjRLn8qdToPGtROXyQwwa0YXW1YYy6mhJa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n15ShtoL; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n15ShtoL"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c89d754dfso198084b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 18:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769653562; x=1770258362; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
        b=n15ShtoLOVPomZIIvAoOSK9mhJ607lf0UQlFSX5mf9yGtXwuGtGHYNBguwxU6oGmew
         4fNpf2kOQQL4u3hAN1uI8xKceb7/emRRJh1fBIBkm70+u0SNJp75Cfv/hRY7wsEeq8QJ
         4kNUwKrW1YeLCtbKJuUygaPqcyZSD4hW2OnaxsMDbQCYuldgBbSW7JrCDOhJYmzj6AM8
         2Zp6CWqI3Dbbv5zYcGRN9YpcDyiU7nP78Bkxv+l0WbtK/zdJkWYnr8OlOm8MOibJNV3i
         fXVU0bFzrqiKb82Gy2SToHpBK8Lq/yjuoeIm3ylLu5dEIaQg6btL7ZBuzlpULVvrNFbL
         VGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653562; x=1770258362;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQMG62klzk7My02okdNZGZ5OJ2y6Qu0CKZDTi7zTjZA=;
        b=kQj+V+avikGJYWyYy+420IykdxGblid29efwRGLxsV+RMAq8SI62FsZEJ4I8HpD9Qt
         SS7UifTK8ZcNW5z3M4LRie+Hk7601SKESfsyjuz82vCqumouu2XCdCEVj7MiebjLLGo2
         Ieu1q3FKimpwfJai99c8M6AKshaqxL+XlFDXLdtpyE6uupSgv+KOzno2Bdq+R38lQPYI
         3VeE5BrhYVm376EQdVcQ/KBIJHfA93f+RuDu+X8PeNl1ACIzXoYpxOAxm8WG4LR23UCk
         fwapsKLLKb4roIFHaI0BlPnI0Cv3ngEU7bcIqk6gd9OQv0kKVkNpvAGrKuzKKb9+U+n4
         2Sow==
X-Forwarded-Encrypted: i=1; AJvYcCXETJpAUSIl0dhN/DEmeEAb8Z+6SiayhmPylpQxZ7eYZKc7p0fDaF2WxAPv5yXH/uANEoGz66DVXQ9ufsukkiwSZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YOmDYhQo6Pn7uTT5/QX0shG8QQCgcLow37i5s5cDIZdc6zda
	8bakM5X+ESEaKjWlUzdtecN+udeMoS8kSdyWqsHK2dFMc7xDxF2evn80Uoy6mcIDBrpOD/jsAaz
	W7ksDVp0=
X-Gm-Gg: AZuq6aJWg5ATLfUS6wKpQRe2kiZiCMzWxWZku55zZbJYCjr9vYM/0DKP70VAc9uv178
	NCHLDpBgXPZXCDbY+Kh89vSPmhdc9/uIn/EWQoXbgVXvYkeQ/qgnqq6kns38XJIBg2rzAO7+7lU
	PJKvsKXcKdj6XfcnE9z5LcAd+Y0jeTIagddFQww/nb2ihQ+LO1azetfceQzoafm9N8GO3fgR8ly
	6NCIUvOshAmatjTmRFAm83hzNKlZUfUHZYFVvc+cHnp8VwOa7PdoPb6IzKNv5YU4fPDo8F1jK3p
	istNCJ17VyDFuordoc3dd+v0uixl+XO93P8qJdIwV/mE8r7+6FSrbD9gP3whAkJp1kxA4kKupML
	wz2/Tjutv4jZeMN4G2DUcHMbKyMM/jtK9d5psq5QZdO6cTV6lNu+3Vyy7mLE6r/It4fW7hLNmF/
	Ad3CvniEwToHEMvL46XYoFO0JEkZ1GyyM6HduDxLsovQ==
X-Received: by 2002:a05:6808:221c:b0:45e:801c:a0ea with SMTP id 5614622812f47-45efc6d0628mr3467328b6e.32.1769653562137;
        Wed, 28 Jan 2026 18:26:02 -0800 (PST)
Received: from smtpclient.apple ([99.196.128.181])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f22b4e676sm483963b6e.3.2026.01.28.18.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:26:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jens Axboe <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when trace_async_init set
Date: Wed, 28 Jan 2026 19:25:46 -0700
Message-Id: <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
References: <20260128194104.30051be1@gandalf.local.home>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260128194104.30051be1@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (23C71)

On Jan 28, 2026, at 5:40=E2=80=AFPM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
>=20
> =EF=BB=BF
> Jens,
>=20
> Can you give me an acked-by on this patch and I can take the series throug=
h
> my tree.

On phone, hope this works:

Acked-by: Jens Axboe <axboe@kernel.dk>

> Or perhaps this doesn't even need to test the trace_async_init flag and ca=
n
> always do the work queue? Does blk_trace ever do tracing at boot up? That
> is, before user space starts?

Not via the traditonal way of running blktrace.

