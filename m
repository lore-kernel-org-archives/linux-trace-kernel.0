Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90E1E5207
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118068; cv=pass; b=UmlbTKknPMwoCubekUa6eldGcRonaBlL6oOwyzbxd3FVUokGPn9DK4yPkyyadNQWQvr6ZfjjG60mFkzP+8VVn4bWmQvkONlCVlWxB6yi5p2xWg0af2FvgPIf02srdck9DC6T91R7oV1HUwkmq3II8XQ5BdTZmX72naNA/Q3pVLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118068; c=relaxed/simple;
	bh=KojWc5g4dM4amOUWQa6TiDAvQ799Q6Ii9VxdLEUmD28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfEQ+AuPMNVzomZnStrJA7hoPgbiodi8wEwBl9IWBFlqQBAvWrk8tkKzQxarss1rd7Z3ojzPZS+ATXW1aia/rmaI3Oyx7T0QXUO6H2c55kHxPkAJZ3icMt71gJTzCh7v/uJPfz8tfeJkcPjU0xq6d+/aCRjXygB95qgVWLLIalo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CEZDFGR+; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CEZDFGR+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so7745529e87.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 12:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118065; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUnC5qjyEpzzpbR/fboUc8pD4CykHSFn6XSSqTH+KcglDlY8F4uLuThf3OUqDj830C
         0oD6oVIRwB4YSayHAyRVpAeGVcUghAcOzR1vyoIeukSglmpfMBLmIOx71TMfz1+9Tg3L
         J6vJCUsF25iP3w+8FklvHqnHG+TdzaoCPdVai0ukaG9BAjE3MsPrewbHPey2KaP7z/Rk
         ynDPlGJTf3VitMSWxdMNYh826WX3xjx0OSTorlqzuhLNTuB8pFL1B/AGvRBL98OhQf6A
         l7ugO7p31yEGpd8OY9kdCFt2OxgsaFy+TemaVJLJj8a0+EzL9RqH13Ve/2W1+jX6xfGj
         kPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sK1ep5727p7DwH3peM6L5HJRPXeW5dBkVx3KmvyAzlI=;
        fh=87FcYqOfAMZcj5WWE1A72bsSd9BO9kuCgX7SuFk8b5Y=;
        b=JGwA8SPoIzj8KlicE79Zjz7Nm8/1e2HtthJ6Yk0rujmd4VNmzIHrUZAsqVctRM2gDz
         PsOH7mO6e9+w6P2wjyMtY7YYbbJdV/2bOCXQANAgLHArJVC3C3fs3y/uzu9pcBdR/GmR
         Lvj/fR4cOVsmPkHQCBlXhXCZDoKIfskKfqLqpW6N5evJjlJ0NjX1MIy3QlqkkiY4GXuo
         MIAM6CIIAMhlFkcxiLhAk1rwImGkEI7YnmyWRUiDOiEzv3Pvq6zENYujJXNBkWBA/8/v
         OLvU4ofnYYyEbxuB4ffhuFwlz0tWEkwTJQyOTcaTVO/J02GUBiENNFlVjymrNDiTQm06
         hQPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118065; x=1781722865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK1ep5727p7DwH3peM6L5HJRPXeW5dBkVx3KmvyAzlI=;
        b=CEZDFGR+nssOsp0tvY+J+QqT6lQ6cuWEyPXEY1bDbNJ4j5AfIf6e/uqQloZ179guDR
         CBuxGsz5ldkTcspb2cFxcIgJBH9ww49pnpOHfbWP/JZLyT3dsKrWivB3/ivwDILLEyFf
         ycp66oGv3ynVmPBQqrkuZ8VLFskMI0yIVbcCbC/XsvhxPt8v6ldVPf+DBa4B+REmZo8z
         V6c3Zf9mRbI0NJfTkcBvH5XsPYvMNYd9t7SpnHcrbnv5GUGD8BpVz3rHff4n9060Wn6D
         42XNvls3AiDVp7FhyeWrc9igoi0MMOXARVyk0QVWa8OyLILEUzUEC9L/cVXGPJvO9uNS
         bWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118065; x=1781722865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK1ep5727p7DwH3peM6L5HJRPXeW5dBkVx3KmvyAzlI=;
        b=W5+ua5yhuqLDlqjK3jcacjMFwY/eiBF6ZIbfAv+p7jVZ/G5FB7Ye9nWcHdo9/lIF3E
         uQ7JOsZcP8qOQVmALMWIY2E+Mitec3LqTMBrYZXqqicNmf8bHPIlItF5PyFyob0+lZnJ
         lSjT5uGsQxz/ufFzVPP5Y5eWKE93v+EBevKmE3K4cdEn4aYSuKc5EdjgDv9c70Gdmw1J
         XhdsrQbL8HuQaBG4KQCCNVVKnllCul6KaEBODnVPj3IIjMMmyFEbLKsKQdNehBfPVUVH
         6IpDTA808ClKrP4UB9SW4+102XNadlzqJEhu673Ts//55DiC3r+hJYmUFPuP8fhGIn3B
         Ulow==
