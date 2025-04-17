Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489C1B87E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879698; cv=none; b=c0E+PYF5qq1jlVlWWjU5GGWpNtpXkOtW8/zDR31zVY66m4Zr4Nopx7ML+thr5bUPEduSC9d/9CUzVhYYJ6+2Gd/1PjU2yxyGtOgUHQo2lWsb17VcZcF1OA75quIsFf5Nfw86lyandGhBqZzv6yzP10jvpSmMKFY4AUKdr95lGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879698; c=relaxed/simple;
	bh=rNqfOpdvWo3nU+69engpF5Ne/JYJBVZI+48pd8YR7LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTPO/fLUrDewTUKpEbrGoy+H4FOhmfj6xnDN77gT9t1yf9tbZn/svMbI8ciogZtjt2naLyuudZjozpiCODANoxZQ3coTnSQp5+Ai68YSoR2e9mWuOTFUtdlfuJOYOrGHEt/ClmhMhdRGIdCZGlOsApeVbUFi8xZyL6MAvv/NDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8fiXLGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8fiXLGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744879695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNqfOpdvWo3nU+69engpF5Ne/JYJBVZI+48pd8YR7LY=;
	b=A8fiXLGhDcHIDgcI12iDX2SJXKHstMJIa8e8qVz9chC87bIs5QNXs66HSrPYW2zSxj3l0I
	J7onnDiA+yVunCw7AQaMunNCWsv8B6uX61prGNAnchy4vNJN/vwkkrcvkMbf/5M9YXgwuV
	Y96hh0ZSXSvmeLt8AKR9gP+Rt5roEzU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-JpuxEGojM7aBl0Gre4vNyg-1; Thu, 17 Apr 2025 04:48:13 -0400
X-MC-Unique: JpuxEGojM7aBl0Gre4vNyg-1
X-Mimecast-MFC-AGG-ID: JpuxEGojM7aBl0Gre4vNyg_1744879693
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb67aad0e2so10135066b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 01:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879693; x=1745484493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNqfOpdvWo3nU+69engpF5Ne/JYJBVZI+48pd8YR7LY=;
        b=U4XGJTU+omiEnnzubU/AIKtgJSgfRt708W6k7+AAex9eOWyJ+Hu4n6XsqlCrxUwlnh
         MX5UJqrHfkeDo4tcZwOaMSM3OQaXYzbbbxYAkRYCr2Izr/4aS25xpq4oscHn6KjVPnzi
         TucU6a6SGyGLguesV53CBSofznkVVF3lfmeZiKysCPzIngu84GlWqY+Nj7+g/VBcgWln
         gyBseLeSq98kQFc9rtoX3b5BDfeonhmlFWZf9puhRYd9zWABSuuswf+C7JY71HLQJV3B
         R8DGkhoXUl5/xXVi780DKp26FMHoYF8/T2OkiFSSNGfhtR/l/oXrR8pUth6VEOmMlBhI
         8WYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbk/ir/Zxg1FTHSy8o8vnqK+NB+5ILaCuKxzw/8Ppbz4Hm4jRFdl42vmD3DdlncbzpvT3x0QY2hbs+U7Kuu5Om6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUO2UJnILczLqhVQtaK0NKFUbhWOVcwuy9tQuIXdH1XHkx6SG
	C6YNoXcjaFwXsV1FHfjToJTTdi026jdB2xglOno/jTM38RkwJoPkD82rI5/jMeV1GPJcqnH9VzE
	MM9Rm2GyP8h74V1EgIqUfuLwwmEsq9E+6Zjb+TUvy9+e1dASZ39LrS0it9Qb7S5NqSVPKD0cxox
	VyB6BlqVi45Jk9UD1G6JviXRdPYYzTD2d4Gk9IrcyyCVFj
X-Gm-Gg: ASbGnct2ODfTOyIfjMSyxPh/NL4f/JMfG833xaXfNVrGtR93uAoavAJu+7EPaS2Fg2k
	lvU5GarckBORwonn1QpM5380mBftxlFvwIFIVbB5ERlFWCp+1+bE9CCKvZiiQ3ZZBABgje1hAUu
	Kdg/Vzg/ysicmxf7QYIhCzxAe0QP0=
X-Received: by 2002:a17:907:c0c:b0:ac7:334d:3217 with SMTP id a640c23a62f3a-acb5a0a1cc9mr159897466b.12.1744879692743;
        Thu, 17 Apr 2025 01:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwisL56CNB6JWsN6ZU8eoAg09sybzZyfAG5BMAjq/z3wsnSgAeDIcUZetAvErtBlKk9IBiNOC4jLH9eX+Lfg8=
X-Received: by 2002:a17:907:c0c:b0:ac7:334d:3217 with SMTP id
 a640c23a62f3a-acb5a0a1cc9mr159895966b.12.1744879692307; Thu, 17 Apr 2025
 01:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330184641.1929409-1-costa.shul@redhat.com> <CAP4=nvS7nAfrMfb5L8A4DU0ZtGY7cxVD9gTLL-xV9jW3rU1rTA@mail.gmail.com>
In-Reply-To: <CAP4=nvS7nAfrMfb5L8A4DU0ZtGY7cxVD9gTLL-xV9jW3rU1rTA@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 17 Apr 2025 11:47:36 +0300
X-Gm-Features: ATxdqUGN7ba5gRNdexibLVcLha16FrxdenSAnD-IPLQR8ct9qXqtpbHwbOJnd5Y
Message-ID: <CADDUTFzrUz9811qtOyvTObJnB61UoejxdXAqxV5Qr8bB9fD4ZA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Set distinctive exit value for failed tests
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F5GgBpazPKPVVDBBg-V_BTd9uuZf0a9CHWcr8UXhe1s_1744879693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 09:30, Tomas Glozar <tglozar@redhat.com> wrote:
> Also, users might be already relying on rtla exiting with 0 on
> threshold violation. What do you think about adding a new command line
> argument, `--fail-on-threshold`, that would allow the user (including
> the test suite) to trigger the new behavior?
Although it is technically possible to rely on a failed value zero, I
suppose it is very unexpected. I expect current users only grep the
output of rtla.
I think adding a new command line argument is overcomplicated. Adding
a new command-line argument for this seems unnecessarily complex, and
I'm not aware of any Linux/POSIX tools that offer such an option.

Costa

