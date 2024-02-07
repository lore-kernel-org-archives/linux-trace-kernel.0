Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778977F20
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315226; cv=none; b=pyHvGLNM17yL1bhELMe8XnlOFa9iZhtJ9R2f4zgFRbggIvMmsQUSeb6wrFzr3OVY8cMbAIa0kYBkFCEnQSeligHjQrixyzjxR0GGqbGq/W7Dxr9Ly6oZ4ONVTp42hNfaW/g+meo8nXeO8EI/y7DWWARx/MZs9hGecl124SvjPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315226; c=relaxed/simple;
	bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKEJRjWhJeGa1pMHXpiH3XddwyqG0PzS93uJYEFm4FrllVE1Cce3pspot3nE+QsBsWDhLorMYXcLVKo6WncQTc9Q1fKKn9BHszZC4KvG+w456SWtZhFJFEDmfpQQJ8hCnnY6q98nC60YCeT7z5X4F2olz0hwQFyB7aSa5DiYIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AEM1TaGG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AEM1TaGG"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a4e8444dso7815531fa.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707315223; x=1707920023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=AEM1TaGGJL4wfEqm+2q9peXuocQIkjrQDjqZWUgmrqbKh2c6echwGBVUOkHYGtL1Jp
         02AhZevn+De6PN7zGsB819FgrNnk/pvSqHSCA7PPW//BH4iRu3GtCxMeDnF34BH9WieF
         R1hLL0ZneyOMPuS0eERh9ZDVSUIzkN/ZJ2rKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315223; x=1707920023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=RubFyadD4DRlxJTm62mwCVrwcqGBXuhLhijeZIpfM8y+8DxAc7J5x/PUuR+g00RkPu
         jTCLkPcr6gKdOI6lF8hdRFDGt/WIMj4R3aDSaXDFBT4OadkzDplsbamlZlj7MjDiPzB2
         jPNpdLVGFe68wD0qIW0O8NztGEYChWetFBnQyafRHeCzSS5BYuMULqG53a3BcK/vCLFC
         Vp8zfiPClN0ELH7o6KGltUSk80USv+o0y8lYK1n35WUElJdjJFhQcko6NRrag2vNxJI5
         R51xYmOUtVlK6NaQNs7QAgiASSBqTvSW5ha8baUI1uC1b7OEytgkWMH93bWObLff3TBN
         cyWQ==
X-Gm-Message-State: AOJu0YwWW2naJuar2ejcnMxf0knQ3FpnZtfoQGDLVQuNWK99UWeYL8ZE
	apcqWoxe4gVqdJ2WYkJbAiBd3h/oaGiqGdaDEafPUQhis/538TPJuqbMpjN7nzIfv46oAaJhyfu
	M9Ena66Q2lieb4YdIeevu1ewMHzJ+/7exTpfd3A==
X-Google-Smtp-Source: AGHT+IED9YAP6IjuLO7QGzwihwwoadtsQqIErozgRiEhzKfXYz5J89hbN3mS6Tn00zxP0ae3LMxLBAw1f4m1Z4XB0YY=
X-Received: by 2002:a2e:2206:0:b0:2d0:5f90:2b29 with SMTP id
 i6-20020a2e2206000000b002d05f902b29mr4579555lji.12.1707315222978; Wed, 07 Feb
 2024 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
 <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org> <20240207061429.3e29afc8@rorschach.local.home>
In-Reply-To: <20240207061429.3e29afc8@rorschach.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 7 Feb 2024 09:13:30 -0500
Message-ID: <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by ftrace_dump_on_oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>, mhiramat@kernel.org, mark.rutland@arm.com, 
	mcgrof@kernel.org, keescook@chromium.org, j.granados@samsung.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, 
	quic_satyap@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com, 
	Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 7 Feb 2024 05:24:58 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Btw, hopefully the "trace off on warning" and related boot parameters a=
lso apply
> > to instances, I haven't personally checked but I often couple those wit=
h the
> > dump-on-oops ones.
>
> Currently they do not. It would require an updated interface to do so,
> as sometimes instances can be used to continue tracing after a warning,
> so I don't want to make it for all instances.

Thanks for clarifying.

> Perhaps we need an option for these too, and have all options be
> updated via the command line. That way we don't need to make special
> boot line parameters for this. If we move these to options (keeping the
> proc interface for backward compatibility) it would make most features
> available to all with one change.

Agreed, that would be nice!!

 - Joel
