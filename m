Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C2426EA8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746643; cv=pass; b=gPAkodW5Xd0oVunvd6kfW2xReUthfJHzc/M++UNU+zBemq3XPyT4j7ERaN+ZfxEmOdqnOrqLMC5w+l5Cig1Tq4H5Lg0qEgSDTjrMqpUzp9LFKkJnfJIivFMSmM+sJWikKXIaWjkRnNWT2EM7xJbv3POkqmlI8gHs3Pgm/i0HREE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746643; c=relaxed/simple;
	bh=F8vcDIdBIsy6rCka8JEsTLLKxcVfY7jRbzmJSvdEJNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzdRtG5a8Xc3RdF0u9SNKPCsYzZc7waHhZ4rDFkJYNobClkk0EGqBdn/tRcT9cQz8fd5d2wLVN09zMR+EfTBFFyqYQz4nc2xkxBTqWEx1xY1FuZ4e2ko9IqMc29BoPWmHWjgx9zzZdrfbL5xyrT59Pujmulclfnf3kjKsBxuovs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=fr892XzM; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="fr892XzM"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1211034e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 08:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782746641; cv=none;
        d=google.com; s=arc-20260327;
        b=bR5WNE7bS6qK/XJ9KsLCGvMSGHAUcQLhIH1vrSQeHo1LYzowwj/4k+byGnfXQvihQW
         WmQ58EdY5ToRZIrhvJxEYTeOrpXG3sW6dAC5wU+6DqfG4Og1avVe7oTXzBNltpA7gdP7
         98oxYdwJ+X3OXvHl/qladMZSwsnYMJzc/GSOKw9I7/1hXBPchmXiczmARb2X7x6Lx4CR
         3k/yq//KwyeW6gpFB/4hE0GxAgBXd/hBNsAI0x5OK5Uiw8lF3Wr51r4/Up7ksekH8IgR
         YOJLy+Rbr2RDKut58mbSS/AD4OuvETFd8Ze7sV+aTMUNGnNu1tJNzAYTWQzxMdnCELR0
         e6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5e+h/WCXBHYnhoN0/wz9bxlji5oiFMsvI8wYyIiBjU=;
        fh=FMlVACi84+mcZdY7viS7l7Tk5stcEHiL/NwW5uS0EXU=;
        b=XsXsx2ZseClnt/XZAO4ca9p9g9LqSS+QhggyzbANREfl0cxFypURIAj1t9FeSK4Veh
         cKRfD7xrAz4LIQZQLGJjDTkCH88mV+aSSraj7tn1FWm7WBH+i6F6lF3cpZMG+Guw2Yo6
         BjK6z3soe27ULmUuv+NlK0xX1AvWO9lfuKxxCVDZa9WsebIrSmcBJQs6pFiIbSvzDL45
         XApYHUjj+HgDDl528gOvqLJkfm/E5QmtYKv8MVPDHzfgTsUM9i6n5X0/toksWrGypCgi
         4Hd6C/2LPRDapn40pYe7jtmbZWzrNtU+avMja83WVRP0+kZ0O68GvrnE9PXrEvhCa9of
         2k3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782746641; x=1783351441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5e+h/WCXBHYnhoN0/wz9bxlji5oiFMsvI8wYyIiBjU=;
        b=fr892XzMgQ8cylkq1pGszQtdcAtx66QtMWxtexIl6cwexmUoMg+cNq+fSkGXUEwy7q
         3czbUPS8EWlGzUae4HjOBk83yFOdlLyvAtB6LHZgiJhGg/a2aaPAArEWIy3n3shN7jWe
         l/HeuzWZtbNc43xpD4LDBLqtLw+j0Mpx4Nt4YjXAM//ZIeULLXWqgO4RPsrGo99y0aso
         gHQRk6h+qSAeP2cAyNpDj/5r0OBQneGvx6ZUa/5Lf+i4wx2+iKK0neRudNhI5kR8WnEm
         sj3qF7iTopVqF6OfvQI0UcAEZrYaeq5MoeOa7LmJTXZ36yArPVYsvwQojhVWv63USiEm
         nANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746641; x=1783351441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5e+h/WCXBHYnhoN0/wz9bxlji5oiFMsvI8wYyIiBjU=;
        b=EmpCBcc4jB0GkFqQYxEFBDJD00mfFX9kPdihYYZN1bkuydpbIBTtjP4Y3GbAJO6YJJ
         YwcQaU+25Kqe93OYnJLtC9JcDvqMeSWe7OLJ8jwkUgGYV/PMXtz1e8T4TJwekD7bjrri
         XIBAAgyJr46mVGhun9u+bYsevUPG/DxSuncaVh88Xi7nobkhpNpWDrgN6AYKxzQhxSMy
         5NOlY+L9jVeX0nzUaDFxoY+bzXFZ7PIjfurbV/4QB7sZ1eMcwxFKcMxhMDIrm7QG48I5
         BzIvvJthlMGLdCAK/VPpAvWhSKK0btpznxt9Tn06xB2dGzdiNlBCuUzWhtrKx+gyzf1s
         nKmg==
