Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971551;
	b=qbRu14qR7l7xcAt3n8zOMeEn9HWUZ10wXV7fg1w4JuAOxNkTf5aMc44aD9UImTvqA3RC
	 SHU9CZFY4/9rukYQHasAg0Vb5OqXX95fUr4+z7kY/4E4l9oZQ1rRRYNLrTuankACukZE7
	 1G/HFwyB3blK+92MuYBaPPJmSpSme1bQz5ZBGQ6gcmTCFRbTFAtcWD1sCDUNLEvT5vBhY
	 TNfUneD9qEaVqZCSnjDo6cb4w+4RKVLsizYHD563sJUFM1ISoKmNoz3EfMrgwkAKA/yv6
	 KFoc0faWp+bLaJ/83+GDZ2FnhmU3U5S1NVYcCyRqYeJ5HbilqHb2u+YW6BkICTG5VlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971551;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1qij314zoZxRirYc0U3jWu9+iby5U2jYKMg8ZnSCq6Y=;
	b=pRQC+mxK/5HV9Th5VkdnqoBDJoHf4ubWutWOnJji8WaO/hM+pVvNcPGuILJia+opHIXC
	 RQR0zMS487ZqeJvWN+S3aWX9GLCzCzQytdCJd1IKliUl1llbCpFfU5C/tAMiBeEanOjyM
	 FoIyOTf7HcULJsBPJYkpO6qU1scDJHYhB0KGhZuJcSnPZgh5u+RvegBRElo7RV9nPBcYI
	 AZrpTaViQQdD7CdZO/CGUqcgA7/aZhlCFI7l6x/f/689N6pytO2EjRA/WzINLukJbuEAf
	 dvk1wBcRFCyWdGLb+ix2CskKRmlROySKtXIueKp9Gd50VICDsUBtHsU3cleKlwxdI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbYsXDg2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D354606A329
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbYsXDg2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED341F008A7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971550;
	bh=1qij314zoZxRirYc0U3jWu9+iby5U2jYKMg8ZnSCq6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bbYsXDg2sCi/PgjU32XsYMu6y/C1IXR8pPnZJD0AOvY3JnlXhqAa3CGaUuPksEZnG
	 ambzwSgaiI4bJMmoG+bqfq839Ose/D2cUE+cQIiDNLJ2GmI3LNK4QFPcrnFnZk5y10
	 P06RsR4d7j/ueIbgcKCsRRKG1PW3aQMdIk4LB93B9aEis9l//dVUwozE5xDn2jDq+E
	 RVcdF/L8j3oGxd/W7EA9+V+rSyEFy4TSyso06k8TT0hi8DnL496qwyM8cqJ1nuJGcr
	 cLFqKO9MLHtGzhHAXafqQBZPEU3MpukJ8WnPv0bjB/kDt2lty30KEcZxHIfl8OAIYb
	 wODFNqnG9148Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso484777e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 05:25:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwdyeABFr0XuY00xwSzNo1AXuCQ/wbCsAeuZ8I7VxILowgISG12ERO0pfvgnu++JGnD8S3ICUBGJvGPMDXOdlAHhbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D98hiiET3oF8g90ocsdYyybubqxhX9sNU6/cCO2cLryS+Xkrb
	R5IYZTkKFiKVc+fHCUQbOwcjbkVLscxryabMDzKKqEcIIAe8gyHpMVT0iV9owDkq7yMPVi4A1lN
	iP+/u9u/0ldqfpoYvacg0WD2wvd9zLcs=
X-Received: by 2002:a05:6512:3c8e:b0:5be:3c86:f24a with SMTP id
 2adb3069b0e04-5c003b066c4mr930672e87.53.1793971549628; Fri, 06 Nov 2026
 05:25:49 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com> <20261105-i2c-fault-reporting-v3-11-515ad74ac4c9@mobileye.com>
In-Reply-To: <20261105-i2c-fault-reporting-v3-11-515ad74ac4c9@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:25:36 +0100
X-Gmail-Original-Message-ID: <CAD++jL=R9qr-PP7HnP5SvZrqwcNruH95h=jGp1oZQygU_AyUbA@mail.gmail.com>
X-Gm-Features: AclHuK_jwcl2jYgOKr2HFBdWlzfrDzM0qykcv5w6x1x1j7s493OVvppJLUOpzHk
Message-ID: <CAD++jL=R9qr-PP7HnP5SvZrqwcNruH95h=jGp1oZQygU_AyUbA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 11/14] i2c: nomadik: save I2C_CR register before
 resetting HW in IRQ handler
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:16=E2=80=AFPM Dmitry Guzman <Dmitry.Guzman@mobiley=
e.com> wrote:

> On some interrupts, such as Bus Error interrupt or Arbitration Lost
> interrupt, the interrupt handler calls init_hw() to reset the I2C
> controller. This clears I2C_SR register value that might be used for
> fault reporting.
>
> Add i2c_sr field to nmk_i2c_dev structure, store there I2C_SR register
> value before resetting the hardware, and use this value instead of
> reading it directly in nmk_i2c_xfer_one() if it was read in IRQ handler.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
