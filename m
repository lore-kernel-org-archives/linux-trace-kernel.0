Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7822EBDD0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465800; cv=none; b=PhvclHBu9bWiEUFKo6xDZSILBA9aI6J8j1G3RFr2QmJ1aEWuitr3V8kpLX2t18rLJSJnqNo23VOOc04iKMKRnifqL5VzY048ZpzDN1rNoq0A59cNKJHV/xQ1hZoAHgIqBCNdBRE2jGZBe9B8PXXcgOUNPew/0FCmH4FbcMu6bNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465800; c=relaxed/simple;
	bh=tNQbo97LbzX5ZaNglX85pgNLYN18HQeZxfnHfOkxn1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENlgw89DtxDMwVNrCJK8PDTOW1dthog6GOcEnIKouMpOBb39W0rp61mGYp99w8hnya0NJBSoAFWZvQz5S0z+ircfqCS+sJ9CkNk5rajxvcPpQ9hJjnmrweEHx7XZy2NhTV+2qxNq5Q2VRb2Zmyfep8xHO3rwOss2kyJYWsgPKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWNyUm8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWNyUm8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751465797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNQbo97LbzX5ZaNglX85pgNLYN18HQeZxfnHfOkxn1U=;
	b=UWNyUm8abdT/W64Dhc/Epa3oxYOOJ/6rDHVaxDne0YcEm7OdULxhEX3dOB3nTne15EPpv4
	m37yyaoqS4u7X2vUIxUgej04S/QVd5r5rY8zLhvyyYmP/fQLrvd6kUElToepf8jNOIcNkB
	d3fxRMaDCf/HjiW3aLMYPgNpOcVjoU0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-JjMJ6CsFNBKhxiN88ohykA-1; Wed, 02 Jul 2025 10:16:36 -0400
X-MC-Unique: JjMJ6CsFNBKhxiN88ohykA-1
X-Mimecast-MFC-AGG-ID: JjMJ6CsFNBKhxiN88ohykA_1751465794
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a71914dd25so111424021cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 07:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465794; x=1752070594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNQbo97LbzX5ZaNglX85pgNLYN18HQeZxfnHfOkxn1U=;
        b=C1gGs1fQVdtZFp1JAFh6NxXFDvJVGUFO2knWBqju73B7+Wc7qtdrHYGspyycplKKIA
         XZjW0OATdaQHv7vNQcdQsDRQb086/2JFf7d/MP/BLU++5wMAyMSGgg8aV1l0Z1rpZLgF
         cqI4EovpEdrBQ3DUazh4nz0AOZtsWevltT3jiwypE9Bmg3FVG/eriRyoeMubuu9KrU3v
         0XpOhBj8i6CiyGodJdB5lXC3vad7bV+gD0dyGrtU2zq+9FIvkttEqR/TDh2IushAvCvb
         c8yfjnJSD8kZsrIXJz8fzbbdYMhvTkqdbRGQsLCK7v1ousEGY8CVQz/Wck18JNRKQT9C
         crTw==
X-Forwarded-Encrypted: i=1; AJvYcCU9XFzY5hRLszXVJyES1ZVPkXbbztraKK+pt+Q80D4CkSO0pa4pI5Hzffw3SRIrqrVP9TESSgFM0daKCO4El0uhRhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPHzOmVV39/DFJ2Tma8rGhR60fclZ5BIIBXtytG3RfC0VPqXz
	YlpvEDINUEjU/qJzxQi82OzUIPRjF7J8mtR9DtlVwdPvZePRzAkD/iLtY48mJeTp8rDb5fTTUD0
	nGN8nvowz05FYlU0JOMCG9Mgsg0o9AVSxozJfA6Wgy5DUR3+RZSeFuPoTtjBnN65Eoeh2pV7Ogs
	er6yjcYPftzj6XXrA6q/VqKanrXUNQX3Yj0HJGXp+VeMug7ewMxojXA+P96yXClw==
X-Gm-Gg: ASbGnctgK3AYGgwVP+ncnKh2/bcXBQXBFeeFQkR1dMFUWZdlzS6oFFjd/o3gAmlMsvs
	ALoSj+7WiKnMRRbmHZxJ0gCmNowjzeHK/vkRznRURxmMGSMNHm7L7BTbtKTPnNpdPy1cjpEV0FW
	9EnilMq4l+BUILtwL35hcNp7nNJNyKFqiKmR5J
X-Received: by 2002:a05:622a:1441:b0:494:b924:1374 with SMTP id d75a77b69052e-4a9769badc8mr51474031cf.43.1751465794078;
        Wed, 02 Jul 2025 07:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHX5w9jng/ZR1ywwst/46yrWJUGZinoQ5Odmtit+CDr1mDil33vdxFF08u52zkDS4qeA1JDEAm04peNXJcoI0=
X-Received: by 2002:a05:622a:1441:b0:494:b924:1374 with SMTP id
 d75a77b69052e-4a9769badc8mr51473351cf.43.1751465793526; Wed, 02 Jul 2025
 07:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104349.5047-1-gpaoloni@redhat.com> <20250612104349.5047-2-gpaoloni@redhat.com>
 <20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org> <CA+wEVJa0jL-JH_4=5sR+Mvb26n4mPPudmOL0LRBDV54nMZcw8g@mail.gmail.com>
 <20250620183503.6c84eb22cca206cd10418c04@kernel.org> <CA+wEVJaQcHdpVc3Za8qy0+Z-CGNeaDTrXtjJg2j7J6qsW4uAkQ@mail.gmail.com>
 <20250701175826.429a7b4b@batman.local.home>
In-Reply-To: <20250701175826.429a7b4b@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 2 Jul 2025 16:16:22 +0200
X-Gm-Features: Ac12FXyfEtePa0XxvqJu6sGqCavh_IyDuIhKaeWfAiYCVIb-sDPUMESrR81HL5o
Message-ID: <CA+wEVJZ1BpwKOApGmmv=m0yoTypJd22XFOGD9kpG1yRErEvikg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	acarmina@redhat.com, chuck.wolber@boeing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2VsBDgT3TxcI9Kq0qPdneShml47WeSqZf21Anhwtfus_1751465794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:58=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 20 Jun 2025 15:26:27 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > I think that from my side I do not have comprehensive answers to all yo=
ur
> > questions (I need to read the code more in depth).
> > So to be pragmatic I can split this effort into two parts (documentatio=
n and
> > redesign); I will propose documentation first with the TIPs that you me=
ntioned
> > above and later, if we find a better re-design solution, we can also am=
end
> > the documentation as needed.
>
> Just to confirm, I agree with Masami. The enable file is quite special,
> and I don't see the use of user space playing tricks with it, which
> even includes lseek. Maybe to keep rewinding a read to get a new status
> change?

Well the proposed patchset was aiming to prevent the user from doing
stupid things (e.g. reading 1byte at a time or reading after a write has
increased ppos). However documenting the correct AoUs would still work

>
> But it usually contains a single character (sometimes two) and a new
> line. It's not something that's ever been reported as an issue. I
> rather not touch it if it hasn't been reported as broken because
> there's some hypothetical use case that can see it as broken.
>
> Documenting its current behavior is perfectly fine with me.

Yep "[RFC PATCH v3] tracing: add testable specifications for
event_enable_write/read" is already out.

Thanks
Gab

>
> -- Steve
>