X-Forwarded-Encrypted: i=1; AFNElJ89mFBS+1fNs57G5SKm2Og3DvOPzECj1UONSSC8xQhk57zPqw4YJ8sT/Zu9eQWzY/sPOWjmJIkidJhy3EtL3l6GcZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpPKwo7KoMM/XaGJoghdozcge3plsD3NFFrWuwxT9YHWlJsCE
	VLcEmHYzzqHlkc/X986MkW5fNTkv12Ri7ZkyGsYwO7XsLsNelS+BuPNtyVLZvQ7VdZX9dgXYoXQ
	WX1/AlAwsRFlTiYZbLLb08HeX3f9pLhwktmsL+2FEbg==
X-Gm-Gg: Acq92OE5oXNFILP4zV/cJGY9E32GzjG59+8n66zz0+kIihu5wnQpxVdUxdIr/Zj8wdG
	GZ4PmBjb+ObAeP3ezQpIpt/lGnZJmamaXYsTUVOpC0WMNpjRETs/46Cq85zKr1AYW2Hiu7AnHFn
	F9RyRJCuvyvLVTGRpDpPZhV6YiGDLchOOncSv47+nX44HiZTJ87iGpxJ1Z5of4QB2Ktj+gHh67Z
	S/TOGaHlVAT66az62jWcqsCckfBiNyPdyLlo08KBwSV2Rv29NMuq8HGAZyp9TAQ32/nyetx2yuC
	vlD4bFsGbJFilWMN
X-Received: by 2002:ac2:43b3:0:b0:5aa:6301:846b with SMTP id
 2adb3069b0e04-5aa87b8c393mr5862222e87.5.1781118065424; Wed, 10 Jun 2026
 12:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605004006.2041148-1-sam.moelius@trailofbits.com> <20260609181617.185f1e02@fedora>
In-Reply-To: <20260609181617.185f1e02@fedora>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:00:52 -0400
X-Gm-Features: AVVi8CdKPs4dbSPdBcbMhTvlLGa4uVilMi5s-VISt168ofSBYuZq9mZwQkJxOxk
Message-ID: <CAE+C+DYR7bA1AoT6Aqv_2eCWVzsYhepmy1TeHV27uwEdDBpwxg@mail.gmail.com>
Subject: Re: [PATCH] tracing: reject invalid preemptirq_delay_test CPU affinity
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri,  5 Jun 2026 00:40:06 +0000
> Samuel Moelius <sam.moelius@trailofbits.com> wrote:
>
> > preemptirq_delay_test accepts cpu_affinity as a module parameter and,
> > when it is non-negative, writes that CPU directly into a temporary
> > cpumask from the worker thread.  Values outside nr_cpu_ids can set a
> > bit outside the allocated cpumask before the test reports a normal
> > affinity error.
> >
> > Validate the requested CPU before starting the worker thread, and
> > return -EINVAL for invalid affinity requests.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
> >  kernel/trace/preemptirq_delay_test.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemp=
tirq_delay_test.c
> > index acb0c971a408..0f017799754a 100644
> > --- a/kernel/trace/preemptirq_delay_test.c
> > +++ b/kernel/trace/preemptirq_delay_test.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/module.h>
> >  #include <linux/printk.h>
> > +#include <linux/cpumask.h>
> >  #include <linux/string.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/completion.h>
> > @@ -152,6 +153,15 @@ static int preemptirq_run_test(void)
> >       struct task_struct *task;
> >       char task_name[50];
> >
> > +     if (cpu_affinity > -1) {
> > +             unsigned int cpu =3D cpu_affinity;
> > +
> > +             if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu)) {
> > +                     pr_err("cpu_affinity:%d, invalid CPU\n", cpu_affi=
nity);
> > +                     return -EINVAL;
>
> Just add the check to the preemptirq_delay_run() function where it
> tests affinity. Who cares if it created the thread or not. It's just a
> test.

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
