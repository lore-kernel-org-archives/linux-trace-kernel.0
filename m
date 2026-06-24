Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179A3B27F9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341810; cv=none; b=f0l9SXd0bwKDS8iDlRDIzCA/FznkzUiNkLF579jy7OIvyrQ+LNVqBpsKepoTESQZUGswzTz3f/YLJE9YEaQqIiVyktp1QI8p/3I9FHzZcroDIhUaHsX+uxyFc88qhm+9nxapQsYIAQbMgE+0ovtvIw3efYBoRImUargSdoQ7ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341810; c=relaxed/simple;
	bh=ygSwhLMj6NXCilW+c33iw+FbMzYRnhoWI20Z3BXK3IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Psf147aU4jZNyIu3UHlkdzNSjqzhOUXFDvTfgCrbxhtabE7C46fj2WnNUuu9JRA55oxFZnIR3e6KB8vXNLFLv+1hSx3Vl44xzUquGXLQv63axN7RMzwEjkwvWBs7lwOygCMidO6bijZxM5ewA8jsw2fUgkT8qStLXpvCYbKZEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvho+GqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvho+GqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3361F00A3E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341809;
	bh=ygSwhLMj6NXCilW+c33iw+FbMzYRnhoWI20Z3BXK3IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bvho+GqGAxHLH6uEZGyu9fddQFEwrsP0mN8QqgpKkIwYYWpu253UeybRkOcs9F84C
	 cJGiJ7nKH0vcQPW80ICOo5u71AbDVPLQAZxlgQsr4HW2YHgizvw9pFtEr0lJhvfb0t
	 fluwtxIgJxiZgkEa6MJ0WoVdWdj88s85Ivq3gtG+eGRMOXXR8EefgB/C7OIS0V7bcK
	 ciS3H3V0bfaeXziERb5x7swNfY5FnCFkiXvBZTZ3bIe42muOvA7HAuvUhtmjpj6ETD
	 xE5mRCaIogz1f//+vFfs/vRcpLAzewi8Spns2OlYlu4x8R6WU3+HnTnF+d3jJQIzOD
	 vZPbA62sM9utA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad4c89ecd8so1539762e87.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:56:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro3VuaUJqqrXkn4jfpYLhb0ejyVzoxZbya4kkA72mP6DnfNQ2tnO498Kd45ncqNvHSfHNDzYHjrPN36K8kbhuXN+9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcoWLa6NCNWJL31J9VgdRpT26DJIJwd1YTjTY8dw3Ez7uLPBD
	vOs5DjSHjnb3uJzDLQ7PU4574ti3lGXymiZOdBPZC387QpYn3RILYUsAvj5hFY66gHu3lftaWek
	SNFYnxvNiKvWl5z9iadJWCf49jUNVO+s=
X-Received: by 2002:a05:6512:135b:b0:5aa:6ede:1a69 with SMTP id
 2adb3069b0e04-5aea1f43aa8mr15092e87.17.1782341808041; Wed, 24 Jun 2026
 15:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-7-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-7-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:56:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLnF34JGQ5HbRdSx=g_kyvqj35kDoW8mjaJYadCFVWeGLQ@mail.gmail.com>
X-Gm-Features: AVVi8CcNUuaB-Vq_8JOqV-nSNQpuwqzs4DxG1-v--Hf1jCE0OC5XQdbb55KCWJI
Message-ID: <CAD++jLnF34JGQ5HbRdSx=g_kyvqj35kDoW8mjaJYadCFVWeGLQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] i2c: nomadik: add support for I2C_XFER_V2 - detailed
 fault reporting
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> I2C_XFER_V2 is a new API that allows I2C clients to get the detailed
> report in case of transmission failure. Previously, the only information
> returned by I2C bus controller was the error code; there was no way to
> find out how many messages or bytes in a certain message have been sent
> or received until the fault condition occurred.
>
> This commit introduces support of this feature in i2c-nomadik driver.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

I don't fully understand patch 1 but if that is fine, this is fine:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