X-Forwarded-Encrypted: i=1; AHgh+Ro++szBUJkrL5jCQrB+oYs1rjiq8pD+3JWQElE0FQx90UstCNRp2WlG2v5ceijMCt+ZDgrTLlTelYmi1Z9HeB3u0JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQd2T/joeppl665BeqVFHX9+hnAEQPe50RPKDkpOXLJKfdU8tL
	IlPLv5CT2BB5ZpSng2GNB9G1CeBt+/G4DztTZJeAcciSuV9Pq8D8vUGz/vsUh7/Mdg8LgTbI7EN
	YjL7N3NDvk+3K4uzvP8+12KaMJ37Y5Mtri4a84UO955n1lmDJMuAHlWVsnA==
X-Gm-Gg: AfdE7cnj3wGJLsUuUdZY4a7WGxMvyihTtEH9HFKiUb4bp1EQWy8Mb9UoFI60z7+Z+hy
	ROBt9045uO9HK3EzursiqhXHarRLIvErIXHTg0HAupcp2pQ1Vs5d3UKJH/pExHbXybQgCvvKee6
	9XbVwJaSws53KgAXSXpJa7kqEtwj3HI+PQOxHxcUNieIKKauZp3Yg8fYt4OUlf8MvsyfDNZP7wx
	7oCBHDgj8DZzFB4dDQqm5aOjHWyvdbA/lEu5FPestXIR4diZKXhz5ZUwcqVzG0jPNK61WMfuwef
	8kR8JQ==
X-Received: by 2002:a05:6512:252a:b0:5ae:b765:ac58 with SMTP id
 2adb3069b0e04-5aeb765af84mr1069034e87.5.1782746640911; Mon, 29 Jun 2026
 08:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
 <20260608210324.6af37e65@gandalf.local.home> <CAE+C+DZXcQfyQt-UV2PRt0vVFJqCciW6QkyEd9FaJ8++B3M4Ow@mail.gmail.com>
 <20260610200336.3c4d32c3@robin>
In-Reply-To: <20260610200336.3c4d32c3@robin>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Mon, 29 Jun 2026 11:23:49 -0400
X-Gm-Features: AVVi8CetJ5llWV-oIf3VgVyYNgVt2nh_sTNo0X_lnDt19z_jJ1PPsGLmGU0woOs
Message-ID: <CAE+C+DYPQnm1cqdmDb4cE8GqSgaHH2gzHmpRYb7ZrE7RQt2yEA@mail.gmail.com>
Subject: Re: [PATCH] samples/ftrace: reject zero ftrace-ops call count
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 9 Jun 2026 07:26:27 -0400
> Samuel Moelius <sam.moelius@trailofbits.com> wrote:
>
> > Is it okay to keep the same subject line or should I change it?
>
> Yeah, and also note that the tracing subsystem uses capital letters:
>
>   samples/ftrace: Reject zero ftrace-ops call count
>
> But you can change it to:
>
>   samples/ftrace: Prevent division by zero when nr_function_calls is zero

I will submit a new patch with that subject line.
