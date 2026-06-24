Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B93A7849
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341664; cv=none; b=ibHn5xTsqKOzbKeYHM+Ynh9Gdbvdkfv/0VxmUHrg8RN+zEo8+yd7qr60eksAupsd875/t0Q85mRrHU4m59GT3GtRnUo/dYAlle00NXJFzkzZ93h4DVKXwO2YoDh4l7x9PJ2etLyQbwZBfn43ewCdGJdRDhT5f7APQER6jVRyo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341664; c=relaxed/simple;
	bh=56P581cyET3p8pfSvFHStxu8oHOszFLpsAJpj8hvZRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCCHAEIe+wOMwY4wpn/6e67YT2X+bKqy+p+ldrQ2KupcqQ1MYkxu56EvpEqVgIRN3iMTzCDk7BkL4jU+pNt7XYQUpn5zsZczLW46spt8fOpJV+5iJdlpFPQrxGg+NVvG7Ns5nWmXyPtXzcqo43ofAiNqaUekeY/g21nRiEj3WQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAm5f3UJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAm5f3UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DADF1F00ADB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341663;
	bh=56P581cyET3p8pfSvFHStxu8oHOszFLpsAJpj8hvZRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GAm5f3UJm54F7qj3ACcwYfMiGhx0fpiVaO2rFqe7P93zV07FTHwTKz1bXSlkOHfY5
	 TB/A9TbrlhZ5dNEYrabhUw5qDFvF8QVCFjphUnvqkmohy/6K7usTVDt4R5FeqxBd/N
	 YlfUKleNA6S67dMaaUf0dYF/71Qj88x1+iv5suPtjNOJlCdD+UqQsdfiwYXDKF03jK
	 cxN0hdjXlFfWNhB3ieru21GjQxxJmnPKtaH/n+hLoR6SCDF910PlwmFYmNSBIneJhg
	 7jZfRIcX9945y0F+OpbmHA0RI5Py6ZJsX2yI2fde1JdeKi6iRBGe+ZWIvMqiq+MOFp
	 0EzoksAhuaRDA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad578c49afso1644792e87.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:54:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqo4QsZ8X3zSBpw/dEk6hEQBs9nBOo8KavuRlbWdDLbG61lrIrKu3MmXxxvqGaH+v9oZGhnlMuqnFfKuELxfq3o8CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32SvZMO9gtzph11TvqlBkqDZjArEu20hsEHff8tf1yWl9ACJx
	tIhBw5UbeYFKMnKQrbvJaV5Ls6PJXKZv1HABiKzrwQGegqSog+VBz79xeg9CG+9eipvS/7Mgf/r
	lpQvqXU5oQ6JsOdXG9HKGcXmcV1Dzkec=
X-Received: by 2002:ac2:4909:0:b0:5aa:6e60:1983 with SMTP id
 2adb3069b0e04-5aea1f4cc2emr7661e87.24.1782341662098; Wed, 24 Jun 2026
 15:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-5-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-5-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:54:10 +0200
X-Gmail-Original-Message-ID: <CAD++jLmze1K8LnMniv1gNTxXnW87AOF08vcPXnsASXn+75WG-Q@mail.gmail.com>
X-Gm-Features: AVVi8CfWKmNuDtu_CQ8CzYherOgZFOOUsqFP_TlnPojbQL-Ikm-PqOSDWXEzGJQ
Message-ID: <CAD++jLmze1K8LnMniv1gNTxXnW87AOF08vcPXnsASXn+75WG-Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] i2c: nomadik: change print level for fault messages
 to debug
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> i2c-nomadik driver prints error message on every faulted message. This
> is not a good practice, because in I2C a fault not always is an error,
> sometimes it is the expected result. For example, scanning bus with
> `i2cdetects` prints over 100 messages in dmesg (two messages per each
> target address).
>
> To avoid excessive prints in the log, change the print level from err to
> debug.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
