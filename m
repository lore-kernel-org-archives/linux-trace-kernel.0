Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674254723
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036593; cv=none; b=QQx3zf9GTBWWChwwi5c16LliXi8yV39ypLFQeGtbSEVrU2ATLdI1tuJKYHcPR/ED70bJGw0TEo7pWNXOC1N3xZuuxMtoNyUt+IFh4zZMX/7wozOVMln9Q44Ht55HwKrlMf56Ju3Ai+sifP80Q8rTJcSG7uwFKJE0zHiW87ds78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036593; c=relaxed/simple;
	bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOI8tD+lfjkZDn/cjVAo9Jj9B7YtnOdXxcGMVaI4njDyDevec6gEXsyqBM739bWCsAJrtgL+1gvOZXOCiYBYzLpzPJS9uBYwGBzlB/IZblTwFr8bvRM4uj9VPkkZ2jnfyXKJd/luPNU1XkQjFB7I6N4cs4nH6SomxHRX1UH7Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSalNk7D; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSalNk7D"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53f22fd6832so1091053e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734036590; x=1734641390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
        b=xSalNk7DwG4LZW4iSH96NW3YuLczACUM6IRHqto6FEM0SWSg0+OgLeIMV9eH8z0nhw
         RXecHiwpu1MbTyexJ2TYK05fIbGmWjoYFxqL98s3PN/yg5JFwjFKi3b39BtZvPIc/e/p
         GbTigCHFXUGqNWY0hNEjZYQ0FDWcFoRKZQOige7ytdgXYfEjp1NMXSAlTammah0mtaVQ
         V4XzmvBMcB1kRLj0DB6HX65ezxacTo3BWPV2fI6jR7eOTzU0Gmt3t1IA97Ao1gRwAdY9
         Ttw8EbyFo77iRkImUs9Tgnxnf2XuOt+ayXwDpzJGqfWKtXawOb8OxLaXQEvvOZ/JLpld
         BKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036590; x=1734641390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhb7Oa14Zb1laQhFgw/C+qh1MljqAcSMkUcNxzQt6M0=;
        b=eFpsVO9BrMoR1a3EdRORH4cDFz0SLgRrCksSM0oZ4Oq4sQ0HNhh0bEl+2TK/xpaqEv
         qBcCvwKsmC4jatjuQoEa0a89tPR7YK+0q12VUsdG2Vh1hRKHN40bgFGNF0ASawLhs2nx
         yjqzDF7sBjm/sbVc8QUfs0XA5f9gUhMuBQnSlFcdogk5Oe4oHSO71njI66SogORFuKdQ
         eQil9FBk+9r7ySlUZdVa+ODPHGTYq/1a4/eXNleK/i2U7c0GOSuzkP0QZcH6J4zShpfa
         uGN22rmOVkUj5Oi2VRFrQGGcMHCH+P5g9zG7tyfO4cYl4M8saD5+sPVcAkDSVtE23r1U
         oYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXguXiIa6wifXIcgZxDP8yuQG9hJItj0ZXgBb8xvs2gnfCP9ozIBDGslrjzofqNWg/2nQMmIf6/X746TeG7dmvBQUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitcG6L+WBxIKf1zWkMNlCHdSVqDO6mypAgYvWnoYErIGj+OFm
	ywsOZ3q9/7kbtfkOwVXjbLoPF3lc0fmloCV1H1QienzN8ddq5hirx1dDQVfV885lGEtaJQBUpM0
	1md2gzjPaJiKfi1w3t745bWbNvKKhsSJwYGeCbQ==
X-Gm-Gg: ASbGncviid83wDqJA444C2K3ZWFSE1q2o1ilSJTyh7TNVO8A6mDRl1rB7JCbqfGazZo
	aGQviu314aOmWE1uVfE9QnRjoYpv6EQWE45ee
X-Google-Smtp-Source: AGHT+IGNX5RK7MGEBvDKboipL69ANJo/iscsTrFTzt8I8Ex7/HcqjhgnfX9X6hkBPTYVYM+wmL1CpKpZIq72Pu4bhIo=
X-Received: by 2002:a05:6512:230c:b0:540:2549:b5ad with SMTP id
 2adb3069b0e04-54034107c9amr671405e87.22.1734036589615; Thu, 12 Dec 2024
 12:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211135335.094ba282@batman.local.home>
In-Reply-To: <20241211135335.094ba282@batman.local.home>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2024 21:49:37 +0100
Message-ID: <CACRpkdbrJ6ERLeMxBPXykCk+mgUkiYGVYqVSnTCKzu=9DBgy6w@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Still initialize idle shadow stacks when starting
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
>
> A bug was discovered where the idle shadow stacks were not initialized
> for offline CPUs when starting function graph tracer, and when they came
> online they were not traced due to the missing shadow stack. To fix
> this, the idle task shadow stack initialization was moved to using the
> CPU hotplug callbacks. But it removed the initialization when the
> function graph was enabled. The problem here is that the hotplug
> callbacks are called when the CPUs come online, but the idle shadow
> stack initialization only happens if function graph is currently
> active. This caused the online CPUs to not get their shadow stack
> initialized.
>
> The idle shadow stack initialization still needs to be done when the
> function graph is registered, as they will not be allocated if function
> graph is not registered.
>
> Cc: stable@vger.kernel.org
> Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idl=
e shadow stacks")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Closes: https://lore.kernel.org/all/CACRpkdaTBrHwRbbrphVy-=3DSeDz6MSsXhTK=
ypOtLrTQ+DgGAOcQ@mail.gmail.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yep that solves my issue and I can go on debugging my boot!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for patching this up so quickly Stephen, you're the best.

Yours,
Linus Walleij
